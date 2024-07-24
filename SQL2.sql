-- Sử dụng cơ sở dữ liệu Adventureworks
USE AdventureWorks2022
GO

SELECT * FROM HumanResources.Employee
SELECT * FROM HumanResources.Department WHERE DepartmentID > 15

SELECT DepartmentID, Name, GroupName FROM HumanResources.Department WHERE DepartmentID > 15
-- Khai báo biến
DECLARE @deptID INT --Khai báo biến cục bộ @ là deptID kiểu int
SET @deptID=12 --Thiết lập giá trị cho biến bằng 12
SELECT DepartmentID, Name, GroupName FROM HumanResources.Department
          WHERE DepartmentID >= @deptID

GO
USE NORTHWND

SELECT * FROM Categories
SELECT CategoryID, CategoryName, Description FROM Categories
SELECT EmployeeID, LastName, FirstName FROM Employees
SELECT * FROM Employees

SELECT @@LANGUAGE --Hiển thị thông tin của bản cài đặt ngôn ngữ @@LANGUAGE, trả lại thông tin ngôn ngữ sử dụng trong sql server
SELECT @@VERSION --Trả lại thông tin của bản cài đặt hiện tại của câu @@VERSION, trả lại thông tin về phiên bản sql server


USE AdventureWorks2022
GO
-- Lấy ra giá trị giá các sản phẩm từ trung tâm StandardsCost thuộc bảng ProductCostHistory
SELECT SUM(StandardCost) FROM Production.ProductCostHistory
-- Lấy giá trị trung bình của bảng trung tâm StandardsCost thuộc bảng ProductCostHistory
SELECT AVG(StandardCost) FROM Production.ProductCostHistory
-- Lấy giá trị lớn nhất của trung tâm StandardsCost trong bảng ProductCostHistory
SELECT MAX(StandardCost) FROM Production.ProductCostHistory
-- Lấy giá trị nhỏ nhất từ bảng trung tâm ProductCostHistory
SELECT MIN(StandardCost) FROM Production.ProductCostHistory
-- Không có trung bình từ bảng ProductProduction
SELECT TOP 10 ProductPhotoID, ThumbNailPhoto FROM Production.ProductPhoto

-- Lấy ra ngày hôm nay:
SELECT DATENAME(MM, GETDATE())
SELECT GETDATE()
SELECT DATEDIFF(DAY, GETDATE(), GETDATE() + 100)
--Tham khảo
--http://www.java2s.com/Code/SQLServer/Date-Timezone/CONVERTanyChar50GETDATE102.htm

-- Tạo cơ sở dữ liệu
SELECT DB_ID('AdventureWorks')
CREATE DATABASE EXAMPLES
USE EXAMPLES

-- Tạo bảng trong cơ sở dữ liệu
CREATE TABLE Contacts(
    MailID VARCHAR(20),
    Name NVARCHAR(20),
    TelephoneNumber INT)

-- Thêm 1 đối tượng vào bảng có sẵn:
ALTER TABLE Contacts ADD ADDRESS NVARCHAR(50)

-- Thêm nhiều đối tượng vào bảng
INSERT INTO Contacts values ('exelogical.com','Nguyen Van A',89809896,'NHà N01')
INSERT INTO Contacts values ('nvt@gmail.com','Nguyen Thi B',22332234,'NHà N02')
INSERT INTO Contacts values ('tramanv@gmail.com','Nguyen Van C',929234234,'NHà N01')
INSERT INTO Contacts values ('vanvi@gmail.com','Trịnh Văn D',4563576,'NHà N01')

-- Hiển thị ra dữ liệu từ bảng Contacts
SELECT * FROM Contacts

-- Xóa bỏ 1 dữ liệu trong bảng
DELETE FROM Contacts WHERE MailID='tramanv@gmail.com'

-- Sửa đổi dữ liệu
UPDATE Contacts SET Name=N'Nguyen Viet Anh' WHERE MailID='vandi@gmail.com'

-- Tạo login account có tên test1
CREATE LOGIN example3 WITH PASSWORD='123456'

-- Tạo user cho login account với tên example3
CREATE USER example3 FROM LOGIN example3

-- Như bỏ đi các quyền của user example3 trên bảng Contacts
REVOKE ALL ON example3 TO example3

-- Disconnect với connect tài khoản user example3/123456, thực hiện câu lệnh select để demo cho sinh viên thấy user không còn bất kỳ quyền nào trên bảng Contacts trong cơ sở dữ liệu
DENY ALL SELECT ON example3 TO example3
GRANT SELECT ON Contacts TO example3