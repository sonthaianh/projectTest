<#
.SYNOPSIS
    Script cài đặt file MSI với logging chi tiết.
.DESCRIPTION
    Script này sẽ ghi lại thời điểm bắt đầu và kết thúc vào file log tổng.
    Nó cũng kích hoạt chế độ logging chi tiết của msiexec cho từng file.
.PARAMETER MsiPath
    Đường dẫn đến file .msi cần cài đặt.
.EXAMPLE
    .\install_msi.ps1 -MsiPath "C:\Installer\App.msi"
#>

param(
    [Parameter(Mandatory=$true)]
    [string]$MsiPath,

    [string]$LogFile = "install_history.log"
)

# Chuyển đổi đường dẫn sang dạng tuyệt đối để tránh lỗi
$FullPath = Resolve-Path $MsiPath
$FileName = [System.IO.Path]::GetFileNameWithoutExtension($FullPath)
$Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

# Ghi log bắt đầu
$StartMsg = "[$Timestamp] START installing '$FullPath'"
Write-Host $StartMsg -ForegroundColor Cyan
Add-Content -Path $LogFile -Value $StartMsg

# Định nghĩa file log chi tiết cho msiexec
$MsiInternalLog = "${FileName}_verbose.log"

# Cấu hình tham số cho msiexec
$Arguments = "/i `"$FullPath`" /quiet /norestart /l*v `"$MsiInternalLog`""

# Thực thi
try {
    $Process = Start-Process -FilePath "msiexec.exe" -ArgumentList $Arguments -Wait -PassThru
    
    $ExitCode = $Process.ExitCode
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    
    if ($ExitCode -eq 0) {
        $EndMsg = "[$Timestamp] SUCCESS installing '$FullPath'. Exit Code: 0"
        Write-Host $EndMsg -ForegroundColor Green
        Add-Content -Path $LogFile -Value $EndMsg
    } elseif ($ExitCode -eq 3010) {
        $EndMsg = "[$Timestamp] SUCCESS (Reboot Required) installing '$FullPath'. Exit Code: 3010"
        Write-Host $EndMsg -ForegroundColor Yellow
        Add-Content -Path $LogFile -Value $EndMsg
    } else {
        $EndMsg = "[$Timestamp] FAILED installing '$FullPath'. Exit Code: $ExitCode. Check '$MsiInternalLog' for details."
        Write-Host $EndMsg -ForegroundColor Red
        Add-Content -Path $LogFile -Value $EndMsg
    }
}
catch {
    $ErrorMsg = "[$Timestamp] ERROR executing installer: $_"
    Write-Host $ErrorMsg -ForegroundColor Red
    Add-Content -Path $LogFile -Value $ErrorMsg
}
