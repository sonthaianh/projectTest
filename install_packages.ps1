<#
.SYNOPSIS
    Script cài đặt MSI linh hoạt cho phép tích hợp với các ứng dụng khác.
    Hỗ trợ đầu vào từ danh sách file (txt) hoặc tham số dòng lệnh trực tiếp.

.DESCRIPTION
    Script này cho phép bạn cài đặt hàng loạt MSI theo 2 cách:
    1. Truyền đường dẫn file danh sách (mỗi dòng là 1 đường dẫn MSI).
    2. Truyền trực tiếp danh sách các file MSI qua tham số dòng lệnh.
    
    Script vẫn giữ tính năng Logging và Fail-fast (dừng khi lỗi).

.PARAMETER ListFile
    Đường dẫn đến file .txt chứa danh sách các file MSI cần cài đặt.
    Mỗi file nằm trên một dòng. Dòng bắt đầu bằng # sẽ bị bỏ qua.

.PARAMETER Files
    Danh sách các file MSI được truyền trực tiếp qua dòng lệnh.

.EXAMPLE
    Cách 1: Dùng file danh sách
    .\install_packages.ps1 -ListFile "install_list.txt"

.EXAMPLE
    Cách 2: Truyền trực tiếp
    .\install_packages.ps1 "App1.msi" "App2.msi" "Libs\App3.msi"
#>

[CmdletBinding(DefaultParameterSetName="Direct")]
param(
    [Parameter(ParameterSetName="ListFile", Mandatory=$true)]
    [string]$ListFile,

    [Parameter(ParameterSetName="Direct", Mandatory=$true, ValueFromRemainingArguments=$true)]
    [string[]]$Files,

    [string]$LogFile = "install_packages_history.log"
)

$ErrorActionPreference = "Stop"

# --- HELPER FUNCTION ---
function Write-Log {
    param($Message, $Color="White")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $FormattedMsg = "[$Timestamp] $Message"
    Write-Host $FormattedMsg -ForegroundColor $Color
    Add-Content -Path $LogFile -Value $FormattedMsg
}

# --- PREPARE LIST ---
$MsiList = @()

if ($PSCmdlet.ParameterSetName -eq "ListFile") {
    if (-not (Test-Path $ListFile)) {
        Write-Error "List file not found: $ListFile"
        exit 1
    }
    # Đọc file, bỏ qua dòng trống và dòng bắt đầu bằng #
    $MsiList = Get-Content $ListFile | Where-Object { $_ -and -not $_.StartsWith("#") }
    Write-Log "Loaded $($MsiList.Count) items from $ListFile" "Cyan"
}
else {
    $MsiList = $Files
    Write-Log "Received $($MsiList.Count) items from command line arguments" "Cyan"
}

# --- MAIN LOOP ---
if ($MsiList.Count -eq 0) {
    Write-Log "No files to install." "Yellow"
    exit 0
}

Write-Log "--- STARTING BATCH INSTALLATION ---" "Cyan"

foreach ($MsiPath in $MsiList) {
    # Trim whitespace
    $MsiPath = $MsiPath.Trim()
    
    Write-Log "----------------------------------------"
    
    # Resolve full path
    if (-not (Test-Path $MsiPath)) {
        Write-Log "ERROR: File not found '$MsiPath'. Aborting sequence." "Red"
        exit 1
    }
    $FullPath = Resolve-Path $MsiPath
    
    Write-Log "Installing: $MsiPath..." "Yellow"

    try {
        # Gọi lại script đơn lẻ install_msi.ps1 để tận dụng logic có sẵn
        # Giả sử install_msi.ps1 nằm cùng thư mục
        $ScriptPath = Join-Path $PSScriptRoot "install_msi.ps1"
        
        if (-not (Test-Path $ScriptPath)) {
            Write-Log "ERROR: Helper script 'install_msi.ps1' missing." "Red"
            exit 1
        }

        $Process = Start-Process -FilePath "powershell.exe" -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$ScriptPath`" -MsiPath `"$FullPath`"" -Wait -PassThru
        
        $ExitCode = $Process.ExitCode

        if ($ExitCode -eq 0) {
            Write-Log "SUCCESS: Installed $MsiPath" "Green"
        }
        elseif ($ExitCode -eq 3010) {
            Write-Log "WARNING: Installed $MsiPath (Reboot Required). Continuing..." "Yellow"
        }
        else {
            Write-Log "CRITICAL FAILURE: Failed to install $MsiPath. Exit Code: $ExitCode" "Red"
            Write-Log "ABORTING SEQUENCE." "Red"
            exit $ExitCode
        }
    }
    catch {
        Write-Log "EXCEPTION: $_" "Red"
        exit 1
    }
}

Write-Log "----------------------------------------"
Write-Log "ALL TASKS COMPLETED SUCCESSFULLY." "Green"
