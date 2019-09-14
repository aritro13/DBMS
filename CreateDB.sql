DROP DATABASE IF EXISTS smart_phone_ecommerce;

CREATE DATABASE smart_phone_ecommerce;

\c smart_phone_ecommerce;
CREATE TABLE item (
    item_ID serial PRIMARY KEY,
    item_price NUMERIC(5, 2)
);

CREATE TABLE seller (
    s_ID serial PRIMARY KEY,
    s_name varchar(50),
    s_password varchar(355),
    s_contact integer,
    s_warehouse varchar(50),
    item_ID integer REFERENCES item (item_ID)
);

CREATE TABLE product (
    p_ID serial PRIMARY KEY,
    p_name varchar(50),
    p_processor varchar(50),
    p_ram varchar(50),
    p_display varchar(50),
    p_battery varchar(50),
    camera_rear varchar(50),
    camera_front varchar(50),
    p_desc varchar(355),
    p_in_the_box varchar(255),
    item_ID integer REFERENCES item (item_ID)
);

CREATE TABLE cart (
    cart_ID serial PRIMARY KEY,
    cart_integer integer,
    integer_of_items integer,
    p_ID integer REFERENCES product (p_ID)
);

CREATE TABLE porder (
    order_ID serial PRIMARY KEY,
    payment_status varchar(50),
    integer_of_items integer,
    cart_ID integer REFERENCES cart (cart_ID),
    item_ID integer REFERENCES item (item_ID)
);

CREATE TABLE customer (
    c_ID serial PRIMARY KEY,
    c_wallet integer,
    c_contact integer,
    c_address varchar(355),
    first_name varchar(50),
    last_name varchar(50),
    c_password varchar(355),
    c_email varchar(50),
    cart_ID integer REFERENCES cart (cart_ID)
);

CREATE TABLE keeps (
    p_ID integer REFERENCES product (p_ID),
    s_ID integer REFERENCES seller (s_ID),
    PRIMARY KEY (p_ID, s_ID)
);

