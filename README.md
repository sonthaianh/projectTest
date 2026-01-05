# Cài đặt MSI silent (không UI), tuần tự, có log

## Mục tiêu
- Cài đặt file `.msi` **ngầm** (không hiển thị UI)
- **Cài theo thứ tự** (package trước xong mới chạy package sau)
- Có **log** để biết tiến trình và thời điểm hoàn tất

## Lệnh chuẩn để cài MSI silent + log
Bạn có thể dùng trực tiếp `msiexec`:

```powershell
msiexec /i "C:\path\app.msi" /qn /norestart /L*V "C:\logs\app.log"
```

- `/qn`: silent (không UI)
- `/norestart`: không tự reboot
- `/L*V`: ghi log chi tiết (verbose)

Exit code thường gặp:
- `0`: thành công
- `3010`: thành công nhưng **yêu cầu reboot**
- `1641`: đã initiate reboot (hiếm gặp khi dùng `/norestart`)

## Script cài tuần tự 5 MSI + log
File: `install-msis.ps1`

### Cách dùng nhanh
1) Copy 5 file `.msi` vào cùng thư mục với `install-msis.ps1`
2) Mở PowerShell **Run as Administrator**
3) Chạy:

```powershell
Set-ExecutionPolicy -Scope Process Bypass -Force
.\install-msis.ps1
```

### Tuỳ biến danh sách/thứ tự MSI
Mở `install-msis.ps1` và chỉnh mảng `$Msis` theo đúng thứ tự bạn muốn.

### Log nằm ở đâu?
Script sẽ tạo thư mục `.\logs\<timestamp>\` và ghi:
- `master.log`: log tổng
- `<msi-name>.msi.log`: log riêng từng gói
