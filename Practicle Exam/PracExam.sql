\echo "SET 11"
DROP DATABASE IF EXISTS dbexpt18102c2016;

\echo "Q1"
CREATE DATABASE dbexpt18102c2016;

\echo "Q2"
\c dbexpt18102c2016;
CREATE TABLE doctor(
	regno BIGINT PRIMARY KEY,
	dname VARCHAR(255) NOT NULL,
	specialization VARCHAR(355),
	contactno BIGINT
);

CREATE TABLE patient(
	pid serial PRIMARY KEY,
	pname VARCHAR(255) NOT NULL,
	birthdate DATE NOT NULL,
	gender VARCHAR(155) NOT NULL,
	bloodgroup VARCHAR(155) NOT NULL
);

CREATE TABLE visit(
	pid BIGINT NOT NULL,
	regno BIGINT NOT NULL,
	visit_date DATE,
	fees float(5)
);

CREATE TABLE treatment(
	pid BIGINT NOT NULL,
	trno BIGINT UNIQUE NOT NULL,
	PRIMARY KEY(pid,trno),
	tr_date DATE,
	charges float(5),
	tr_doctor VARCHAR(255),
	tr_type VARCHAR(255),
	result VARCHAR(255)
);

\echo "Q3"

ALTER TABLE visit
ADD FOREIGN KEY(pid) REFERENCES patient(pid),
ADD FOREIGN KEY(regno) REFERENCES doctor(regno);

ALTER TABLE treatment
ADD FOREIGN KEY(pid) REFERENCES patient(pid),
ADD FOREIGN KEY(tr_doctor) REFERENCES doctor(dname);

\echo 'Q4'
INSERT INTO doctor(regno, dname, specialization, contactno)
VALUES (101,'Aritro','Neuro Surgeon',9912343232),
(102,'Biswas', 'Orthopedic Surgeon', 3465742121);


INSERT INTO patient(pname,birthdate,gender,bloodgroup)
VALUES ('JOHN','19900601','MALE','B+'),
('Foo','19900602','MALE','O+'),
('James','19400602','MALE','A+'),
('DOE','19800611','MALE','A+');


INSERT INTO visit(pid,regno,visit_date,fees)
VALUES (1,101,'20190922',8000),
(2,102,'20190923',7000),
(2,102,'20190923',7000),
(1,101,'20190923',7000),
(1,101,'20190923',7000);


INSERT INTO treatment(pid,trno,tr_date,charges,tr_doctor,tr_type,result)
VALUES (1,1,'20190925', 50000, 'Aritro', 'Heart Surgery', 'Success'),
(2,2,'20190926', 40000, 'Biswas','Heart Surgery','Success'),
(3,3,'20190925', 50000, 'Aritro', 'Brain Surgery', 'Success');


\echo 'Q5'

SELECT * FROM doctor
WHERE specialization = 'Orthopedic Surgeon';

\echo 'Q6'
SELECT pid FROM visit
WHERE visit_date > '20180101';

\echo 'Q7'


SELECT patient.pid,patient.pname FROM patient
INNER JOIN 
(
	SELECT pid FROM visit 
	WHERE regno in (
		SELECT regno FROM doctor
		WHERE dname= 'Aritro' or dname = 'Biswas'
	)
	GROUP BY pid,regno
) as p
ON patient.pid = p.pid;

\echo 'Q8'

CREATE VIEW doctor_visits(regno,dname,number_of_visits) AS
SELECT visit.regno,doctor.dname,count(visit.regno)
FROM visit,doctor
WHERE visit.regno = doctor.regno
GROUP BY doctor.dname, visit.regno;

SELECT * FROM doctor_visits;

\echo 'Q9'

SELECT * 
FROM doctor_visits
where number_of_visits in (
	SELECT min(number_of_visits)
	FROM doctor_visits
);


-- ******************************************************************************

-- ******************************************************************************

\echo 'SET 12'

\echo 'Q5'

SELECT * FROM patient
WHERE bloodgroup = 'O+';

\echo 'Q6'

SELECT pname FROM patient
WHERE pid in (
	SELECT pid FROM treatment
	WHERE tr_doctor = 'Aritro'
);

\echo 'Q7'

SELECT pid FROM visit
WHERE pid NOT IN(
	SELECT pid FROM treatment
	WHERE tr_doctor = 'Aritro'
)AND regno IN (
	SELECT regno FROM doctor
	WHERE dname = 'Aritro'
);

\echo 'Q8'

CREATE VIEW Treatment_charges(tr_type, average_charges) AS
SELECT tr_type, avg(charges)
FROM treatment
GROUP BY tr_type;

SELECT * FROM Treatment_charges;

\echo 'Q9'

SELECT * 
FROM Treatment_charges
where average_charges in (
	SELECT max(average_charges)
	FROM Treatment_charges
);

-- ******************************************************************************

-- ******************************************************************************

\echo 'SET 13'

\echo 'Q5'

SELECT regno FROM visit
WHERE fees > 1000
GROUP BY regno;

\echo 'Q6'

Select *,age(birthdate)  FROM patient
WHERE gender = 'MALE' and age(birthdate) > '60 years';

\echo 'Q7'
SELECT pname 
FROM patient as p1,(
	SELECT gender,bloodgroup
	FROM patient
	WHERE pname = 'James'
)as p2
WHERE p1.gender =p2.gender and p1.bloodgroup =p2.bloodgroup;


