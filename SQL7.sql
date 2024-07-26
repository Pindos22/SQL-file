USE master
GO

IF EXISTS (
    SELECT [name]
        FROM sys.databases
        WHERE [name] = N'OK4U'
)
DROP DATABASE OK4U
GO

CREATE DATABASE OK4U
GO

USE OK4U
GO

CREATE TABLE Type (
    ID VARCHAR(4) PRIMARY KEY NOT NULL,
    Name NVARCHAR(50) NOT NULL
)
GO

CREATE TABLE Res (
    ID VARCHAR(6) PRIMARY KEY NOT NULL,
    FirstName NVARCHAR(30) NOT NULL,
    LastName NVARCHAR(10) NOT NULL
)
GO

CREATE TABLE Product (
    ProdID VARCHAR(10) PRIMARY KEY NOT NULL,
    ProdDate Date,
    TypeID VARCHAR(4) NOT NULL,
    ResID VARCHAR(6) NOT NULL
    FOREIGN KEY (TypeID) REFERENCES Type(ID),
    FOREIGN KEY (ResID) REFERENCES Res(ID)
)
GO

--Chèn thêm dữ liệu vào các bảng đã thiết kế
INSERT INTO Type (ID, Name) VALUES
('T001', N'Điện tử'),
('T002', N'Nội thất'),
('T003', N'Thời trang'),
('T004', N'Đồ chơi'),
('T005', N'Sách'),
('T006', N'Thể thao'),
('T007', N'Mỹ phẩm'),
('T008', N'Ô tô'),
('T009', N'Trang sức'),
('T010', N'Thực phẩm'),
('T011', N'Dụng cụ'),
('T012', N'Vườn'),
('T013', N'Văn phòng phẩm'),
('T014', N'Âm nhạc'),
('T015', N'Sức khỏe');
GO

INSERT INTO Res (ID, FirstName, LastName) VALUES
('R00001', N'Nguyễn Văn', N'Minh'),
('R00002', N'Trần Thị', N'Lan'),
('R00003', N'Lê Anh', N'Hòa'),
('R00004', N'Phạm Văn', N'Tuấn'),
('R00005', N'Bùi Thị', N'Thảo'),
('R00006', N'Vũ Đức', N'Nam'),
('R00007', N'Đinh Thị', N'Linh'),
('R00008', N'Hoàng Minh', N'Hải'),
('R00009', N'Dương Thị', N'An'),
('R00010', N'Lý Văn', N'Bình'),
('R00011', N'Mai Thị', N'Hương'),
('R00012', N'Ngô Văn', N'Khoa'),
('R00013', N'Đoàn Thị', N'Mai'),
('R00014', N'Hà Văn', N'Anh'),
('R00015', N'Tô Thị', N'Giang');
GO

INSERT INTO Product (ProdID, ProdDate, TypeID, ResID) VALUES
('P00000001', '2024-01-15', 'T001', 'R00001'),
('P00000002', '2024-02-20', 'T002', 'R00002'),
('P00000003', '2024-03-10', 'T003', 'R00003'),
('P00000004', '2024-04-05', 'T004', 'R00004'),
('P00000005', '2024-05-12', 'T005', 'R00005'),
('P00000006', '2024-06-18', 'T006', 'R00006'),
('P00000007', '2024-07-21', 'T007', 'R00007'),
('P00000008', '2024-08-25', 'T008', 'R00008'),
('P00000009', '2024-09-30', 'T009', 'R00009'),
('P00000010', '2024-10-15', 'T010', 'R00010'),
('P00000011', '2024-11-20', 'T011', 'R00011'),
('P00000012', '2024-12-05', 'T012', 'R00012'),
('P00000013', '2024-01-20', 'T013', 'R00013'),
('P00000014', '2024-02-15', 'T014', 'R00014'),
('P00000015', '2024-03-22', 'T015', 'R00015'),
('P00000016', '2024-04-18', 'T001', 'R00002'),
('P00000017', '2024-05-23', 'T003', 'R00004'),
('P00000018', '2024-06-10', 'T007', 'R00006'),
('P00000019', '2024-07-05', 'T008', 'R00009'),
('P00000020', '2024-08-12', 'T012', 'R00012');
GO

--4. Viết các câu lênh truy vấn để
--a) Liệt kê danh sách loại sản phẩm của công ty.
SELECT *
FROM Type
GO

--b) Liệt kê danh sách sản phẩm của công ty.
SELECT *
FROM Product
GO

--c) Liệt kê danh sách người chịu trách nhiệm của công ty.
SELECT ID AS 'Mã số người chịu trách nhiệm',
       CONCAT(FirstName, ' ', LastName) AS 'Người chịu trách nhiệm'
FROM Res
GO

--5. Viết các câu lệnh truy vấn để lấy
--a) Liệt kê danh sách loại sản phẩm của công ty theo thứ tự tăng dần của tên
SELECT *
FROM [Type]
ORDER BY Name ASC;
GO

--b) Liệt kê danh sách người chịu trách nhiệm của công ty theo thứ tự tăng dần của tên.
SELECT CONCAT(FirstName, ' ', LastName) AS 'Người chịu trách nhiệm'
FROM Res
ORDER BY LastName ASC;
GO

