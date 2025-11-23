CREATE DATABASE IF NOT EXISTS student_db;
USE student_db;

CREATE TABLE IF NOT EXISTS courses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    fees DECIMAL(10, 2) NOT NULL
);

CREATE TABLE IF NOT EXISTS students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    course_id INT,
    FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE SET NULL
);

-- Insert dummy data
INSERT INTO courses (name, fees) VALUES 
('Java Programming', 500.00),
('Web Development', 450.00),
('Database Management', 400.00);

INSERT INTO students (name, email, course_id) VALUES 
('John Doe', 'john@example.com', 1),
('Jane Smith', 'jane@example.com', 2);
