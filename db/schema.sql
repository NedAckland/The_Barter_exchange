CREATE DATABASE the_barter_exchange;

CREATE TABLE items (
    id SERIAL PRIMARY KEY,
    name TEXT,
    user_id INTEGER
);

CREATE TABLE wishlist (
    id SERIAL PRIMARY KEY,
    name TEXT,
    user_id INTEGER
);


CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name TEXT,
    email TEXT,
    password TEXT
);

INSERT INTO items (name, user_id) VALUES('', 1);
INSERT INTO users (name, email, password) VALUES('','', '');
INSERT INTO wishlist (name, user_id) VALUES('ballon', 1);