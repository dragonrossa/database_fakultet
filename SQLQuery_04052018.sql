
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

--- zadatak 1.3


USE master;

CREATE DATABASE Zadatak_1_3;

USE Zadatak_1_3;

CREATE TABLE �lanovi (
	�lanski_broj CHAR(10) PRIMARY KEY,
	Ime VARCHAR(50) NOT NULL,
	Prezime VARCHAR(100) NOT NULL,
	Adresa VARCHAR(100) NOT NULL,
	Telefon VARCHAR(20) NULL,
	Datum_u�lanjenja DATETIME
	);

CREATE TABLE �anr (
	�ifra_�anra CHAR(10) PRIMARY KEY,
	Naziv VARCHAR(50) NOT NULL,
	);

DROP TABLE Cjenik;

CREATE TABLE Cjenik (
	�ifra_cjenika INT PRIMARY KEY,
	Kategorija VARCHAR(50) NOT NULL,
	Cijena MONEY NOT NULL,
	);

CREATE TABLE Filmovi(
	�ifra_filma VARCHAR PRIMARY KEY,
	Naziv VARCHAR(50) NOT NULL,
	Re�iser VARCHAR(50) NOT NULL,  
	Glavni_glumci VARCHAR(200) NOT NULL,
	Godina_izdanja INT NOT NULL,
	Koli�ina_DVD INT NOT NULL,
	Koli�ina_VHS INT NOT NULL,
	Slika_naslovnice IMAGE,
	�ifra_�anra CHAR(10) REFERENCES �anr(�ifra_�anra)
	);

CREATE TABLE Posudba(
	�lanski_broj CHAR(10) REFERENCES �lanovi(�lanski_broj),
	�ifra_filma	VARCHAR  REFERENCES Filmovi(�ifra_filma),
	Datum_posudbe DATETIME,
	Datum_povratka DATETIME,
	�ifra_cjenika INT REFERENCES Cjenik(�ifra_cjenika),
	CONSTRAINT Posudba_FK PRIMARY KEY (�lanski_broj, �ifra_filma, Datum_posudbe)
	);

	-- umetnuti 3 retka u �ANR

	INSERT INTO �anr VALUES ('1', 'Drama'),('2', 'Akcija'),('3', 'KOMEDIJA');

	select * from �anr

USE Fakultet;

-- 3.2

SELECT mbrStud, imestud, prezstud,
		imestud + prezstud AS Ime_prezime
FROM stud; 

-- 3.3 

SELECT DISTINCT imestud 
FROM stud;

--3.4

SELECT mbrstud 
FROM ispit
WHERE sifPred=146 AND ocjena >1; -- polo�eni ispiti

-- 3.5 Select * FROM tablica - * ispisuje sav sadr�aj

SELECT imeNastavnik, prezNastavnik, (koef +0.4)*800 AS Pla�a  FROM nastavnik;

--3.6
SELECT imeNastavnik, prezNastavnik, (koef +0.4)*800 AS Pla�a  
FROM nastavnik
WHERE (koef +0.4)*800 < 3500
OR (koef +0.4)*800 > 8000;

--3.7, tablica stud i tablica ispit koje su povezane s mbr studenta//aliasi tablice - npr.Stud = S
SELECT S.imeStud,S.prezStud
FROM stud S, ispit I
WHERE S.mbrStud = I.mbrStud
AND I.ocjena = 1
AND I.sifPred BETWEEN 220 AND 240;

--3.8
SELECT DISTINCT S.imeStud,S.prezStud   --student je mogao polagati vi�e ispita i dobiti vi�e 3-ki - zato stavljamo DISTINCT
FROM stud S, ispit I
WHERE S.mbrStud = I.mbrStud
AND I.ocjena = 3;

--3.9 
SELECT P.nazPred
FROM pred P LEFT OUTER JOIN ispit I
	ON P.sifPred = I.sifPred
WHERE I.sifPred IS NULL;

--3.10

