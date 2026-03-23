# Tiến trình nghiên cứu: Tích hợp prompt researcher tham khảo vào bộ prompt chuẩn

## 1. Thông tin phiên nghiên cứu
- Vai trò chuyên gia đang dùng: Chuyên gia thiết kế prompt nghiên cứu và đánh giá chất lượng prompt
- Ngôn ngữ đang dùng: Tiếng Việt
- Cấp độ hiện tại của người học: Đã có bộ prompt nền tảng, đang muốn tăng độ trust và sức mạnh nghiên cứu
- Mục tiêu phiên này: Phân tích prompt researcher tham khảo, chọn lọc các điểm mạnh phù hợp, và tích hợp vào bộ prompt hiện có mà không làm mất tính portable

## 2. Vấn đề đang nghiên cứu
- Chủ đề chính: Tích hợp tinh hoa từ một prompt researcher thiên về technical research vào bộ prompt nghiên cứu tổng quát
- Phạm vi nghiên cứu:
  - đánh giá giá trị thực sự của prompt tham khảo;
  - phân biệt phần nên giữ và phần không nên bê nguyên;
  - tăng độ trust bằng cơ chế cross-check và phân loại tri thức;
  - giữ nguyên triết lý dạy người mới và không code sớm.
- Giả định hiện tại:
  - prompt đích cần dùng được cho nhiều nền tảng AI khác nhau;
  - người dùng cần cả chất lượng nghiên cứu lẫn khả năng hướng dẫn;
  - không nên khóa prompt vào một runtime có tool riêng.
- Điều chưa có đủ dữ kiện:
  - nền tảng cụ thể nào là đích sử dụng chính;
  - có cần một phiên bản riêng chỉ cho technical research hay không.

## 3. Kiến thức nền đã làm rõ
- Prompt tham khảo rất mạnh ở quy trình research: query fan-out, ưu tiên nguồn chuẩn, kiểm chứng chéo, phân biệt stable/experimental.
- Prompt hiện có mạnh ở vai trò mentor, giải thích cho người mới, tách research khỏi implementation, và ghi chú tiến trình.
- Hướng tích hợp tốt nhất là giữ phương pháp nghiên cứu, bỏ phần cấu hình tool/runtime cụ thể.

## 4. Phân tích chính
- Nguyên nhân cốt lõi:
  - prompt tham khảo được thiết kế cho một hệ agent cụ thể, nên có nhiều phần không portable;
  - tuy vậy phần methodology lại rất giá trị nếu bóc tách đúng.
- Cơ chế hoạt động:
  - đưa phương pháp nghiên cứu có hệ thống vào prompt chuẩn;
  - bổ sung nhãn fact / inference / recommendation;
  - thêm yêu cầu unresolved questions sau mỗi báo cáo hoặc chủ đề lớn;
  - nhấn mạnh cross-reference và phân biệt stable vs experimental.
- Các thành phần liên quan:
  - quy tắc mở đầu;
  - research mode;
  - quy tắc về nguồn;
  - cấu trúc báo cáo;
  - ghi chú tiến trình.

## 5. Các lựa chọn đã xem xét
| Tiêu chí | Phương án A: Bê gần như nguyên prompt tham khảo | Phương án B: Chọn lọc và tích hợp phương pháp nghiên cứu | Nhận xét |
|---|---|---|---|
| Độ mạnh về methodology | Cao | Cao | Cả hai đều mạnh nếu tích hợp đúng |
| Tính portable | Thấp | Cao | Phương án B vượt trội |
| Phù hợp với người mới | Trung bình | Cao | Phương án B giữ được tính sư phạm |
| Rủi ro gây rối prompt | Cao | Thấp hơn | Phương án A dễ làm prompt bị lẫn runtime/tool |
| Khả năng tái sử dụng | Thấp | Rất cao | Phương án B tốt hơn rõ rệt |
| Phù hợp mục tiêu hiện tại | Trung bình | Rất cao | Phương án B là hướng hợp lý |

## 6. Hướng đã chọn
- Phương án được chọn: Chọn lọc và tích hợp phương pháp nghiên cứu
- Lý do chọn:
  - tăng sức mạnh nghiên cứu mà vẫn giữ tính phổ dụng;
  - tăng độ trust bằng cơ chế kiểm chứng chéo;
  - vẫn bảo toàn tinh thần "dạy người mới" của prompt hiện tại.
- Lý do chưa chọn phương án khác:
  - bê nguyên prompt tham khảo sẽ mang theo nhiều phụ thuộc runtime và ngôn ngữ không phù hợp.
- Rủi ro cần lưu ý:
  - prompt có thể dài hơn;
  - nếu dùng trên nền tảng giới hạn context thấp, có thể cần phiên bản rút gọn tiếp.

## 7. Câu hỏi tự kiểm tra
1. Vì sao nên giữ query fan-out nhưng bỏ phần tools cụ thể?
2. Sự khác nhau giữa fact, inference và recommendation là gì?
3. Vì sao unresolved questions làm tăng độ trust thay vì làm prompt yếu đi?

## 8. Bài tập hoặc việc thực hành
- Bài tập nhỏ:
  - thử đưa một chủ đề kỹ thuật đang thay đổi nhanh vào prompt mới và kiểm tra xem AI có phân biệt stable vs experimental không.
- Lệnh hoặc thao tác người dùng cần tự thực hiện:
  - mở `docs/research-skill-prompt.md` và chạy thử với một AI khác.
- Kết quả cần kiểm tra:
  - AI có chia câu hỏi lớn thành câu hỏi con không;
  - AI có phân biệt dữ kiện đã xác minh với suy luận không;
  - AI có kết thúc bằng unresolved questions khi dữ kiện còn thiếu không.

## 9. Điều còn mơ hồ / cần kiểm chứng
- Có nên tạo thêm một phiên bản prompt chuyên biệt chỉ cho software research không.
- Có nên thêm một checklist đánh giá chất lượng nguồn vào progress template không.

## 10. Bước tiếp theo
1. Thử prompt mới trên 3 nhóm chủ đề: kỹ thuật, kinh doanh, học thuật.
2. Đo xem phần bổ sung mới có làm prompt dài quá mức trên nền tảng đích không.
3. Nếu cần, tách thêm một bản "technical research edition" và một bản "general research edition".
