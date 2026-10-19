# Báo Cáo Thực Hành: Xoá CSDL Trên MySQL Workbench

## 1. Mục tiêu
- Luyện tập và nắm vững 2 phương pháp xoá Cơ sở dữ liệu (CSDL) trên MySQL Workbench: bằng Giao diện đồ họa (GUI) và bằng Câu lệnh SQL.
- Nắm rõ tính an toàn và cẩn trọng khi thực hiện thao tác DROP DATABASE.

---

## 2. Cách 1: Xoá CSDL sử dụng giao diện đồ họa (GUI) trên MySQL Workbench

### Các bước thực hiện:
1. **Đăng nhập:** Khởi động MySQL Workbench và kết nối tới máy chủ MySQL (`Local instance 3306`).
2. **Chọn CSDL cần xoá:**
   - Tại khung **Navigator** bên trái, chọn thẻ **Schemas**.
   - Tìm đến CSDL muốn xóa (ví dụ: `my_database1` hoặc `my_database`).
3. **Thực hiện thao tác:**
   - Nhấp chuột phải vào tên CSDL cần xóa $\rightarrow$ chọn **Drop Schema...**.
4. **Xác nhận xóa:**
   - Hộp thoại cảnh báo xuất hiện xác nhận thao tác.
   - Nhấp chọn **Drop Now** để tiến hành xoá vĩnh viễn CSDL.
5. **Kiểm tra kết quả:**
   - Khung **Output** hiển thị dấu tích xanh thông báo thao tác hoàn tất.
   - Nhấp nút **Refresh** (hai mũi tên xoay tròn) ở mục Schemas, CSDL đã được xóa hoàn toàn khỏi danh sách.

---

## 3. Cách 2: Xoá CSDL bằng câu lệnh SQL trên MySQL Workbench

### Mã nguồn: `drop_database.sql`

```sql
-- Lệnh xóa cơ sở dữ liệu trên MySQL Workbench
DROP DATABASE `my_database`;

### File mã nguồn: `drop_database.sql`

```sql
-- Kiểm tra và xoá cơ sở dữ liệu
DROP DATABASE IF EXISTS `my_database1`;
