# Báo Cáo Phân Tích Độ Bất Nhất (Gap Analysis) - Dự Án HealthSync

Bản thiết kế cơ sở dữ liệu cũ (Legacy Schema) bộc lộ sự thiếu hụt nghiêm trọng so với UML Activity Diagram của bộ phận BA qua 3 điểm vênh cốt lõi sau:

1. **Sai lệch mô hình hóa trạng thái (State Anti-pattern):** 
Cột `is_active BOOLEAN` chỉ biểu diễn được trạng thái nhị phân (Đúng/Sai). Trong khi đó, quy trình nghiệp vụ yêu cầu một vòng đời 5 trạng thái liên tục: `PENDING` -> `CONFIRMED` -> `CHECKED_IN` -> `COMPLETED` / `CANCELLED`. Việc ép kiểu Boolean khiến hệ thống không thể biết lịch hẹn đang ở giai đoạn chờ, đã đến khám hay đã hoàn tất.

2. **Mất dấu vết dòng tiền và chế tài (Financial & Auditing Gaps):** 
Quy trình yêu cầu đặt cọc (`deposit_amount`), phạt tiền khi hủy lịch sau xác nhận (`penalty_fee`) và lưu nguyên nhân (`cancel_reason`). Thiết kế cũ không hề có các trường này, dẫn đến việc phòng khám thất thoát doanh thu phạt cọc, không thể đối soát sổ sách kế toán và thiếu minh bạch khi xử lý khiếu nại của bệnh nhân.

3. **Gãy đứt chuỗi nghiệp vụ khám bệnh (Missing Domain Entity):** 
Bước cuối cùng của Activity Diagram là bác sĩ kê đơn thuốc khi hoàn tất khám. Bản thiết kế cũ hoàn toàn bỏ quên thực thể `Prescriptions`, khiến kết quả chẩn đoán và điều trị không có nơi lưu trữ, làm đứt gãy luồng vận hành cốt lõi của một phòng khám y tế.
