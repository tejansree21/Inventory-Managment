-- 1️⃣ Create Database
CREATE DATABASE InventoryDB;
USE InventoryDB;

-- 2️⃣ Create Tables

-- Table: Suppliers
CREATE TABLE Suppliers (
    supplier_id INT PRIMARY KEY AUTO_INCREMENT,
    supplier_name VARCHAR(100) NOT NULL,
    contact_person VARCHAR(100),
    phone VARCHAR(20),
    email VARCHAR(100),
    address TEXT
);

-- Table: Products
CREATE TABLE Products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    unit_price DECIMAL(10,2),
    quantity_in_stock INT,
    supplier_id INT,
    FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id)
);

-- Table: Customers
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100),
    phone VARCHAR(20),
    email VARCHAR(100),
    address TEXT
);

-- Table: Purchases (Stock In)
CREATE TABLE Purchases (
    purchase_id INT PRIMARY KEY AUTO_INCREMENT,
    supplier_id INT,
    product_id INT,
    quantity INT,
    purchase_date DATE,
    total_cost DECIMAL(10,2),
    FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Table: Sales (Stock Out)
CREATE TABLE Sales (
    sale_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    product_id INT,
    quantity INT,
    sale_date DATE,
    total_price DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- =========================================================
-- 3️⃣ Insert Sample Data
-- =========================================================

INSERT INTO Suppliers (supplier_name, contact_person, phone, email, address)
VALUES 
('TechWorld Supplies', 'Amit Sharma', '9876543210', 'amit@techworld.com', 'Delhi, India'),
('Global Traders', 'Neha Patel', '9123456780', 'neha@globaltraders.com', 'Mumbai, India');

INSERT INTO Products (product_name, category, unit_price, quantity_in_stock, supplier_id)
VALUES
('Laptop', 'Electronics', 65000, 10, 1),
('Keyboard', 'Accessories', 1200, 50, 2),
('Mouse', 'Accessories', 800, 40, 2);

INSERT INTO Customers (customer_name, phone, email, address)
VALUES
('Rahul Kumar', '9898989898', 'rahul@email.com', 'Delhi, India'),
('Sneha Gupta', '9777777777', 'sneha@email.com', 'Pune, India');

-- Purchases (Stock In)
INSERT INTO Purchases (supplier_id, product_id, quantity, purchase_date, total_cost)
VALUES 
(1, 1, 5, '2025-09-10', 325000),
(2, 2, 30, '2025-09-12', 36000),
(2, 3, 25, '2025-09-14', 20000);

-- Sales (Stock Out)
INSERT INTO Sales (customer_id, product_id, quantity, sale_date, total_price)
VALUES
(1, 1, 2, '2025-10-01', 130000),
(2, 2, 5, '2025-10-02', 6000),
(1, 3, 3, '2025-10-05', 2400);

-- =========================================================
-- 4️⃣ Queries and Reports
-- =========================================================

-- 🧾 View Current Inventory
SELECT product_name, category, unit_price, quantity_in_stock
FROM Products;

-- 🛒 Total Sales Report
SELECT p.product_name, SUM(s.quantity) AS total_sold, SUM(s.total_price) AS revenue
FROM Sales s
JOIN Products p ON s.product_id = p.product_id
GROUP BY p.product_name;

-- 🏬 Total Purchase Report
SELECT p.product_name, SUM(pr.quantity) AS total_purchased, SUM(pr.total_cost) AS total_cost
FROM Purchases pr
JOIN Products p ON pr.product_id = p.product_id
GROUP BY p.product_name;

-- 📉 Update Stock After Sale
UPDATE Products
SET quantity_in_stock = quantity_in_stock - 2
WHERE product_id = 1;

-- 📈 Update Stock After Purchase
UPDATE Products
SET quantity_in_stock = quantity_in_stock + 10
WHERE product_id = 2;

-- 🧾 Low Stock Alert
SELECT product_name, quantity_in_stock
FROM Products
WHERE quantity_in_stock < 10;
