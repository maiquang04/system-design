-- Drop existing user and database if they exist
DROP USER IF EXISTS 'auth_user'@'localhost';
DROP DATABASE IF EXISTS auth;

-- Create database and user
CREATE DATABASE auth;
CREATE USER 'auth_user'@'localhost' IDENTIFIED BY '123456789';

-- Grant privileges
GRANT ALL PRIVILEGES ON auth.* TO 'auth_user'@'localhost';

-- Use the database
USE auth;

-- Create table
CREATE TABLE user (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);

-- Insert default user
INSERT INTO user (email, password) VALUES ('admin@admin.com', '123456789');

-- Apply privileges
FLUSH PRIVILEGES;
