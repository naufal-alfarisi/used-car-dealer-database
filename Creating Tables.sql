CREATE TABLE city (
city_id integer PRIMARY KEY,
city_name varchar(255),
latitude float,
longitude float
);

COPY city(city_id, city_name, latitude, longitude)
FROM 'D:\Pacman\SU_SE\Project\SQL\city.csv'
DELIMITER ','
CSV
HEADER;

SELECT * FROM city;

CREATE TABLE car_type(
	car_id varchar(255) PRIMARY KEY,
	brand varchar(255),
	model varchar(255),
	type varchar(255),
	transmission varchar(255)
);

COPY car_type(car_id,brand,model,type,transmission)
FROM 'D:\Pacman\SU_SE\Project\SQL\car_type.csv'
DELIMITER ','
CSV
HEADER;

SELECT * FROM car_type;

CREATE TABLE user_info(
	user_id varchar(255) PRIMARY KEY,
	first_name varchar(255),
	last_name varchar(255),
	city integer,
	email varchar(255) UNIQUE,
	phone_number varchar(255) UNIQUE,
	buyer boolean,
	seller boolean
);

COPY user_info(user_id,first_name,last_name,city,email,phone_number,buyer,seller)
FROM 'D:\Pacman\SU_SE\Project\SQL\user.csv'
DELIMITER ','
CSV
HEADER;

SELECT * FROM user_info;

CREATE TABLE car_product(
	product_id varchar(255) PRIMARY KEY,
	seller_id varchar(255),
	car_id varchar(255),
	year integer,
	price integer,
	color varchar(255),
	milage float,
	date_posted date,
	detail varchar(1000)
);

COPY car_product(product_id,seller_id,car_id,year,price,color,milage,date_posted,detail)
FROM 'D:\Pacman\SU_SE\Project\SQL\car_product.csv'
DELIMITER ','
CSV
HEADER;

SELECT * FROM car_product;

ALTER TABLE car_product
ALTER COLUMN milage SET DATA TYPE integer;

CREATE TABLE bid(
	bid_id varchar(255) PRIMARY KEY,
	buyer_id varchar(255),
	product_id varchar(255),
	date date,
	price integer,
	status varchar(255)
);

COPY bid(bid_id,buyer_id,product_id,date,price,status)
FROM 'D:\Pacman\SU_SE\Project\SQL\bid.csv'
DELIMITER ','
CSV
HEADER;

SELECT * FROM bid;
