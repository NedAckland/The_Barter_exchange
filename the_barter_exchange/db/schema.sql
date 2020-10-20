CREATE DATABASE the_barter_exchange;

CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    item_name TEXT,
    image_url TEXT,
    user_id INTEGER
);


CREATE TABLE vendors (
    id SERIAL PRIMARY KEY,
    vendor_name TEXT,
    password TEXT
);

INSERT INTO products (item_name, image_url, user_id) VALUES('', '', 1);