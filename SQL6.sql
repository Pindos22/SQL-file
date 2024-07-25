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
    Detail NVARCHAR(100) NOT NULL,
    Unit NVARCHAR(10) NOT NULL,
    Price MONEY
)
GO

CREATE TABLE Customer (
    ID VARCHAR(5) PRIMARY KEY NOT NULL,
    FirstName NVARCHAR(30) NOT NULL,
    SecondName NVARCHAR(10) NOT NULL,
    Address NVARCHAR(100) NOT NULL,
    Phone VARCHAR(10) NOT NULL
)
GO

CREATE TABLE Orders (
    OrderID VARCHAR(4) PRIMARY KEY NOT NULL,
    CustomerID VARCHAR(5) NOT NULL,
    OrderDate DATE
    FOREIGN KEY (CustomerID) REFERENCES Customer(ID)
)
GO

CREATE TABLE OrderDetails (
    OrderID VARCHAR(4) NOT NULL,
    ProdID VARCHAR(5) NOT NULL,
    Price MONEY,
    Qtt INT NOT NULL,
    Cost AS (Price * Qtt) PERSISTED,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProdID) REFERENCES Product(ID)
)
GO

--Viết các câu lệnh để thêm dữ liệu vào các bảng
-- Tạo dữ liệu cho bảng Product
INSERT INTO Product (ID, Name, Detail, Unit, Price)
VALUES
    ('P001', N'Laptop Dell XPS 13', N'Laptop siêu mỏng với màn hình 4K', 'cái', 2500.00),
    ('P002', N'iPhone 12 Pro', N'Smartphone của Apple với bộ nhớ 128GB', 'cái', 1200.00),
    ('P003', N'Đồng hồ thông minh Samsung Galaxy Watch 4', N'Đồng hồ thông minh tích hợp các tính năng theo dõi sức khỏe', 'cái', 299.99),
    ('P004', N'Tai nghe không dây Sony WH-1000XM4', N'Tai nghe chống ồn hiệu suất cao của Sony', 'cái', 349.99),
    ('P005', N'Máy ảnh mirrorless Canon EOS R6', N'Máy ảnh mirrorless với cảm biến 20.1 MP', 'cái', 2499.00),
    ('P006', N'Tai nghe chống ồn Bose QuietComfort 45', N'Tai nghe chống ồn của Bose', 'cái', 329.00),
    ('P007', N'iPad Pro 12.9-inch', N'Máy tính bảng với chip M1 và bộ nhớ 256GB', 'cái', 1099.00),
    ('P008', N'Smartphone Samsung Galaxy S21 Ultra', N'Smartphone Android hỗ trợ 5G', 'cái', 1199.99),
    ('P009', N'Máy ảnh mirrorless Sony A7 III', N'Máy ảnh mirrorless full-frame với 24.2 MP', 'cái', 1998.00),
    ('P010', N'Laptop cảm ứng Microsoft Surface Laptop 4', N'Laptop cảm ứng với vi xử lý AMD Ryzen', 'cái', 1299.00);
GO

-- Tạo dữ liệu cho bảng Customer
INSERT INTO Customer (ID, FirstName, SecondName, Address, Phone)
VALUES
    ('C001', N'Nguyễn Văn', N'An', N'123 Đường ABC, Quận 1, TP. HCM', '0123456789'),
    ('C002', N'Trần Thị', N'Bình', N'456 Đường XYZ, Quận 2, TP. HCM', '0987654321'),
    ('C003', N'Phạm Minh', N'Tuấn', N'789 Đường KLM, Quận 3, TP. HCM', '0369852147'),
    ('C004', N'Lê Thị', N'Mai', N'234 Đường DEF, Quận 4, TP. HCM', '0765432198'),
    ('C005', N'Hoàng Văn', N'Long', N'567 Đường GHI, Quận 5, TP. HCM', '0912345678'),
    ('C006', N'Đặng Thị', N'Hương', N'890 Đường UVW, Quận 6, TP. HCM', '0357924681'),
    ('C007', N'Vũ Minh', N'Đức', N'123 Đường LMO, Quận 7, TP. HCM', '0852369741'),
    ('C008', N'Nguyễn Thị', N'Thu', N'456 Đường NOP, Quận 8, TP. HCM', '0936852471'),
    ('C009', N'Trần Văn', N'Hòa', N'789 Đường QRS, Quận 9, TP. HCM', '0478523691'),
    ('C010', N'Lê Thanh', N'Tùng', N'234 Đường XYZ, Quận 10, TP. HCM', '0612345789');
GO

-- Tạo dữ liệu cho bảng Orders
INSERT INTO Orders (OrderID, CustomerID, OrderDate)
VALUES
    ('O001', 'C001', '2024-07-25'),
    ('O002', 'C002', '2024-07-24'),
    ('O003', 'C003', '2024-07-23'),
    ('O004', 'C004', '2024-07-22'),
    ('O005', 'C005', '2024-07-21'),
    ('O006', 'C006', '2024-07-20'),
    ('O007', 'C007', '2024-07-19'),
    ('O008', 'C008', '2024-07-18'),
    ('O009', 'C009', '2024-07-17'),
    ('O010', 'C010', '2024-07-16');
GO

