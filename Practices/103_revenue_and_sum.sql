-- Day 4 SQL practice dataset
-- Run this script in MySQL Workbench or your MySQL client.
CREATE DATABASE IF NOT EXISTS data_analyst_practice;
USE data_analyst_practice;

DROP TABLE IF EXISTS sales;

CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    order_date DATE NOT NULL,
    status VARCHAR(20) NOT NULL,
    product_id INT NOT NULL,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL
);

INSERT INTO sales
(sale_id, order_date, status, product_id, product_name, category, quantity, unit_price)
VALUES
(1, '2026-02-27', 'Completed', 304, 'Notebook Set', 'Accessories', 1, 350),
(2, '2026-03-13', 'Completed', 104, 'Headphones', 'Electronics', 2, 4500),
(3, '2026-02-14', 'Completed', 302, 'Backpack', 'Accessories', 1, 2200),
(4, '2026-04-22', 'Completed', 102, 'Wireless Mouse', 'Electronics', 2, 1200),
(5, '2026-04-12', 'Completed', 302, 'Backpack', 'Accessories', 2, 2200),
(6, '2026-04-23', 'Completed', 203, 'Bookshelf', 'Furniture', 1, 7000),
(7, '2026-03-23', 'Completed', 101, 'Laptop', 'Electronics', 1, 60000),
(8, '2026-04-21', 'Refunded', 103, 'Keyboard', 'Electronics', 1, 2500),
(9, '2026-07-14', 'Completed', 102, 'Wireless Mouse', 'Electronics', 3, 1200),
(10, '2026-05-16', 'Cancelled', 303, 'Desk Lamp', 'Accessories', 2, 1800),
(11, '2026-03-05', 'Refunded', 302, 'Backpack', 'Accessories', 1, 2200),
(12, '2026-05-31', 'Cancelled', 302, 'Backpack', 'Accessories', 2, 2200),
(13, '2026-10-23', 'Completed', 202, 'Study Desk', 'Furniture', 1, 15000),
(14, '2026-04-27', 'Completed', 304, 'Notebook Set', 'Accessories', 5, 350),
(15, '2026-02-21', 'Completed', 104, 'Headphones', 'Electronics', 1, 4500),
(16, '2026-03-25', 'Completed', 202, 'Study Desk', 'Furniture', 1, 15000),
(17, '2026-02-06', 'Completed', 201, 'Office Chair', 'Furniture', 1, 8500),
(18, '2026-05-06', 'Completed', 305, 'USB Hub', 'Electronics', 1, 1600),
(19, '2026-10-13', 'Completed', 304, 'Notebook Set', 'Accessories', 1, 350),
(20, '2026-04-28', 'Cancelled', 101, 'Laptop', 'Electronics', 3, 60000),
(21, '2026-05-18', 'Completed', 203, 'Bookshelf', 'Furniture', 4, 7000),
(22, '2026-06-11', 'Completed', 303, 'Desk Lamp', 'Accessories', 2, 1800),
(23, '2026-08-23', 'Completed', 304, 'Notebook Set', 'Accessories', 1, 350),
(24, '2026-10-15', 'Completed', 305, 'USB Hub', 'Electronics', 2, 1600),
(25, '2026-10-26', 'Completed', 203, 'Bookshelf', 'Furniture', 1, 7000),
(26, '2026-09-18', 'Completed', 103, 'Keyboard', 'Electronics', 3, 2500),
(27, '2026-03-20', 'Completed', 102, 'Wireless Mouse', 'Electronics', 3, 1200),
(28, '2026-11-02', 'Completed', 203, 'Bookshelf', 'Furniture', 1, 7000),
(29, '2026-09-28', 'Completed', 301, 'Water Bottle', 'Accessories', 2, 600),
(30, '2026-02-28', 'Completed', 101, 'Laptop', 'Electronics', 2, 60000),
(31, '2026-11-25', 'Completed', 201, 'Office Chair', 'Furniture', 1, 8500),
(32, '2026-08-21', 'Completed', 103, 'Keyboard', 'Electronics', 2, 2500),
(33, '2026-05-15', 'Refunded', 305, 'USB Hub', 'Electronics', 3, 1600),
(34, '2026-02-24', 'Cancelled', 302, 'Backpack', 'Accessories', 1, 2200),
(35, '2026-09-17', 'Completed', 304, 'Notebook Set', 'Accessories', 1, 350),
(36, '2026-10-04', 'Refunded', 103, 'Keyboard', 'Electronics', 4, 2500),
(37, '2026-11-03', 'Completed', 101, 'Laptop', 'Electronics', 1, 60000),
(38, '2026-06-07', 'Completed', 202, 'Study Desk', 'Furniture', 1, 15000),
(39, '2026-02-10', 'Completed', 303, 'Desk Lamp', 'Accessories', 2, 1800),
(40, '2026-09-30', 'Completed', 102, 'Wireless Mouse', 'Electronics', 1, 1200),
(41, '2026-10-09', 'Completed', 301, 'Water Bottle', 'Accessories', 2, 600),
(42, '2026-08-05', 'Refunded', 303, 'Desk Lamp', 'Accessories', 4, 1800),
(43, '2026-04-13', 'Completed', 305, 'USB Hub', 'Electronics', 1, 1600),
(44, '2026-07-11', 'Completed', 304, 'Notebook Set', 'Accessories', 2, 350),
(45, '2026-05-07', 'Completed', 102, 'Wireless Mouse', 'Electronics', 1, 1200),
(46, '2026-10-11', 'Completed', 303, 'Desk Lamp', 'Accessories', 1, 1800),
(47, '2026-11-20', 'Completed', 102, 'Wireless Mouse', 'Electronics', 1, 1200),
(48, '2026-06-19', 'Completed', 101, 'Laptop', 'Electronics', 1, 60000),
(49, '2026-09-06', 'Completed', 304, 'Notebook Set', 'Accessories', 1, 350),
(50, '2026-10-23', 'Completed', 303, 'Desk Lamp', 'Accessories', 3, 1800),
(51, '2026-04-08', 'Completed', 203, 'Bookshelf', 'Furniture', 2, 7000),
(52, '2026-08-05', 'Completed', 202, 'Study Desk', 'Furniture', 3, 15000),
(53, '2026-11-27', 'Completed', 101, 'Laptop', 'Electronics', 1, 60000),
(54, '2026-02-25', 'Completed', 202, 'Study Desk', 'Furniture', 1, 15000),
(55, '2026-03-13', 'Completed', 301, 'Water Bottle', 'Accessories', 1, 600),
(56, '2026-02-08', 'Completed', 104, 'Headphones', 'Electronics', 3, 4500),
(57, '2026-02-20', 'Completed', 302, 'Backpack', 'Accessories', 5, 2200),
(58, '2026-02-17', 'Refunded', 101, 'Laptop', 'Electronics', 3, 60000),
(59, '2026-07-28', 'Completed', 103, 'Keyboard', 'Electronics', 1, 2500),
(60, '2026-01-31', 'Completed', 203, 'Bookshelf', 'Furniture', 1, 7000),
(61, '2026-05-16', 'Refunded', 203, 'Bookshelf', 'Furniture', 3, 7000),
(62, '2026-08-05', 'Completed', 201, 'Office Chair', 'Furniture', 2, 8500),
(63, '2026-09-07', 'Completed', 302, 'Backpack', 'Accessories', 1, 2200),
(64, '2026-10-24', 'Completed', 101, 'Laptop', 'Electronics', 1, 60000),
(65, '2026-01-30', 'Completed', 202, 'Study Desk', 'Furniture', 1, 15000),
(66, '2026-03-22', 'Completed', 302, 'Backpack', 'Accessories', 2, 2200),
(67, '2026-02-05', 'Completed', 103, 'Keyboard', 'Electronics', 2, 2500),
(68, '2026-07-26', 'Completed', 104, 'Headphones', 'Electronics', 3, 4500),
(69, '2026-10-24', 'Completed', 104, 'Headphones', 'Electronics', 2, 4500),
(70, '2026-10-26', 'Completed', 203, 'Bookshelf', 'Furniture', 1, 7000),
(71, '2026-04-15', 'Completed', 201, 'Office Chair', 'Furniture', 1, 8500),
(72, '2026-07-22', 'Completed', 201, 'Office Chair', 'Furniture', 2, 8500),
(73, '2026-06-11', 'Refunded', 301, 'Water Bottle', 'Accessories', 4, 600),
(74, '2026-08-23', 'Completed', 101, 'Laptop', 'Electronics', 2, 60000),
(75, '2026-02-07', 'Completed', 102, 'Wireless Mouse', 'Electronics', 2, 1200),
(76, '2026-06-28', 'Cancelled', 103, 'Keyboard', 'Electronics', 3, 2500),
(77, '2026-05-26', 'Completed', 202, 'Study Desk', 'Furniture', 3, 15000),
(78, '2026-06-04', 'Completed', 305, 'USB Hub', 'Electronics', 5, 1600),
(79, '2026-09-28', 'Completed', 304, 'Notebook Set', 'Accessories', 3, 350),
(80, '2026-02-23', 'Refunded', 201, 'Office Chair', 'Furniture', 1, 8500),
(81, '2026-02-24', 'Completed', 102, 'Wireless Mouse', 'Electronics', 1, 1200),
(82, '2026-11-06', 'Completed', 201, 'Office Chair', 'Furniture', 1, 8500),
(83, '2026-11-21', 'Cancelled', 304, 'Notebook Set', 'Accessories', 2, 350),
(84, '2026-01-27', 'Completed', 201, 'Office Chair', 'Furniture', 1, 8500),
(85, '2026-01-23', 'Completed', 201, 'Office Chair', 'Furniture', 3, 8500),
(86, '2026-05-15', 'Completed', 304, 'Notebook Set', 'Accessories', 1, 350),
(87, '2026-08-07', 'Completed', 305, 'USB Hub', 'Electronics', 1, 1600),
(88, '2026-03-18', 'Completed', 305, 'USB Hub', 'Electronics', 3, 1600),
(89, '2026-10-10', 'Completed', 303, 'Desk Lamp', 'Accessories', 1, 1800),
(90, '2026-07-06', 'Cancelled', 201, 'Office Chair', 'Furniture', 3, 8500),
(91, '2026-07-03', 'Completed', 101, 'Laptop', 'Electronics', 1, 60000),
(92, '2026-07-01', 'Cancelled', 102, 'Wireless Mouse', 'Electronics', 3, 1200),
(93, '2026-11-14', 'Completed', 203, 'Bookshelf', 'Furniture', 4, 7000),
(94, '2026-03-25', 'Refunded', 104, 'Headphones', 'Electronics', 3, 4500),
(95, '2026-01-13', 'Completed', 203, 'Bookshelf', 'Furniture', 4, 7000),
(96, '2026-05-08', 'Completed', 203, 'Bookshelf', 'Furniture', 3, 7000),
(97, '2026-07-15', 'Cancelled', 102, 'Wireless Mouse', 'Electronics', 3, 1200),
(98, '2026-04-13', 'Cancelled', 104, 'Headphones', 'Electronics', 1, 4500),
(99, '2026-04-27', 'Completed', 201, 'Office Chair', 'Furniture', 2, 8500),
(100, '2026-06-18', 'Completed', 203, 'Bookshelf', 'Furniture', 1, 7000);

SELECT *, 
row_number() over()
FROM sales
WHERE status = 'Completed' and YEAR(order_date) = 2026;

SELECT product_id, product_name, sum(quantity)
FROM sales
WHERE status = 'Completed' and YEAR(order_date) = 2026
group by product_id, product_name
having sum(quantity)<10
order by sum(quantity);

select category, SUM(quantity * unit_price)
from sales
where status = 'Completed' and YEAR(order_date) = 2026
group by category
having SUM(quantity * unit_price)>50000
order by SUM(quantity * unit_price) desc;