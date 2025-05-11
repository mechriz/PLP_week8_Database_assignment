-- Clinic Booking System Database
-- Created by [Your Name]

-- Create the database
DROP DATABASE IF EXISTS clinic_db;
CREATE DATABASE clinic_db;
USE clinic_db;

-- Tables
-- 1. Department Table
CREATE TABLE department (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE
) ENGINE=InnoDB;

-- 2. Doctor Table
CREATE TABLE doctor (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    license_number VARCHAR(20) NOT NULL UNIQUE,
    department_id INT NOT NULL,
    FOREIGN KEY (department_id) 
        REFERENCES department(department_id) 
        ON DELETE CASCADE
) ENGINE=InnoDB;

-- 3. Patient Table
CREATE TABLE patient (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(15) NOT NULL
) ENGINE=InnoDB;

-- 4. Appointment Table (1-M relationships)
CREATE TABLE appointment (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATETIME NOT NULL,
    status ENUM('Scheduled', 'Completed', 'Cancelled') NOT NULL DEFAULT 'Scheduled',
    FOREIGN KEY (patient_id) 
        REFERENCES patient(patient_id) 
        ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) 
        REFERENCES doctor(doctor_id) 
        ON DELETE CASCADE
) ENGINE=InnoDB;

-- 5. Medical Record Table (1-1 with Patient)
CREATE TABLE medical_record (
    record_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL UNIQUE, -- Ensures 1-1 relationship
    diagnosis TEXT,
    prescribed_medication TEXT,
    FOREIGN KEY (patient_id) 
        REFERENCES patient(patient_id) 
        ON DELETE CASCADE
) ENGINE=InnoDB;
