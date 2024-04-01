CREATE DATABASE source;
USE source;
-- Create a table for storing information about customers
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    phone_number VARCHAR(20),
    registration_date DATE
);
-- Create a table for storing product information
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2),
    stock_quantity INT
);
-- Create a table for recording sales transactions
CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    sale_date DATE,
    quantity_sold INT,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
-- Create a table for tracking employees
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    hire_date DATE,
    salary DECIMAL(10, 2)
);
-- Create a table for recording employee attendance
CREATE TABLE attendance (
    attendance_id INT PRIMARY KEY,
    employee_id INT,
    attendance_date DATE,
    hours_worked DECIMAL(5, 2),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);


-- Insert sample data into the customers table
INSERT INTO customers (customer_id, first_name, last_name, email, phone_number, registration_date)
VALUES
    (1, 'John', 'Doe', 'john.doe@example.com', '123-456-7890', '2023-01-01'),
    (2, 'Jane', 'Smith', 'jane.smith@example.com', '987-654-3210', '2023-01-02'),
    (3, 'Bob', 'Johnson', 'bob.johnson@example.com', '555-123-4567', '2023-01-03'),
    (4, 'Michael', 'Williams', 'michael.williams@example.com', '333-444-5555', '2023-01-04'),
    (5, 'Emily', 'Brown', 'emily.brown@example.com', '111-222-3333', '2023-01-05'),
    (6, 'David', 'Davis', 'david.davis@example.com', '777-888-9999', '2023-01-06');

-- Insert sample data into the products table
INSERT INTO products (product_id, product_name, price, stock_quantity)
VALUES
    (1, 'Laptop', 999.99, 50),
    (2, 'Smartphone', 599.99, 100),
    (3, 'Headphones', 79.99, 200),
    (4, 'Tablet', 299.99, 75),
    (5, 'Smartwatch', 199.99, 150),
    (6, 'Printer', 149.99, 50);

-- Insert sample data into the sales table
INSERT INTO sales (sale_id, customer_id, product_id, sale_date, quantity_sold, total_amount)
VALUES
    (1, 1, 1, '2024-02-28', 2, 1999.98),
    (2, 2, 3, '2024-02-27', 3, 239.97),
    (3, 3, 2, '2024-02-26', 1, 599.99),
    (4, 4, 4, '2024-03-01', 1, 299.99),
    (5, 5, 5, '2024-03-02', 2, 399.98),
    (6, 6, 6, '2024-03-03', 1, 149.99);


-- Insert sample data into the employees table
INSERT INTO employees (employee_id, first_name, last_name, hire_date, salary)
VALUES
    (1, 'Alice', 'Johnson', '2023-01-15', 60000.00),
    (2, 'Charlie', 'Brown', '2023-02-10', 75000.00),
    (3, 'Eva', 'Miller', '2023-03-05', 90000.00),
    (4, 'Sophia', 'Martinez', '2023-04-01', 65000.00),
    (5, 'William', 'Taylor', '2023-04-02', 80000.00),
    (6, 'Olivia', 'Anderson', '2023-04-03', 70000.00);


-- Insert sample data into the attendance table
INSERT INTO attendance (attendance_id, employee_id, attendance_date, hours_worked)
VALUES
    (1, 1, '2024-02-28', 8.5),
    (2, 2, '2024-02-28', 7.5),
    (3, 3, '2024-02-27', 9.0),
    (4, 4, '2024-03-01', 8.0),
    (5, 5, '2024-03-01', 8.5),
    (6, 6, '2024-03-02', 7.0);

