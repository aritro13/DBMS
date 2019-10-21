DROP DATABASE IF EXISTS smart_phone_ecommerce;

CREATE DATABASE smart_phone_ecommerce;

\c smart_phone_ecommerce;
CREATE TABLE customer (
    c_ID serial PRIMARY KEY,
    c_wallet float(5),
    c_contact bigint,
    c_address varchar(355),
    first_name varchar(50),
    last_name varchar(50),
    c_password varchar(355),
    c_email varchar(50)
);
CREATE TABLE product (
    p_ID serial PRIMARY KEY,
    p_name varchar(300),
    p_processor varchar(300),
    p_ram varchar(200),
    p_display varchar(200),
    p_battery varchar(200),
    camera_rear varchar(100),
    camera_front varchar(100),
    p_desc varchar(1000),
    p_in_the_box varchar(1000)
);
CREATE TABLE seller (
    s_ID serial PRIMARY KEY,
    s_name varchar(50),
    s_email varchar(50),
    s_password varchar(355),
    s_contact bigint,
    s_warehouse varchar(50)
);
CREATE TABLE seller_keeps_products (
    p_ID integer REFERENCES product (p_ID),
    s_ID integer REFERENCES seller (s_ID),
    PRIMARY KEY (p_ID, s_ID)
);

CREATE TABLE item (
    item_ID serial PRIMARY KEY,
    item_price float(5),
    p_ID integer REFERENCES product (p_ID),
    s_ID integer REFERENCES seller (s_ID)
);

CREATE TABLE cart (
    cart_ID serial PRIMARY KEY,
    number_of_items integer,
    c_ID integer REFERENCES customer (c_ID)
);

CREATE TABLE porder (
    order_ID serial PRIMARY KEY,
    payment_status varchar(50),
    cart_ID integer REFERENCES cart (cart_ID)
);


CREATE TABLE order_contains_items (
    item_ID integer REFERENCES item (item_ID),
    order_ID integer REFERENCES porder (order_ID),
    PRIMARY KEY (item_ID, order_ID)
);
CREATE TABLE cart_contains_product (
    quantity integer,
    cart_ID integer REFERENCES cart (cart_ID),
    p_ID integer REFERENCES product (p_ID),
    PRIMARY KEY (cart_ID, p_ID)
);


\echo 'Experiment 4'

INSERT INTO seller (s_name, s_email, s_password, s_contact, s_warehouse)
    VALUES ('Rahul', 'rahul@gmail.com', 'password', 9983747382, 'Mumbai'), 
    ('Rohan', 'rohan@gmail.com', 'password', 9983747383,'Mumbai'), 
    ('Rohit', 'rohit@gmail.com', 'password', 9983747384,'Mumbai'), 
    ('Rakesh', 'rakesh@gmail.com', 'password', 9983747385,'Mumbai');

INSERT INTO product (p_name, p_ram, p_display, camera_rear, camera_front, p_battery, p_processor, p_desc, p_in_the_box)
    VALUES ('Samsung Galaxy A70',
    '6 GB RAM',
    '17.02 cm (6.7 inch) FHD+ Display',
    '32 MP + 8 MP + 5 MP',
    '32 MP',
    '4000 mAh Li-polymer Battery',
    'Octa core (2 GHz, Dual core, Kryo 460 + 1.7 GHz, Hexa Core, Kryo 460) Processor',
    'The Samsung Galaxy A70 is here to make your life much simpler with its set of features. From making secure payments via Samsung Pay to watching your favourite scenes on the FHD+ Super AMOLED Infinity-U display, this phone will make your smartphone experience truly delightful. Not to forget, it features a triple rear camera (32 MP + 8 MP + 5 MP) and a 32 MP front camera to let you click beautiful pictures',
    'Handset, Earphone, Travel Adapter, USB Cable, Ejection Pin, User Manual'
    ),
    ('OPPO F11 Pro',
    '6 GB RAM ',
    '16.51 cm (6.5 inch) FHD+ Display',
    '48MP + 5MP',
    '16 MP',
    '4000 mAh Li-polymer Battery',
    'MediaTek Helio P70 Octa Core 2.1 GHz Processor',
    'There are plenty of reasons as to why the OPPO F11 Pro smartphone is going to be your new favourite device. For the picture lovers, this phone will be a boon, thanks to its 48 MP + 5 MP Dual Rear camera and its rising front camera. Its massive 4000 mAh battery will keep you glued to your device, without worrying about charging.',
    'Handset, Adapter, Headset, Micro-USB Cable, Important Information Booklet with Warranty Card, Quick Guide, SIM Card Tool, Screen Protect Film, Case'
    ),
    ('Redmi Note 7S ',
    '4 GB RAM ',
    '16.0 cm (6.3 inch) FHD+ Display',
    '48MP + 5MP',
    '13MP',
    '4000 mAh Battery',
    'Qualcomm Snapdragon 660 AIE Processor',
    'Shoot amazing pictures like a pro with the Redmi Note 7S which features a 48 MP + 5 MP dual rear camera setup.',
    'Handset, Charging Cable, SIM Ejector Tool, Warranty Card, Manual, Soft Protective Case, Adapter'
    ),
    ('Sony Xperia Z3+',
    '3 GB RAM',
    '13.21 cm (5.2 inch) Full HD Display',
    '20.7MP Rear Camera',
    '5MP Front Camera',
    '2930 mAh Battery',
    'Qualcomm Snapdragon 810 MSM8994 Processor',
    'With a thickness of 6.9mm the Sony Xperia Z3 is impossibly slim with an aluminum frame that makes it look very stylish in your hand. The phone has a camera of 20.7MP giving you stunning pictures of landscapes and other objects. With a battery that lasts for over two days, you can enjoy watching videos and listening to all your favourite tracks for long hours.',
    'Handset, Charger, USB Cable, Stereo Headset, User Guide, Screen Protector'
    );

