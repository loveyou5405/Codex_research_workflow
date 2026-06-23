#!/usr/bin/env bash
set -euo pipefail

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
VERSION="$(tr -d '[:space:]' < "$PROJECT_ROOT/VERSION")"
SOURCE="$PROJECT_ROOT/launchers/CloakBrowser Research Launcher.applescript"
APP="$PROJECT_ROOT/launchers/CloakBrowser Research Launcher.app"
CLOSE_SOURCE="$PROJECT_ROOT/launchers/Close CloakBrowser Research Sessions.applescript"
CLOSE_APP="$PROJECT_ROOT/launchers/Close CloakBrowser Research Sessions.app"
CC="${CC:-/usr/bin/clang}"
START_COMMAND="$PROJECT_ROOT/launchers/Start ARS Research Console.command"
CLOSE_COMMAND="$PROJECT_ROOT/launchers/Close ARS Research Console.command"
NODE="${CODEX_NODE_PATH:-}"
if [[ -z "$NODE" ]]; then
  for candidate in \
    "/Applications/Codex.app/Contents/Resources/cua_node/bin/node" \
    "$(command -v node 2>/dev/null || true)"; do
    if [[ -n "$candidate" && -x "$candidate" ]]; then
      NODE="$candidate"
      break
    fi
  done
fi

if [[ ! -f "$SOURCE" ]]; then
  echo "Missing launcher source: $SOURCE" >&2
  exit 1
fi

