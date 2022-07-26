-- dim table
CREATE TABLE Shipping
(
 ship_id   int NOT NULL,
 ship_mode varchar(30) NOT NULL,
 CONSTRAINT PK_30 PRIMARY KEY ( ship_id )
);
 
truncate table Shipping;
-- insert unique values + generate_id
insert into Shipping
select 100+row_number() over(), ship_mode from (select distinct ship_mode from orders) a;

select * from Shipping;

-- ************************************** Product

CREATE TABLE Product
(
 Product_id   varchar(30) NOT NULL,
 product_name varchar(130) NOT NULL,
 segment      varchar(30) NOT NULL,
 category     varchar(25) NOT NULL,
 "sub-Category" varchar(25) NOT NULL,
 CONSTRAINT PK_13 PRIMARY KEY ( Product_id )
);

-- ************************************** Geography

CREATE TABLE Geography
(
 geo_id      int NOT NULL,
 country     varchar(15) NOT NULL,
 city        varchar(20) NOT NULL,
 "state"       varchar(15) NOT NULL,
 region      varchar(15) NOT NULL,
 postal_code int4range NOT NULL,
 CONSTRAINT PK_43 PRIMARY KEY ( geo_id )
);

-- ************************************** Customer

CREATE TABLE Customer
(
 customer_id   varchar(25) NOT NULL,
 customer_name varchar(50) NOT NULL,
 CONSTRAINT PK_6 PRIMARY KEY ( customer_id, customer_name )
);


-- ************************************** Calendar

CREATE TABLE Calendar
(
 order_date date NOT NULL,
 ship_date  date NOT NULL,
 year       int4range NOT NULL,
 month      int4range NOT NULL,
 weak       int4range NOT NULL,
 week_day   int4range NOT NULL,
 "col_-2"      NOT NULL,
 CONSTRAINT PK_35 PRIMARY KEY ( order_date, ship_date )
);

-- fact table
-- ************************************** Metrics

CREATE TABLE Metrics
(
 row_id        int NOT NULL,
 ship_id       int NOT NULL,
 Product_id    varchar(30) NOT NULL,
 customer_id   varchar(25) NOT NULL,
 customer_name varchar(50) NOT NULL,
 order_date    date NOT NULL,
 ship_date     date NOT NULL,
 geo_id        int NOT NULL,
 sales         numeric(9,4) NOT NULL,
 quantity      integer NOT NULL,
 discount      numeric(4,2) NOT NULL,
 profit        numeric(21,16) NOT NULL,
 CONSTRAINT PK_22 PRIMARY KEY ( row_id, ship_id, Product_id, customer_id, customer_name, order_date, ship_date, geo_id ),
 CONSTRAINT FK_57 FOREIGN KEY ( ship_id ) REFERENCES Shipping ( ship_id ),
 CONSTRAINT FK_64 FOREIGN KEY ( geo_id ) REFERENCES Geography ( geo_id ),
 CONSTRAINT FK_67 FOREIGN KEY ( Product_id ) REFERENCES Product ( Product_id ),
 CONSTRAINT FK_70 FOREIGN KEY ( customer_id, customer_name ) REFERENCES Customer ( customer_id, customer_name ),
 CONSTRAINT FK_74 FOREIGN KEY ( order_date, ship_date ) REFERENCES Calendar ( order_date, ship_date )
);

CREATE INDEX FK_59 ON Metrics
(
 ship_id
);

CREATE INDEX FK_66 ON Metrics
(
 geo_id
);

CREATE INDEX FK_69 ON Metrics
(
 Product_id
);

CREATE INDEX FK_73 ON Metrics
(
 customer_id,
 customer_name
);

CREATE INDEX FK_77 ON Metrics
(
 order_date,
 ship_date
);


-- insert data with foreign key
select
order_id,
row_id,
sales,
quantity,
profit,
discount,
s.ship_id
from orders o inner join shipping s on o.ship_mode = s.ship_mode;
