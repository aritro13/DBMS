DROP DATABASE IF EXISTS company;

CREATE DATABASE company;

\c company;
CREATE TABLE department (
    did serial PRIMARY KEY,
    dname varchar(50),
    head integer
);

CREATE TABLE employee (
    eid serial PRIMARY KEY,
    ename varchar(50),
    salary integer,
    ecity varchar(50),
    did integer REFERENCES department (did)
);

ALTER TABLE department
    ADD FOREIGN KEY (head) REFERENCES employee (eid);

CREATE TABLE project (
    pid integer PRIMARY KEY,
    title varchar(250),
    start_date DATE,
    finish_date DATE,
    mgr integer REFERENCES employee (eid),
    budget integer,
    pcity varchar(50)
);

CREATE TABLE assigned (
    eid integer REFERENCES employee (eid),
    pid integer REFERENCES project (pid),
    assign_date date,
    PRIMARY KEY (eid, pid)
);



INSERT INTO department (dname)
    VALUES ('Mobile Application'), ('ERP'), ('HR'), ('Cloud_Service');

INSERT INTO employee (ename, salary, ecity)
    VALUES ('A', 85000, 'Mumbai'), ('B', 95000, 'Pune'), ('C', 80000, 'Mumbai'), ('D', 70000, 'Pune'), ('E', 90000, 'Jaipur'), ('F', 90000, 'Pune'), ('G', 95000, 'Jaipur'), ('H', 85000, 'Mumbai'), ('I', 100000, 'Mumbai'), ('J', 65000, 'Jaipur');

UPDATE department 
    SET head = 3
WHERE
    did = 1;
UPDATE department 
    SET head = 5
WHERE
    did = 2; 

UPDATE department 
    SET head = 2
WHERE
    did = 3; 

UPDATE department 
    SET head = 9
WHERE
    did = 4; 

UPDATE employee 
    SET did = 2
WHERE
    eid = 1; 

UPDATE employee 
    SET did = 3
WHERE
    eid = 2; 

UPDATE employee 
    SET did = 1
WHERE
    eid = 3; 

UPDATE employee 
    SET did = 1
WHERE
    eid = 4; 

UPDATE employee 
    SET did = 2
WHERE
    eid = 5; 

UPDATE employee 
    SET did = 4
WHERE
    eid = 6; 

UPDATE employee 
    SET did = 4
WHERE
    eid = 7; 

UPDATE employee 
    SET did = 1
WHERE
    eid = 8; 

UPDATE employee 
    SET did = 4
WHERE
    eid = 9; 

UPDATE employee 
    SET did = 1
WHERE
    eid = 10; 

    

INSERT INTO project (pid,title,start_date,finish_date,mgr,budget,pcity)
VALUES 
(101,'L','2018-08-20','2019-03-31',3,1500000,'Mumbai'),
(102,'M','2018-04-01','2018-12-30',4,1000000,'Mumbai'),
(103,'N','2019-05-27','2019-12-15',5,800000,'Jaipur'),
(104,'O','2018-10-30','2019-05-30',3,900000,'Jaipur'),
(105,'P','2019-06-15','2020-01-30',6,1300000,'Pune');

INSERT INTO assigned (eid,pid,assign_date)
VALUES 
(3,101, '2018-08-20'),
(4,101, '2018-08-30'),
(1,101, '2018-10-01'), 
(4,102, '2018-04-01'),
(8,102, '2018-04-01'), 
(10,102, '2018-05-01'),
(5,103, '2019-05-27'),
(10,103, '2019-06-01'),
(3,104, '2018-10-30'),
(6,104, '2018-11-15'),
(7,104, '2018-11-15'),
(9,104, '2018-12-01'),
(3,105, '2019-06-15'),
(6,105, '2019-06-30');

SELECT * FROM department;
SELECT * FROM employee;
SELECT * FROM project;
SELECT * FROM assigned;