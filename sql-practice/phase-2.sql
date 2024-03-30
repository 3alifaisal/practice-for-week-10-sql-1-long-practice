-- Your code here
DROP TABLE IF EXISTS customers,coffee_orders;

CREATE TABLE customers {
    id INTEGER PRIMARY KEY,
    name VARCHAR(40) NOT NULL,
    phone_number TEXT CHECK (
                            phone_number LIKE '%[0-9]%' AND
                            NOT phone_number LIKE '%[^0-9]%' AND
                            LENGTH(phone_number) <= 10),
    email VARCHAR(255) UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
};

CREATE TABLE coffee_orders {
    id INTEGER PRIMARY KEY,
    is_redeemed BOOLEAN DEFAULT 0,
    ordered_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    customer_id INTEGER REFERENCES customers(id),
};