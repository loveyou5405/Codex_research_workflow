Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$ProjectRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$Version = (Get-Content (Join-Path $ProjectRoot "VERSION") -Raw).Trim()
$CodexHome = if ($env:CODEX_HOME) { $env:CODEX_HOME } else { Join-Path $HOME ".codex" }
$ConfigFile = Join-Path $CodexHome "config.toml"

function Fail {
  param([string]$Message)
  throw "FAIL: $Message"
}

function Find-Exe {
  param([string[]]$Names)
  foreach ($Name in $Names) {
    if ($Name -and (Test-Path $Name)) {
      return (Resolve-Path $Name).Path
    }
    $Command = Get-Command $Name -ErrorAction SilentlyContinue
    if ($Command) {
      return $Command.Source
    }
  }
  return $null
}

$Node = if ($env:CODEX_NODE_PATH) { $env:CODEX_NODE_PATH } else { Find-Exe @("node.exe", "node") }
$Npm = if ($env:CODEX_NPM_PATH) { $env:CODEX_NPM_PATH } else { Find-Exe @("npm.cmd", "npm.exe", "npm") }

if (-not $Node) { Fail "Cannot find Node.js" }
if (-not $Npm) { Fail "Cannot find npm" }
if (-not (Test-Path (Join-Path $ProjectRoot ".venv\Scripts\markitdown.exe"))) { Fail "Missing .venv\Scripts\markitdown.exe. Run scripts\install-portable.ps1" }
if (-not (Test-Path (Join-Path $ProjectRoot "mcp\cloakbrowser-research\node_modules"))) { Fail "Missing MCP node_modules. Run scripts\install-portable.ps1" }
if (-not (Test-Path (Join-Path $ProjectRoot "output_PDF"))) { Fail "Missing persistent PDF output directory: output_PDF" }
if (-not (Test-Path $ConfigFile)) { Fail "Missing Codex config: $ConfigFile" }

$Config = Get-Content $ConfigFile -Raw
if ($Config -notmatch "\[mcp_servers\.cloakbrowser_research\]") { Fail "Codex config is missing cloakbrowser_research" }
$ServerPath = Join-Path $ProjectRoot "mcp\cloakbrowser-research\src\server.js"
if (-not $Config.Contains($ServerPath)) { Fail "Codex config points at a different clone path" }
$RepoSkill = Join-Path $ProjectRoot "codex\skills\ars-literature-workflow\SKILL.md"
$InstalledSkill = Join-Path $CodexHome "skills\ars-literature-workflow\SKILL.md"
if (-not (Test-Path $InstalledSkill)) { Fail "Missing installed Codex skill: ars-literature-workflow" }
if ((Get-Content $RepoSkill -Raw) -ne (Get-Content $InstalledSkill -Raw)) { Fail "Installed ars-literature-workflow skill is stale; rerun scripts\install-portable.ps1" }

& $Node --check (Join-Path $ProjectRoot "app\research-console\server.js")
& $Node --check (Join-Path $ProjectRoot "mcp\cloakbrowser-research\src\server.js")
& $Node --check (Join-Path $ProjectRoot "mcp\cloakbrowser-research\src\open-for-test.js")

Push-Location (Join-Path $ProjectRoot "mcp\cloakbrowser-research")
try {
  $env:PATH = "$(Split-Path $Node -Parent);$env:PATH"
  & $Npm run smoke | Out-Null
} finally {
  Pop-Location
}

& (Join-Path $ProjectRoot ".venv\Scripts\markitdown.exe") --version | Out-Null

Write-Host "OK: Windows portable deployment v$Version is installed and verified."
