USE master
IF EXISTS (SELECT * FROM sys.databases WHERE Name='BookLibrary')
DROP DATABASE BookLibrary
GO

CREATE DATABASE BookLibrary
GO

USE BookLibrary
GO

CREATE TABLE BOOK(
	BookCode INT,
	BookTitle VARCHAR(100),
	Author VARCHAR(50),
	Edition INT,
	BookPrice MONEY,
	Copies INT
)
GO

CREATE TABLE Member(
	MemberCode INT,
	Name VARCHAR(50),
	Address VARCHAR (100),
	PhoneNumber INT
)
GO

CREATE TABLE IssueDetails(
	BookCode INT,
	MemberCode INT,
	IssueDate DATETIME,
	ReturnDate DATETIME
)
GO

--Xóa bỏ các Ràng buộc Khóa ngoại của bảng IssueDetails
ALTER TABLE IssueDetails
DROP CONSTRAINT fk_ID
GO

--Xóa bỏ Ràng buộc Khóa chính của bảng Member và Book
ALTER TABLE Member
DROP CONSTRAINT pk_member
GO

ALTER TABLE Book
DROP CONSTRAINT pk_book
GO

--Thêm mới Ràng buộc Khóa chính cho bảng Member và Book
ALTER TABLE Member
ALTER COLUMN MemberCode INT NOT NULL;
ALTER TABLE Book
ALTER COLUMN BookCode INT NOT NULL;
GO

ALTER TABLE Member
ADD CONSTRAINT pk_member
PRIMARY KEY (MemberCode);
GO

ALTER TABLE Book
ADD CONSTRAINT pk_book
PRIMARY KEY (BookCode);
GO

--Thêm mới các Ràng buộc Khóa ngoại cho bảng IssueDetails
ALTER TABLE IssueDetails
ADD CONSTRAINT fk_ID
FOREIGN KEY (MemberCode) REFERENCES Member(MemberCode),
FOREIGN KEY (BookCode) REFERENCES Book(BookCode);
GO

--Bổ sung thêm Ràng buộc giá bán sách > 0 và < 200
ALTER TABLE Book
ADD CONSTRAINT check_price
CHECK (BookPrice > 0 AND BookPrice < 200)
GO

--Bổ sung thêm Ràng buộc duy nhất cho PhoneNumber của bảng Member
ALTER TABLE Member
ADD CONSTRAINT unique_number UNIQUE (PhoneNumber);
GO


--Bổ sung thêm ràng buộc NOT NULL cho BookCode, MemberCode trong bảng IssueDetails
ALTER TABLE IssueDetails
ALTER COLUMN BookCode INT NOT NULL;
ALTER TABLE IssueDetails
ALTER COLUMN MemberCode INT NOT NULL;
GO

--Tạo khóa chính gồm 2 cột BookCode, MemberCode cho bảng IssueDetails
ALTER TABLE IssueDetails
ADD CONSTRAINT pk_ID
PRIMARY KEY (BookCode, MemberCode);
GO

--Chèn dữ liệu hợp lý cho các bảng(Sử dụng SQL)
-- Thêm dữ liệu vào bảng BOOK
INSERT INTO BOOK (BookCode, BookTitle, Author, Edition, BookPrice, Copies)
VALUES
(1, 'The Great Gatsby', 'F. Scott Fitzgerald', 1, 19.99, 100),
(2, 'To Kill a Mockingbird', 'Harper Lee', 2, 15.50, 150),
(3, '1984', 'George Orwell', 1, 12.75, 200),
(4, 'Pride and Prejudice', 'Jane Austen', 3, 10.00, 120),
(5, 'The Catcher in the Rye', 'J.D. Salinger', 1, 18.25, 90);
GO

-- Thêm dữ liệu vào bảng Member
INSERT INTO Member (MemberCode, Name, Address, PhoneNumber)
VALUES
(1, 'John Doe', '123 Main St, Cityville, ABC', '+123456789'),
(2, 'Jane Smith', '456 Elm St, Townsville, XYZ', '+987654321'),
(3, 'Michael Johnson', '789 Oak St, Villagetown, DEF', '+246813579');
GO

-- Thêm dữ liệu vào bảng IssueDetails
INSERT INTO IssueDetails (BookCode, MemberCode, IssueDate, ReturnDate)
VALUES
(1, 1, '2024-07-20 10:00:00', NULL),
(2, 2, '2024-07-19 14:30:00', '2024-07-25 11:45:00'),
(3, 3, '2024-07-18 09:00:00', '2024-07-24 16:20:00');
GO