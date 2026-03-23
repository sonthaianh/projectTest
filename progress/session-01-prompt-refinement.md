# Tiến trình nghiên cứu: Chuẩn hóa skill prompt nghiên cứu cho AI

## 1. Thông tin phiên nghiên cứu
- Vai trò chuyên gia đang dùng: Chuyên gia thiết kế prompt và quy trình nghiên cứu cho AI
- Ngôn ngữ đang dùng: Tiếng Việt
- Cấp độ hiện tại của người học: Có ý tưởng rõ nhưng cần chuẩn hóa để AI thực thi ổn định
- Mục tiêu phiên này: Đánh giá prompt gốc, tái cấu trúc thành prompt chuẩn, và bổ sung các thành phần giúp AI nghiên cứu, trình bày, và hướng dẫn người mới tốt hơn

## 2. Vấn đề đang nghiên cứu
- Chủ đề chính: Thiết kế một bộ prompt/skill tiêu chuẩn cho AI đóng vai chuyên gia nghiên cứu
- Phạm vi nghiên cứu:
  - cách AI mở đầu phiên chat;
  - cách xác định vai trò chuyên gia;
  - cách dạy người mới theo từng bước;
  - cách tách nghiên cứu khỏi lập trình;
  - cách ghi chú tiến trình;
  - cách yêu cầu trích dẫn và kiểm chứng nguồn.
- Giả định hiện tại:
  - AI sẽ được dùng lặp lại qua nhiều phiên nghiên cứu khác nhau;
  - người dùng cần một prompt ổn định, dễ tái sử dụng;
  - người dùng muốn AI giải thích cẩn trọng hơn là trả lời nhanh.
- Điều chưa có đủ dữ kiện:
  - nền tảng AI cụ thể nào sẽ sử dụng prompt này;
  - giới hạn ký tự hoặc system prompt của nền tảng đích;
  - có cần tối ưu riêng cho mô hình nhỏ hay không.

## 3. Kiến thức nền đã làm rõ
- Prompt gốc có định hướng rất tốt nhưng còn dài và chưa có thứ tự ưu tiên rõ ràng.
- AI dễ làm sai khi prompt có nhiều yêu cầu nhưng không có flow mở đầu cố định.
- Việc tách `Research Mode` và `Implementation Mode` là cần thiết để tránh nhảy sang code quá sớm.
- Muốn AI dạy người mới tốt thì phải quy định mẫu trình bày, giải thích thuật ngữ, ví dụ, bảng so sánh và câu hỏi tự kiểm tra.

## 4. Phân tích chính
- Nguyên nhân cốt lõi:
  - prompt gốc chứa nhiều ý đúng nhưng ở dạng mong muốn tự nhiên;
  - chưa chuyển hóa thành chỉ thị có cấu trúc và có thể thực thi ổn định.
- Cơ chế hoạt động:
  - AI cần một flow mở đầu chuẩn để khóa ngữ cảnh;
  - AI cần thứ tự ưu tiên để xử lý xung đột giữa yêu cầu chi tiết, trung thực, dễ hiểu và không code sớm;
  - AI cần định dạng đầu ra cố định để giữ tính nhất quán giữa nhiều phiên.
- Các thành phần liên quan:
  - vai trò chuyên gia;
  - ngôn ngữ sử dụng;
  - chủ đề nghiên cứu;
  - cấp độ người học;
  - chế độ làm việc;
  - tiêu chuẩn trích dẫn;
  - cơ chế ghi chú tiến trình.

## 5. Các lựa chọn đã xem xét
| Tiêu chí | Phương án A: Giữ prompt gốc, chỉ sửa câu chữ | Phương án B: Tái cấu trúc thành bộ tài liệu + prompt chuẩn | Nhận xét |
|---|---|---|---|
| Dễ học | Trung bình | Cao | Phương án B rõ ràng hơn với người mới |
| Độ phức tạp | Thấp | Trung bình | Phương án B cần nhiều công chuẩn hóa hơn |
| Khả năng tái sử dụng | Trung bình | Cao | Phương án B dùng lại ổn định hơn |
| Khả năng mở rộng | Thấp | Cao | Phương án B dễ thêm mode, template, checklist |
| Rủi ro AI hiểu sai | Cao | Thấp hơn | Phương án B có cấu trúc rõ nên giảm mơ hồ |
| Phù hợp với mục tiêu hiện tại | Trung bình | Rất cao | Phương án B phù hợp hơn rõ rệt |

## 6. Hướng đã chọn
- Phương án được chọn: Tái cấu trúc thành bộ tài liệu + prompt chuẩn
- Lý do chọn:
  - giúp AI hiểu rõ vai trò và flow làm việc;
  - dễ copy sang nền tảng khác;
  - dễ bảo trì và cải tiến về sau;
  - có thể tách riêng phần lý thuyết, prompt dùng ngay và mẫu tiến trình.
- Lý do chưa chọn phương án khác:
  - chỉ sửa câu chữ của prompt gốc sẽ chưa xử lý triệt để các điểm mơ hồ và xung đột.
- Rủi ro cần lưu ý:
  - prompt đầy đủ có thể dài với một số nền tảng;
  - có thể cần thêm phiên bản siêu ngắn nếu nền tảng đích có giới hạn ngữ cảnh chặt.

## 7. Câu hỏi tự kiểm tra
1. Vì sao cần tách Research Mode và Implementation Mode?
2. Nếu không có flow mở đầu cố định, AI dễ mắc lỗi gì?
3. Vì sao bảng so sánh và ghi chú tiến trình lại quan trọng trong nghiên cứu?

## 8. Bài tập hoặc việc thực hành
- Bài tập nhỏ:
  - Thử dùng `docs/research-skill-prompt.md` với một AI khác và kiểm tra xem nó có hỏi lại vai trò, ngôn ngữ, mục tiêu và cấp độ người học hay không.
- Lệnh hoặc thao tác người dùng cần tự thực hiện:
  - Mở file prompt hoàn chỉnh, copy sang nền tảng AI đang dùng, và bắt đầu một phiên nghiên cứu mới.
- Kết quả cần kiểm tra:
  - AI có mở đầu đúng flow không;
  - AI có tránh code khi chưa được yêu cầu không;
  - AI có tạo được ghi chú tiến trình sau một chủ đề lớn không.

## 9. Điều còn mơ hồ / cần kiểm chứng
- Prompt này có cần tinh chỉnh riêng cho từng nền tảng AI cụ thể hay không.
- Có cần thêm phiên bản ultra-short cho môi trường có giới hạn token thấp hay không.
- Có cần tách riêng prompt cho nghiên cứu kỹ thuật và nghiên cứu phi kỹ thuật hay không.

## 10. Bước tiếp theo
1. Thử nghiệm prompt trên 2-3 loại chủ đề khác nhau: kỹ thuật, kinh doanh, học thuật.
2. Ghi nhận các lỗi AI còn mắc phải khi áp dụng prompt.
3. Tạo thêm một phiên bản tối giản nếu cần dùng cho môi trường hạn chế ngữ cảnh.
