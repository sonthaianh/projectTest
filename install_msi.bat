@echo off
setlocal EnableDelayedExpansion

:: File log tổng
set LOGFILE=install_summary.log

echo [%DATE% %TIME%] === Bat dau cai dat === >> %LOGFILE%

:: Danh sách các file (Bạn có thể thêm bớt tùy ý)
set FILES="C:\Path\To\App1.msi" "C:\Path\To\App2.msi" "C:\Path\To\App3.msi" "C:\Path\To\App4.msi" "C:\Path\To\App5.msi"

for %%f in (%FILES%) do (
    echo Dang cai dat %%f ...
    echo [%DATE% %TIME%] Dang cai dat %%f >> %LOGFILE%
    
    :: Lệnh start /wait giúp đợi quá trình cài đặt xong mới chạy tiếp
    :: /qn: Im lặng hoàn toàn
    :: /norestart: Không reboot
    :: /l*v: Log chi tiết ra file .log tương ứng
    start /wait msiexec /i %%f /qn /norestart /l*v "%%~nf.log"
    
    :: Kiểm tra mã lỗi
    if !ERRORLEVEL! EQU 0 (
        echo [%DATE% %TIME%] ✅ Thanh cong: %%f >> %LOGFILE%
        echo Thanh cong.
    ) else if !ERRORLEVEL! EQU 3010 (
        echo [%DATE% %TIME%] ⚠️ Thanh cong (Can Reboot): %%f >> %LOGFILE%
        echo Can Reboot.
    ) else (
        echo [%DATE% %TIME%] ❌ That bai (Code !ERRORLEVEL!): %%f >> %LOGFILE%
        echo That bai.
    )
)

echo [%DATE% %TIME%] === Hoan tat === >> %LOGFILE%
echo Da xong het. Kiem tra file install_summary.log
pause
