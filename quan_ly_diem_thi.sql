-- Bước 1: Tạo cơ sở dữ liệu
CREATE DATABASE IF NOT EXISTS QuanLyDiemThi CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Bước 2: Chọn cơ sở dữ liệu để thao tác
USE QuanLyDiemThi;

-- Bước 3: Tạo bảng HocSinh
CREATE TABLE HocSinh (
    MaHS VARCHAR(20) PRIMARY KEY,
    TenHS VARCHAR(50) NOT NULL,
    NgaySinh DATETIME,
    Lop VARCHAR(20),
    GT VARCHAR(20)
);

-- Bước 4: Tạo bảng GiaoVien trước (để MonHoc có thể tham chiếu ngay hoặc thêm FK sau)
CREATE TABLE GiaoVien (
    MaGV VARCHAR(20) PRIMARY KEY,
    TenGV VARCHAR(50) NOT NULL,
    SDT VARCHAR(10)
);

-- Bước 5: Tạo bảng MonHoc (MaMH độ dài 50 theo bảng đặc tả)
CREATE TABLE MonHoc (
    MaMH VARCHAR(50) PRIMARY KEY,
    TenMH VARCHAR(50) NOT NULL,
    MaGV VARCHAR(20)
);

-- Bước 6: Tạo bảng trung gian BangDiem (Khóa chính tổ hợp MaHS + MaMH)
CREATE TABLE BangDiem (
    MaHS VARCHAR(20),
    MaMH VARCHAR(50),
    DiemThi INT,
    NgayKT DATETIME,
    PRIMARY KEY (MaHS, MaMH),
    FOREIGN KEY (MaHS) REFERENCES HocSinh(MaHS),
    FOREIGN KEY (MaMH) REFERENCES MonHoc(MaMH)
);

-- Bước 7: Bổ sung khóa ngoại cho bảng MonHoc tham chiếu đến bảng GiaoVien
ALTER TABLE MonHoc 
ADD CONSTRAINT FK_MaGV FOREIGN KEY (MaGV) REFERENCES GiaoVien(MaGV);
