-- Database: ConsultingDB

-- DROP DATABASE ConsultingDB

-- CREATE DATABASE ConsultingDB

CREATE DATABASE ConsultingDB
  WITH OWNER = postgres
       ENCODING = 'UTF8'
       TABLESPACE = pg_default
       CONNECTION LIMIT = -1;

-- 

--delete from Expenses ;
--delete from Invoices ;  
--delete from Projects ;
--delete from Clients ;
--delete from Employee;
 
--drop table Expenses; 
--drop table Invoices;  
--drop table Projects; 
--drop table Clients; 
--drop table Employee; 

--

CREATE TABLE Employee (

EmployeeID INTEGER PRIMARY KEY, 
First_Name TEXT NOT NULL,  
Last_Name TEXT NOT NULL, 
Address TEXT, 
email TEXT,  
PhoneNumber VARCHAR(20), 
BillingRate NUMERIC,  
StartDate DATE NOT NULL DEFAULT current_DATE,  
terminated DATE, 
HourlyPayRate NUMERIC NOT NULL,
ProjectID INTEGER 
);


CREATE TABLE Clients (

ClientID INTEGER PRIMARY KEY,
ClientName TEXT NOT NULL,
BillingAddress TEXT NOT NULL,
ClientPhone VARCHAR(20) NOT NULL,
FaxNumber VARCHAR(20),
ClientIndustry TEXT

);


CREATE TABLE Projects (

ProjectID INTEGER PRIMARY KEY,
DateApproved DATE NOT NULL,
ProjectDesc  TEXT NOT NULL,
Project_start DATE NOT NULL,
Proejct_finish DATE, 
EmployeeID INTEGER,  
ClientID INTEGER 
);



CREATE TABLE Invoices (

InvoiceID INTEGER PRIMARY KEY,
invoiceDate DATE NOT NULL DEFAULT CURRENT_DATE, 
Invoiceamount NUMERIC,
InvoiceStatus VARCHAR(20),
employeeID INTEGER, 
ProjectID INTEGER 
);



CREATE TABLE Expenses (

ExpenseID INTEGER PRIMARY KEY,
ExpenseDesc TEXT, 
Expensetype VARCHAR(40),
ExpenseAmount NUMERIC,
ExpenseDate DATE NOT NULL DEFAULT CURRENT_DATE, 
employeeID INTEGER, 
ProjectID INTEGER,
ClientID  INTEGER
);



-- Foreign keys constraints  

-- Adding a foreign key in the project table to reference the employee table.  Each project will have one emplyee assigned to it
-- and an employee can have multiple projects.  
ALTER TABLE  Projects ADD FOREIGN KEY  (EmployeeID) REFERENCES Employee  (employeeID);


-- ALTER TABLE  Projects ADD FOREIGN KEY  (InvoiceID)  REFERENCES Invoices  (InvoiceID);
-- Adding a foreign key in the project table to reference the Client table. each project will have a client associated with it  
ALTER TABLE  Projects ADD FOREIGN KEY  (ClientID)   REFERENCES Clients   (ClientID);

-- Adding a foreign key in the Invoices table to reference the employee table.  Each Invoices will have one employee assigned to it
-- and an employee can have multiple Invoices.  
ALTER TABLE  Invoices ADD FOREIGN KEY  (EmployeeID) REFERENCES Employee  (EmployeeID);

-- Adding a foreign key in the Invoices table to reference the Porjects table.  Each Invoices will have one project assigned to it
ALTER TABLE  Invoices ADD FOREIGN KEY  (ProjectID)  REFERENCES Projects  (ProjectID);


-- Adding a foreign key in the Expenses table to reference the employee table.  Each Expense will have one employee assigned to it
-- and an employee can have multiple Expenses.  
ALTER TABLE  Expenses ADD FOREIGN KEY  (EmployeeID) REFERENCES Employee  (EmployeeID);

-- Adding a foreign key in the Expenses table to reference the Projects table.  Each Expense will have one project assigned to it
-- and a project can have multiple Expenses.
ALTER TABLE  Expenses ADD FOREIGN KEY  (ProjectID)  REFERENCES Projects  (ProjectID);


-- Adding a foreign key in the Expenses table to reference the Clients table.  Each Expense will have one Client assigned to it
-- and a client can have multiple Expenses.
ALTER TABLE  Expenses ADD FOREIGN KEY  (ClientID)   REFERENCES Clients   (ClientID);

--
--
--  Manual Data insertion in the following sequence:
--  Employee
--  Clients
--  Projects
--  Invoices
--  Expenses
--

-- Inserting data into the Employee table

