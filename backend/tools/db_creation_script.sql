DROP DATABASE IF EXISTS bee_kahve_db;

CREATE DATABASE bee_kahve_db;
USE bee_kahve_db;

CREATE TABLE Stock (
	stock_id INT AUTO_INCREMENT PRIMARY KEY,
	small_cup_count INT NOT NULL,
	medium_cup_count INT NOT NULL,
	large_cup_count INT NOT NULL,
	espresso_amount FLOAT NOT NULL,
	decaff_espresso_amount FLOAT NOT NULL,
	whole_milk_amount FLOAT NOT NULL,
	reduced_fat_milk_amount FLOAT NOT NULL,
	lactose_free_milk_amount FLOAT NOT NULL,
	oat_milk_amount FLOAT NOT NULL,
	almond_milk_amount FLOAT NOT NULL,
	chocolate_syrup_amount FLOAT NOT NULL,
	white_chocolate_syrup_amount FLOAT NOT NULL,
	caramel_syrup_amount FLOAT NOT NULL,
	white_sugar_amount FLOAT NOT NULL,
	brown_sugar_amount FLOAT NOT NULL,
	ice_amount INT NOT NULL
);

CREATE TABLE Admins (
	admin_id INT AUTO_INCREMENT PRIMARY KEY,
	admin_name VARCHAR(50) NOT NULL,
	stock_id INT UNIQUE,
	FOREIGN KEY (stock_id) REFERENCES Stock(stock_id),
	admin_email VARCHAR(50) UNIQUE NOT NULL,
	admin_password VARCHAR(50) NOT NULL,
);

CREATE TABLE Employees (
	employee_id INT AUTO_INCREMENT PRIMARY KEY,
	employee_name VARCHAR(50) NOT NULL,
	employee_email VARCHAR(50) UNIQUE NOT NULL,
	employee_password VARCHAR(50) NOT NULL,
	admin_id INT NOT NULL,
	FOREIGN KEY (admin_id) REFERENCES Admins(admin_id),
	is_employee_active TINYINT(1) DEFAULT 1
);

CREATE TABLE Customers (
	customer_id INT AUTO_INCREMENT PRIMARY KEY,
	customer_name VARCHAR(50) NOT NULL,
	customer_email VARCHAR(50) UNIQUE NOT NULL,
	customer_password VARCHAR(50) NOT NULL,
	customer_address VARCHAR(500),
	loyalty_coffee_count INT DEFAULT 0
);

CREATE TABLE Products (
	product_id INT PRIMARY KEY,
	coffee_name VARCHAR(50) UNIQUE NOT NULL,
	photo_path VARCHAR(50) NOT NULL,
	espresso_amount FLOAT NOT NULL,
	milk_amount FLOAT,
	foam_amount FLOAT,
	chocolate_syrup_amount FLOAT,
	caramel_syrup_amount FLOAT,
	sugar_amount FLOAT,
	small_cup_only TINYINT(1) DEFAULT 0,
	price FLOAT NOT NULL,
	rate FLOAT DEFAULT 0,
	rate_count INT DEFAULT 0,
	is_product_disabled TINYINT(1) DEFAULT 0
);

CREATE TABLE Orders (
	order_id INT PRIMARY KEY,
	customer_id INT NOT NULL,
	FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
	order_date VARCHAR(255) NOT NULL,
	order_status VARCHAR(255) NOT NULL,
	employee_id INT,
	FOREIGN KEY (employee_id) REFERENCES Employees(employee_id)
);

CREATE TABLE Line_Items (
	item_id INT AUTO_INCREMENT PRIMARY KEY,
	order_id INT NOT NULL,
	FOREIGN KEY (order_id) REFERENCES Orders(order_id),
	product_id INT NOT NULL,
	FOREIGN KEY (product_id) REFERENCES Products(product_id),
	size_choice VARCHAR(50) NOT NULL,
	milk_choice VARCHAR(50) NOT NULL,
	extra_shot_choice TINYINT(1) NOT NULL,
	caffein_choice TINYINT(1) NOT NULL
);

INSERT INTO Stock (small_cup_count, medium_cup_count, large_cup_count, espresso_amount, decaff_espresso_amount,
	whole_milk_amount, reduced_fat_milk_amount, lactose_free_milk_amount, oat_milk_amount, almond_milk_amount,
	chocolate_syrup_amount, white_chocolate_syrup_amount, caramel_syrup_amount,
	white_sugar_amount, brown_sugar_amount, ice_amount)
	VALUES (10, 15, 20, 100.0, 70.0, 1000.0, 1100.0, 1200.0, 1300.0, 1400.0,
	100.0, 110.0, 120.0, 130.0, 140.0, 100);

INSERT INTO Admins (admin_name, admin_email, admin_password, stock_id) VALUES ("Admin Name", "Admin Email", "Admin Password", 1);
INSERT INTO Employees (employee_name, employee_email, employee_password, admin_id) VALUES ("Employee Name", "Employee Email", "Employee Password", 1);
INSERT INTO Customers (customer_name, customer_email, customer_password) VALUES ("Customer Name", "Customer Email", "Customer Password");
INSERT INTO Products (product_id, coffee_name, photo_path, espresso_amount, milk_amount, price) VALUES (1, "Coffee Name", "Photo path", 40.0, 100.0, 60.0);
