-- Create a new database called 'TestTaskDB'
-- Connect to the 'master' database to run this snippet
USE master
GO
IF NOT EXISTS (
   SELECT name
   FROM sys.databases
   WHERE name = N'TestTaskDB'
)
CREATE DATABASE [TestTaskDB]
GO

-- Drop tables

IF EXISTS (SELECT name from sys.tables WHERE name = 'ProductCategories') DROP TABLE ProductCategories
IF EXISTS (SELECT name from sys.tables WHERE name = 'Products') DROP TABLE Products
IF EXISTS (SELECT name from sys.tables WHERE name = 'Categories') DROP TABLE Categories

GO

-- Create tables

CREATE TABLE Products (
    ProductID int PRIMARY KEY,
    ProductName varchar(50)
);

CREATE TABLE Categories (
    CategoryID int PRIMARY KEY,
    CategoryName varchar(50)
);

CREATE TABLE ProductCategories (
    ProductID int,
    CategoryID int,
    PRIMARY KEY (ProductID, CategoryID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

GO

-- Insert rows

INSERT INTO Products (ProductID, ProductName)
VALUES (1, 'Red Strat'), (2, 'Mediator DG'), (3, 'Mediator BM'), (4, 'Noname guitar'), (5, 'Elexir'), (6, 'Sheet of paper')

INSERT INTO Categories (CategoryID, CategoryName)
VALUES (1, 'Strings'), (2, 'Guitars'), (3, 'Acoustics'), (4, 'Electric'), (5, 'Drums'), (6, 'Cases'), 
(7, 'Mediators'), (8, 'Fender'), (9, 'Gibson'), (10, 'Les Paul'), (11, 'Stratocaster');

INSERT INTO ProductCategories (ProductID, CategoryID)
VALUES (1, 2), (1, 4), (1, 8), (1, 11), (2, 7), (2, 8), (3, 7), (4, 3), (5, 1) ;


-- Query

SELECT p.ProductName, COALESCE(c.CategoryName, 'No Category') AS CategoryName
FROM Products p
LEFT JOIN ProductCategories pc ON p.ProductID = pc.ProductID
LEFT JOIN Categories c ON pc.CategoryID = c.CategoryID
ORDER BY p.ProductName ASC;