-- Tạo dữ liệu cho bảng OrderDetails (ví dụ đơn hàng chi tiết)
INSERT INTO OrderDetails (OrderID, ProdID, Price, Qtt)
VALUES
    ('O001', 'P001', 2500.00, 2),
    ('O001', 'P002', 1200.00, 1),
    ('O002', 'P003', 299.99, 1),
    ('O003', 'P004', 349.99, 1),
    ('O003', 'P005', 2499.00, 1),
    ('O004', 'P006', 329.00, 2),
    ('O005', 'P007', 1099.00, 1),
    ('O005', 'P008', 1199.99, 1),
    ('O006', 'P009', 1998.00, 1),
    ('O007', 'P010', 1299.00, 1);
GO

--Viết các câu lênh truy vấn để
--a) Liệt kê danh sách khách hàng đã mua hàng ở cửa hàng.
SELECT DISTINCT c.ID, c.FirstName, c.SecondName, c.Address, c.Phone
FROM Customer c
JOIN Orders o ON c.ID = o.CustomerID
GO

--b) Liệt kê danh sách sản phẩm của của hàng
SELECT * FROM Product
GO

--c) Liệt kê danh sách các đơn đặt hàng của cửa hàng.
SELECT o.OrderID AS 'Mã số đơn hàng',
       CONCAT(c.FirstName, ' ', c.SecondName) AS 'Người đặt hàng',
       c.Address AS 'Địa chỉ',
       c.Phone AS 'Điện thoại',
       o.OrderDate AS 'Ngày đặt hàng',
       p.ID AS 'Mã sản phẩm',
       p.Name AS 'Tên hàng',
       p.Detail AS 'Mô tả',
       p.Unit AS 'Đơn vị',
       p.Price AS 'Giá',
       od.Qtt AS 'Số lượng',
       od.Cost AS 'Thành tiền'
FROM Orders o
JOIN Customer c ON o.CustomerID = c.ID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Product p on od.ProdID = p.ID
GO

--Viết các câu lệnh truy vấn để
--a) Liệt kê danh sách khách hàng theo thứ thự alphabet.
SELECT CONCAT(FirstName, ' ', SecondName) AS 'Họ và tên'
FROM Customer
Order BY SecondName ASC;
GO

--b) Liệt kê danh sách sản phẩm của cửa hàng theo thứ thự giá giảm dần.
SELECT *
FROM Product
ORDER BY Price DESC
GO

--c) Liệt kê các sản phẩm mà khách hàng Nguyễn Văn An đã mua.
SELECT CONCAT(c.FirstName, ' ', c.SecondName) AS 'Họ và tên',
       p.Name AS 'Tên sản phẩm',
       p.Detail AS 'Mô tả' 
FROM Orders o
JOIN Customer c ON o.CustomerID = c.ID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Product p on od.ProdID = p.ID
WHERE c.FirstName = N'Nguyễn Văn' AND c.SecondName = N'An'
GO

--Viết các câu lệnh truy vấn để
--a) Số khách hàng đã mua ở cửa hàng.
SELECT COUNT(DISTINCT CustomerID) AS 'Số lượng khách hàng đã mua'
FROM Orders o
JOIN OrderDetails od ON o.OrderID = od.OrderID
WHERE od.OrderID = o.OrderID
GO

--b) Số mặt hàng mà cửa hàng bán.
SELECT COUNT(DISTINCT ID) AS 'Số mặt hàng mà cửa hàng bán'
FROM Product
GO

--c) Tổng tiền của từng đơn hàng.
SELECT o.OrderID, SUM(od.Cost) AS TotalCost
FROM Orders o
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Product p ON od.ProdID = p.ID
GROUP BY o.OrderID
ORDER BY o.OrderID;
GO

--Thay đổi những thông tin sau từ cơ sở dữ liệu
--a) Viết câu lệnh để thay đổi trường giá tiền của từng mặt hàng là dương(>0).
UPDATE Product
SET Price = ABS(Price)
WHERE Price < 0;
GO

--b) Viết câu lệnh để thay đổi ngày đặt hàng của khách hàng phải nhỏ hơn ngày hiện tại.
UPDATE Orders
SET OrderDate = GETDATE() - 1
WHERE OrderDate >= GETDATE() - 1;
GO

--c) Viết câu lệnh để thêm trường ngày xuất hiện trên thị trường của sản phẩm.
ALTER TABLE Product
ADD OnDate DATE;
GO

--Thực hiện các yêu cầu sau
--a) Đặt chỉ mục (index) cho cột Tên hàng và Người đặt hàng để tăng tốc độ truy vấn dữ liệu trên
--các cột này.
--b) Xây dựng các view sau đây:
--View_KhachHang với các cột: Tên khách hàng, Địa chỉ, Điện thoại
--View_SanPham với các cột: Tên sản phẩm, Giá bán
--View_KhachHang_SanPham với các cột: Tên khách hàng, Số điện thoại, Tên sản
--phẩm, Số lượng, Ngày mua

--c) Viết các Store Procedure (Thủ tục lưu trữ) sau:
--SP_TimKH_MaKH: Tìm khách hàng theo mã khách hàng
--SP_TimKH_MaHD: Tìm thông tin khách hàng theo mã hóa đơn
--SP_SanPham_MaKH: Liệt kê các sản phẩm được mua bởi khách hàng có mã được
--truyền vào Store.