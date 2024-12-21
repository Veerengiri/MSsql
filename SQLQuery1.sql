-- 1. Database Design and Creation
CREATE DATABASE BookstoreDB;

USE BookstoreDB;

-- Create Tables
CREATE TABLE Authors (
    AuthorID INT PRIMARY KEY,
    AuthorName NVARCHAR(100) NOT NULL
);

CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName NVARCHAR(50) NOT NULL
);

CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title NVARCHAR(100) NOT NULL,
    AuthorID INT,
    CategoryID INT,
    Price DECIMAL(10,2) NOT NULL,
    StockQuantity INT NOT NULL,
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID),
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName NVARCHAR(100) NOT NULL,
    OrderDate DATE NOT NULL
);

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    BookID INT,
    Quantity INT NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);

-- 2. Data Insertion
INSERT INTO Authors VALUES 
(1, 'J.K. Rowling'), 
(2, 'George R.R. Martin'), 
(3, 'J.R.R. Tolkien'), 
(4, 'Agatha Christie'), 
(5, 'Dan Brown');

-- Insert Categories
INSERT INTO Categories VALUES 
(1, 'Fantasy'), 
(2, 'Mystery'), 
(3, 'Science Fiction'), 
(4, 'Thriller'), 
(5, 'Historical Fiction');

-- Insert Books
INSERT INTO Books VALUES 
(1, 'Harry Potter and the Philosopher''s Stone', 1, 1, 19.99, 10),
(2, 'A Game of Thrones', 2, 1, 24.99, 5),
(3, 'The Hobbit', 3, 1, 14.99, 7),
(4, 'Murder on the Orient Express', 4, 2, 29.99, 3),
(5, 'The Da Vinci Code', 5, 4, 39.99, 2),
(6, 'Harry Potter and the Chamber of Secrets', 1, 1, 9.99, 15),
(7, 'A Clash of Kings', 2, 1, 12.99, 10),
(8, 'The Lord of the Rings', 3, 1, 49.99, 4),
(9, 'And Then There Were None', 4, 2, 5.99, 6),
(10, 'Angels & Demons', 5, 4, 59.99, 1);

-- Insert Orders
INSERT INTO Orders VALUES 
(1, 'Alice Johnson', '2024-12-20'),
(2, 'Bob Smith', '2024-12-21'),
(3, 'Catherine Lee', '2024-12-22');

-- Insert OrderDetails
INSERT INTO OrderDetails VALUES 
(1, 1, 1, 2),
(2, 1, 3, 1),
(3, 2, 4, 3),
(4, 3, 5, 5),
(5, 3, 8, 1);

-- 3. Querying and Analysis

-- 3.1 Retrieve all books along with their authors and categories
SELECT Books.Title, Authors.AuthorName, Categories.CategoryName 
FROM Books 
JOIN Authors ON Books.AuthorID = Authors.AuthorID 
JOIN Categories ON Books.CategoryID = Categories.CategoryID;

-- 3.2 Find books that are out of stock
SELECT Title FROM Books WHERE StockQuantity = 0;

-- 3.3 Find the total revenue generated from all orders
SELECT SUM(Books.Price * OrderDetails.Quantity) AS TotalRevenue 
FROM OrderDetails 
JOIN Books ON OrderDetails.BookID = Books.BookID;

-- 3.4 Get the number of books available in each category
SELECT Categories.CategoryName, SUM(Books.StockQuantity) AS TotalStock 
FROM Books 
JOIN Categories ON Books.CategoryID = Categories.CategoryID 
GROUP BY Categories.CategoryName;

-- 3.5 List all orders with customer name, order date, book titles, and quantity ordered
SELECT Orders.CustomerName, Orders.OrderDate, Books.Title, OrderDetails.Quantity 
FROM OrderDetails 
JOIN Orders ON OrderDetails.OrderID = Orders.OrderID 
JOIN Books ON OrderDetails.BookID = Books.BookID;

-- 3.6 Find the most expensive book in the Science category
SELECT TOP 1 Title, Price 
FROM Books 
WHERE CategoryID = (SELECT CategoryID FROM Categories WHERE CategoryName = 'Science')
ORDER BY Price DESC;

-- 3.7 List customers who have ordered more than 5 books in a single order
SELECT Orders.CustomerName 
FROM Orders 
JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID 
GROUP BY Orders.CustomerName 
HAVING SUM(OrderDetails.Quantity) > 5;

-- 3.8 Identify authors whose books have generated revenue exceeding $500
SELECT Authors.AuthorName 
FROM Authors 
JOIN Books ON Authors.AuthorID = Books.AuthorID 
JOIN OrderDetails ON Books.BookID = OrderDetails.BookID 
GROUP BY Authors.AuthorName 
HAVING SUM(Books.Price * OrderDetails.Quantity) > 500;

-- 3.9 Calculate stock value and list the top 3 books by stock value
SELECT TOP 3 Title, (Price * StockQuantity) AS StockValue 
FROM Books 
ORDER BY StockValue DESC;

-- 3.10 Create a stored procedure GetBooksByAuthor
CREATE PROCEDURE GetBooksByAuthor
@AuthorID INT
AS
BEGIN
    SELECT Title FROM Books WHERE Books.AuthorID = @AuthorID;
END;

-- 3.11 Create a view TopSellingBooks
CREATE VIEW TopSellingBooks AS
SELECT TOP 5 Books.Title, SUM(OrderDetails.Quantity) AS TotalSold 
FROM Books 
JOIN OrderDetails ON Books.BookID = OrderDetails.BookID 
GROUP BY Books.Title 
ORDER BY TotalSold DESC;

-- 3.12 Create an index on the Books table for the Title column
CREATE INDEX idx_books_title ON Books(Title);
