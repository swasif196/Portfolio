CREATE SEQUENCE if not exists tid
    INCREMENT 1
    START 1;

create table if not exists vendor
    (Vno char(5), Vname char(20), City char (10), Vbalance numeric(10,2),
     primary key (Vno));

create table if not exists customer
    (Account char(5), Cname char(20), Province char (10), Cbalance numeric(10,2), Crlimit numeric(10, 0), primary key (Account));

create table if not exists transactions
    (Tno char(5), Vno char(5), Account char(5), T_date date, Amount numeric(10,2), primary key (Tno));


INSERT INTO vendor VALUES ('V1', 'IKEA', 'Toronto', 200.00);
INSERT INTO vendor VALUES ('V2', 'Walmart', 'Waterloo', 671.05);
INSERT INTO vendor VALUES ('V3', 'Esso', 'Windsor', 0.00);
INSERT INTO vendor VALUES ('V4', 'Esso', 'Waterloo', 225.00);

INSERT INTO customer VALUES ('A1', 'Smith', 'ONT', 2515.00, 2000);
INSERT INTO customer VALUES ('A2', 'Jones', 'BC', 2014.00, 2500);
INSERT INTO customer VALUES ('A3', 'Doc', 'ONT', 150.00, 1000);

INSERT INTO transactions VALUES ('T'||nextval('tid'), 'V2', 'A1', '2020-07-15', 1325.00);
INSERT INTO transactions VALUES ('T'||nextval('tid'), 'V2', 'A3', '2019-12-16', 1900.00);
INSERT INTO transactions VALUES ('T'||nextval('tid'), 'V3', 'A1', '2020-09-01', 2500.00);
INSERT INTO transactions VALUES ('T'||nextval('tid'), 'V4', 'A2', '2020-03-20', 1613.00);
INSERT INTO transactions VALUES ('T'||nextval('tid'), 'V4', 'A3', '2020-07-31', 2212.00);