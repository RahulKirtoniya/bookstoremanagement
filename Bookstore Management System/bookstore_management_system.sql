
CREATE DATABASE bookstore_management_system;
use bookstore_management_system;


CREATE TABLE Authors (
    AuthorID INT AUTO_INCREMENT PRIMARY KEY,
    AuthorName VARCHAR(255) NOT NULL,
    Email VARCHAR(255),
    Birthdate DATE
);


CREATE TABLE Books (
    BookID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    ISBN VARCHAR(13),
    Genre VARCHAR(50),
    Price DECIMAL(10, 2),
    QuantityAvailable INT,
    AuthorID INT,
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID)
);


CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(255) NOT NULL,
    LastName VARCHAR(255) NOT NULL,
    Email VARCHAR(255),
    Phone VARCHAR(20)
);
CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);


CREATE TABLE OrderDetails (
    OrderDetailID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT,
    BookID INT,
    Quantity INT,
    Subtotal DECIMAL(10, 2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);


INSERT INTO Authors (AuthorName, Email, Birthdate)
VALUES
    ('Rahul1', 'rahul@email.com', '1990-01-01'),
    ('Rahul2', 'rahul2@email.com', '1985-03-15');


INSERT INTO Books (Title, ISBN, Genre, Price, QuantityAvailable, AuthorID)
VALUES
    ('Book1', '123456789', 'Fiction', 20.99, 50, 1),
    ('Book2', '987654321', 'Non-Fiction', 15.99, 30, 2);


INSERT INTO Customers (FirstName, LastName, Email, Phone)
VALUES
    ('Customer1', 'Lastname1', 'customer1@email.com', '123-456-7890'),
    ('Customer2', 'Lastname2', 'customer2@email.com', '987-654-3210');

INSERT INTO Orders (CustomerID, OrderDate, TotalAmount)
VALUES
    (1, '2024-02-01', 45.98),
    (2, '2024-02-05', 31.98);


INSERT INTO OrderDetails (OrderID, BookID, Quantity, Subtotal)
VALUES
    (1, 1, 2, 41.98),
    (1, 2, 1, 4.00),
    (2, 1, 3, 62.97);
SHOW DATABASES;
USE bookstore_management_system;
SHOW TABLES;
SELECT 
    b.Title,
    a.AuthorName,
    SUM(od.Quantity) AS TotalSold
FROM 
    Books b
    JOIN OrderDetails od ON b.BookID = od.BookID
    JOIN Authors a ON b.AuthorID = a.AuthorID
GROUP BY 
    b.Title, a.AuthorName
ORDER BY 
    TotalSold DESC;

SELECT 
    SUM(od.Subtotal) AS TotalRevenue
FROM 
    Orders o
    JOIN OrderDetails od ON o.OrderID = od.OrderID
WHERE 
    o.OrderDate BETWEEN '2024-02-01' AND '2024-02-05';
