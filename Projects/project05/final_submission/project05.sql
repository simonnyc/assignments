--
--		The Mixed Martial Arts (MMA) school database:
--
-- 
-- The purpose of the (Mixed Martial Arts) MMA school database is to store the school coaches’ and student’s information, track 
-- the students’ activities and progress, and   keep the school’s financial information.  
-- The database has 8 internal tables and one external table called sex offenders table that holds public data. 
-- Using a database trigger, before hiring coaches, the sex offenders table is checked against the coaches’ background for any “sex offenders” crimes. 
-- The sex offenders’ public data set is downloaded to a .csv file. Then the .csv file is imported into a table called “Sex_Offenders”
-- 
--
-- The functionality could be extended by linking the sex offenders table to better type of background checking such as facial recognition as sometimes 
-- criminals use fake names and social security numbers. In addition, the certification table can be extended to check the authenticity 
-- and validity of the coaches’ certifications.  
-- And finally,  the students table could be linked to the students health records ( of course after the student consent) to ensure 
-- proper training and to monitor progress
--
--
-- DROP DATABASE MMADB; 
-- 
CREATE DATABASE MMADB
  WITH OWNER = postgres
  ENCODING = 'UTF8'
  TABLESPACE = pg_default
 CONNECTION LIMIT = -1;

       

DROP TABLE IF EXISTS	Certfications; 
DROP TABLE IF EXISTS	Students;
DROP TABLE IF EXISTS	Classes;
DROP TABLE IF EXISTS	Coaches;
DROP TABLE IF EXISTS	Memberships;
DROP TABLE IF EXISTS	Payments;
DROP TABLE IF EXISTS 	Tournaments;	
DROP TABLE IF EXISTS 	Belts;
DROP TABLE IF EXISTS 	sex_offenders_test;
DROP TABLE IF EXISTS 	sex_offenders_audit;


CREATE TABLE IF NOT EXISTS Coaches

(
Coach_ID	INTEGER PRIMARY KEY,
First_Name	TEXT NOT NULL,
Last		varchar(100) NOT NULL,
Gender		VARCHAR(20),
Address		TEXT,
City		TEXT,
State		CHAR(2),
Zip_code	VARCHAR(20)
);


CREATE TABLE IF NOT EXISTS Certfications	
(
Certification_ID	INTEGER NOT NULL,
Certification_Type	TEXT NOT NULL,
Certification_Desc	TEXT,
Certification_Date 	DATE NOT NULL DEFAULT current_DATE,
Coach_ID		INTEGER
);



CREATE TABLE IF NOT EXISTS Students
(	
Student_ID	INTEGER PRIMARY KEY,
First_Name	TEXT NOT NULL,
Last_Name	TEXT NOT NULL,
Gender		VARCHAR(20),
Address		TEXT,
City		TEXT,
State		CHAR(2),
Zip_code	VARCHAR(20) NOT NULL,
Class_ID	INTEGER,
Membership_ID	INTEGER,
Payment_ID	INTEGER,
Belt_ID		INTEGER,
Tournament_ID	INTEGER
);



CREATE TABLE IF NOT EXISTS Classes	
(
Class_ID		INTEGER PRIMARY KEY,
Class_session		VARCHAR(20) NOT NULL, 
Coach_ID		INTEGER
);



CREATE TABLE IF NOT EXISTS Memberships	
(
Membership_ID	INTEGER PRIMARY KEY,
Membership_Type	VARCHAR(20) NOT NULL
);	



CREATE TABLE IF NOT EXISTS Payments	
(
Payment_ID	INTEGER PRIMARY KEY,
Payment_Type	VARCHAR(20) NOT NULL,
Student_ID	INTEGER NOT NULL,
AMOUNT		NUMERIC NOT NULL ,          
Payment_Date	DATE NOT NULL DEFAULT current_DATE,
Notes		TEXT
);



CREATE TABLE IF NOT EXISTS Tournaments	
(
Tournament_ID		INTEGER PRIMARY KEY,
Tournament_Type		TEXT NOT NULL,
Tournament_Name		TEXT,
Address			TEXT NOT NULL,
City			TEXT NOT NULL,
State			CHAR(2) NOT NULL,
Zip_code		VARCHAR(20) NOT NULL
);



