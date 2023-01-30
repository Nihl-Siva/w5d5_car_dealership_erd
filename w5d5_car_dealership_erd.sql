-- Table Creation
CREATE TABLE "salespersons" (
	"salesperson_id" SERIAL PRIMARY KEY,
	"first_name" VARCHAR(100),
	"last_name" VARCHAR(100)
);

CREATE TABLE "sales_invoices" (
	"sales_id" SERIAL PRIMARY KEY,
	"sold_date" TIMESTAMP,
	"amount" NUMERIC (10,2),
	"salesperson_id" INTEGER,
	"car_id" INTEGER,
	"customer_id" INTEGER,
	FOREIGN KEY("salesperson_id") REFERENCES "salespersons"("salesperson_id"),
	FOREIGN KEY("car_id") REFERENCES "cars"("car_id"),
	FOREIGN KEY("customer_id") REFERENCES "customers"("customer_id")	
);

CREATE TABLE "customers" (
	"customer_id" SERIAL PRIMARY KEY,
	"first_name" VARCHAR(100),
	"last_name" VARCHAR(100)
);

CREATE TABLE "service_tickets" (
	"ticket_id" SERIAL PRIMARY KEY,
	"mechanic_id" INTEGER,
	"service_id" INTEGER,
	FOREIGN KEY("mechanic_id") REFERENCES "mechanics"("mechanic_id"),	
	FOREIGN KEY("service_id") REFERENCES "service_invoices"("service_id")	
);

CREATE TABLE "dealer_inventory" (
	"inventory_id" SERIAL PRIMARY KEY,
	"used" BOOLEAN,
	"purchased_date" TIMESTAMP,
	"purchased_price" NUMERIC (10,2),
	"sale_price" NUMERIC (10,2),
	"days_in_lot" INTERVAL,
	"car_id" INTEGER,
	FOREIGN KEY("car_id") REFERENCES "cars"("car_id")
);

CREATE TABLE "mechanics" (
	"mechanic_id" SERIAL PRIMARY KEY,
	"first_name" VARCHAR(100),
	"last_name" VARCHAR(100)
);

CREATE TABLE "cars" (
	"car_id" SERIAL PRIMARY KEY,
	"make" VARCHAR(100),
	"model" VARCHAR(100),
	"year" INTEGER,
	"mileage" INTEGER,
	"dealer_owned" BOOLEAN
);

CREATE TABLE "service_invoices" (
	"service_id" SERIAL PRIMARY KEY,
	"service_date" TIMESTAMP,
	"amount" NUMERIC (10,2),
	"service_type" TEXT,
	"customer_id" INTEGER,
	"car_id" INTEGER,
	FOREIGN KEY("customer_id") REFERENCES "customers"("customer_id"),	
	FOREIGN KEY("car_id") REFERENCES "cars"("car_id")
);


-- Function Creation
CREATE OR REPLACE FUNCTION add_salesperson(first_name VARCHAR(100), last_name VARCHAR(100))
RETURNS VOID AS $$
BEGIN
   INSERT INTO salespersons(first_name, last_name)
   VALUES (first_name, last_name);
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION add_sales_invoice(sold_date TIMESTAMP, amount NUMERIC (10,2), salesperson_id INTEGER, car_id INTEGER, customer_id INTEGER)
RETURNS VOID AS $$
BEGIN
   INSERT INTO sales_invoices(sold_date, amount, salesperson_id, car_id, customer_id)
   VALUES (sold_date, amount, salesperson_id, car_id, customer_id);
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION add_customer(first_name VARCHAR(100), last_name VARCHAR(100))
RETURNS VOID AS $$
BEGIN
   INSERT INTO customers(first_name, last_name)
   VALUES (first_name, last_name);
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION add_service_ticket(mechanic_id INTEGER, service_id INTEGER)
RETURNS VOID AS $$
BEGIN
   INSERT INTO service_tickets(mechanic_id, service_id)
   VALUES (mechanic_id, service_id);
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION add_dealer_inventory(used BOOLEAN, purchased_date TIMESTAMP, purchased_price NUMERIC(10,2), sale_price NUMERIC(10,2), days_in_lot INTERVAL, car_id INTEGER)
RETURNS VOID AS $$
BEGIN
   INSERT INTO dealer_inventory(used, purchased_date, purchased_price, sale_price, days_in_lot, car_id)
   VALUES (used, purchased_date, purchased_price, sale_price, days_in_lot, car_id);
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION add_mechanic(first_name VARCHAR(100), last_name VARCHAR(100))
RETURNS VOID AS $$
BEGIN
   INSERT INTO mechanics(first_name, last_name)
   VALUES (first_name, last_name);
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION add_car(make VARCHAR(100), model VARCHAR(100), year INTEGER, mileage INTEGER, dealer_owned BOOLEAN)
RETURNS VOID AS $$
BEGIN
   INSERT INTO cars(make, model, year, mileage, dealer_owned)
   VALUES (make, model, year, mileage, dealer_owned);
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION add_service_invoice(service_date TIMESTAMP, amount NUMERIC (10,2), service_type TEXT, customer_id INTEGER, car_id INTEGER)
RETURNS VOID AS $$
BEGIN
  INSERT INTO "service_invoices" ("service_date", "amount", "service_type", "customer_id", "car_id")
  VALUES (service_date, amount, service_type, customer_id, car_id);
