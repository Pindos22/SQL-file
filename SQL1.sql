USE NORTHWND
GO

--Truy vấn dữ liệu từ bảng Product (hiển thị toàn bộ các bản ghi)
SELECT *
FROM Products

--Chỉ lấy ra những sản phẩm có giá lớn hơn 1000$
SELECT *
FROM Products
WHERE [UnitPrice] > 100


--Chỉ lấy ra tên và giá của sản phẩm 
SELECT [ProductName], [UnitPrice]
FROM Products

--Lấy ra top 5 bản ghi đầu tiên của Product
SELECT TOP 5 *
FROM Products