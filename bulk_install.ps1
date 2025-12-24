<#
.SYNOPSIS
    Script cài đặt hàng loạt file MSI tuần tự.
.DESCRIPTION
    Cài đặt danh sách các file MSI được định nghĩa trong biến $MsiList.
    Nếu một file cài đặt thất bại, quy trình sẽ dừng lại ngay lập tức.
    Sử dụng lại logic của script đơn lẻ 'install_msi.ps1' để đảm bảo tính nhất quán.
#>

# --- CẤU HÌNH ---
# Danh sách file cần cài đặt (theo thứ tự)
$MsiList = @(
    "App1.msi",
    "App2.msi",
    "App3.msi",
    "App4.msi",
    "App5.msi"
)
$LogFile = "bulk_install_history.log"
# ----------------

$ErrorActionPreference = "Stop"

function Write-Log {
    param($Message, $Color="White")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $FormattedMsg = "[$Timestamp] $Message"
    Write-Host $FormattedMsg -ForegroundColor $Color
    Add-Content -Path $LogFile -Value $FormattedMsg
}

# Xóa log cũ nếu có
if (Test-Path $LogFile) { Remove-Item $LogFile }

Write-Log "--- STARTING BULK INSTALLATION ---" "Cyan"

foreach ($MsiFile in $MsiList) {
    Write-Log "----------------------------------------"
    
    # Kiểm tra file tồn tại
    if (-not (Test-Path $MsiFile)) {
        Write-Log "ERROR: File not found '$MsiFile'. Aborting." "Red"
        exit 1
    }

    Write-Log "Installing: $MsiFile..." "Yellow"

    try {
        # Gọi script install_msi.ps1 con
        # -ErrorAction Stop để bắt lỗi nếu script con throw error
        # Lấy Exit Code từ script con
        
        $ScriptPath = Join-Path $PSScriptRoot "install_msi.ps1"
        
        # Chạy script con và chờ nó xong
        $Process = Start-Process -FilePath "powershell.exe" -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$ScriptPath`" -MsiPath `"$MsiFile`"" -Wait -PassThru
        
        $ExitCode = $Process.ExitCode

        if ($ExitCode -eq 0) {
            Write-Log "SUCCESS: Installed $MsiFile" "Green"
        }
        elseif ($ExitCode -eq 3010) {
            Write-Log "WARNING: Installed $MsiFile (Reboot Required). Continuing..." "Yellow"
        }
        else {
            Write-Log "CRITICAL FAILURE: Failed to install $MsiFile. Exit Code: $ExitCode" "Red"
            Write-Log "ABORTING REMAINING INSTALLATIONS." "Red"
            exit $ExitCode
        }
    }
    catch {
        Write-Log "EXCEPTION: An error occurred while running installer for $MsiFile. $_" "Red"
        exit 1
    }
}

Write-Log "----------------------------------------"
Write-Log "ALL INSTALLATIONS COMPLETED SUCCESSFULLY." "Green"
