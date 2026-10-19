# Báo Cáo Thực Hành: Xây Dựng Cơ Sở Dữ Liệu Quản Lý Sinh Viên

## 1. Mục tiêu
- Luyện tập và nắm vững các thao tác tạo bảng (`CREATE TABLE`) trên MySQL Workbench bằng cả 2 phương pháp:
  - Giao diện đồ họa (GUI).
  - Câu lệnh truy vấn SQL.

---

## 2. Cách 1: Tạo bảng bằng giao diện đồ họa (GUI) trên MySQL Workbench

### A. Tạo bảng `Class` (gồm các trường: id, name):
1. **Mở kết nối:** Khởi động MySQL Workbench và đăng nhập vào kết nối máy chủ MySQL.
2. **Chọn CSDL:** Tại khung **Navigator -> Schemas**, tìm đến schema `student_management` (hoặc `student-management`).
3. **Mở giao diện tạo bảng:** Nhấp chuột phải vào schema `student_management` (hoặc mục **Tables** bên dưới schema) $\rightarrow$ chọn **Create Table...**.
4. **Thiết lập thông tin bảng `Class`:**
   - Tại ô **Table Name**, nhập: `Class`.
   - Thêm các cột (Columns) tương ứng:
     - `id`: Kiểu dữ liệu `INT`, tích chọn `PK` (Primary Key), `NN` (Not Null), `AI` (Auto Increment).
     - `name`: Kiểu dữ liệu `VARCHAR(100)`, tích chọn `NN` (Not Null).
5. **Thực thi:** Nhấp nút **Apply** ở góc dưới bên phải, kiểm tra câu lệnh DDL tự sinh rồi tiếp tục bấm **Apply** $\rightarrow$ bấm **Finish**.

### B. Tạo bảng `Teacher` (gồm các trường: id, name, age, country):
1. Nhấp chuột phải vào schema hoặc mục **Tables** $\rightarrow$ chọn **Create Table...**.
2. **Thiết lập thông tin bảng `Teacher`:**
   - Tại ô **Table Name**, nhập: `Teacher`.
   - Thêm các cột (Columns) tương ứng:
     - `id`: Kiểu dữ liệu `INT`, tích chọn `PK`, `NN`, `AI`.
     - `name`: Kiểu dữ liệu `VARCHAR(100)`, tích chọn `NN`.
     - `age`: Kiểu dữ liệu `INT`.
     - `country`: Kiểu dữ liệu `VARCHAR(50)`.
3. **Thực thi:** Nhấp nút **Apply** $\rightarrow$ bấm tiếp **Apply** $\rightarrow$ chọn **Finish** để hoàn tất.
4. **Kiểm tra:** Tại danh sách mục **Tables** của schema, bấm biểu tượng **Refresh**, cả 2 bảng `Class` và `Teacher` đã hiển thị đầy đủ.

---

## 3. Cách 2: Tạo bảng sử dụng câu lệnh SQL

### File mã nguồn: `student_management.sql`

```sql
-- 1. Tạo và sử dụng cơ sở dữ liệu
CREATE DATABASE IF NOT EXISTS `student_management`
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE `student_management`;

-- 2. Tạo bảng Class (id, name)
CREATE TABLE IF NOT EXISTS `Class` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(100) NOT NULL
);

-- 3. Tạo bảng Teacher (id, name, age, country)
CREATE TABLE IF NOT EXISTS `Teacher` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(100) NOT NULL,
    `age` INT,
    `country` VARCHAR(50)
);
