@echo off
setlocal EnableDelayedExpansion

:: --- CẤU HÌNH ---
:: Danh sách các file MSI cần cài đặt theo thứ tự
:: Bạn có thể sửa danh sách này
set "MSI_LIST=App1.msi App2.msi App3.msi App4.msi App5.msi"
set "LOG_FILE=bulk_install.log"
:: ----------------

echo [BULK INSTALL START] %DATE% %TIME% > %LOG_FILE%

for %%f in (%MSI_LIST%) do (
    echo.
    echo --------------------------------------------------
    echo Processing: %%f
    
    :: Kiểm tra file có tồn tại không
    if not exist "%%f" (
        echo [ERROR] File not found: %%f
        echo [ERROR] File not found: %%f >> %LOG_FILE%
        goto :ErrorExit
    )

    :: Gọi script cài đặt đơn lẻ (đã tạo ở bước trước)
    :: Dùng call để script chính không bị kết thúc
    call install_msi.bat "%%f"
    
    :: Kiểm tra mã lỗi trả về
    :: ERRORLEVEL sẽ lấy mã lỗi từ lệnh call gần nhất
    if !ERRORLEVEL! NEQ 0 (
        if !ERRORLEVEL! NEQ 3010 (
            echo [CRITICAL ERROR] Installation failed for %%f. Error Code: !ERRORLEVEL!
            echo [CRITICAL ERROR] Installation stopped at %%f. Error Code: !ERRORLEVEL! >> %LOG_FILE%
            goto :ErrorExit
        ) else (
             echo [WARNING] %%f requried a reboot but succeeded (Code 3010). Continuing...
             echo [WARNING] %%f requried a reboot but succeeded (Code 3010). >> %LOG_FILE%
        )
    ) else (
        echo [SUCCESS] Installed %%f
    )
)

echo.
echo ==================================================
echo ALL INSTALLATIONS COMPLETED SUCCESSFULLY!
echo [COMPLETED] All installations finished successfully. >> %LOG_FILE%
goto :eof

:ErrorExit
echo.
echo ==================================================
echo INSTALLATION PROCESS ABORTED DUE TO ERRORS.
echo Please check logs for details.
exit /b 1
