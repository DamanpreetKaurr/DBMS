create database daman;
use daman;
CREATE TABLE Students (
student_id INT AUTO_INCREMENT PRIMARY KEY,
first_name VARCHAR(50), last_name VARCHAR(50), dob DATE,
gender ENUM('Male', 'Female', 'Other'), email VARCHAR(100),
contact_number VARCHAR(15),
address TEXT
);

INSERT INTO Students (first_name, last_name, dob, gender, email, contact_number, address)
VALUES
('John', 'Doe', '1998-07-12', 'Male', 'john.doe@example.com', '9876543210', '123 Main St, City, Country'),
('Jane', 'Smith', '2000-11-20', 'Female', 'jane.smith@example.com', '9123456789', '456 Another St, City, Country');

CREATE TABLE Rooms (
room_id INT AUTO_INCREMENT PRIMARY KEY, room_number VARCHAR(10) UNIQUE,
room_type ENUM('Single', 'Double', 'Triple', 'Quad'), room_capacity INT,
room_status ENUM('Available', 'Occupied', 'Under Maintenance')
);

INSERT INTO Rooms (room_number, room_type, room_capacity, room_status)
VALUES
('A101', 'Single', 1, 'Available'), 
('A102', 'Double', 2, 'Available'), 
('B201', 'Triple', 3, 'Occupied');

CREATE TABLE Bookings (
booking_id INT AUTO_INCREMENT PRIMARY KEY, student_id INT,
room_id INT, booking_date DATE, check_in_date DATE, check_out_date DATE,
FOREIGN KEY (student_id) REFERENCES Students(student_id), FOREIGN KEY (room_id) REFERENCES Rooms(room_id)
);

INSERT INTO Bookings (student_id, room_id, booking_date, check_in_date, check_out_date)
VALUES
(1, 1, '2025-04-10', '2025-04-12', '2025-05-12'), 
(2, 2, '2025-04-11', '2025-04-15', '2025-05-15');

CREATE TABLE Fees (
fee_id INT AUTO_INCREMENT PRIMARY KEY, student_id INT,
amount DECIMAL(10, 2), fee_due_date DATE, fee_paid_date DATE,
status ENUM('Paid', 'Pending'),
FOREIGN KEY (student_id) REFERENCES Students(student_id)
);

INSERT INTO Fees (student_id, amount, fee_due_date, fee_paid_date, status) VALUES
(1, 500.00, '2025-04-30', '2025-04-20', 'Paid'), 
(2, 800.00, '2025-04-30', NULL, 'Pending');


CREATE TABLE Staff (
staff_id INT AUTO_INCREMENT PRIMARY KEY,
first_name VARCHAR(50), last_name VARCHAR(50), role VARCHAR(50),
contact_number VARCHAR(15), email VARCHAR(100)
);

INSERT INTO Staff (first_name, last_name, role, contact_number, email) VALUES
('Alice', 'Johnson', 'Warden', '9988776655', 'alice.johnson@hostel.com'), 
('Bob', 'Brown', 'Caretaker', '9777886655', 'bob.brown@hostel.com');

SELECT * FROM Students; 

SELECT * FROM Rooms WHERE room_status = 'Available';

SELECT b.booking_id, r.room_number, b.check_in_date,
b.check_out_date
FROM Bookings b
JOIN Rooms r ON b.room_id = r.room_id WHERE b.student_id = 1;

SELECT s.first_name, s.last_name, f.amount, f.status
FROM Fees f
JOIN Students s ON f.student_id = s.student_id WHERE s.student_id = 1;

UPDATE Rooms
SET room_status = 'Occupied'
WHERE room_id = 1;

UPDATE Fees
SET status = 'Paid', fee_paid_date = '2025-04-20'
WHERE fee_id = 1; 

DELETE FROM Bookings WHERE booking_id = 1;

