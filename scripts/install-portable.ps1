Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$ProjectRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$Version = (Get-Content (Join-Path $ProjectRoot "VERSION") -Raw).Trim()
$CodexHome = if ($env:CODEX_HOME) { $env:CODEX_HOME } else { Join-Path $HOME ".codex" }
$ConfigFile = Join-Path $CodexHome "config.toml"
$SkillSource = Join-Path $ProjectRoot "codex\skills\ars-literature-workflow"
$SkillTarget = Join-Path $CodexHome "skills\ars-literature-workflow"

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
$Python = Find-Exe @("python.exe", "python", "py.exe", "py", "python3")

if (-not $Node) { throw "Cannot find Node.js. Install Node.js or set CODEX_NODE_PATH." }
if (-not $Npm) { throw "Cannot find npm. Install Node.js or set CODEX_NPM_PATH." }
if (-not $Python) { throw "Cannot find Python. Install Python 3 first." }

New-Item -ItemType Directory -Force -Path `
  (Join-Path $ProjectRoot "downloads"), `
  (Join-Path $ProjectRoot "uploads"), `
  (Join-Path $ProjectRoot "mcp\cloakbrowser-research\outputs"), `
  (Join-Path $CodexHome "skills") | Out-Null

Write-Host "Installing MCP dependencies..."
Push-Location (Join-Path $ProjectRoot "mcp\cloakbrowser-research")
try {
  $env:PATH = "$(Split-Path $Node -Parent);$env:PATH"
  & $Npm install
} finally {
  Pop-Location
}

Write-Host "Installing MarkItDown virtual environment..."
if ((Split-Path $Python -Leaf) -ieq "py.exe") {
  & $Python -3 -m venv (Join-Path $ProjectRoot ".venv")
} else {
  & $Python -m venv (Join-Path $ProjectRoot ".venv")
}
$VenvPython = Join-Path $ProjectRoot ".venv\Scripts\python.exe"
& $VenvPython -m pip install --upgrade pip
& $VenvPython -m pip install markitdown

Write-Host "Installing Codex skill..."
if (Test-Path $SkillTarget) {
  Remove-Item -Recurse -Force $SkillTarget
}
Copy-Item -Recurse $SkillSource $SkillTarget

Write-Host "Writing Codex MCP config..."
New-Item -ItemType Directory -Force -Path $CodexHome | Out-Null
if (-not (Test-Path $ConfigFile)) {
  New-Item -ItemType File -Path $ConfigFile | Out-Null
}
Copy-Item $ConfigFile "$ConfigFile.bak.$(Get-Date -Format yyyyMMddHHmmss)"

$Existing = Get-Content $ConfigFile -Raw
$Clean = [regex]::Replace(
  $Existing,
  "(?ms)\r?\n?# BEGIN ARS_RESEARCH_CONSOLE_PORTABLE.*?# END ARS_RESEARCH_CONSOLE_PORTABLE\r?\n?",
  "`r`n"
).TrimEnd()
$TomlNode = $Node.Replace("'", "''")
$TomlServer = (Join-Path $ProjectRoot "mcp\cloakbrowser-research\src\server.js").Replace("'", "''")
$Block = @"

# BEGIN ARS_RESEARCH_CONSOLE_PORTABLE
[mcp_servers.cloakbrowser_research]
command = '$TomlNode'
args = ['$TomlServer']
startup_timeout_sec = 120

[mcp_servers.cloakbrowser_research.env]
CLOAKBROWSER_RESEARCH_AUTHORIZED = "1"
CLOAKBROWSER_HEADLESS = "false"
CLOAKBROWSER_HUMANIZE = "1"
CLOAKBROWSER_BLOCK_FILE_DOWNLOADS = "0"
# CLOAKBROWSER_PROXY = "http://user:pass@proxy.example.edu:8080"
# CLOAKBROWSER_GEOIP = "1"
# END ARS_RESEARCH_CONSOLE_PORTABLE
"@
Set-Content -Path $ConfigFile -Value ($Clean + $Block + "`r`n") -Encoding UTF8

Write-Host "Running Windows doctor..."
& (Join-Path $ProjectRoot "scripts\doctor.ps1")

Write-Host "Installed ARS Research Console v$Version for Windows."
Write-Host "Restart Codex so cloakbrowser_research and ars-literature-workflow are loaded."
