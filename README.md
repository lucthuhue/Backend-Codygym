# Báo Cáo Thực Hành: Tạo CSDL Trên MySQL Workbench

## 1. Mục tiêu
- Luyện tập và nắm vững cả 2 phương pháp tạo Cơ sở dữ liệu (CSDL) trên MySQL Workbench: bằng Giao diện đồ họa (GUI) và bằng Câu lệnh SQL.

---

## 2. Cách 1: Tạo CSDL sử dụng giao diện đồ họa (GUI) trên MySQL Workbench

### Các bước thực hiện chi tiết:
1. **Đăng nhập:** Mở ứng dụng MySQL Workbench và đăng nhập vào kết nối cơ sở dữ liệu (`Local instance 3306`).
2. **Khởi tạo Schema mới:**
   - Tại thanh công cụ điều hướng chính, nhấp vào biểu tượng **Create a new schema in the connected server** (biểu tượng hình trụ cơ sở dữ liệu có dấu cộng màu vàng).
   - Hoặc tại tab **Navigator -> Schemas**, nhấp chuột phải vào khoảng trống và chọn **Create Schema...**.
3. **Thiết lập thông tin CSDL:**
   - Tại ô **Schema Name**, nhập tên cơ sở dữ liệu: `my_database1`.
   - Cấu hình bảng mã chuẩn:
     - **Default Charset:** `utf8mb4`
     - **Default Collation:** `utf8mb4_unicode_ci`
4. **Xác nhận tạo:**
   - Nhấp chọn nút **Apply** ở góc dưới cùng bên phải.
   - Hộp thoại Review xuất hiện đoạn script DDL tương ứng:
     ```sql
     CREATE SCHEMA `my_database1` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
     ```
   - Tiếp tục nhấp **Apply** để thực thi và nhấn **Finish** để hoàn tất.
5. **Kiểm tra kết quả:**
   - Tại tab **Schemas** ở khung bên trái, nhấp nút **Refresh** (hai mũi tên xoay vòng).
   - Cơ sở dữ liệu `my_database1` đã hiển thị trong danh sách Schema của MySQL Workbench.

---

## 3. Cách 2: Tạo CSDL sử dụng câu lệnh SQL

File mã nguồn chi tiết: `create_database.sql`

```sql
-- 1. Tạo cơ sở dữ liệu nếu chưa tồn tại
CREATE DATABASE IF NOT EXISTS `my_database1`
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

-- 2. Chọn cơ sở dữ liệu vừa tạo
USE `my_database1`;

-- 3. Tạo bảng mẫu HocVien
CREATE TABLE IF NOT EXISTS `HocVien` (
    `HocVienId` INT AUTO_INCREMENT PRIMARY KEY,
    `HoTen` VARCHAR(100) NOT NULL,
    `NgaySinh` DATE,
    `ThoiDiemTao` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `TrangThai` ENUM('dang_hoc', 'bao_luu', 'da_nghi') DEFAULT 'dang_hoc'
);
