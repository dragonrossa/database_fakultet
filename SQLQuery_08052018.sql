CREATE DATABASE Upisi;

DROP DATABASE Upisi;
----------------------------------



CREATE DATABASE Upisi;

USE upisi;

CREATE TABLE Polaznici (
	Broj_telefona INT );

ALTER TABLE Polaznici 
	ALTER COLUMN Broj_telefona VARCHAR(25);   -- 1.


drop table Polaznici

CREATE TABLE Polaznici (
	�ifra_polaznika INT,
	Ime VARCHAR(50),
	Prezime VARCHAR(50),
	Mjesto_stanovanja VARCHAR(50)
	);

ALTER TABLE Polaznici
	ADD Broj_telefona INT;  -- 2.

ALTER TABLE Polaznici
	ALTER COLUMN Broj_telefona VARCHAR(25);  -- 3.

ALTER TABLE Polaznici
	DROP COLUMN Broj_telefona; -- 4.

DROP TABLE polaznici   -- 5.
	
DROP DATABASE Upisi   -- 6.
----------------------------------------------------------

CREATE DATABASE Upisi

USE Upisi

CREATE TABLE Polaznici (
�ifra_polaznika INT PRIMARY KEY NOT NULL,
Ime  VARCHAR(50) NOT NULL,
Prezime VARCHAR(50) NOT NULL,
Mjesto_stanovanja VARCHAR(50) NULL,
CONSTRAINT chk_�ifra_polaznika CHECK (�ifra_polaznika BETWEEN 1 AND 1000)   ---7. I 8. CONSTRAINT PROIZVOLJAN_NAZIV_CONSTRAINT-A CHECK (�ifra_polaznika BETWEEN 1 AND 1000)
);

CREATE TABLE Upisi (
	�ifra_polaznika INT PRIMARY KEY NOT NULL,
	�ifra_te�aja VARCHAR(3) NOT NULL
	);

DROP TABLE Upisi

CREATE TABLE Upisi (
	�ifra_polaznika INT NOT NULL,                                          ---7. I 8.
	�ifra_te�aja VARCHAR(3) NOT NULL
	CONSTRAINT PK_Upisi PRIMARY KEY (�ifra_polaznika , �ifra_te�aja)  -- obavezno za slo�eni klju� (2 PK u tablici Upisi (�ifra polaznika i �ifra te�aja)) ide CONSTRAINT
	);

CREATE TABLE Te�ajevi (
	�ifra_te�aja VARCHAR(3) PRIMARY KEY NOT NULL,
	Naziv_te�aja VARCHAR(50) NOT NULL
	);

USE Upisi;



