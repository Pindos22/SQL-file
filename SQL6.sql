USE master
GO

IF EXISTS (
    SELECT [name]
        FROM sys.databases
        WHERE [name] = N'ProductStorage'
)
DROP DATABASE ProductStorage
GO

CREATE DATABASE ProductStorage
GO

USE ProductStorage
GO

CREATE TABLE Product (
    ID VARCHAR(5) PRIMARY KEY NOT NULL,
    Name NVARCHAR(50) NOT NULL,
    Unit NVARCHAR(10) NOT NULL,
    Price MONEY
)
GO

CREATE TABLE [Order](
    OrderID VARCHAR(3) PRIMARY KEY NOT NULL,
    Customer NVARCHAR(50) NOT NULL,
    Address NVARCHAR(100) NOT NULL,
    Phone VARCHAR(10) NOT NULL,
    OrderDate DATE
)
GO

CREATE TABLE OrderDetails(
    OrderID VARCHAR(3) NOT NULL,
    ProdID VARCHAR(5) NOT NULL,
    ProdName NVARCHAR(50) NOT NULL,
    ProdDetail NVARCHAR(50) NOT NULL,
    Unit NVARCHAR(10) NOT NULL,
    Price MONEY NOT NULL,
    Qtt INT NOT NULL,
    Cost AS (Price * Qtt) PERSISTED,
    FOREIGN KEY (OrderID) REFERENCES [Order](OrderID),
    FOREIGN KEY (ProdID) REFERENCES [Product](ID)
)
GO

--Viết các câu lệnh để thêm dữ liệu vào các bảng
--Cho vào hai dữ liệu tưng tự như bảng đề bài trên
INSERT INTO Product (ID, Name, Unit, Price)
VALUES 
    ('P001', N'Máy Tính', N'Chiếc', 1000.00),
    ('P002', N'Điện Thoại', N'Chiếc', 200.00),
    ('P003', N'Máy In', N'Chiếc', 100.00),
    ('P004', N'Bàn Phím', N'Chiếc', 50.00),
    ('P005', N'Chuột', N'Chiếc', 30.00);
GO

INSERT INTO [Order] (OrderID, Customer, Address, Phone, OrderDate)
VALUES ('001', N'Nguyễn Văn An', N'111 Nguyễn Trãi, Thanh Xuân, Hà Nội', '987654321', '2024-07-24'),
       ('002', N'Trần Thị Bình', N'222 Lê Lợi, Quận 1, TP.HCM', '123456789', '2024-07-24');
GO

INSERT INTO OrderDetails (OrderID, ProdID, ProdName, ProdDetail, Unit, Price, Qtt)
VALUES 
    ('001', 'P001', N'Máy Tính', N'Máy nhập mới', N'Chiếc', 1000.00, 1),
    ('001', 'P002', N'Điện Thoại', N'Điện thoại đang hot', N'Chiếc', 200.00, 2),
    ('001', 'P003', N'Máy In', N'Máy in đang ế', N'Chiếc', 100.00, 1),
    ('001', 'P004', N'Bàn Phím', N'Bàn phím cơ', N'Chiếc', 50.00, 3),
    ('002', 'P001', N'Máy Tính', N'Máy nhập mới', N'Chiếc', 1000.00, 2),
    ('002', 'P003', N'Máy In', N'Máy in đang ế', N'Chiếc', 100.00, 1),
    ('002', 'P005', N'Chuột', N'Chuột không dây', N'Chiếc', 30.00, 4);
GO

--Viết các câu lênh truy vấn để
--a) Liệt kê danh sách khách hàng đã mua hàng ở cửa hàng.
SELECT Customer AS 'Người đặt hàng',
       Address AS 'Địa chỉ',
       Phone AS 'Số điện thoại'
FROM [Order]
GO

--b) Liệt kê danh sách sản phẩm của của hàng
SELECT * FROM Product
GO

--c) Liệt kê danh sách các đơn đặt hàng của cửa hàng.


SELECT
    o.OrderID AS OrderID,
    o.Customer,
    o.Address,
    o.Phone,
    o.OrderDate,
    od.ProdID,
    od.ProdName,
    od.ProdDetail,
    od.Unit,
    od.Price,
    od.Qtt,
    od.Cost AS TotalCost
FROM
    [Order] o
INNER JOIN
    OrderDetails od ON o.OrderID = od.OrderID
ORDER BY
    o.OrderID, od.ProdID;
