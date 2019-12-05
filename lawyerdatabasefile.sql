DROP DATABASE LAWFIRMDB;
CREATE DATABASE LAWFIRMDB;
USE LAWFIRMDB;

CREATE TABLE LAWFIRM (
  FIRM_ID int(11) NOT NULL PRIMARY KEY,
  FIRM_NAME varchar(45) NOT NULL,
  FIRM_CITY varchar(45) NOT NULL
);

CREATE TABLE JOB (
  JOB_ID int(11) NOT NULL PRIMARY KEY,
  JOB_NAME varchar(45) NOT NULL,
  JOB_DESC varchar(45) NOT NULL
);

CREATE TABLE LAWYERLOGIN (
  LAWYER_USERNAME varchar(20) NOT NULL PRIMARY KEY,
  LAWYER_PASSWORD varchar(45) NOT NULL
);

CREATE TABLE EMPLOYEE (
  EMP_ID int(11) NOT NULL PRIMARY KEY,
  EMP_LNAME varchar(45) NOT NULL,
  EMP_FNAME varchar(45) NOT NULL,
  EMP_INIT char(1),
  EMP_DOB date default NULL,
  JOB_ID int(11) NOT NULL,
  FIRM_ID int(11) NOT NULL,
  FOREIGN KEY(JOB_ID) REFERENCES JOB(JOB_ID),
  FOREIGN KEY(FIRM_ID) REFERENCES LAWFIRM(FIRM_ID)
);

CREATE TABLE LAWYER (
  LAWYER_ID int(11) NOT NULL PRIMARY KEY,
  EMP_ID int(11) DEFAULT NULL CHECK(EMP_ID IN(1)),
  CLIENT_NUM int(11) NOT NULL DEFAULT '0',
  RETAINER_FEE double NOT NULL,
  LAWYER_CATEGORY varchar(45) NOT NULL,
  LAWYER_USERNAME VARCHAR(20) NOT NULL,
  FOREIGN KEY(EMP_ID) REFERENCES EMPLOYEE(EMP_ID),
  FOREIGN KEY(LAWYER_USERNAME) REFERENCES LAWYERLOGIN(LAWYER_USERNAME)
);

CREATE TABLE LAWCLIENT (
  CLIENT_ID int(11) NOT NULL PRIMARY KEY,
  CLIENT_FNAME varchar(45) NOT NULL,
  CLIENT_LNAME varchar(45) NOT NULL,
  CLIENT_DOB date,
  LAWYER_ID int(11) NOT NULL,
  FOREIGN KEY(LAWYER_ID) REFERENCES LAWYER(LAWYER_ID)
);

CREATE TABLE LAWCASE (
  CASE_ID int(11) NOT NULL PRIMARY KEY,
  CLIENT_ID int(11) DEFAULT NULL,
  CASE_DESC varchar(45) NOT NULL,
  LAWYER_EXPENSES double NOT NULL,
  LAWYER_FEE double NOT NULL,
  FOREIGN KEY(CLIENT_ID) REFERENCES LAWCLIENT(CLIENT_ID)
);

INSERT INTO JOB (JOB_ID, JOB_NAME, JOB_DESC) VALUES
(1, 'Lawyer', 'Lawyer description'),
(2, 'Manager', 'Manager description'),
(3, 'Janitor', 'Janitor description'),
(4, 'IT', 'IT description'),
(5, 'Accounting', 'Accounting description'),
(6, 'Reception', 'Reception descripion');


INSERT INTO LAWFIRM (FIRM_ID, FIRM_NAME, FIRM_CITY) VALUES
(1, 'Capital Law', 'Lansing'),
(2, 'Twin Bros Lawfirm', 'Detroit'),
(3, 'Terrence Hill Law', 'Flint'),
(4, 'Mark, Mark, Mark, and Mark LLC', 'Troy'),
(5, 'Paulie Smith DUI Attourney', 'Ann Arbor');

