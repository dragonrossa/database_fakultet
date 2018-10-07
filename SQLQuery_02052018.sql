
/*komentari
u vi�e
redaka*/

--kreiramo bazu koja se zove Prva_baza
CREATE DATABASE Prva_baza;

-- ulazak/odabir baze
USE Prva_baza;

--drop database bri�e bazu
DROP DATABASE Prva_baza;

CREATE DATABASE Prva_baza;

USE MOJA_FIRMA;

CREATE TABLE osobe (
OIB      char(11),
Ime      varchar(50), 
Prezime  varchar(100),
Godine   INT,
Telefon  varchar(20) 
);

--DODAJEM POLJE GRAD
ALTER TABLE osobe
ADD GRAD VARCHAR(50);

-- BRISANJE POLJA IZ TABLICE
ALTER TABLE osobe
DROP COLUMN TELEFON;

--PROMJENA POSTOJE�EG POLJA
ALTER TABLE osobe
ALTER COLUMN Godine VARCHAR(3);

---- BAZA ZADATAK_1_1

CREATE DATABASE Zadatak_1_1;

USE Zadatak_1_1;


-- PRVO KREIRAMO TABLICU ODJELA

CREATE TABLE Odjeli (
�ifraOdjela CHAR(3) PRIMARY KEY, 
NazivOdjela VARCHAR(100) UNIQUE NOT NULL,
LokacijaOdjela VARCHAR(100) NOT NULL
);

-- KREIRAMO ZAPOSLENIKE
CREATE TABLE Zaposlenici(
	�ifraZaposlenika	INT PRIMARY KEY,
	ImeZaposlenika		VARCHAR(50) NOT NULL,
	PrezimeZaposlenika	VARCHAR(100) NOT NULL,
	�ifraOdjela			CHAR(3) REFERENCES Odjeli(�ifraOdjela)
);
---KREIRAMO �EFOVE
CREATE TABLE �efovi (
	�ifraOdjela	CHAR(3) REFERENCES Odjeli(�ifraOdjela),
	�ifraZaposlenika	INT REFERENCES Zaposlenici(�ifraZaposlenika),
	--- definicija primarnog klju�a
	CONSTRAINT �efovi_PK PRIMARY KEY (�ifraOdjela, �ifraZaposlenika)
);
CREATE DATABASE Zadatak_1_2;

USE Zadatak_1_2;

CREATE TABLE Skladi�no_mjesto (
	�ifra_skladi�ta INT PRIMARY KEY,
	Naziv	VARCHAR(100) UNIQUE NOT NULL
	);

CREATE TABLE Proizvod (
	�ifra_proizvoda INT,
	Naziv		VARCHAR(100) UNIQUE NOT NULL,
	�ifra_skladi�ta INT,
	CONSTRAINT Proizvod_pk PRIMARY KEY(�ifra_proizvoda),
	CONSTRAINT Proizvod_sklad_fk FOREIGN KEY (�ifra_skladi�ta)
			REFERENCES Skladi�no_mjesto (�ifra_skladi�ta)
);

CREATE TABLE Radnik (
	�ifra_radnika  INT PRIMARY KEY,
	Ime			VARCHAR(50) NOT NULL,
	Prezime		VARCHAR(100) NOT NULL,
	�ifra_skladi�ta INT REFERENCES Skladi�no_mjesto (�ifra_skladi�ta)
);

CREATE TABLE Voditelji (
	�ifra_radnika  INT REFERENCES Radnik(�ifra_radnika),
	�ifra_skladi�ta INT REFERENCES Skladi�no_mjesto(�ifra_skladi�ta),
	CONSTRAINT Voditelji_PK PRIMARY KEY (�ifra_radnika,�ifra_skladi�ta)
);

CREATE DATABASE EKSPERIMENT;

USE EKSPERIMENT;

CREATE TABLE PROBA (
	broj INT,
	tekst VARCHAR(50)
);

--UMETANJE PODATAKA
INSERT INTO PROBA (broj, tekst)
VALUES (1, 'JEDAN');               --�KOLSKI

--UMETANJE VI�E REDAKA JEDNOM NAREDBOM INSERT
INSERT INTO PROBA (broj, tekst)
VALUES (2, 'DVA'), (3, 'TRI');

--SKRA�ENI OBLIK
INSERT INTO PROBA
VALUES (4, '�ETIRI');

--JO� KRA�E, NE POPUNJAVAMO SVA POLJA
INSERT INTO PROBA (broj)
VALUES (5);
--ILI
INSERT INTO PROBA (broj,tekst)
VALUES (6, NULL);

--UMETANJE I IMPLICITNA KONVERZIJA
INSERT INTO PROBA (broj, tekst)
VALUES (7.5, 'SEDAM I POLA :)'); --->(1 row(s) affected)

-- PROVJERA SADR�AJA TABLICE

SELECT * FROM PROBA;

---A�URIRANJE PODATAKA

UPDATE PROBA
SET tekst = 'PET'
WHERE broj = 5;

--brisanje podataka

DELETE FROM PROBA
WHERE Broj= 6;