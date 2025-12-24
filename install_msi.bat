@echo off
setlocal

:: File log tổng hợp (ghi lại thời điểm bắt đầu/kết thúc)
set MASTER_LOG=install_history.log

:: Kiểm tra tham số đầu vào
if "%~1"=="" (
    echo Usage: %0 "path\to\file.msi"
    goto :eof
)

set MSI_FILE=%~1

:: Lấy thời gian hiện tại
set CURRENT_TIME=%DATE% %TIME%

:: Ghi log trước khi chạy
echo [%CURRENT_TIME%] START installing %MSI_FILE%... >> %MASTER_LOG%
echo [%CURRENT_TIME%] START installing %MSI_FILE%...

:: Tạo tên file log chi tiết cho riêng lần cài đặt này (dựa trên tên file msi và timestamp)
set MSI_LOG_FILE="%~n1_install.log"

:: Chạy lệnh cài đặt
:: /i: install
:: /quiet: chế độ im lặng (không hiện giao diện)
:: /norestart: không tự động khởi động lại máy
:: /l*v: ghi log chi tiết (verbose) của chính quá trình cài đặt MSI
msiexec /i "%MSI_FILE%" /quiet /norestart /l*v %MSI_LOG_FILE%

:: Lấy mã lỗi trả về (0 là thành công)
set EXIT_CODE=%ERRORLEVEL%
set CURRENT_TIME=%DATE% %TIME%

:: Ghi log sau khi chạy
if %EXIT_CODE% EQU 0 (
    echo [%CURRENT_TIME%] SUCCESS installing %MSI_FILE%. Exit code: %EXIT_CODE% >> %MASTER_LOG%
    echo [%CURRENT_TIME%] SUCCESS installing %MSI_FILE%.
) else (
    echo [%CURRENT_TIME%] FAILED installing %MSI_FILE%. Exit code: %EXIT_CODE%. See %MSI_LOG_FILE% for details. >> %MASTER_LOG%
    echo [%CURRENT_TIME%] FAILED installing %MSI_FILE%. Check logs.
)

endlocal
