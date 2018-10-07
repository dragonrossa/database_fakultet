
/*komentari
u više
redaka*/

--kreiramo bazu koja se zove Prva_baza
CREATE DATABASE Prva_baza;

-- ulazak/odabir baze
USE Prva_baza;

--drop database briše bazu
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

--PROMJENA POSTOJEÆEG POLJA
ALTER TABLE osobe
ALTER COLUMN Godine VARCHAR(3);

---- BAZA ZADATAK_1_1

CREATE DATABASE Zadatak_1_1;

USE Zadatak_1_1;


-- PRVO KREIRAMO TABLICU ODJELA

CREATE TABLE Odjeli (
ŠifraOdjela CHAR(3) PRIMARY KEY, 
NazivOdjela VARCHAR(100) UNIQUE NOT NULL,
LokacijaOdjela VARCHAR(100) NOT NULL
);

-- KREIRAMO ZAPOSLENIKE
CREATE TABLE Zaposlenici(
	ŠifraZaposlenika	INT PRIMARY KEY,
	ImeZaposlenika		VARCHAR(50) NOT NULL,
	PrezimeZaposlenika	VARCHAR(100) NOT NULL,
	ŠifraOdjela			CHAR(3) REFERENCES Odjeli(ŠifraOdjela)
);
---KREIRAMO ŠEFOVE
CREATE TABLE Šefovi (
	ŠifraOdjela	CHAR(3) REFERENCES Odjeli(ŠifraOdjela),
	ŠifraZaposlenika	INT REFERENCES Zaposlenici(ŠifraZaposlenika),
	--- definicija primarnog kljuèa
	CONSTRAINT Šefovi_PK PRIMARY KEY (ŠifraOdjela, ŠifraZaposlenika)
);
CREATE DATABASE Zadatak_1_2;

USE Zadatak_1_2;

CREATE TABLE Skladišno_mjesto (
	Šifra_skladišta INT PRIMARY KEY,
	Naziv	VARCHAR(100) UNIQUE NOT NULL
	);

CREATE TABLE Proizvod (
	Šifra_proizvoda INT,
	Naziv		VARCHAR(100) UNIQUE NOT NULL,
	Šifra_skladišta INT,
	CONSTRAINT Proizvod_pk PRIMARY KEY(Šifra_proizvoda),
	CONSTRAINT Proizvod_sklad_fk FOREIGN KEY (Šifra_skladišta)
			REFERENCES Skladišno_mjesto (Šifra_skladišta)
);

CREATE TABLE Radnik (
	Šifra_radnika  INT PRIMARY KEY,
	Ime			VARCHAR(50) NOT NULL,
	Prezime		VARCHAR(100) NOT NULL,
	Šifra_skladišta INT REFERENCES Skladišno_mjesto (Šifra_skladišta)
);

CREATE TABLE Voditelji (
	Šifra_radnika  INT REFERENCES Radnik(Šifra_radnika),
	Šifra_skladišta INT REFERENCES Skladišno_mjesto(Šifra_skladišta),
	CONSTRAINT Voditelji_PK PRIMARY KEY (Šifra_radnika,Šifra_skladišta)
);

CREATE DATABASE EKSPERIMENT;

USE EKSPERIMENT;

CREATE TABLE PROBA (
	broj INT,
	tekst VARCHAR(50)
);

--UMETANJE PODATAKA
INSERT INTO PROBA (broj, tekst)
VALUES (1, 'JEDAN');               --ŠKOLSKI

--UMETANJE VIŠE REDAKA JEDNOM NAREDBOM INSERT
INSERT INTO PROBA (broj, tekst)
VALUES (2, 'DVA'), (3, 'TRI');

--SKRAÆENI OBLIK
INSERT INTO PROBA
VALUES (4, 'ÈETIRI');

--JOŠ KRAÆE, NE POPUNJAVAMO SVA POLJA
INSERT INTO PROBA (broj)
VALUES (5);
--ILI
INSERT INTO PROBA (broj,tekst)
VALUES (6, NULL);

--UMETANJE I IMPLICITNA KONVERZIJA
INSERT INTO PROBA (broj, tekst)
VALUES (7.5, 'SEDAM I POLA :)'); --->(1 row(s) affected)

-- PROVJERA SADRŽAJA TABLICE

SELECT * FROM PROBA;

---AŽURIRANJE PODATAKA

UPDATE PROBA
SET tekst = 'PET'
WHERE broj = 5;

--brisanje podataka

DELETE FROM PROBA
WHERE Broj= 6;