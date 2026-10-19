# Nhật Ký Tương Tác Cùng AI (AI Prompt Log)

### Lượt tương tác 1: Tối ưu kiểu dữ liệu tài chính
- **Prompt:** "Khi thiết kế cột deposit_amount và penalty_fee trong MySQL phục vụ tính toán tài chính, tôi nên dùng kiểu dữ liệu FLOAT, DOUBLE hay DECIMAL? Tại sao?"
- **Phản hồi từ AI:** 
  - Kiểu `FLOAT` và `DOUBLE` sử dụng định dạng dấu phẩy động nhị phân chuẩn IEEE 754, dễ gặp lỗi làm tròn số (Floating-point precision issue) khi cộng trừ tiền bạc (ví dụ: `0.1 + 0.2 = 0.30000000000000004`).
  - Kiểu `DECIMAL(M, D)` lưu trữ số thập phân dưới dạng chuỗi byte cố định (Exact numeric), loại bỏ hoàn toàn sai số làm tròn, là tiêu chuẩn bắt buộc cho dữ liệu tiền tệ.
- **Áp dụng vào code:** Khai báo `DECIMAL(12, 2)` cho `deposit_amount` và `penalty_fee`.

---

### Lượt tương tác 2: Chặn vi phạm nghiệp vụ ở tầng cơ sở dữ liệu
- **Prompt:** "Làm thế nào để chặn việc cố tình INSERT một đơn thuốc vào bảng Prescriptions khi lịch hẹn ở bảng Appointments chưa đạt trạng thái COMPLETED bằng ràng buộc hoặc Trigger trong MySQL?"
- **Phản hồi từ AI:**
  - Ràng buộc `CHECK` trong MySQL hiện tại chỉ kiểm tra được giá trị giữa các cột trong cùng một bảng, không hỗ trợ truy vấn chéo sang bảng khác (Subquery).
  - Giải pháp tối ưu là sử dụng `BEFORE INSERT TRIGGER`, đọc trạng thái của `appointment_id` tương ứng và ném lỗi qua `SIGNAL SQLSTATE '45000'` nếu trạng thái khác `COMPLETED`.
- **Áp dụng vào code:** Viết trigger `trg_before_insert_prescription`.

---

### Lượt tương tác 3: Cơ chế toàn vẹn tham chiếu bảng Appointments - Prescriptions
- **Prompt:** "Bảng Prescriptions liên kết 1-1 với Appointments, tôi nên cấu hình ON DELETE CASCADE hay ON DELETE RESTRICT cho khóa ngoại này?"
- **Phản hồi từ AI:** 
  - Trong nghiệp vụ y tế, hồ sơ bệnh án và đơn thuốc là dữ liệu pháp lý nhạy cảm, không được phép vô tình bị xóa mất.
  - Sử dụng `ON DELETE RESTRICT` để ngăn chặn việc xóa một lịch hẹn nếu đã có đơn thuốc liên kết.
- **Áp dụng vào code:** Thiết lập `FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id) ON DELETE RESTRICT`.
