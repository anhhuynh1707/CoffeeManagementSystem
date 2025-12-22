CREATE DATABASE coffee_management;
USE coffee_management;
CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  full_name VARCHAR(100) NOT NULL ,
  email VARCHAR(100) UNIQUE NOT NULL,
  password VARCHAR(255) NOT NULL,
  phone VARCHAR(20),
  address VARCHAR(255),
  role ENUM('admin', 'customer') DEFAULT 'customer',
  status VARCHAR(20) DEFAULT 'active',
  reset_token VARCHAR(255),
  reset_token_expiry DATETIME
);
INSERT INTO users (full_name, email, password, phone, address, role, status)
VALUES (
    'Admin',
    'admin@email.com',
    '$2a$12$XH8.0aTKrdCqqO2kibVx3uYzV.Al0lds9dB2l10yfEF8f3Xp5kQfW', -- Admin@123
    '0123456789',
    'HCMIU',
    'admin',
    'active'
);
CREATE TABLE menu (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  description TEXT,
  price decimal(10,0) NOT NULL,
  image_url VARCHAR(255),
  category VARCHAR(50),
  status VARCHAR(20) DEFAULT 'available',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
INSERT INTO menu (name, description, price, image_url, category, status)
VALUES
-- MATCHA
('Matcha Latte', 'Smooth Japanese matcha whisked with milk', 45000,
 'matcha_latte.jpg', 'Matcha', 'available'),

('Iced Matcha Latte', 'Cold refreshing matcha drink', 48000,
 'iced_matcha_latte.jpg', 'Matcha', 'available'),

('Matcha Frappe', 'Icy blended matcha with sweet cream', 52000,
 'matcha_frappe.jpg', 'Matcha', 'available'),

('Matcha Espresso Fusion', 'Matcha layered with espresso', 50000,
 'matcha_espresso_fusion.jpg', 'Matcha', 'available'),

-- COFFEE
('Americano', 'Smooth hot americano', 30000,
 'americano.jpg', 'Coffee', 'available'),

('Cappuccino', 'Espresso with steamed milk foam', 38000,
 'cappuccino.jpg', 'Coffee', 'available'),

('Latte', 'Rich espresso with steamed milk', 42000,
 'latte.jpg', 'Coffee', 'available'),

('Mocha', 'Chocolate-flavored caffe latte', 46000,
 'mocha.jpg', 'Coffee', 'available'),

('Iced Coffee', 'Cold brewed arabica coffee', 38000,
 'iced_coffee.jpg', 'Coffee', 'available'),

-- TEA
('Jasmine Green Tea', 'Light and floral green tea infusion', 32000,
 'jasmine_tea.jpg', 'Tea', 'available'),

('Peach Tea', 'Sweet peach-flavored iced tea', 36000,
 'peach_tea.jpg', 'Tea', 'available'),

('Lemon Black Tea', 'Bold black tea with lemon', 35000,
 'lemon_black_tea.jpg', 'Tea', 'available'),

-- MILK TEA
('Classic Milk Tea', 'Authentic Taiwanese milk tea', 39000,
 'classic_milk_tea.jpg', 'Milk Tea', 'available'),

('Brown Sugar Milk Tea', 'Brown sugar with tapioca pearls', 46000,
 'brown_sugar_milk_tea.jpg', 'Milk Tea', 'available'),

('Matcha Milk Tea', 'Creamy matcha mixed with milk tea', 45000,
 'matcha_milk_tea.jpg', 'Milk Tea', 'available'),

-- BAKERY
('Matcha Cheesecake', 'Soft cheesecake infused with matcha', 55000,
 'matcha_cheesecake.jpg', 'Bakery', 'available'),

('Chocolate Croissant', 'Flaky croissant with chocolate', 32000,
 'chocolate_croissant.jpg', 'Bakery', 'available'),

('Butter Croissant', 'Classic buttery French croissant', 28000,
 'butter_croissant.jpg', 'Bakery', 'available'),

('Tiramisu Cup', 'Italian dessert with mascarpone', 49000,
 'tiramisu_cup.jpg', 'Bakery', 'available'),

('Banana Muffin', 'Moist banana muffin baked daily', 25000,
 'banana_muffin.jpg', 'Bakery', 'available');
CREATE TABLE cart_items (
    cart_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    base_price DOUBLE NOT NULL,        -- from menu.price
    extra_price DOUBLE DEFAULT 0,      -- milk/toppings adjustments
    final_price DOUBLE NOT NULL,       -- base_price + extra_price
    milk_type VARCHAR(50),             -- same as order_items
    sugar_level VARCHAR(20),
    ice_level VARCHAR(20),
    toppings VARCHAR(200),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (product_id) REFERENCES menu(id)
);
CREATE TABLE order_items (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    base_price DOUBLE NOT NULL,
    extra_price DOUBLE DEFAULT 0,
    final_price DOUBLE NOT NULL,
    milk_type VARCHAR(50),
    sugar_level VARCHAR(20),
    ice_level VARCHAR(20),
    toppings VARCHAR(200),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES menu(id)
);
CREATE TABLE orders (
  order_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  subtotal DOUBLE NOT NULL,
  shipping_fee DOUBLE NOT NULL,
  total_amount DOUBLE NOT NULL,
  total_cups INT NOT NULL,
  status VARCHAR(20) DEFAULT 'pending',
  payment_method VARCHAR(50),
  transaction_id VARCHAR(100),
  payment_status VARCHAR(30),
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id)
);
CREATE TABLE shipping_zone (
    zone_id INT AUTO_INCREMENT PRIMARY KEY,
    city VARCHAR(100) NOT NULL,
    district VARCHAR(100) NOT NULL,
    shipping_fee INT NOT NULL
);
INSERT INTO shipping_zone (city, district, shipping_fee) VALUES
-- 15,000 VND zones
('Ho Chi Minh City', 'Thu Duc', 15000),
('Ho Chi Minh City', 'Binh Thanh', 15000),
-- 30,000 VND zones
('Ho Chi Minh City', 'District 1', 30000),
('Ho Chi Minh City', 'District 3', 30000),
('Ho Chi Minh City', 'District 4', 30000),
('Ho Chi Minh City', 'District 5', 30000),
('Ho Chi Minh City', 'District 7', 30000),
('Ho Chi Minh City', 'District 10', 30000),
('Ho Chi Minh City', 'Phu Nhuan', 30000),
-- 50,000 VND zones
('Ho Chi Minh City', 'District 6', 50000),
('Ho Chi Minh City', 'District 8', 50000),
('Ho Chi Minh City', 'District 11', 50000),
('Ho Chi Minh City', 'District 12', 50000),
('Ho Chi Minh City', 'Tan Binh', 50000),
('Ho Chi Minh City', 'Go Vap', 50000),
('Ho Chi Minh City', 'Binh Tan', 50000),
('Ho Chi Minh City', 'Tan Phu', 50000);
CREATE TABLE shipping (
    shipping_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    receiver_name VARCHAR(100),
    phone VARCHAR(20),
    address VARCHAR(255),
    city VARCHAR(100),
    district VARCHAR(100),
    ward VARCHAR(100),
    shipping_fee DOUBLE,
    method VARCHAR(50),
    status VARCHAR(20),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY(order_id) REFERENCES orders(order_id)
);