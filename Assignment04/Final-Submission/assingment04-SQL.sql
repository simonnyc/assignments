DROP TABLE IF EXISTS OrgChart; 

--
-- Creating a table with person’s name, the person’s supervisor, and the person’s job title. 
--
CREATE TABLE IF NOT EXISTS OrgChart (
EmployeeID   INTEGER  NOT NULL,
Name         TEXT ,
SupervisorID INTEGER,
Depth        INTEGER,
title        TEXT
);


-- Populating the OrgChart table with a few sample rows.

INSERT INTO  OrgChart VALUES (1001,'Susan Kennedy',NULL,	0,'CEO');
INSERT INTO  OrgChart VALUES (1002,'Adam Richardson', 1001,	1,'VP');
INSERT INTO  OrgChart VALUES (1003,'John Smith',	1001,	1,'VP');
INSERT INTO  OrgChart VALUES (1004,'Kyle Tucker',	1002,	2,'Manager');
INSERT INTO  OrgChart VALUES (1005,'David Klein',	1002,	2,'Manager');
INSERT INTO  OrgChart VALUES (1006,'Liz Hamilton',	1003,	2,'Manager');
INSERT INTO  OrgChart VALUES (1007,'Natasha Jacobs',	1003,	2,'Manager');
INSERT INTO  OrgChart VALUES (1008,'Zak Oliver',	1004,	3,'Engineer');
INSERT INTO  OrgChart VALUES (1009,'Rick Smith',	1004,	3,'Engineer');
INSERT INTO  OrgChart VALUES (1010,'Laura Johnson',	1005,	3,'Engineer');
INSERT INTO  OrgChart VALUES (1011,'Jane smith',	1005,	3,'Engineer');
INSERT INTO  OrgChart VALUES (1012,'Scott Eliot',	1006,	3,'Engineer');
INSERT INTO  OrgChart VALUES (1013,'Barbara Gomez',	1006,	3,'Engineer');
INSERT INTO  OrgChart VALUES (1014,'Joe Pane',	1007,	3,'Engineer');
INSERT INTO  OrgChart VALUES (1015,'Anthony Riggs',	1007,	3,'Engineer');

-- select * from orgchart

--
-- Below is a single SELECT statement that displays the information in the table, showing who reports to whom
--

SELECT Executive.Name "Executive", Executive.title, 
       Upper_Managments.Name "VP & Managers",  
       Upper_Managments.title, orgchart.Name, 
       orgchart.title "Manageers & Engineers"
FROM orgchart 
  INNER JOIN orgchart AS Upper_Managments ON orgchart.SupervisorID=Upper_Managments.EmployeeID 
  INNER JOIN orgchart Executive ON Upper_Managments.SupervisorID=Executive.EmployeeID
  ;

  

 

 



