# Cấu hình danh sách file MSI (Hãy thay đổi đường dẫn thực tế của bạn ở đây)
$msiFiles = @(
    "C:\Path\To\App1.msi",
    "C:\Path\To\App2.msi",
    "C:\Path\To\App3.msi",
    "C:\Path\To\App4.msi",
    "C:\Path\To\App5.msi"
)

# Đường dẫn file log tổng
$mainLogFile = ".\install_summary.log"

# Hàm ghi log
function Log-Message {
    param([string]$message)
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logEntry = "[$timestamp] $message"
    Write-Host $logEntry
    Add-Content -Path $mainLogFile -Value $logEntry
}

Log-Message "=== Bắt đầu quy trình cài đặt ==="

foreach ($msi in $msiFiles) {
    if (Test-Path $msi) {
        Log-Message "Đang cài đặt: $msi"
        
        # Tạo tên file log chi tiết cho từng MSI
        $msiLog = "$msi.install.log"
        
        # Cấu hình tham số cho msiexec
        # /i : Install
        # /qn : Quiet (no UI)
        # /norestart : Không tự động khởi động lại máy
        # /l*v : Log verbose (chi tiết)
        $arguments = "/i `"$msi`" /qn /norestart /l*v `"$msiLog`""
        
        # Chạy process và ĐỢI (-Wait) cho đến khi nó kết thúc
        $process = Start-Process -FilePath "msiexec.exe" -ArgumentList $arguments -Wait -PassThru
        
        # Kiểm tra mã lỗi (Exit Code)
        if ($process.ExitCode -eq 0) {
            Log-Message "✅ Cài đặt THÀNH CÔNG: $msi"
        }
        elseif ($process.ExitCode -eq 3010) {
            Log-Message "⚠️ Cài đặt THÀNH CÔNG (Cần khởi động lại sau): $msi"
        }
        else {
            Log-Message "❌ Cài đặt THẤT BẠI: $msi (Exit Code: $($process.ExitCode)). Xem chi tiết tại $msiLog"
            # Tùy chọn: Dừng lại nếu gặp lỗi bằng lệnh 'break'
            # break 
        }
    }
    else {
        Log-Message "⛔ Không tìm thấy file: $msi"
    }
}

Log-Message "=== Hoàn tất quy trình cài đặt ==="