INSERT INTO Employee (employeeID,First_Name, Last_Name, Address, email, PhoneNumber, BillingRate, HourlyPayRate, projectID)
VALUES ( 1, 'Employee John1', 'Smith1', '111 11th street New yrok, NY', 'name@yahoo.com', '111-111-1111', 100, 80,1);
INSERT INTO Employee (employeeID,First_Name, Last_Name, Address, email, PhoneNumber, BillingRate, HourlyPayRate,projectID )
VALUES ( 2, 'Employee John2', 'Smith2','222 99th street New York, NY', 'name2@yahoo.com', '222-222-2222', 200, 160,2);
INSERT INTO Employee (employeeID,First_Name, Last_Name, Address, email, PhoneNumber, BillingRate, HourlyPayRate, projectID)
VALUES ( 3, 'Employee John3', 'Smith3', '333 33th street New York, NY', 'name3@yahoo.com', '333-333-3333', 300, 240,3);
INSERT INTO Employee (employeeID,First_Name, Last_Name, Address, email, PhoneNumber, BillingRate, HourlyPayRate, projectID)
VALUES ( 4, 'Employee John4', 'Smith4', '444 44th street New York, NY', 'name4@yahoo.com', '444-444-4444', 400, 320,4);
INSERT INTO Employee (employeeID,First_Name, Last_Name, Address, email, PhoneNumber, BillingRate, HourlyPayRate, projectID)
VALUES ( 5, 'Employee John5', 'Smith5', '555 55th street New York, NY', 'name5@yahoo.com', '555-555-5555', 500, 400,5);
INSERT INTO Employee (employeeID,First_Name, Last_Name, Address, email, PhoneNumber, BillingRate, HourlyPayRate, projectID)
VALUES ( 6, 'Employee John6', 'Smith6', '666 11th street New yrok, NY', 'name6@yahoo.com', '666-666-666', 600, 500,1);
INSERT INTO Employee (employeeID,First_Name, Last_Name, Address, email, PhoneNumber, BillingRate, HourlyPayRate,projectID )
VALUES ( 7, 'Employee John7', 'Smith7','777 77th street New York, NY', 'name7@yahoo.com', '777-777-7777', 700, 550,2);
INSERT INTO Employee (employeeID,First_Name, Last_Name, Address, email, PhoneNumber, BillingRate, HourlyPayRate, projectID)
VALUES ( 8, 'Employee John8', 'Smith8', '888 88th street New York, NY', 'name8@yahoo.com', '888-888-8888', 800, 600,3);
INSERT INTO Employee (employeeID,First_Name, Last_Name, Address, email, PhoneNumber, BillingRate, HourlyPayRate, projectID)
VALUES ( 9, 'Employee John9', 'Smith9', '999 99th street New York, NY', 'name8@yahoo.com', '999-999-9999', 900, 700,5);

--
-- Inserting data into the Clients table
--
INSERT INTO Clients ( ClientID, ClientName, BillingAddress, ClientPhone, FaxNumber, ClientIndustry)
VALUES ( 1, 'first Client', ' First Client Address in NY', '111-111-1111', '111-111-1111', 'Retail');
INSERT INTO Clients ( ClientID, ClientName, BillingAddress, ClientPhone, FaxNumber, ClientIndustry)
VALUES ( 2, 'Secod Client', ' Second Client Address in NY', '222-222-2222', '222-222-222', 'Pharmaceutical');
INSERT INTO Clients ( ClientID, ClientName, BillingAddress, ClientPhone, FaxNumber, ClientIndustry)
VALUES ( 3, 'Third Client', ' Third Client Address in NY', '333-333-3333', '333-333-3333', 'Finance');
INSERT INTO Clients ( ClientID, ClientName, BillingAddress, ClientPhone, FaxNumber, ClientIndustry)
VALUES ( 4, 'Fourth Client', ' Fourth Client Address in NY', '444-444-4444', '444-444-4444', 'Software');
INSERT INTO Clients ( ClientID, ClientName, BillingAddress, ClientPhone, FaxNumber, ClientIndustry)
VALUES ( 5, 'Fifth Client', 'Fifth Client Address in NY', '555-555-5555', '555-555-5555', 'Hardware');

--
-- Inserting data into the projects table
--
INSERT INTO projects ( ProjectID,  DateApproved , ProjectDesc, Project_start,EmployeeID, ClientID  )
VALUES ( 1, current_date, 'First project', current_date, 1, 1 );
INSERT INTO projects ( ProjectID,  DateApproved , ProjectDesc, Project_start,EmployeeID, ClientID  )
VALUES ( 2, current_date, 'Second project', current_date, 2, 2 );
INSERT INTO projects ( ProjectID,  DateApproved , ProjectDesc, Project_start,EmployeeID, ClientID  )
VALUES ( 3, current_date, 'Third project', current_date, 2, 3 );
INSERT INTO projects ( ProjectID,  DateApproved , ProjectDesc, Project_start,EmployeeID, ClientID  )
VALUES ( 4, current_date, 'Fourth project', current_date, 4, 4 );
INSERT INTO projects ( ProjectID,  DateApproved , ProjectDesc, Project_start,EmployeeID, ClientID  )
VALUES ( 5, current_date, 'Fifth project', current_date, 5, 5 );
INSERT INTO projects ( ProjectID,  DateApproved , ProjectDesc, Project_start,EmployeeID, ClientID  )
VALUES ( 6, current_date, 'Sixth project', current_date, 1, 4 );
INSERT INTO projects ( ProjectID,  DateApproved , ProjectDesc, Project_start,EmployeeID, ClientID  )
VALUES ( 7, current_date, 'Seventh project', current_date, 1, 5 );


