# Tiến trình nghiên cứu: Tích hợp prompt tham khảo mới vào bộ prompt nghiên cứu

## 1. Thông tin phiên nghiên cứu
- Vai trò chuyên gia đang dùng: Chuyên gia thiết kế prompt nghiên cứu và quy trình phân tích kỹ thuật cho AI
- Ngôn ngữ đang dùng: Tiếng Việt
- Cấp độ hiện tại của người học: Đã có bộ prompt mạnh, đang muốn nâng cấp thêm bằng cách tích hợp nguồn tham khảo mới
- Mục tiêu phiên này: Đọc prompt tham khảo mới, phân tích ưu/nhược điểm, rồi tích hợp các điểm mạnh vào bộ prompt hiện tại mà không xóa bớt nội dung cũ

## 2. Vấn đề đang nghiên cứu
- Chủ đề chính: Mở rộng prompt AI Research Mentor bằng một nguồn prompt tham khảo thứ hai
- Phạm vi nghiên cứu:
  - phân tích phương pháp nghiên cứu theo pha;
  - đánh giá phần quality standards;
  - đánh giá khung technical research report;
  - tích hợp các điểm mạnh vào cả bản tiếng Việt và tiếng Anh;
  - tránh phụ thuộc runtime hoặc tool cụ thể.
- Giả định hiện tại:
  - prompt hiện tại đã có nền tảng tốt về mentoring, research mode, implementation mode, citations, và progress notes;
  - prompt tham khảo mới chủ yếu bổ sung chiều sâu cho research workflow kỹ thuật;
  - người dùng muốn chỉ thêm mới, không xóa cấu trúc cũ.
- Điều chưa có đủ dữ kiện:
  - prompt này sẽ chủ yếu dùng cho research kỹ thuật hay mở rộng cho cả non-technical domains;
  - có cần thêm một bản report-template tách riêng thành file riêng hay không;
  - có cần một phiên bản ultra-short sau khi prompt ngày càng dài hơn hay không.

## 3. Kiến thức nền đã làm rõ
- Prompt tham khảo mới mạnh ở phần chia research thành nhiều phase.
- Prompt tham khảo mới có report structure khá hoàn chỉnh cho technical research.
- Prompt tham khảo mới có quality criteria rõ ràng như accuracy, currency, completeness, actionability, clarity, attribution.
- Prompt tham khảo mới cũng đưa ra các special checks rất hữu ích cho security, performance, new tech, API, deprecation, migration.
- Nhiều phần vẫn không nên bê nguyên vì phụ thuộc `.claude`, `gemini`, `docs-seeker`, `Naming`, hoặc yêu cầu runtime-specific.

## 4. Phân tích chính
- Nguyên nhân cốt lõi:
  - prompt hiện tại của bộ skill mạnh về mentoring và tính trung thực;
  - prompt tham khảo mới mạnh về workflow research kỹ thuật chuyên nghiệp;
  - hai bên có thể bổ sung cho nhau rất tốt nếu tích hợp đúng cách.
- Cơ chế hoạt động:
  - thêm một lớp methodology theo phase lên trên prompt hiện tại;
  - thêm source recency và source evaluation criteria;
  - thêm khung report kỹ thuật để AI có thể tổng hợp báo cáo tốt hơn;
  - thêm quality standards và special considerations cho từng loại research kỹ thuật.
- Các thành phần liên quan:
  - scope definition;
  - systematic information gathering;
  - analysis and synthesis;
  - report generation;
  - quality standards;
  - special topic checks;
  - runtime portability.

## 5. Các lựa chọn đã xem xét
| Tiêu chí | Phương án A: Chỉ phân tích prompt tham khảo mới | Phương án B: Tích hợp chọn lọc vào prompt hiện tại | Nhận xét |
|---|---|---|---|
| Tăng sức mạnh thực tế | Thấp | Cao | Chỉ phân tích thì không tạo giá trị vận hành trực tiếp |
| Giữ tính portable | Cao | Cao nếu chọn lọc kỹ | Cần tránh bê nguyên phần runtime-specific |
| Rủi ro làm prompt rối | Thấp | Trung bình | Có thể kiểm soát nếu thêm theo cụm rõ ràng |
| Phù hợp yêu cầu người dùng | Trung bình | Rất cao | Người dùng muốn phân tích và tích hợp |
| Khả năng tái sử dụng | Trung bình | Cao | Prompt sau tích hợp dùng được rộng hơn |

## 6. Hướng đã chọn
- Phương án được chọn: Tích hợp chọn lọc vào prompt hiện tại
- Lý do chọn:
  - tăng chiều sâu nghiên cứu kỹ thuật mà không phá kiến trúc prompt đang có;
  - đáp ứng đúng yêu cầu "không xóa bớt, chỉ thêm mới";
  - giúp prompt mạnh hơn cả ở mentoring lẫn technical research discipline.
- Lý do chưa chọn phương án khác:
  - chỉ phân tích mà không tích hợp sẽ không làm prompt mạnh lên thực tế.
- Rủi ro cần lưu ý:
  - prompt ngày càng dài hơn;
  - có thể cần một phiên bản production-short sau này;
  - cần tránh lặp ý giữa research methodology cũ và methodology mới.

## 7. Câu hỏi tự kiểm tra
1. Vì sao phase-based research flow là một nâng cấp quan trọng?
2. Tại sao quality standards nên được ghi rõ trong prompt thay vì để AI tự hiểu?
3. Vì sao các phần runtime-specific không nên bê nguyên vào prompt nền tảng chung?

## 8. Bài tập hoặc việc thực hành
- Bài tập nhỏ:
  - Thử dùng bản prompt mới để nghiên cứu một chủ đề kỹ thuật như "best practices for API versioning" và kiểm tra xem AI có tự tạo ra flow theo phase và report structure hay không.
- Lệnh hoặc thao tác người dùng cần tự thực hiện:
  - Mở `docs/research-skill-prompt.md` hoặc `docs/research-skill-prompt-en.md`, copy sang AI khác, và yêu cầu nghiên cứu một chủ đề có security/performance/API implications.
- Kết quả cần kiểm tra:
  - AI có làm rõ scope trước không;
  - AI có xét recency của nguồn không;
  - AI có tách verified fact / inference / recommendation không;
  - AI có nêu unresolved questions ở cuối không.

## 9. Điều còn mơ hồ / cần kiểm chứng
- Có nên tách riêng một file "technical-report-template.md" để dùng độc lập hay không.
- Có nên thêm quy tắc đánh giá maturity level của công nghệ theo thang riêng hay không.
- Có nên bổ sung một checklist riêng cho “enterprise architecture research” hay không.

## 10. Bước tiếp theo
1. Thử prompt mới trên một số chủ đề technical research thực chiến.
2. Đánh giá xem prompt có quá dài đối với một số nền tảng hay không.
3. Nếu cần, tạo thêm một phiên bản "production-short" giữ nguyên logic nhưng nén câu chữ.
