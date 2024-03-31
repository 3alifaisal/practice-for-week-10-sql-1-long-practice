-- Your code here
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS coffee_orders;

CREATE TABLE customers (
    id INTEGER PRIMARY KEY,
    name VARCHAR(40) NOT NULL,
    phone_number TEXT,
    points INTEGER DEFAULT 10,
    email VARCHAR(255) UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE coffee_orders (
    id INTEGER PRIMARY KEY,
    is_redeemed BOOLEAN DEFAULT 0,
    ordered_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    customer_id INTEGER REFERENCES customers(id)
);

CREATE TRIGGER PreventRedeemedOrderInsert
BEFORE INSERT ON coffee_orders
BEGIN
    SELECT RAISE(ABORT, 'Not enough points') 
    WHERE NEW.is_redeemed = 1 AND (SELECT points FROM customers WHERE id = NEW.customer_id) < 5;
END;

CREATE TRIGGER UpdatePointsAfterOrder
AFTER INSERT ON coffee_orders
BEGIN
    UPDATE customers
    SET points = 
        CASE 
            WHEN NEW.is_redeemed = 1 THEN points - 5
            ELSE points + 1
        END
    WHERE id = NEW.customer_id;
END;
