# projectTest

Repository này hiện lưu bộ tài liệu chuẩn hóa prompt dành cho AI nghiên cứu, hướng dẫn người mới, và hỗ trợ triển khai khi cần thiết.

Bộ prompt hiện tại đã được nâng cấp thêm các nguyên tắc nghiên cứu có hệ thống như:

- chia nhỏ câu hỏi nghiên cứu;
- mở rộng truy vấn theo nhiều nhánh;
- kiểm chứng chéo nhiều nguồn;
- phân biệt giữa thông tin ổn định và thông tin còn thử nghiệm;
- phân biệt rõ fact, inference, và recommendation.

## Tài liệu chính

- [Bộ tiêu chuẩn prompt nghiên cứu và hướng dẫn dành cho AI](docs/research-skill-standard.md)
- [Prompt hoàn chỉnh để copy-paste sử dụng ngay](docs/research-skill-prompt.md)
- [Mẫu ghi chú tiến trình nghiên cứu](docs/research-progress-template.md)

## Nên đọc theo thứ tự

1. `docs/research-skill-standard.md`  
   Dùng để hiểu cách cấu trúc prompt, các điểm mạnh/yếu của prompt gốc, và các cải tiến nên thêm.

2. `docs/research-skill-prompt.md`  
   Dùng khi bạn muốn copy trực tiếp một prompt hoàn chỉnh sang AI khác hoặc hệ thống khác.  
   Bản này đã tích hợp thêm các nguyên tắc nghiên cứu từ một prompt researcher tham khảo, nhưng vẫn giữ tính portable, không phụ thuộc hệ tool riêng.

3. `docs/research-progress-template.md`  
   Dùng làm mẫu để AI hoặc người dùng ghi lại tiến trình học/nghiên cứu sau từng mốc quan trọng.

## Mục tiêu của bộ tài liệu

Bộ tài liệu này được thiết kế để giúp AI:

- hỏi đúng ở đầu mỗi phiên chat;
- xác nhận vai trò chuyên gia và ngôn ngữ;
- nghiên cứu theo từng bước thay vì trả lời lan man;
- dạy lại cho người mới một cách rõ ràng, có hệ thống;
- chỉ code khi người dùng yêu cầu;
- và luôn duy trì ghi chú tiến trình để dễ xem lại.
