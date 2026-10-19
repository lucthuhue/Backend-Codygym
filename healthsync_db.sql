-- ====================================================================
-- HỆ THỐNG HEALTHSYNC (OPTIMIZED DATABASE SCHEMA & SEED DATA)
-- Tác giả: System Analyst & DBA
-- ====================================================================

CREATE DATABASE IF NOT EXISTS healthsync_db 
CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE healthsync_db;

-- 1. BẢNG BỆNH NHÂN
CREATE TABLE IF NOT EXISTS Patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) NOT NULL
);

-- 2. BẢNG BÁC SĨ
CREATE TABLE IF NOT EXISTS Doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    specialty VARCHAR(50)
);

-- 3. BẢNG LỊCH HẸN (ĐÃ TÁI CẤU TRÚC HOÀN TOÀN)
-- - Loại bỏ is_active BOOLEAN
-- - Bổ sung ENUM trạng thái, các cột tài chính DECIMAL và lý do hủy
DROP TABLE IF EXISTS Prescriptions;
DROP TABLE IF EXISTS Appointments;

CREATE TABLE Appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATETIME NOT NULL,
    
    -- Vòng đời nghiệp vụ 5 trạng thái
    status ENUM('PENDING', 'CONFIRMED', 'CHECKED_IN', 'COMPLETED', 'CANCELLED') 
        NOT NULL DEFAULT 'PENDING',
        
    -- Xử lý tiền tệ chính xác tuyệt đối bằng DECIMAL
    deposit_amount DECIMAL(12, 2) NOT NULL DEFAULT 0.00 CHECK (deposit_amount >= 0),
    penalty_fee DECIMAL(12, 2) DEFAULT 0.00 CHECK (penalty_fee >= 0),
    cancel_reason VARCHAR(255) NULL,
    
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id) ON DELETE RESTRICT,
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id) ON DELETE RESTRICT
);

-- 4. BẢNG ĐƠN THUỐC (THỰC THỂ MỚI)
-- Quan hệ 1-1 với Appointments (Mỗi lịch khám hoàn thành chỉ có duy nhất 1 đơn thuốc)
CREATE TABLE Prescriptions (
    prescription_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT NOT NULL UNIQUE,
    medication_details TEXT NOT NULL,
    diagnosis VARCHAR(255) NOT NULL,
    issued_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id) ON DELETE RESTRICT
);

-- 5. TRIGGER CHẶN KÊ ĐƠN PHI LOGIC Ở TẦNG DATABASE
-- Nghiệp vụ: Chỉ cho phép chèn Đơn thuốc khi lịch hẹn đang ở trạng thái COMPLETED
DELIMITER $$
CREATE TRIGGER trg_before_insert_prescription
BEFORE INSERT ON Prescriptions
FOR EACH ROW
BEGIN
    DECLARE v_status VARCHAR(20);
    
    SELECT status INTO v_status 
    FROM Appointments 
    WHERE appointment_id = NEW.appointment_id;
    
    IF v_status <> 'COMPLETED' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Lỗi nghiệp vụ: Chỉ có thể kê đơn thuốc cho lịch hẹn đã hoàn thành (COMPLETED)!';
    END IF;
END$$
DELIMITER ;

-- ====================================================================
-- KỊCH BẢN THỬ NGHIỆM DỮ LIỆU THỰC TẾ (SEED & TEST SCRIPTS)
-- ====================================================================

-- Chèn dữ liệu mẫu
INSERT INTO Patients (patient_id, full_name, phone) VALUES 
(1, 'Nguyễn Văn An', '0901234567'),
(2, 'Trần Thị Bình', '0912345678');

INSERT INTO Doctors (doctor_id, full_name, specialty) VALUES 
(1, 'BS. Lê Quang Minh', 'Nội tổng quát'),
(2, 'BS. Hoàng Mai Lan', 'Tai Mũi Họng');

-- --------------------------------------------------------------------
-- KỊCH BẢN 1: QUY TRÌNH KHÁM BỆNH THÀNH CÔNG TRỌN VẸN
-- --------------------------------------------------------------------
-- Bước 1.1: Đặt lịch, đóng cọc 500.000đ -> Trạng thái PENDING
INSERT INTO Appointments (appointment_id, patient_id, doctor_id, appointment_date, status, deposit_amount)
VALUES (101, 1, 1, '2026-10-20 08:30:00', 'PENDING', 500000.00);

-- Bước 1.2: Xác nhận cọc -> CONFIRMED
UPDATE Appointments SET status = 'CONFIRMED' WHERE appointment_id = 101;

-- Bước 1.3: Bệnh nhân đến phòng khám -> CHECKED_IN
UPDATE Appointments SET status = 'CHECKED_IN' WHERE appointment_id = 101;

-- Bước 1.4: Bác sĩ khám xong -> COMPLETED
UPDATE Appointments SET status = 'COMPLETED' WHERE appointment_id = 101;

-- Bước 1.5: Kê đơn thuốc gắn với lịch hẹn 101
INSERT INTO Prescriptions (appointment_id, medication_details, diagnosis, issued_date)
VALUES (101, '1. Paracetamol 500mg (20 viên, ngày 2 lần)\n2. Vitamin C 500mg (10 viên, ngày 1 lần)', 'Viêm họng hạt cấp tính', NOW());

-- --------------------------------------------------------------------
-- KỊCH BẢN 2: BỆNH NHÂN HỦY LỊCH VÀ PHẠT TIỀN CỌC
-- --------------------------------------------------------------------
-- Bước 2.1: Đặt lịch, đóng cọc 300.000đ và đã được duyệt CONFIRMED
INSERT INTO Appointments (appointment_id, patient_id, doctor_id, appointment_date, status, deposit_amount)
VALUES (102, 2, 2, '2026-10-21 14:00:00', 'CONFIRMED', 300000.00);

-- Bước 2.2: Bệnh nhân báo hủy -> Update trạng thái CANCELLED, lý do và áp phí phạt 150.000đ
UPDATE Appointments 
SET status = 'CANCELLED',
    cancel_reason = 'Bận việc đột xuất',
    penalty_fee = 150000.00
WHERE appointment_id = 102;

-- --------------------------------------------------------------------
-- CÁC CÂU LỆNH TRUY VẤN KIỂM ĐỊNH TÍNH TOÀN VẸN
-- --------------------------------------------------------------------

-- Truy vấn 1: Danh sách bệnh nhân đã hoàn tất khám kèm chi tiết đơn thuốc
SELECT 
    a.appointment_id,
    p.full_name AS patient_name,
    d.full_name AS doctor_name,
    a.appointment_date,
    a.status,
    pr.diagnosis,
    pr.medication_details,
    pr.issued_date
FROM Appointments a
JOIN Patients p ON a.patient_id = p.patient_id
JOIN Doctors d ON a.doctor_id = d.doctor_id
JOIN Prescriptions pr ON a.appointment_id = pr.appointment_id
WHERE a.status = 'COMPLETED';

-- Truy vấn 2: Báo cáo đối soát tài chính tiền cọc và tiền phạt do hủy lịch
SELECT 
    a.appointment_id,
    p.full_name AS patient_name,
    a.status,
    a.deposit_amount AS tien_coc,
    a.penalty_fee AS phi_phat,
    (a.deposit_amount - a.penalty_fee) AS tien_hoan_tra_benh_nhan,
    a.cancel_reason
FROM Appointments a
JOIN Patients p ON a.patient_id = p.patient_id
WHERE a.status = 'CANCELLED';
