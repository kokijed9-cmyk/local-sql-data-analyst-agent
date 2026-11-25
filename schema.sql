-- Create database
CREATE DATABASE IF NOT EXISTS analytics_demo
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE analytics_demo;

-- Create sales table
DROP TABLE IF EXISTS sales;

CREATE TABLE sales (
  id INT AUTO_INCREMENT PRIMARY KEY,
  product VARCHAR(100) NOT NULL,
  category VARCHAR(50) NOT NULL,
  amount DECIMAL(10, 2) NOT NULL,
  sale_date DATE NOT NULL
);

-- Seed sample sales records
INSERT INTO sales (product, category, amount, sale_date) VALUES
  ('Portland Cement', 'Building', 4500.00, '2026-10-01'),
  ('Red Bricks', 'Building', 2800.00, '2026-10-03'),
  ('Steel Rebar', 'Building', 7200.00, '2026-10-05'),
  ('Ceramic Tiles', 'Finishing', 3100.00, '2026-10-07'),
  ('Interior Paint', 'Finishing', 1450.00, '2026-10-10');