INSERT INTO  customer (c_wallet ,c_contact ,c_address ,first_name ,last_name ,c_password ,c_email)
 VALUES (800000,9856457851,'Mumbai','Aritro','Biswas','hash','aritro13@gmail.com'),
    (63000,9824575412,'Hydrabad','Rohan','Katkam','hash','rohan@gmail.com'),
    (75225,4575412632,'Pune','Rohit','Gupta','hash','rohit@gupta'),
    (54655,2365478594,'Rajasthan','Advait','Maindalkar','hash','advait@gmail.com'); 

INSERT INTO item (item_price,s_ID,p_ID)
    VALUES (28990,1,1), 
    (20990,2,2), 
    (11999,3,3), 
    (55990,4,4);

INSERT INTO cart (number_of_items , c_ID )
    VALUES (1,1),
    (2,2),
    (3,3),
    (4,4);
    
INSERT INTO porder (payment_status ,cart_ID )
    VALUES ('complete',1),
    ('incomplete',2),
    ('incomplete',3),
    ('complete',4);  
 

INSERT INTO seller_keeps_products (p_ID,s_ID)
 VALUES (1,1),
    (2,2),
    (3,3),
    (4,4); 

INSERT INTO order_contains_items (item_ID,order_ID)
 VALUES (1,1),
    (2,2),
    (3,3),
    (4,4);  

INSERT INTO cart_contains_product (cart_ID,p_ID,quantity)
 VALUES (1,1,1),
    (2,2,2),
    (3,3,3),
    (4,4,4);  
    
SELECT * FROM item;
SELECT * FROM seller;
SELECT p_name FROM product;
SELECT * FROM cart;
SELECT * FROM porder;
SELECT * FROM customer;
SELECT * FROM seller_keeps_products;
SELECT * FROM order_contains_items;
SELECT * FROM cart_contains_product;


\echo 'Experiment 5'

\echo 'Insert new item'
INSERT INTO item (item_price,s_ID,p_ID)
VALUES  (30000, 2,1);
SELECT * FROM item;

INSERT INTO seller_keeps_products (s_ID,p_ID)
VALUES  ( 2,1);
SELECT * FROM item;

\echo 'Insert new Product'
INSERT INTO product (p_name, p_ram, p_display, camera_rear, camera_front, p_battery, p_processor, p_desc, p_in_the_box)
VALUES ('OnePlus 7T',
'8 GB RAM ',
'16.64 cm (6.55 inch) Display',
'48 MP + 12 MP + 16 MP',
'16MP',
'3800 mAh Battery',
'Qualcomm® Snapdragon™ 855 Plus Processor',
'1. With a responsive 90 Hz refresh rate and the latest HDR10+ technology, the OnePlus 7T’s Fluid Display is smooth, vivid, and incredibly immersive. If it sounds too good to be true, just wait until you see it.',
'OnePlus 7T Warp Charge 30 Power Adapter Warp Charge Type-C Cable (Support USB 2.0) Quick Start Guide Welcome Letter Safety Information and Warranty Card Logo Sticker Case Screen Protector (pre-applied) SIM Tray Ejector'
);

SELECT p_name FROM product;

\echo 'Make changes in DB if Aritro Biswas adds OPPO F11 Pro and orders all items in the cart'