CREATE TABLE IF NOT EXISTS Belts	
(
Belt_ID		INTEGER PRIMARY KEY,
Belt_TYPE	TEXT,
Belt_Color	TEXT
);


--
-- The sex_offenders_test table is used to test the trigger at the end of this script
--
CREATE TABLE IF NOT EXISTS sex_offenders_test
(
  last 		VARCHAR(200),
  first 	TEXT,
  block 	TEXT,
  gender 	VARCHAR(20),
  race 		TEXT,
  birth_date 	TEXT,
  age 		INTEGER,
  height 	INTEGER,
  weight 	INTEGER,
  victim_minor 	VARCHAR(5)
);

/*
CREATE TABLE IF NOT EXISTS  Sex_Offenders
(
LAST		TEXT,
FIRST		TEXT,
BLOCK		TEXT,
GENDER		VARCHAR(20),
RACE		TEXT,
BIRTH_DATE	TEXT,
AGE		INTEGER,
HEIGHT		INTEGER,
WEIGHT		INTEGER,
VICTIM_MINOR   VARCHAR(5)
)
*/
-- select * from sex_offenders 
-- create table Sex_Offenders_old as select * from sex_Offenders
-- select * from Sex_Offenders


CREATE TABLE IF NOT EXISTS sex_offenders_audit(
    operation           char(1)   NOT NULL,
    stamp               timestamp NOT NULL,
    userid              TEXT      NOT NULL,
    last		TEXT      NOT NULL,
    first		TEXT	
);

CREATE OR REPLACE FUNCTION sex_offenders_audit() RETURNS TRIGGER AS $energy_audit$

declare x boolean;

    BEGIN
        
-- Insert a row in the sex_offenders_audit table to reflect the Insert operation performed on Coaches table. 
-- The special variable TG_OP is used for the INSERT operation.  
-- If there is a match between the new Coach last name and the first name in the sex offenders table, the SELECT statement 
-- returns TRUE and a row is inserted in the sex_offenders_audit for management review. 
        
        		
        IF (TG_OP = 'INSERT') THEN 
         INSERT INTO sex_offenders_audit SELECT 'I', now(), user, NEW.LAST, NEW.FIRST_NAME 
		WHERE  EXISTS (SELECT 1 
			FROM Coaches c  LEFT JOIN  Sex_offenders_test s USING (last)
			WHERE last IS NOT NULL 
			AND s.first = NEW.first_name
			);
	END IF;
													
RETURN NEW;
RETURN NULL; -- result is ignored since this is an AFTER trigger
END;
$energy_audit$ LANGUAGE plpgsql;



-- DROP TRIGGER sex_offenders_audit_tg ON coaches; 

CREATE  TRIGGER sex_offenders_audit_tg
AFTER INSERT ON coaches
    FOR EACH ROW EXECUTE PROCEDURE sex_offenders_audit();


-- FOREIGN KEY CREATION 

ALTER TABLE  Certfications ADD FOREIGN KEY  (Coach_ID) REFERENCES Coaches  (Coach_ID);
ALTER TABLE  Classes ADD FOREIGN KEY  (Coach_ID) REFERENCES Coaches  (Coach_ID);
ALTER TABLE  Students ADD FOREIGN KEY  (Class_ID) REFERENCES Classes  (Class_ID);
ALTER TABLE  Students ADD FOREIGN KEY (Membership_ID) REFERENCES Memberships  (Membership_ID);
ALTER TABLE  Students ADD FOREIGN KEY (Tournament_ID) REFERENCES Tournaments  (Tournament_ID);
ALTER TABLE  Students ADD FOREIGN KEY (Belt_ID) REFERENCES Belts  (Belt_ID);

--
-- INSERT Statement for Coaches table 
-- 

-- select * from coaches; 
-- 

