Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$ProjectRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$PidFile = Join-Path $ProjectRoot ".research-console.pid"
$Url = "http://127.0.0.1:8765"

function Find-Node {
  if ($env:CODEX_NODE_PATH -and (Test-Path $env:CODEX_NODE_PATH)) {
    return (Resolve-Path $env:CODEX_NODE_PATH).Path
  }
  foreach ($Name in @("node.exe", "node")) {
    $Command = Get-Command $Name -ErrorAction SilentlyContinue
    if ($Command) { return $Command.Source }
  }
  return $null
}

$Node = Find-Node
if (-not $Node) {
  throw "Cannot find Node.js. Install Node.js or set CODEX_NODE_PATH."
}

if (Test-Path $PidFile) {
  $OldPid = (Get-Content $PidFile -Raw).Trim()
  if ($OldPid) {
    $Existing = Get-Process -Id ([int]$OldPid) -ErrorAction SilentlyContinue
    if ($Existing) {
      Start-Process $Url
      exit 0
    }
  }
}

$Server = Join-Path $ProjectRoot "app\research-console\server.js"
$Process = Start-Process -FilePath $Node -ArgumentList @($Server) -WorkingDirectory $ProjectRoot -WindowStyle Hidden -PassThru
Set-Content -Path $PidFile -Value $Process.Id -Encoding ASCII
Start-Sleep -Seconds 1
Start-Process $Url
Start-Process "Codex" -ErrorAction SilentlyContinue