INSERT INTO cart_contains_product (cart_ID,p_ID,quantity)
VALUES (1,2,1);

UPDATE cart
SET number_of_items = number_of_items + 1
WHERE cart_ID = 1;

INSERT INTO porder (payment_status ,cart_ID )
VALUES ('Processing', 1);

INSERT INTO order_contains_items (item_ID ,order_ID )
VALUES (2, 5);

SELECT * FROM item;

UPDATE customer
SET c_wallet = c_wallet - amount.totalamount
FROM (
    SELECT sum(item_price * dist.quantity) as totalamount
    from (
        SELECT DISTINCT ON (item.p_ID) item.p_ID, pq.quantity, item_price
        FROM (
            SELECT p_ID, quantity 
            FROM cart_contains_product
            WHERE cart_ID in(
                SELECT cart_ID
                FROM cart 
                WHERE c_ID in (
                    SELECT c_ID 
                    FROM customer as c
                    WHERE first_name = 'Aritro' and last_name = 'Biswas'
                )
            )   

        ) as pq, item
        WHERE item.p_ID = pq.p_ID
    ) as dist
) as amount
WHERE first_name = 'Aritro' and last_name = 'Biswas';

SELECT * FROM customer
order by c_ID;

UPDATE porder
set payment_status = 'Complete'
WHERE cart_ID = 1;

SELECT * FROM porder;

\echo 'Experiment 6'

\echo 'List products which have price greator than 20000'

select p_name from product inner join item on product.p_ID = item.p_ID where item_price > 20000;

\echo 'List the products sold by Rohan'

select p_name, seller.s_name
from product 
inner join seller_keeps_products 
on product.p_ID = seller_keeps_products.p_ID 
inner join seller 
on seller_keeps_products.s_ID = seller.s_ID
where seller.s_name = 'Rohan';

\echo 'Give order detals for customer Aritro Biswas'

select payment_status, customer.first_name, customer.last_name, cart.cart_ID
from porder
inner join cart
on  porder.cart_ID = cart.cart_ID
inner join customer
on cart.c_ID = customer.c_ID
where customer.first_name = 'Aritro' and customer.last_name = 'Biswas';

\echo 'Experiment 7'

\echo 'List the order details which have payment status as complete for customer Aritro Biwas and Advait Mainalkar'

select cart_ID, payment_status
from porder
where cart_ID in(
        select cart_ID from porder intersect select cart_ID from cart where cart_ID in (
        Select c_ID 
        from cart 
        intersect 
        select c_ID 
        from  customer
        where first_name ='Aritro' or first_name = 'Advait'
    )
);

\echo 'Display products that are not sold by Rohit'
 
select p_ID
from product
except
select p_ID 
from seller_keeps_products
where s_ID in (
    select s_ID 
    from seller
    where s_name = 'Rohit'
);

\echo 'List the products which are present in the cart of Advait'

select p_ID
from product
intersect
select p_ID
from cart_contains_product
where cart_ID in(
    Select c_ID 
        from cart 
        intersect 
        select c_ID 
        from  customer
        where first_name = 'Advait'
);

\echo 'Experiment 8'


\echo 'List the products which are not present in the cart of Advait'


select p_ID
from product
intersect
select p_ID
from cart_contains_product
where cart_ID not in(
    Select c_ID 
        from cart 
        intersect 
        select c_ID 
        from  customer
        where first_name = 'Advait'
);

\echo 'List the products which are in Advaits cart but not in Aritros'

select p_ID
from product
intersect
select p_ID
from cart_contains_product
where cart_ID in(
    Select c_ID 
        from cart 
        intersect 
        select c_ID 
        from  customer
        where first_name = 'Advait'
)and cart_ID not in
(
    Select c_ID 
        from cart 
        intersect 
        select c_ID 
        from  customer
        where first_name = 'Aritro'
);

\echo 'List the products sold by Rakesh which have price > 10000'
select p_ID
from product
where p_ID in(
    select p_ID
    from item
    inner join seller 
    on item.s_ID = seller.s_ID
    where seller.s_name = 'Rakesh' and item.item_price > 10000
);

\echo 'Experiment 9'

\echo 'List the number of times Aritro placed ordered'

select count(cart_ID) as times_ordered
from porder
where cart_ID in (
    select cart_ID from porder intersect select cart_ID from cart where cart_ID in (
        Select c_ID 
        from cart 
        intersect 
        select c_ID 
        from  customer
        where first_name ='Aritro'
    )
);

\echo 'Calculate total amount of order for Rohit'

