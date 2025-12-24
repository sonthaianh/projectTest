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

### Cách A: Sử dụng PowerShell Script (`install_packages.ps1`)
Sử dụng script PowerShell để cài đặt nhiều file. Đây là cách nhanh nhất không cần biên dịch.

**1. Dùng File Danh sách (Khuyên dùng):**
```powershell
.\install_packages.ps1 -ListFile "list.txt"
```
*(File `list.txt` chứa mỗi dòng một đường dẫn file MSI)*

**2. Truyền trực tiếp qua dòng lệnh:**
```powershell
.\install_packages.ps1 "App1.msi" "App2.msi"
```

### Cách B: Sử dụng C# Console App (Mới)
Dành cho bạn nếu bạn muốn tự build một công cụ `.exe` riêng biệt, không phụ thuộc vào PowerShell policy.
Mã nguồn nằm trong thư mục `src/MsiInstaller`.

**1. Build ứng dụng:**
Sử dụng Visual Studio hoặc lệnh dotnet để build.
```cmd
dotnet build src/MsiInstaller
```

**2. Sử dụng:**
Sau khi build, bạn sẽ có file `MsiInstaller.exe`.

*   **Chạy với danh sách file:**
    ```cmd
    MsiInstaller.exe -ListFile "list.txt"
    ```

*   **Chạy với tham số trực tiếp:**
    ```cmd
    MsiInstaller.exe "App1.msi" "App2.msi" "Lib\App3.msi"
    ```

**3. Mã nguồn C# tham khảo:**
(Xem file `src/MsiInstaller/Program.cs` để biết chi tiết logic xử lý Process và ExitCode).

---

## Kết quả Logging
1. **Log tổng quát (install_history.log):** Chứa lịch sử thành công/thất bại của toàn bộ tiến trình.
2. **Log chi tiết (TênFile_verbose.log):** Chứa log kỹ thuật của từng file MSI (dùng để tra lỗi cụ thể).

## Mã lỗi (Exit Codes)
Script/App sẽ dừng ngay lập tức nếu gặp lỗi (Exit code khác 0 và 3010).
- **0**: Thành công.
- **1603**: Lỗi cài đặt (Fatal error).
- **3010**: Thành công nhưng cần khởi động lại máy (Công cụ sẽ tiếp tục chạy file tiếp theo).
