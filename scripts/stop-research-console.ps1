Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$ProjectRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$PidFile = Join-Path $ProjectRoot ".research-console.pid"

function Remove-Children {
  param([string]$Path)
  if (Test-Path $Path) {
    Get-ChildItem -Force $Path | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue
  }
}

Get-CimInstance Win32_Process |
  Where-Object { $_.CommandLine -like "*src/open-for-test.js*" } |
  ForEach-Object {
    Stop-Process -Id $_.ProcessId -Force -ErrorAction SilentlyContinue
  }

Get-ChildItem -Path $env:TEMP -Directory -Filter "playwright_chromiumdev_profile-*" -ErrorAction SilentlyContinue |
  Remove-Item -Recurse -Force -ErrorAction SilentlyContinue

$Outputs = Join-Path $ProjectRoot "mcp\cloakbrowser-research\outputs"
if (Test-Path $Outputs) {
  Get-ChildItem -Path $Outputs -File -Include *.png,*.jpg,*.jpeg,*.webp,*.log,*.tmp -Recurse -ErrorAction SilentlyContinue |
    Remove-Item -Force -ErrorAction SilentlyContinue
}
Remove-Children (Join-Path $ProjectRoot "uploads")
Remove-Children (Join-Path $ProjectRoot "downloads")

if (Test-Path $PidFile) {
  $PidValue = (Get-Content $PidFile -Raw).Trim()
  if ($PidValue) {
    Stop-Process -Id ([int]$PidValue) -Force -ErrorAction SilentlyContinue
  }
  Remove-Item $PidFile -Force -ErrorAction SilentlyContinue
}

Remove-Item (Join-Path $ProjectRoot ".research-console.log") -Force -ErrorAction SilentlyContinue
Write-Host "Research Console stopped and temporary files cleaned."