insert into Coaches(coach_ID, first_name, last) values (1, 'Caoch01 FirstName','Caoch01 LastName');
insert into Coaches(coach_ID, first_name, last) values (2, 'Caoch02 FirstName','Caoch02 LastName');
insert into Coaches(coach_ID, first_name, last) values (3, 'Caoch03 FirstName','Caoch03 LastName');
insert into Coaches(coach_ID, first_name, last) values (4, 'Caoch04 FirstName','Caoch04 LastName');
insert into Coaches(coach_ID, first_name, last) values (5, 'Caoch05 FirstName','Caoch05 LastName');
insert into Coaches(coach_ID, first_name, last) values (6, 'Caoch06 FirstName','Caoch06 LastName');
insert into Coaches(coach_ID, first_name, last) values (7, 'Caoch07 FirstName','Caoch07 LastName');
insert into Coaches(coach_ID, first_name, last) values (8, 'Caoch08 FirstName','Caoch08 LastName');
insert into Coaches(coach_ID, first_name, last) values (9, 'Caoch09 FirstName','Caoch09 LastName');

-- -- INSERT Statement for the Certfications table;

insert into  Certfications (Certification_ID, Certification_Type, Certification_Date, Coach_ID  ) 
values ( 400, 'MMA', now(), 4);
insert into Certfications (Certification_ID, Certification_Type, Certification_Date, Coach_ID  ) 
values ( 500, 'MMA', now(), 5);
insert into Certfications (Certification_ID, Certification_Type, Certification_Date, Coach_ID  ) 
values ( 600, 'MMA', now(), 6);
insert into Certfications (Certification_ID, Certification_Type, Certification_Date, Coach_ID ) 
values ( 700, 'MMA', now(), 7);
insert into Certfications (Certification_ID, Certification_Type, Certification_Date, Coach_ID  ) 
values ( 800, 'MMA', now(), 8);
insert into Certfications (Certification_ID, Certification_Type, Certification_Date, Coach_ID  ) 
values ( 900, 'MMA', now(), 9);

--
-- INSERT Statement for the Classes table 

insert into Classes (Class_ID, Class_session, Coach_ID  ) values ( 1, 'Morning6am', 1);
insert into Classes (Class_ID, Class_session, Coach_ID  ) values ( 2, 'Morning7pm', 2);
insert into Classes (Class_ID, Class_session, Coach_ID  ) values ( 3, 'Morning9am', 3);
insert into Classes (Class_ID, Class_session, Coach_ID  ) values ( 4, 'Morning10am', 4);
insert into Classes (Class_ID, Class_session, Coach_ID  ) values ( 5, 'Morning10am', 5);
insert into Classes (Class_ID, Class_session, Coach_ID  ) values ( 6, 'Evening6pm',6 );
insert into Classes (Class_ID, Class_session, Coach_ID  ) values ( 7, 'Evening7pm',7 );
--insert into Classes (Class_ID, Class_session, Coach_ID  ) values ( 8, 'Evening8pm',8);
-- insert into Classes (Class_ID, Class_session, Coach_ID  ) values ( 9, 'Evening9pm',9);



-- INSERT Statement for the memberships table

insert into Memberships	(Membership_ID, Membership_Type  ) values ( 1, 'Monthly');
insert into Memberships	(Membership_ID, Membership_Type  ) values ( 2, 'Yearly');
insert into Memberships	(Membership_ID, Membership_Type  ) values ( 3, 'Private');
insert into Memberships	(Membership_ID, Membership_Type  ) values ( 4, 'Staff');


-- -- INSERT Statement for the Payments table 

insert into Payments (Payment_ID, Payment_Type ,AMOUNT,  Payment_Date, Student_ID ) values ( 2, 'Check', 100, now(), 2);
insert into Payments (Payment_ID, Payment_Type ,AMOUNT,  Payment_Date, Student_ID ) values ( 3, 'Credit', 100, now(), 3);
insert into Payments (Payment_ID, Payment_Type ,AMOUNT,  Payment_Date, Student_ID ) values ( 4, 'CASH', 100, now(), 4);
insert into Payments (Payment_ID, Payment_Type ,AMOUNT,  Payment_Date, Student_ID ) values ( 5, 'Credit', 100, now(), 5);
insert into Payments (Payment_ID, Payment_Type ,AMOUNT,  Payment_Date, Student_ID ) values ( 6, 'Credit', 100, now(), 6);
insert into Payments (Payment_ID, Payment_Type ,AMOUNT,  Payment_Date, Student_ID ) values ( 7, 'CHECK', 100, now(), 7);