--
-- Inserting data into the invoices table
--
INSERT INTO invoices( InvoiceID, invoiceDate, Invoiceamount, InvoiceStatus,employeeID, ProjectID)
VALUES ( 1,current_date,11100.00, 'Paid', 1, 1);
INSERT INTO invoices( InvoiceID, invoiceDate, Invoiceamount, InvoiceStatus,employeeID, ProjectID)
VALUES ( 2,current_date,22200.00, 'In progress', 2, 2);
INSERT INTO invoices( InvoiceID, invoiceDate, Invoiceamount, InvoiceStatus,employeeID, ProjectID)
VALUES ( 3,current_date,33300.00, 'Pending',3 , 3);
INSERT INTO invoices( InvoiceID, invoiceDate, Invoiceamount, InvoiceStatus,employeeID, ProjectID)
VALUES ( 4,current_date,44400.00, 'Extended',4 , 4);
INSERT INTO invoices( InvoiceID, invoiceDate, Invoiceamount, InvoiceStatus,employeeID, ProjectID)
VALUES ( 5,current_date,55500.00, 'Pending', 5, 5);
INSERT INTO invoices( InvoiceID, invoiceDate, Invoiceamount, InvoiceStatus,employeeID, ProjectID)
VALUES ( 6,current_date,55900.00, 'Pending', 5, 4);
  
--
-- Inserting data into the Expenses table
--
INSERT INTO Expenses ( ExpenseID, ExpenseDesc, Expensetype, ExpenseAmount,ExpenseDate, employeeID, ProjectID, ClientID)
VALUES ( 1, 'First Expense Description', 'Transportation', 110.00, current_date, 1, 1, 1);
INSERT INTO Expenses ( ExpenseID, ExpenseDesc, Expensetype, ExpenseAmount,ExpenseDate, employeeID, ProjectID, ClientID)
VALUES ( 2, 'Second Expense Description', 'Lodging', 220.00, current_date, 2, 2, 2);
INSERT INTO Expenses ( ExpenseID, ExpenseDesc, Expensetype, ExpenseAmount,ExpenseDate, employeeID, ProjectID, ClientID)
VALUES ( 3, 'Third Expense Description', 'Food', 330.00, current_date, 3, 3, 3);
INSERT INTO Expenses ( ExpenseID, ExpenseDesc, Expensetype, ExpenseAmount,ExpenseDate, employeeID, ProjectID, ClientID)
VALUES ( 4, 'Fourth Expense Description', 'lunch with client', 440.00, current_date, 4, 4, 4);
INSERT INTO Expenses ( ExpenseID, ExpenseDesc, Expensetype, ExpenseAmount,ExpenseDate, employeeID, ProjectID, ClientID)
VALUES ( 5, 'Fifth Expense Description', 'Flight', 550.00, current_date, 5, 5, 5);


-- select * from Employee; 
-- select * from Clients ; 
-- select * from Projects ; 
-- select * from Invoices ;
-- select * from Expenses;



-- Many to many 
-- An employee can have multiple projects. And project can have multiple employees. In this case Employee John1 works on projects 1, 6, and 7.
-- In the meantime the third project is assigned to 2 and 3
--
SELECT e.employeeid, First_Name, Last_Name,  projectdesc
FROM employee e , projects p 
WHERE p.employeeid= e.employeeid
OR p.projectid=e.projectid

-- 
-- One to many where a project has two invoices. In this case project ID 4 has two amounts 44400.00 and 55900.00
--
SELECT p.projectid, projectdesc, invoiceamount
FROM projects p, invoices i 
WHERE p.projectid= i.projectid

-- 
-- Which client has the highest invoice?
-- We need to query three tables: clients, projects, and invoices.
-- Clientid 4 seems to be paying the highest amount. Therefore, special attention may need to be paid to client 4.
--

SELECT c.clientid, ClientName, clientindustry, max(invoiceamount)
FROM clients c , projects  p , invoices i 
WHERE c.clientid = p.clientid 
AND p.projectid = i.projectid
GROUP BY ClientName, c.clientid, clientindustry
ORDER BY max(invoiceamount) DESC
lIMIT 1






 