END;
$$ LANGUAGE plpgsql;


-- Table Insertion by Stored Function
SELECT add_customer('John', 'Doe');
SELECT add_customer('Jane', 'Smith');
SELECT add_customer('Bob', 'Johnson');
SELECT add_customer('Emily', 'Brown');

SELECT*
FROM customers;

SELECT add_salesperson('Avery', 'Henderson');
SELECT add_salesperson('Nash', 'Riley');
SELECT add_salesperson('Sophie', 'Myers');
SELECT add_salesperson('Jaxon', 'Parker');

SELECT*
FROM salespersons;

SELECT add_car('Toyota', 'Camry', 2021, 1000, true);
SELECT add_car('Honda', 'Accord', 2022, 5000, false);
SELECT add_car('Ford', 'Mustang', 2020, 10000, false);
SELECT add_car('Tesla', 'Model S', 2022, 5000, true);
SELECT add_car('Chevrolet', 'Camaro', 2020, 8000, false);
SELECT add_car('Nissan', 'Altima', 2021, 6000, false);
SELECT add_car('Jeep', 'Wrangler', 2022, 5000, true);
SELECT add_car('Subaru', 'Impreza', 2020, 9000, true);
SELECT add_car('Mazda', 'MX-5', 2022, 4000, false);
SELECT add_car('Kia', 'Optima', 2021, 7000, false);
SELECT add_car('Dodge', 'Charger', 2020, 8000, false);
SELECT add_car('Fiat', '124 Spider', 2022, 6000, false);

SELECT*
FROM cars
ORDER BY dealer_owned;

SELECT add_mechanic('Tommy', 'Shelby');
SELECT add_mechanic('Freddy', 'Black');
SELECT add_mechanic('Artie', 'Solomon');
SELECT add_mechanic('Abalama', 'Gold');

SELECT*
FROM mechanics;

SELECT add_dealer_inventory(TRUE, '2023-01-30 12:00:00', 25000.00, 27000.00, '7 days', 8);
SELECT add_dealer_inventory(FALSE, '2022-12-25 00:00:00', 35000.00, 38000.00, '30 days', 7);
SELECT add_dealer_inventory(TRUE, '2022-11-15 08:00:00', 45000.00, 48000.00, '60 days', 1);
SELECT add_dealer_inventory(FALSE, '2022-10-01 10:00:00', 55000.00, 58000.00, '90 days', 4);

SELECT*
FROM dealer_inventory;

SELECT add_sales_invoice('2022-12-12 12:00:00', 35000, 1, 9, 1);
SELECT add_sales_invoice('2022-11-22 14:30:00', 40000, 2, 11, 2);
SELECT add_sales_invoice('2022-10-15 16:00:00', 32000, 3, 12, 3);
SELECT add_sales_invoice('2022-09-10 09:00:00', 47000, 4, 3, 4);

SELECT*
FROM sales_invoices;

SELECT add_service_invoice('2022-05-10', 100.00, 'Oil Change', 1, 1);
SELECT add_service_invoice('2022-06-15', 150.00, 'Tire Rotation', 2, 2);
SELECT add_service_invoice('2022-07-20', 200.00, 'Brake Pad Replacement', 3, 3);
SELECT add_service_invoice('2022-08-25', 250.00, 'Battery Replacement', 4, 4);

SELECT*
FROM service_invoices;

SELECT add_service_ticket(1, 5);
SELECT add_service_ticket(2, 2);
SELECT add_service_ticket(3, 3);
SELECT add_service_ticket(4, 4);
SELECT add_service_ticket(1, 3);
SELECT add_service_ticket(2, 4);

SELECT*
FROM service_tickets;


-- Add "is_serviced" column to cars table
ALTER TABLE "cars" ADD COLUMN "is_serviced" BOOLEAN;
UPDATE cars SET is_serviced = false;

SELECT*
FROM cars;


-- Procedure to update "is_serviced"
CREATE OR REPLACE PROCEDURE update_service_status (IN _car_id INTEGER)
AS $$
BEGIN
    UPDATE cars
    SET is_serviced = true
    WHERE car_id = _car_id AND is_serviced = false;
END $$
LANGUAGE plpgsql;

CALL update_service_status(1);
CALL update_service_status(2);
CALL update_service_status(3);
CALL update_service_status(4);




