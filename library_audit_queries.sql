CREATE DATABASE library_audit;
USE library_audit;

CREATE TABLE books (
    book_id VARCHAR(20) PRIMARY KEY,
    title VARCHAR(100),
    author VARCHAR(100),
    is_issued BOOLEAN
);

CREATE TABLE users (
    user_id VARCHAR(20) PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE transactions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    book_id VARCHAR(20),
    user_id VARCHAR(20),
    issue_date DATE,
    due_date DATE,
    return_date DATE
);

INSERT INTO books VALUES
('B1001','Java Programming','James Gosling',FALSE),
('B1002','Python Basics','Guido van Rossum',TRUE),
('B1003','DBMS','Korth',FALSE),
('B1004','C Programming','Dennis Ritchie',TRUE),
('B1005','Data Structures','Mark Allen Weiss',FALSE),
('B1006','Operating Systems','Galvin',TRUE),
('B1007','Computer Networks','Andrew Tanenbaum',FALSE),
('B1008','Machine Learning','Tom Mitchell',TRUE),
('B1009','Artificial Intelligence','Stuart Russell',FALSE),
('B1010','Web Development','Jon Duckett',TRUE);

INSERT INTO users VALUES
('U1001','Akhil'),
('U1002','Rahul'),
('U1003','Teja'),
('U1004','Sandeep'),
('U1005','Kiran'),
('U1006','Vamsi'),
('U1007','Rohit'),
('U1008','Anil'),
('U1009','Mahesh'),
('U1010','Praveen');

INSERT INTO transactions(book_id,user_id,issue_date,due_date,return_date) VALUES
('B1001','U1001','2026-04-01','2026-04-08','2026-04-10'),
('B1002','U1002','2026-04-02','2026-04-09','2026-04-09'),
('B1003','U1003','2026-04-03','2026-04-10','2026-04-15'),
('B1004','U1004','2026-04-04','2026-04-11',NULL),
('B1005','U1005','2026-04-05','2026-04-12','2026-04-12'),
('B1006','U1006','2026-04-06','2026-04-13','2026-04-20'),
('B1007','U1007','2026-04-07','2026-04-14',NULL),
('B1008','U1008','2026-04-08','2026-04-15','2026-04-16'),
('B1009','U1009','2026-04-09','2026-04-16','2026-04-16'),
('B1010','U1010','2026-04-10','2026-04-17',NULL);

SELECT * FROM books;

SELECT * FROM books WHERE is_issued=FALSE;

SELECT * FROM books WHERE is_issued=TRUE;

SELECT * FROM transactions;

SELECT * FROM transactions WHERE return_date>due_date;

SELECT * FROM transactions WHERE return_date IS NULL;

SELECT * FROM users;

SELECT book_id,user_id,issue_date,due_date,return_date,
CASE WHEN return_date IS NULL THEN 0
WHEN DATEDIFF(return_date, due_date)>0 
THEN DATEDIFF(return_date, due_date)*10
ELSE 0 
END AS fine
FROM transactions;

SELECT * FROM transactions WHERE user_id='U1001';

SELECT t.book_id,b.title,u.name,t.issue_date,t.return_date
FROM transactions t
JOIN books b ON t.book_id=b.book_id
JOIN users u ON t.user_id=u.user_id;

SELECT book_id, COUNT(*) AS total_issued FROM transactions GROUP BY book_id ORDER BY total_issued DESC;

SELECT user_id, COUNT(*) AS total FROM transactions GROUP BY user_id ORDER BY total DESC;