-- INSERT Statement for the Tournaments table 

insert into Tournaments	 (Tournament_ID, Tournament_Type,Address,  City, State, Zip_code ) 
values ( 1, 'Kick Boxing',' 1 NEW YORK Address', 'NEW YORK', 'NY', '10019');
insert into Tournaments	 (Tournament_ID, Tournament_Type,Address,  City, State, Zip_code ) 
values ( 2, 'MMA',' 2 NEW JERSEY Address', 'NEW JERSEY', 'NJ', '90012');

--
-- INSERT Statement for the Belts table 
--
insert into Belts (Belt_ID, Belt_TYPE, Belt_Color ) values ( 1, 'BJJ',' WHITE');
insert into Belts (Belt_ID, Belt_TYPE, Belt_Color ) values ( 2, 'BJJ',' BLUE');
insert into Belts (Belt_ID, Belt_TYPE, Belt_Color ) values ( 3, 'BJJ',' PURPLE');
insert into Belts (Belt_ID, Belt_TYPE, Belt_Color ) values ( 4, 'BJJ',' BROWN');
insert into Belts (Belt_ID, Belt_TYPE, Belt_Color ) values ( 5, 'BJJ',' BLACK');

--
-- INSERT Statement for the Students table 
-- 

insert into Students (Student_ID, First_Name, Last_Name, Zip_code, Class_ID, Membership_ID,Payment_ID, Belt_ID,Tournament_ID) 
values ( 1, 'Student01FirstName', 'Student01LastNAme', '10000', 1,1,1,1,1 );
insert into Students (Student_ID, First_Name, Last_Name, Zip_code, Class_ID, Membership_ID,Payment_ID, Belt_ID,Tournament_ID) 
values ( 2, 'Student02FirstName', 'Student02LastNAme', '20000', 2,2,2,2,2 );
insert into Students (Student_ID, First_Name, Last_Name, Zip_code, Class_ID, Membership_ID,Payment_ID, Belt_ID,Tournament_ID) 
values ( 3, 'Student03FirstName', 'Student03LastNAme', '30000', 3,3,3,3,1 );
insert into Students (Student_ID, First_Name, Last_Name, Zip_code, Class_ID, Membership_ID,Payment_ID, Belt_ID,Tournament_ID) 
values ( 4, 'Student03FirstName', 'Student03LastNAme', '40000', 4,4,4,4,2 );
insert into Students (Student_ID, First_Name, Last_Name, Zip_code, Class_ID, Membership_ID,Payment_ID, Belt_ID,Tournament_ID) 
values ( 5, 'Student04FirstName', 'Student04LastNAme', '50000', 5,4,5,5,1 );
insert into Students (Student_ID, First_Name, Last_Name, Zip_code, Class_ID, Membership_ID,Payment_ID, Belt_ID,Tournament_ID) 
values ( 6, 'Student05FirstName', 'Student05LastNAme', '60000', 6,3,6,2,2 );
insert into Students (Student_ID, First_Name, Last_Name, Zip_code, Class_ID, Membership_ID,Payment_ID, Belt_ID,Tournament_ID) 
values ( 7, 'Student06FirstName', 'Student07LastNAme', '70000', 7,1,7,2,1 );

/*SELECT * FROM students

SELECT * FROM 	Certfications; 
SELECT * FROM 	Students;
SELECT * FROM 	Classes;
SELECT * FROM 	Coaches;
SELECT * FROM 	Memberships;
SELECT * FROM 	Payments;
SELECT * FROM  	Tournaments;	
SELECT * FROM 	Belts;
SELECT * FROM  	sex_offenders_audit;
*/

--
-- SELECT STATEMENTS
--

-- Find the list of all blue belt students 
--

