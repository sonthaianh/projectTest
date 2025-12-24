# Hướng dẫn cài đặt MSI bằng dòng lệnh (CLI) với Logging

Tài liệu này hướng dẫn cách sử dụng script để cài đặt các file `.msi` một cách tự động và ghi lại nhật ký (log) chi tiết trước và sau khi cài đặt.

## Mục đích
- Ghi lại thời điểm BẮT ĐẦU cài đặt vào file log tổng.
- Thực hiện cài đặt ngầm (silent install) không hiện cửa sổ.
- Ghi lại log chi tiết của chính trình cài đặt MSI (hữu ích để debug nếu lỗi).
- Ghi lại thời điểm KẾT THÚC và mã lỗi (Exit Code) vào file log tổng.

## 1. Cài đặt 1 file MSI riêng lẻ (Cơ bản)

### Cách A: Batch Script (`install_msi.bat`)
```cmd
install_msi.bat "C:\Downloads\MyApp.msi"
```

### Cách B: PowerShell Script (`install_msi.ps1`)
```powershell
.\install_msi.ps1 -MsiPath ".\MyApp.msi"
```

---

## 2. Cài đặt HÀNG LOẠT & TÍCH HỢP (Nâng cao)

Sử dụng script `install_packages.ps1` để cài đặt nhiều file. Đây là cách tốt nhất để tích hợp vào quy trình tự động hóa (CI/CD) hoặc gọi từ ứng dụng khác.

### Phương pháp A: Dùng File Danh sách (Khuyên dùng)
Bạn tạo một file văn bản (ví dụ `list.txt`), mỗi dòng là đường dẫn đến một file MSI.

**Nội dung `list.txt`:**
```text
App1.msi
Libs\App2.msi
# Dòng bắt đầu bằng dấu thăng sẽ bị bỏ qua
C:\Others\App3.msi
```

**Lệnh chạy:**
```powershell
.\install_packages.ps1 -ListFile "list.txt"
```

### Phương pháp B: Truyền trực tiếp qua dòng lệnh
Phù hợp khi bạn muốn gọi script từ code (C#, Python, Node.js) và truyền danh sách file động.

**Lệnh chạy:**
```powershell
.\install_packages.ps1 "App1.msi" "App2.msi" "App3.msi"
```

### Tích hợp vào ứng dụng khác (Ví dụ C#)
```csharp
ProcessStartInfo psi = new ProcessStartInfo();
psi.FileName = "powershell.exe";
// Truyền danh sách file
psi.Arguments = "-File install_packages.ps1 \"App1.msi\" \"App2.msi\"";
Process.Start(psi);
```

---

## Kết quả Logging
1. **Log tổng quát (install_packages_history.log):** Chứa lịch sử thành công/thất bại của toàn bộ tiến trình.
2. **Log chi tiết (TênFile_verbose.log):** Chứa log kỹ thuật của từng file MSI (dùng để tra lỗi cụ thể).

## Mã lỗi (Exit Codes)
Script sẽ dừng ngay lập tức nếu gặp lỗi (Exit code khác 0 và 3010).
- **0**: Thành công.
- **1603**: Lỗi cài đặt (Fatal error).
- **3010**: Thành công nhưng cần khởi động lại máy (Script sẽ tiếp tục chạy file tiếp theo).
