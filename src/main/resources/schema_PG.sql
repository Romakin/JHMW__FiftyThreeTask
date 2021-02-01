CREATE TABLE IF NOT EXISTS CUSTOMERS (
    id SERIAL PRIMARY KEY,
    name varchar(255) DEFAULT '' NOT NULL,
    surname varchar(255) DEFAULT '' NOT NULL,
    age integer DEFAULT 18 NOT NULL CHECK (age > 0),
    phone_number varchar(255) DEFAULT NULL
    );
CREATE UNIQUE INDEX persons_uniq1 ON CUSTOMERS(name, surname, age);

CREATE TABLE IF NOT EXISTS ORDERS (
    id SERIAL PRIMARY KEY,
    date timestamp NOT NULL DEFAULT NOW(),
    product_name varchar(255) DEFAULT '' NOT NULL,
    customer_id integer,
    amount integer DEFAULT 0 CHECK (amount >= 0)
    );
CREATE UNIQUE INDEX orders_uniq1 ON ORDERS(product_name, customer_id);

ALTER TABLE ONLY ORDERS ADD CONSTRAINT c_customer FOREIGN KEY (customer_id) REFERENCES CUSTOMERS(id);

INSERT INTO CUSTOMERS(
    name,
    surname,
    age,
    phone_number
) VALUES
('Varvara', 'Businkova', 26, '89695521122'),
('Maria', 'Bostovich', 29, '88885552233'),
('Alexey', 'Bostovich', 32, '88621752233'),
('Michael', 'Kornov', 35, '85657832545');

INSERT INTO ORDERS(
    product_name,
    customer_id,
    amount
) VALUES
('pencil', 1, 20),
('notebook', 2, 10),
('clock', 3, 5),
('mouse pointer', 3, 6),
('keyboards', 3, 6),
('monitors', 4, 10),
('laptops', 4, 6)
;
