# Hướng dẫn cài đặt MSI bằng dòng lệnh (CLI) với Logging

Tài liệu này hướng dẫn cách sử dụng script để cài đặt các file `.msi` một cách tự động và ghi lại nhật ký (log) chi tiết trước và sau khi cài đặt.

## Mục đích
- Ghi lại thời điểm BẮT ĐẦU cài đặt vào file log tổng.
- Thực hiện cài đặt ngầm (silent install) không hiện cửa sổ.
- Ghi lại log chi tiết của chính trình cài đặt MSI (hữu ích để debug nếu lỗi).
- Ghi lại thời điểm KẾT THÚC và mã lỗi (Exit Code) vào file log tổng.

## Cách 1: Sử dụng Batch Script (`install_msi.bat`)

Dành cho môi trường Command Prompt (cmd) truyền thống.

### Cú pháp
```cmd
install_msi.bat "đường_dẫn_đến_file.msi"
```

### Ví dụ
```cmd
install_msi.bat "C:\Downloads\MyApp.msi"
```

### Kết quả
1. File `install_history.log`: Chứa lịch sử chạy script (Thời gian bắt đầu/kết thúc, kết quả).
2. File `MyApp_install.log`: Chứa log chi tiết kỹ thuật của quá trình cài đặt MSI.

---

## Cách 2: Sử dụng PowerShell Script (`install_msi.ps1`)

Dành cho môi trường PowerShell, hỗ trợ xử lý lỗi tốt hơn và hiển thị màu sắc.

### Cú pháp
```powershell
.\install_msi.ps1 -MsiPath "đường_dẫn_đến_file.msi"
```

### Ví dụ
```powershell
.\install_msi.ps1 -MsiPath ".\MyApp.msi"
```

### Kết quả
1. File `install_history.log`: Log tổng quát.
2. File `MyApp_verbose.log`: Log chi tiết MSI.
3. Hiển thị trạng thái màu xanh (thành công) hoặc đỏ (lỗi) ngay trên màn hình console.

## Giải thích các mã lỗi (Exit Codes) thường gặp

- **0**: Thành công (Success).
- **1603**: Lỗi nghiêm trọng trong quá trình cài đặt (Fatal error). Thường do thiếu quyền Admin hoặc xung đột phần mềm.
- **3010**: Thành công nhưng cần khởi động lại máy (Success, reboot required).
