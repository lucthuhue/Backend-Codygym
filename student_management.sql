-- 1. Tạo CSDL nếu chưa tồn tại
CREATE DATABASE IF NOT EXISTS `student_management`
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

-- 2. Chọn CSDL làm việc
USE `student_management`;

-- 3. Tạo bảng Class (id, name)
CREATE TABLE IF NOT EXISTS `Class` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(100) NOT NULL
);

-- 4. Tạo bảng Teacher (id, name, age, country)
CREATE TABLE IF NOT EXISTS `Teacher` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(100) NOT NULL,
    `age` INT,
    `country` VARCHAR(50)
);
