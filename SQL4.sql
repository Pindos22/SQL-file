-- Create a new database called 'SaleSys'
-- Connect to the 'master' database to run this snippet
USE master
GO
-- Create the new database if it does not exist already
IF NOT EXISTS (
    SELECT [name]
        FROM sys.databases
        WHERE [name] = N'SaleSys'
)
CREATE DATABASE SaleSys
GO

-- Create a new table called '[Product]' in schema '[dbo]'
-- Drop the table if it already exists
IF OBJECT_ID('[dbo].[Product]', 'U') IS NOT NULL
DROP TABLE [dbo].[Product]
GO
-- Create the table in the specified schema
CREATE TABLE [dbo].[Product]
(
    [Id] INT(10) NOT NULL PRIMARY KEY, -- Primary Key column
    [Cat_id] INT(10) NOT NULL,
    [Name] NVARCHAR(50),
    [Price] Money,
    [Unit] INT,
    [Quantity] INT
);
GO

-- Create a new table called '[Category]' in schema '[dbo]'
-- Drop the table if it already exists
IF OBJECT_ID('[dbo].[Category]', 'U') IS NOT NULL
DROP TABLE [dbo].[Category]
GO
-- Create the table in the specified schema
CREATE TABLE [dbo].[Category]
(
    [Id] INT NOT NULL PRIMARY KEY, -- Primary Key column
    [Name] NVARCHAR(50)
);
GO

ALTER TABLE Product
ADD CONSTRAINT fk_cat_id
FOREIGN KEY (Cat_id) REFERENCES Category(Id)
GO



--Insert
INSERT INTO [dbo].[Product] ([Id], [Cat_id], [Name], [Price], [Unit], [Quantity])
VALUES
(1, 1, 'Smartphone', 599.99, 1, 100),
(2, 2, 'T-shirt', 29.99, 5, 200),
(3, 3, 'Harry Potter and the Philosopher''s Stone', 12.50, 1, 50),
(4, 4, 'Cookware Set', 149.99, 1, 30),
(5, 5, 'LEGO Set', 49.99, 1, 80);
GO

INSERT INTO [dbo].[Category] ([Id], [Name])
VALUES
(1, 'Electronics'),
(2, 'Clothing'),
(3, 'Books'),
(4, 'Home & Kitchen'),
(5, 'Toys');
GO


--Update
UPDATE [dbo].[Product]
SET [Price] = 39.99
WHERE [Id] = 2;
GO

UPDATE [dbo].[Category]
SET [Name] = 'Electronics (Updated)'
WHERE [Id] = 1;
GO


--Delete
DELETE FROM [dbo].[Product]
WHERE [Id] = 3;
GO

DELETE FROM [dbo].[Category]
WHERE [Id] = 5;
GO


--View
SELECT * FROM Product
GO

SELECT * FROM Category
GO


--Tìm theo tên
SELECT *
FROM [dbo].[Product]
WHERE [Name] = 'Smartphone';
GO

SELECT *
FROM [dbo].[Category]
WHERE [Name] = 'Books';
GO


--Tìm theo khoảng giá 0 - 200
SELECT *
FROM [dbo].[Product]
WHERE [Price] > 0 AND [Price] < 200;
GO