SELECT first_name, last_name, belt_color
FROM students s LEFT JOIN belts b USING  (belt_id)
WHERE belt_id = 2;

--
-- Find out coaches that do not have classes assigned to them or where coach ID is null in the classes tables. 
-- Of course DARNELL COE does not have an assignment class as he still being flagged by the sex offenders trigger. 
--


SELECT  c.first_name, c.last, c.coach_id 
FROM  coaches c LEFT JOIN  classes l USING (coach_id)
WHERE l.coach_ID is NULL;

--
-- Testing the trigger by loading actual data from the sex_offenders table into sex_offenders_test. 
-- I selected the first 18 rows from the actual sex offenders’ data set into sex_offenders_test.
-- 

insert into sex_offenders_test values('LIGHTNING','DWAYNE','0000X E 100TH ST','MALE','BLACK','5/26/1988',26,604,215,'Y');
insert into sex_offenders_test values('WHITE','CHARLES','0000X E 100TH ST','MALE','BLACK','5/2/1961',53,509,180,'Y');
insert into sex_offenders_test values('COE','DARNELL','0000X E 102ND ST','MALE','BLACK','4/4/1978',36,602,275,'Y');
insert into sex_offenders_test values('BLOSSOM','MARTIN','0000X E 110TH PL','MALE','BLACK','10/27/1957',57,600,250,'Y');
insert into sex_offenders_test values('POWELLS','TYRONE','0000X E 110TH PL','MALE','BLACK','12/28/1981',33,506,185,'Y');
insert into sex_offenders_test values('WARD','RICHARD','0000X E 110TH PL','MALE','BLACK','7/23/1949',65,506,190,'Y');
insert into sex_offenders_test values('BURTON','RAINNA','0000X E 111TH ST','FEMALE','BLACK','4/10/1962',52,506,177,'Y');
insert into sex_offenders_test values('BROWN','DONALD','0000X E 116TH ST','MALE','BLACK','3/5/1980',34,600,214,'Y');
insert into sex_offenders_test values('DAVENPORT','MARCUS','0000X E 74TH ST','MALE','BLACK','3/29/1951',63,507,140,'Y');
insert into sex_offenders_test values('SCOTT','MICHAEL','0000X E 91ST ST','MALE','BLACK','5/22/1957',57,506,170,'N');
insert into sex_offenders_test values('BOBEL','DANIEL','0000X E 9TH ST','MALE','WHITE','2/27/1968',46,602,185,'Y');
insert into sex_offenders_test values('CAFFREY','DEXTER','0000X E BRAYTON ST','MALE','BLACK','3/14/1985',29,511,175,'Y');
insert into sex_offenders_test values('SLAGO','FRANK','0000X N HOYNE AVE','MALE','WHITE','7/1/1958',56,508,155,'Y');
insert into sex_offenders_test values('LEWIS','CHARLES','0000X N MAYFIELD AVE','MALE','WHITE','2/27/1957',57,604,225,'Y');
insert into sex_offenders_test values('BARNES','JEFFERY','0000X S MENARD AVE','MALE','BLACK','8/12/1973',41,505,150,'Y');
insert into sex_offenders_test values('HOOD','HENRY','0000X W 105TH ST','MALE','BLACK','3/30/1942',72,507,214,'Y');
insert into sex_offenders_test values('FREEMAN','ANTONIO','0000X W 110TH ST','MALE','BLACK','3/22/1981',33,602,220,'Y');
insert into sex_offenders_test values('FRICKSON','DENNIS','0000X W 112TH PL','MALE','WHITE','11/17/1948',66,603,185,'Y');



--
-- Testing the trigger for sex offenders using last name as ‘COE’ and First name ‘DARNELL’.
-- ‘DARNELL COE' is an actual first name and last name in the sex offenders’ public data set;
-- The result is a record was entered automatically into the sex_offenders_audit table which needs to be reviewed and assessed by management.
--

INSERT INTO Coaches(coach_ID, first_name, last) VALUES (7779, 'DARNELL', 'COE');

select * from sex_offenders_audit;
--select * from sex_offenders


    