SELECT sum(item_price * dist.quantity) as totalamount
    from (
        SELECT DISTINCT ON (item.p_ID) item.p_ID, pq.quantity, item_price
        FROM (
            SELECT p_ID, quantity 
            FROM cart_contains_product
            WHERE cart_ID in(
                SELECT cart_ID
                FROM cart 
                WHERE c_ID in (
                    SELECT c_ID 
                    FROM customer as c
                    WHERE first_name = 'Rohit'
                )
            )   
        ) as pq, item
        WHERE item.p_ID = pq.p_ID
    ) as dist;

\echo 'Calculate average item cost for Samsung Galaxy A70'

select avg(i.item_price) as average_cost
    from (
        select item_price
        from item
        inner join
            (select p_ID
            from product
            where p_name = 'Samsung Galaxy A70') as p
        on item.p_ID = p.p_ID
    )as i;


\echo 'Experiment 10'

\echo 'List the number of item instances of all products'
select p_ID , count(p_ID) from item group by p_ID;

\echo 'List details of the products which are ordered more than once'

select p_name 
from product
where p_ID in (
    select p_ID 
    from item
    where item_ID in(
        select item_ID
        from order_contains_items
        GROUP BY  item_ID
        having (count(item_ID) > 1)
    )
);

\echo 'List the total amount of items > 15000 in the cart'

SELECT (dist.item_price * dist.quantity) as cart_amount
    from (
        SELECT DISTINCT ON (item.p_ID) item.p_ID, quantity, item_price
        FROM (
            SELECT p_ID 
            FROM cart_contains_product
            WHERE cart_ID in(
                SELECT cart_ID
                FROM cart 
                WHERE c_ID in (
                    SELECT c_ID 
                    FROM customer
                )
            )   
        ) as pq, item, cart_contains_product as c
        WHERE item.p_ID = pq.p_ID and c.p_ID = item.p_ID
    ) as dist,customer
    GROUP BY dist.item_price,dist.quantity
    having (dist.item_price * dist.quantity) > 15000; 
    
\echo 'Experiment 11'

\echo 'Create View to display customers living in mumbai'

create view mumbai_cust(c_ID,c_wallet ,c_contact ,c_address ,first_name ,last_name ,c_password ,c_email)
as select c_ID,c_wallet ,c_contact ,c_address ,first_name ,last_name ,c_password ,c_email
from customer
where c_address = 'Mumbai';

select * from mumbai_cust;

\echo 'Create view to display products sold by the seller with price'

create view seller_prod(s_name,p_name,item_price) as
select s_name,p_name,item_price from
seller, product, item
where seller.s_ID = item.s_ID and product.p_ID = item.p_ID;

select * from seller_prod;

\echo 'Create view for average item cost'

create view avg_item_cost(p_name, avg_cost) as 
select p_name, avg(item_price) from 
product, item
where product.p_ID = item.p_ID
group by p_name;

select * from avg_item_cost;

\echo 'Create view to display products in customers cart and its quantity'

create view cust_cart(p_name, cart_ID, quantity) as
select p_name, cart.cart_ID, quantity from 
cart, customer, product,cart_contains_product as ccp
where product.p_ID = ccp.p_ID and ccp.cart_ID = cart.cart_ID and cart.c_ID = customer.c_ID;

select * from cust_cart;

\echo 'Experiment 12'
\echo 'Perform Tranzaction form one order'

begin work;

INSERT INTO cart_contains_product (cart_ID,p_ID,quantity)
VALUES (1,3,2);

UPDATE cart
SET number_of_items = number_of_items + 2
WHERE cart_ID = 2;

INSERT INTO porder (payment_status ,cart_ID )
VALUES ('Processing', 1);

INSERT INTO order_contains_items (item_ID ,order_ID )
VALUES (3, 6);

SELECT * FROM item;

SAVEPOINT before_wallet_update;

UPDATE customer
SET c_wallet = c_wallet - amount.totalamount
FROM (
    SELECT sum(item_price * dist.quantity) as totalamount
    from (
        SELECT DISTINCT ON (item.p_ID) item.p_ID, pq.quantity, item_price
        FROM (
            SELECT p_ID, quantity 
            FROM cart_contains_product
            WHERE cart_ID in(
                SELECT cart_ID
                FROM cart 
                WHERE c_ID in (
                    SELECT c_ID 
                    FROM customer as c
                    WHERE first_name = 'Aritro' and last_name = 'Biswas'
                )
            )   

        ) as pq, item
        WHERE item.p_ID = pq.p_ID
    ) as dist
) as amount
WHERE first_name = 'Aritro' and last_name = 'Biswas';

rollback to before_wallet_update;
Select * from customer;
commit;