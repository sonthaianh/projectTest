# Hướng dẫn cài đặt MSI bằng dòng lệnh (CLI) với Logging

Tài liệu này hướng dẫn cách sử dụng script để cài đặt các file `.msi` một cách tự động và ghi lại nhật ký (log) chi tiết trước và sau khi cài đặt.

## Mục đích
- Ghi lại thời điểm BẮT ĐẦU cài đặt vào file log tổng.
- Thực hiện cài đặt ngầm (silent install) không hiện cửa sổ.
- Ghi lại log chi tiết của chính trình cài đặt MSI (hữu ích để debug nếu lỗi).
- Ghi lại thời điểm KẾT THÚC và mã lỗi (Exit Code) vào file log tổng.

## 1. Cài đặt 1 file MSI riêng lẻ

### Cách A: Sử dụng Batch Script (`install_msi.bat`)
Dành cho môi trường Command Prompt (cmd) truyền thống.
```cmd
install_msi.bat "C:\Downloads\MyApp.msi"
```

### Cách B: Sử dụng PowerShell Script (`install_msi.ps1`)
Dành cho môi trường PowerShell, hỗ trợ hiển thị màu sắc và log tốt hơn.
```powershell
.\install_msi.ps1 -MsiPath ".\MyApp.msi"
```

---

## 2. Cài đặt HÀNG LOẠT (Bulk Install) nhiều file MSI

Tính năng:
- Cài đặt tuần tự danh sách các file được định nghĩa.
- **Tự động dừng** nếu một file gặp lỗi (fail-fast).
- Bỏ qua cảnh báo nếu chỉ yêu cầu khởi động lại (Code 3010).

### Cách A: Sử dụng Batch (`bulk_install.bat`)
1. Mở file `bulk_install.bat` bằng Notepad.
2. Sửa dòng `set "MSI_LIST=..."` để điền danh sách file của bạn.
   Ví dụ: `set "MSI_LIST=App1.msi App2.msi SubFolder\App3.msi"`
3. Lưu và chạy file:
   ```cmd
   bulk_install.bat
   ```

### Cách B: Sử dụng PowerShell (`bulk_install.ps1`)
1. Mở file `bulk_install.ps1` bằng Notepad hoặc ISE.
2. Sửa mảng `$MsiList` ở đầu file:
   ```powershell
   $MsiList = @(
       "C:\Apps\App1.msi",
       "C:\Apps\App2.msi"
   )
   ```
3. Lưu và chạy:
   ```powershell
   .\bulk_install.ps1
   ```

---

## Kết quả Logging
1. **Log tổng quát (install_history.log):** Chứa lịch sử thành công/thất bại của từng file.
2. **Log chi tiết (TênFile_verbose.log):** Chứa log kỹ thuật của từng file MSI (dùng để tra lỗi cụ thể).

## Giải thích các mã lỗi (Exit Codes)
- **0**: Thành công.
- **1603**: Lỗi cài đặt (Fatal error). Quy trình sẽ dừng lại tại đây.
- **3010**: Thành công nhưng cần khởi động lại máy. Quy trình vẫn tiếp tục cài file tiếp theo.
