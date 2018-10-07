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
	Šifra_polaznika INT,
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
Šifra_polaznika INT PRIMARY KEY NOT NULL,
Ime  VARCHAR(50) NOT NULL,
Prezime VARCHAR(50) NOT NULL,
Mjesto_stanovanja VARCHAR(50) NULL,
CONSTRAINT chk_Šifra_polaznika CHECK (Šifra_polaznika BETWEEN 1 AND 1000)   ---7. I 8. CONSTRAINT PROIZVOLJAN_NAZIV_CONSTRAINT-A CHECK (Šifra_polaznika BETWEEN 1 AND 1000)
);

CREATE TABLE Upisi (
	Šifra_polaznika INT PRIMARY KEY NOT NULL,
	Šifra_teèaja VARCHAR(3) NOT NULL
	);

DROP TABLE Upisi

CREATE TABLE Upisi (
	Šifra_polaznika INT NOT NULL,                                          ---7. I 8.
	Šifra_teèaja VARCHAR(3) NOT NULL
	CONSTRAINT PK_Upisi PRIMARY KEY (Šifra_polaznika , Šifra_teèaja)  -- obavezno za složeni kljuè (2 PK u tablici Upisi (šifra polaznika i šifra teèaja)) ide CONSTRAINT
	);

CREATE TABLE Teèajevi (
	Šifra_teèaja VARCHAR(3) PRIMARY KEY NOT NULL,
	Naziv_teèaja VARCHAR(50) NOT NULL
	);

USE Upisi;



