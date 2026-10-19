CREATE DATABASE IF NOT EXISTS `my_database1`
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE `my_database1`;

CREATE TABLE IF NOT EXISTS `HocVien` (
    `HocVienId` INT AUTO_INCREMENT PRIMARY KEY,
    `HoTen` VARCHAR(100) NOT NULL,
    `NgaySinh` DATE,
    `ThoiDiemTao` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `TrangThai` ENUM('dang_hoc', 'bao_luu', 'da_nghi') DEFAULT 'dang_hoc'
);
