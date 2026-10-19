# Báo Cáo Thực Hành: Xoá CSDL Trên MySQL Workbench

## 1. Mục tiêu
- Luyện tập và nắm vững 2 phương pháp xoá Cơ sở dữ liệu (CSDL) trên MySQL Workbench: bằng Giao diện đồ họa (GUI) và bằng Câu lệnh SQL.
- Hiểu được mức độ quan trọng và tính cẩn trọng khi thực hiện thao tác DROP DATABASE.

---

## 2. Cách 1: Xoá CSDL sử dụng giao diện đồ họa (GUI) trên MySQL Workbench

### Các bước thực hiện:
1. **Đăng nhập:** Mở ứng dụng MySQL Workbench và đăng nhập vào kết nối MySQL (`Local instance 3306`).
2. **Chọn CSDL cần xoá:**
   - Tại thanh điều hướng bên trái (**Navigator**), chọn thẻ **Schemas**.
   - Tìm đến CSDL muốn xoá (ví dụ: `my_database1` hoặc `my_database`).
3. **Thực hiện lệnh Drop Schema:**
   - Nhấp chuột phải vào tên CSDL đó, chọn **Drop Schema...**.
4. **Xác nhận xoá:**
   - Hộp thoại cảnh báo xuất hiện xác nhận thao tác:
     - Nhấp chọn **Drop Now** để tiến hành xoá vĩnh viễn CSDL.
5. **Kiểm tra kết quả:**
   - Kiểm tra khung **Output** phía dưới hiển thị dấu tích xanh thành công.
   - Nhấn nút **Refresh** (hai mũi tên xoay tròn) ở mục Schemas, CSDL vừa chọn đã biến mất khỏi danh sách.

---

## 3. Cách 2: Xoá CSDL bằng câu lệnh SQL trên MySQL Workbench

### File mã nguồn: `drop_database.sql`

```sql
-- Kiểm tra và xoá cơ sở dữ liệu
DROP DATABASE IF EXISTS `my_database1`;
