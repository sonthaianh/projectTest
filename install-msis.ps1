<#
  install-msis.ps1

  - Cài đặt nhiều MSI theo thứ tự (sequential)
  - Silent (/qn), không tự reboot (/norestart)
  - Log chi tiết từng gói (/L*V) + log tổng

  Yêu cầu: chạy PowerShell as Administrator.
#>

$ErrorActionPreference = "Stop"

# ====== CẤU HÌNH: chỉnh danh sách MSI theo đúng thứ tự bạn muốn ======
# Có thể để path tương đối (cùng thư mục script) hoặc path tuyệt đối.
$Msis = @(
  "01-first.msi",
  "02-second.msi",
  "03-third.msi",
  "04-fourth.msi",
  "05-fifth.msi"
)

# Nếu bạn cần truyền thêm thuộc tính MSI (ví dụ LICENSE=1, SERVER=...),
# bạn có thể thêm vào đây (mỗi phần tử là "KEY=VALUE").
$MsiProperties = @()

# ====== THIẾT LẬP THƯ MỤC LOG ======
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$Timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
$LogDir = Join-Path $ScriptDir ("logs\" + $Timestamp)
New-Item -ItemType Directory -Force -Path $LogDir | Out-Null

$MasterLog = Join-Path $LogDir "master.log"

function Write-MasterLog {
  param([string]$Message)
  $line = ("[{0}] {1}" -f (Get-Date -Format "yyyy-MM-dd HH:mm:ss"), $Message)
  $line | Tee-Object -FilePath $MasterLog -Append
}

function Resolve-MsiPath {
  param([string]$Path)
  if ([System.IO.Path]::IsPathRooted($Path)) {
    return $Path
  }
  return (Join-Path $ScriptDir $Path)
}

function Install-Msi {
  param(
    [Parameter(Mandatory = $true)][string]$MsiPath,
    [Parameter(Mandatory = $true)][string]$LogPath,
    [string[]]$Properties
  )

  $args = @(
    "/i", $MsiPath,
    "/qn",
    "/norestart",
    "/L*V", $LogPath
  )

  if ($Properties -and $Properties.Count -gt 0) {
    $args += $Properties
  }

  # Start-Process -Wait để đảm bảo chạy tuần tự
  $p = Start-Process -FilePath "msiexec.exe" -ArgumentList $args -Wait -PassThru
  return $p.ExitCode
}

Write-MasterLog "Starting sequential MSI install. LogDir=$LogDir"

foreach ($msi in $Msis) {
  $msiPath = Resolve-MsiPath $msi

  if (-not (Test-Path -LiteralPath $msiPath)) {
    Write-MasterLog "NOT FOUND: $msiPath"
    throw "Missing MSI: $msiPath"
  }

  $name = [System.IO.Path]::GetFileName($msiPath)
  $perLog = Join-Path $LogDir ($name + ".log")

  Write-MasterLog "Installing: $name"
  Write-MasterLog "  MSI: $msiPath"
  Write-MasterLog "  LOG: $perLog"

  $code = Install-Msi -MsiPath $msiPath -LogPath $perLog -Properties $MsiProperties

  switch ($code) {
    0     { Write-MasterLog "OK: $name (exit=0)" }
    3010  { Write-MasterLog "OK (reboot required): $name (exit=3010)" }
    1641  { Write-MasterLog "OK (reboot initiated): $name (exit=1641)" }
    default {
      Write-MasterLog "FAILED: $name (exit=$code). Xem log: $perLog"
      throw "MSI install failed: $name (exit=$code)"
    }
  }
}

Write-MasterLog "DONE: all MSI packages completed."