SELECT DISTINCT * --P.nazPred
FROM pred P INNER JOIN ispit I
	ON P.sifPred = I.sifPred;

--- ili pisano druga�ije

SELECT DISTINCT * --P.nazPred
FROM pred P , ispit I
	WHERE P.sifPred = I.sifPred;

--3.11
SELECT S.imeStud, S.prezStud
FROM stud S
--WHERE S.prezStud LIKE 'K%' -- prezime po�inje sa K 
--WHERE S.prezStud LIKE '%K%'

WHERE S.imeStud LIKE '[AEIOU]%' -- ime po�inje SAMOGLASNIKOM A,E,I,O ili U

--3.12
SELECT S.imeStud, S.prezStud
FROM stud S
WHERE S.imeStud LIKE '[^AEIOU]%' -- ime NE PO�INJE samoglasnikom A,E,I,O ili U jer smo stavili znak ^ ili ukoliko stavimo NOT LIKE

--3.13
SELECT S.imeStud, S.prezStud
FROM stud S
WHERE S.imeStud LIKE '[^AEIOU]%' --po�inje SAMOGLASNIKOM
OR S.imeStud LIKE '%[^AEIOU]'   -- ili zavr�ava SAMOGLASNIKOM

--3.14
SELECT S.imeStud, S.prezStud
FROM stud S
WHERE S.imeStud LIKE '%nk%' --sadr�ava "nk" jedan iza drugoga u IMENU
OR S.prezStud LIKE '%nk%' --sadr�ava "nk" jedan iza drugoga u PREZIMENU

--3.15
--STUD(mbrstud), ISPIT(ocijena), PRED (sifpred)
SELECT DISTINCT S.imeStud,S.prezStud, I.sifPred, P.nazPred, I.ocjena  --nisam pazio na DISTINCT , imamo 3 tablice >> n-1=3-1= min. 2 uvjeta
FROM stud S, ispit I, pred P
WHERE S.mbrStud = I.mbrStud
AND I.sifPred  = P.sifPred;
   
--3.16
--STUD (pbrrod), mjesto(pbr, sifzupanija), zupanija

-- SELECT DISTINCT S.imeStud,S.prezStud, ZU.sifZupanija, M.pbr, M.sifZupanija 
--FROM stud S, zupanija ZU, mjesto M
--WHERE S.mbrStud = S.prezStud
--AND ZU.sifZupanija = M.sifZupanija

SELECT S.imeStud, S.prezStud,
		MR.nazMjesto AS MJESTO_RO�ENJA,
		ZR.nazZupanija AS �UPANIJA_RO�ENJA,
		--STANOVANJE
		MS.nazMjesto AS MJESTO_STANOVANJA,         --//ne�to nedostaje
		ZS.nazZupanija AS �UPANIJA_STANOVANJA  
		        
FROM stud S JOIN mjesto MR ON S.pbrRod = MR.pbr
JOIN ZUPANIJA ZR ON MR.sifZupanija = ZR.sifZupanija -- 302
-- DODAJEMO PODATKE STANOVANJA
JOIN mjesto MS ON MS.pbr = S.pbrStan
JOIN zupanija ZS ON ZS.sifZupanija = MS.sifZupanija

--3.17
--PRED, ORGJED (sifOrgjed)
SELECT P.nazPred, O.nazOrgjed
FROM pred P JOIN orgjed O ON P.sifOrgjed = O.sifOrgjed
WHERE P.upisanoStud > 20; -- 26

--3.18
-- imena mjesta pojavljuju se samo jedanput - koristimo DISTINCT
--STUD, MJESTO (PBRSTAN) - ve�emo preko PBR stanovanja
SELECT DISTINCT M.nazMjesto 
FROM stud S JOIN mjesto M ON S.pbrStan= M.pbr; -- 29

--3.19
SELECT DISTINCT M.nazMjesto 
FROM stud S JOIN mjesto M ON S.pbrStan= M.pbr
AND S.pbrRod=S.pbrStan;  --26 
 