build_native_app() {
  local app_path="$1"
  local app_name="$2"
  local executable="$3"
  local action="$4"
  local notification="$5"

  rm -rf "$app_path"
  mkdir -p "$app_path/Contents/MacOS"
  cat > "$app_path/Contents/Info.plist" <<PLIST
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>CFBundleDevelopmentRegion</key>
  <string>zh_TW</string>
  <key>CFBundleExecutable</key>
  <string>$executable</string>
  <key>CFBundleIdentifier</key>
  <string>local.ars-research-console.$executable</string>
  <key>CFBundleInfoDictionaryVersion</key>
  <string>6.0</string>
  <key>CFBundleName</key>
  <string>$app_name</string>
  <key>CFBundlePackageType</key>
  <string>APPL</string>
  <key>CFBundleShortVersionString</key>
  <string>$VERSION</string>
  <key>CFBundleVersion</key>
  <string>$VERSION</string>
</dict>
</plist>
PLIST

  cat > "$app_path/Contents/MacOS/$executable.c" <<C_SOURCE
#include <dirent.h>
#include <errno.h>
#include <fcntl.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

static const char *project_root = "$PROJECT_ROOT";
static const char *node_path = "$NODE";
static const char *server_path = "$PROJECT_ROOT/app/research-console/server.js";
static const char *pid_path = "$PROJECT_ROOT/.research-console.pid";
static const char *log_path = "$PROJECT_ROOT/.research-console.log";
static const char *outputs_path = "$PROJECT_ROOT/mcp/cloakbrowser-research/outputs";
static const char *uploads_path = "$PROJECT_ROOT/uploads";
static const char *url = "http://127.0.0.1:8765";
static const char *action = "$action";
static const char *start_command = "$START_COMMAND";
static const char *close_command = "$CLOSE_COMMAND";

static void join_path(char *out, size_t out_size, const char *base, const char *name) {
  snprintf(out, out_size, "%s/%s", base, name);
}

static int has_temp_extension(const char *name) {
  const char *dot = strrchr(name, '.');
  if (!dot) return 0;
  return strcmp(dot, ".png") == 0 || strcmp(dot, ".jpg") == 0 ||
         strcmp(dot, ".jpeg") == 0 || strcmp(dot, ".webp") == 0 ||
         strcmp(dot, ".log") == 0 || strcmp(dot, ".tmp") == 0;
}

static void remove_tree(const char *path, int remove_root, int temp_files_only) {
  DIR *dir = opendir(path);
  if (!dir) return;
  struct dirent *entry;
  while ((entry = readdir(dir)) != NULL) {
    if (strcmp(entry->d_name, ".") == 0 || strcmp(entry->d_name, "..") == 0) continue;
    char child[4096];
    join_path(child, sizeof(child), path, entry->d_name);
    struct stat st;
    if (lstat(child, &st) != 0) continue;
    if (S_ISDIR(st.st_mode)) {
      remove_tree(child, !temp_files_only, temp_files_only);
      if (!temp_files_only) rmdir(child);
    } else if (!temp_files_only || has_temp_extension(entry->d_name)) {
      unlink(child);
    }
  }
  closedir(dir);
  if (remove_root) rmdir(path);
}

static pid_t read_pid(void) {
  FILE *file = fopen(pid_path, "r");
  if (!file) return 0;
  long pid = 0;
  fscanf(file, "%ld", &pid);
  fclose(file);
  return (pid_t)pid;
}

static void write_pid(pid_t pid) {
  FILE *file = fopen(pid_path, "w");
  if (!file) return;
  fprintf(file, "%ld", (long)pid);
  fclose(file);
}

static void spawn_open(const char *arg1, const char *arg2) {
  pid_t pid = fork();
  if (pid == 0) {
    if (arg2) {
      execl("/usr/bin/open", "open", arg1, arg2, (char *)NULL);
    } else {
      execl("/usr/bin/open", "open", arg1, (char *)NULL);
    }
    _exit(0);
  }
}

static void notify_if_needed(const char *message) {
  if (message == NULL || strlen(message) == 0) return;
  char command[1024];
  snprintf(command, sizeof(command), "display notification \\"%s\\" with title \\"ARS Research Console\\"", message);
  pid_t pid = fork();
  if (pid == 0) {
    execl("/usr/bin/osascript", "osascript", "-e", command, (char *)NULL);
    _exit(0);
  }
  if (pid > 0) {
    int status = 0;
    waitpid(pid, &status, 0);
  }
}

static int launch_console(void) {
  spawn_open(start_command, NULL);
  return 0;
}

static void stop_console(void) {
  spawn_open(close_command, NULL);
}

int main(void) {
  if (strcmp(action, "launch") == 0) {
    return launch_console();
  }
  stop_console();
  notify_if_needed("$notification");
  return 0;
}
C_SOURCE
  "$CC" "$app_path/Contents/MacOS/$executable.c" -o "$app_path/Contents/MacOS/$executable"
  rm -f "$app_path/Contents/MacOS/$executable.c"
  chmod +x "$app_path/Contents/MacOS/$executable"
  echo "Built: $app_path"
}

[[ -x "$CC" ]] || {
  echo "Missing compiler: $CC" >&2
  exit 1
}

[[ -n "$NODE" && -x "$NODE" ]] || {
  echo "Cannot find Node.js. Install Codex for Mac or set CODEX_NODE_PATH." >&2
  exit 1
}

cat > "$START_COMMAND" <<COMMAND
#!/usr/bin/env bash
SCRIPT_DIR="\$(cd "\$(dirname "\${BASH_SOURCE[0]}")" && pwd -P)"
"\$SCRIPT_DIR/../scripts/start-research-console.sh"
COMMAND
chmod +x "$START_COMMAND"

cat > "$CLOSE_COMMAND" <<COMMAND
#!/usr/bin/env bash
SCRIPT_DIR="\$(cd "\$(dirname "\${BASH_SOURCE[0]}")" && pwd -P)"
"\$SCRIPT_DIR/../scripts/stop-research-console.sh"
COMMAND
chmod +x "$CLOSE_COMMAND"

build_native_app "$APP" "CloakBrowser Research Launcher" "research-console-launcher" "launch" ""

if [[ -f "$CLOSE_SOURCE" ]]; then
  build_native_app "$CLOSE_APP" "Close CloakBrowser Research Sessions" "research-console-closer" "close" "本地控制台、測試瀏覽器、上傳暫存與臨時截圖已清理。v$VERSION"
fi
