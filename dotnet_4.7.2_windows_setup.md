# Hướng dẫn Cài đặt và Chạy .NET Framework 4.7.2 trên Windows

.NET Framework 4.7.2 là một phiên bản phổ biến cần thiết cho nhiều ứng dụng Windows. Dưới đây là các bước để kiểm tra, tải xuống và cài đặt nó.

## 1. Kiểm tra xem .NET Framework 4.7.2 đã được cài đặt chưa

Windows 10 (phiên bản 1803 trở lên) và Windows 11 thường đã có sẵn .NET Framework 4.7.2 hoặc mới hơn.

Để kiểm tra phiên bản hiện tại:

1. Nhấn `Windows + R`, gõ `regedit` và nhấn Enter.
2. Điều hướng đến đường dẫn sau:
   `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full`
3. Kiểm tra giá trị `Release`. Nếu giá trị này là **461808** hoặc lớn hơn, bạn đã có .NET Framework 4.7.2 hoặc mới hơn.

## 2. Tải xuống bộ cài đặt

Nếu chưa cài đặt, bạn có thể tải xuống từ trang web chính thức của Microsoft:

*   **Trang tải xuống chính thức:** [Download .NET Framework 4.7.2](https://dotnet.microsoft.com/en-us/download/dotnet-framework/net472)
*   Bạn sẽ thấy hai tùy chọn:
    *   **Web Installer:** Bộ cài nhỏ, sẽ tải các thành phần cần thiết trong quá trình cài đặt (cần kết nối Internet).
    *   **Offline Installer:** Bộ cài đầy đủ, không cần Internet khi cài đặt (khuyên dùng nếu mạng không ổn định).

## 3. Các bước cài đặt

1.  Chạy file `.exe` bạn vừa tải về (ví dụ: `NDP472-KB4054530-x86-x64-AllOS-ENU.exe`).
2.  Chấp nhận các điều khoản cấp phép (License Terms) và nhấn **Install**.
3.  Chờ quá trình cài đặt hoàn tất.
4.  Sau khi cài xong, có thể bạn cần **khởi động lại máy tính** để thay đổi có hiệu lực.

## 4. Bật .NET Framework trong Windows Features (Nếu cần)

Đôi khi .NET Framework đã được cài nhưng chưa được bật:

1.  Nhấn phím Windows, gõ **"Turn Windows features on or off"** và chọn kết quả tương ứng.
2.  Tìm mục **.NET Framework 4.7 Advanced Services** (hoặc tương tự, thường nằm trong nhóm .NET Framework 4.x).
3.  Đảm bảo ô này được tích chọn.
4.  Nhấn **OK**. Windows sẽ tự động tìm kiếm và áp dụng các file cần thiết.

## 5. Khắc phục sự cố thường gặp

*   **Lỗi Block:** Nếu quá trình cài đặt bị chặn, hãy đảm bảo Windows Update của bạn đang hoạt động và không có bản cập nhật nào đang chờ xử lý.
*   **Yêu cầu phiên bản mới hơn:** Nếu máy tính báo đã có phiên bản mới hơn, bạn không cần cài đặt 4.7.2 nữa vì .NET Framework có tính tương thích ngược (phiên bản 4.8 chạy được ứng dụng của 4.7.2).