--c) Liệt kê các sản phẩm của loại sản phẩm có mã số là Z37E.
SELECT p.ProdID AS 'Mã số sản phẩm',
       p.ProdDate AS 'Ngày sản xuất',
       t.Name AS 'Tên loại sản phẩm',
       t.ID AS 'Mã loại sản phẩm',
       CONCAT(r.FirstName, ' ', r.LastName) AS 'Người chịu trách nhiệm',
       r.ID AS 'Mã số của người chịu trách nhiệm' 
FROM Product p
JOIN Type t ON p.TypeID = t.ID
JOIN Res r ON p.ResID = r.ID
WHERE t.ID = 'Z37E'
GO

--d) Liệt kê các sản phẩm Nguyễn Văn An chịu trách nhiệm theo thứ tự giảm đần của mã.
SELECT p.ProdID AS 'Mã số sản phẩm',
       p.ProdDate AS 'Ngày sản xuất',
       t.Name AS 'Tên loại sản phẩm',
       t.ID AS 'Mã loại sản phẩm',
       CONCAT(r.FirstName, ' ', r.LastName) AS 'Người chịu trách nhiệm',
       r.ID AS 'Mã số của người chịu trách nhiệm' 
FROM Product p
JOIN Type t ON p.TypeID = t.ID
JOIN Res r ON p.ResID = r.ID
WHERE r.FirstName = N'Trần Thị'
AND r.LastName = N'Lan'
ORDER BY p.ProdID DESC
GO

--6. Viết các câu lệnh truy vấn để
--a) Số sản phẩm của từng loại sản phẩm.
SELECT t.ID AS 'Mã loại sản phẩm',
       t.Name AS 'Tên loại sản phẩm',
       COUNT(DISTINCT p.ProdID) AS 'Số sản phẩm' 
FROM [Type] t
JOIN Product p ON t.ID = p.TypeID
GROUP BY t.ID, t.Name
ORDER BY t.ID
GO

--b) Số loại sản phẩm trung bình theo loại sản phẩm.
SELECT
    AVG(NumberOfProducts) AS 'Số loại sản phẩm trung bình theo loại sản phẩm'
FROM (
    SELECT
        TypeID,
        COUNT(ProdID) AS NumberOfProducts
    FROM
        Product
    GROUP BY
        TypeID
) AS ProductCounts;
GO

--c) Hiển thị toàn bộ thông tin về sản phẩm và loại sản phẩm.
SELECT p.ProdID AS 'Mã sản phẩm',
       p.ProdDate AS 'Ngày sản xuất',
       t.ID AS 'Mã loại sản phẩm',
       t.Name AS 'Tên loại sản phẩm' 
FROM [Type] t
JOIN Product p ON t.ID = p.TypeID
GO 

--d) Hiển thị toàn bộ thông tin về người chịu trách nhiêm, loại sản phẩm và sản phẩm.
SELECT p.ProdID AS 'Mã số sản phẩm',
       p.ProdDate AS 'Ngày sản xuất',
       t.Name AS 'Tên loại sản phẩm',
       t.ID AS 'Mã loại sản phẩm',
       CONCAT(r.FirstName, ' ', r.LastName) AS 'Người chịu trách nhiệm',
       r.ID AS 'Mã số của người chịu trách nhiệm' 
FROM Product p
JOIN Type t ON p.TypeID = t.ID
JOIN Res r ON p.ResID = r.ID
GO

--7. Thay đổi những thư sau từ cơ sở dữ liệu
--a) Viết câu lệnh để thay đổi trường ngày sản xuất là trước hoặc bằng ngày hiện tại.
UPDATE Product
SET ProdDate = GETDATE() - 1
WHERE ProdDate >= GETDATE();
GO

--b) Viết câu lệnh để xác định các trường khóa chính và khóa ngoại của các bảng.
-- Xác định các khóa chính
SELECT
    tc.TABLE_NAME AS TableName,
    kcu.COLUMN_NAME AS ColumnName,
    tc.CONSTRAINT_NAME AS ConstraintName
FROM
    INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS tc
JOIN
    INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE AS kcu
    ON tc.CONSTRAINT_NAME = kcu.CONSTRAINT_NAME
WHERE
    tc.CONSTRAINT_TYPE = 'PRIMARY KEY'
ORDER BY
    tc.TABLE_NAME, kcu.COLUMN_NAME;
GO

SELECT
    fk.name AS FK_Name,
    tp.name AS ParentTable,
    ref.name AS ReferencedTable,
    cp.name AS FK_Column,
    cr.name AS Referenced_Column
FROM
    sys.foreign_keys AS fk
INNER JOIN
    sys.tables AS tp ON fk.parent_object_id = tp.object_id
INNER JOIN
    sys.tables AS ref ON fk.referenced_object_id = ref.object_id
INNER JOIN
    sys.foreign_key_columns AS fkc ON fk.object_id = fkc.constraint_object_id
INNER JOIN
    sys.columns AS cp ON fkc.parent_object_id = cp.object_id AND fkc.parent_column_id = cp.column_id
INNER JOIN
    sys.columns AS cr ON fkc.referenced_object_id = cr.object_id AND fkc.referenced_column_id = cr.column_id
ORDER BY
    tp.name, fk.name, cp.name;
GO

--c) Viết câu lệnh để thêm trường phiên bản của sản phẩm.
ALTER TABLE Product
ADD Ver NVARCHAR(10);
GO