INSERT INTO LAWYERLOGIN(LAWYER_USERNAME, LAWYER_PASSWORD) VALUES
('srlawyer', 'password'),
('telawyer', 'password'),
('sjlawyer', 'password'),
('thlawyer', 'password'),
('sslawyer', 'password');

INSERT INTO EMPLOYEE (EMP_ID, EMP_LNAME, EMP_FNAME, EMP_INIT, EMP_DOB, JOB_ID, FIRM_ID) VALUES
(1, 'Michaels', 'Darius', 'E', NULL, 2, 1),
(2, 'Thompson', 'Rachel', 'K', NULL, 3, 1),
(3, 'Smith', 'Bob', 'R', NULL, 2, 1),
(4, 'Richards', 'Sara', 'M', NULL, 1, 1),
(5, 'Hon', 'Gill', 'A', NULL, 6, 1),
(6, 'Billiums', 'Terrence', 'H', NULL, 6, 1),
(7, 'Fiddleton', 'Pablo', 'V', NULL, 3, 1),
(8, 'Fieldman', 'Dan', 'T', NULL, 2, 1),
(9, 'Enmo', 'Tom', 'U', NULL, 1, 1),
(10, 'Johnson', 'Stacy', 'W', NULL, 1, 1),
(11, 'Peters', 'Veronica', 'J', NULL, 3, 1),
(12, 'Bin', 'Chad', 'Z', NULL, 1, 1),
(13, 'Hope', 'Tony', 'F', NULL, 1, 1),
(14, 'Sont', 'Susan', 'H', NULL, 5, 1);


INSERT INTO LAWYER(LAWYER_ID, EMP_ID, CLIENT_NUM, RETAINER_FEE, LAWYER_CATEGORY, LAWYER_USERNAME) VALUES
(1, 4, 0, 4500, 'DUI', 'srlawyer'),
(2, 9, 0, 3850, 'Elder Law', 'telawyer'),
(3, 10, 0, 5300, 'Divorce', 'sjlawyer'),
(4, 12, 0, 8000, 'Tax', 'thlawyer'),
(5, 13, 0, 2900, 'Immigration', 'sslawyer');



INSERT INTO LAWCLIENT(CLIENT_ID, CLIENT_FNAME, CLIENT_LNAME, CLIENT_DOB, LAWYER_ID) VALUES
(1, 'Charles', 'Toronto', NULL, 1),
(2, 'Donny', 'Gonzolez', NULL, 1),
(3, 'Katlyn', 'Alo', NULL, 1),
(4, 'Harvey', 'Dennis', NULL, 2),
(5, 'Alexis', 'Thompson', NULL, 3),
(6, 'Alice', 'Vince', NULL, 3),
(7, 'Norton', 'Erickson', NULL, 5),
(8, 'Jerry', 'Mathers', NULL, 5);

INSERT INTO LAWCASE(CASE_ID, CLIENT_ID, CASE_DESC, LAWYER_EXPENSES, LAWYER_FEE) VALUES
(1, 1, 'Description of the DUI case for Charles', 920, 7000),
(2, 2, 'Description of the DUI case for Donny', 400, 6500),
(3, 3, 'Description of the DUI case for Katlyn', 220, 9000),
(4, 4, 'Description of the case for Harvey', 250, 4000),
(5, 4, 'Description of the OTHER case for Harvey', 280, 6700),
(6, 5, 'Description of the divorce case for Alexis', 440, 2900),
(7, 6, 'Description of the divorce case for Alice', 900, 5600),
(8, 7, 'Description of the tax case for Norton', 1050, 54000),
(9, 8, 'Description of the tax case for Jerry', 2330, 10000);

CREATE TRIGGER CLIENT_NUM_TRIG
BEFORE INSERT
ON 
LAWCLIENT
FOR EACH ROW 	
SET LAWYER.CLIENT_NUM = LAWYER.CLIENT_NUM + 1;
