
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

--- zadatak 1.3


USE master;

CREATE DATABASE Zadatak_1_3;

USE Zadatak_1_3;

CREATE TABLE Èlanovi (
	Èlanski_broj CHAR(10) PRIMARY KEY,
	Ime VARCHAR(50) NOT NULL,
	Prezime VARCHAR(100) NOT NULL,
	Adresa VARCHAR(100) NOT NULL,
	Telefon VARCHAR(20) NULL,
	Datum_uèlanjenja DATETIME
	);

CREATE TABLE Žanr (
	Šifra_žanra CHAR(10) PRIMARY KEY,
	Naziv VARCHAR(50) NOT NULL,
	);

DROP TABLE Cjenik;

CREATE TABLE Cjenik (
	Šifra_cjenika INT PRIMARY KEY,
	Kategorija VARCHAR(50) NOT NULL,
	Cijena MONEY NOT NULL,
	);

CREATE TABLE Filmovi(
	Šifra_filma VARCHAR PRIMARY KEY,
	Naziv VARCHAR(50) NOT NULL,
	Režiser VARCHAR(50) NOT NULL,  
	Glavni_glumci VARCHAR(200) NOT NULL,
	Godina_izdanja INT NOT NULL,
	Kolièina_DVD INT NOT NULL,
	Kolièina_VHS INT NOT NULL,
	Slika_naslovnice IMAGE,
	Šifra_žanra CHAR(10) REFERENCES Žanr(Šifra_žanra)
	);

CREATE TABLE Posudba(
	Èlanski_broj CHAR(10) REFERENCES Èlanovi(Èlanski_broj),
	Šifra_filma	VARCHAR  REFERENCES Filmovi(Šifra_filma),
	Datum_posudbe DATETIME,
	Datum_povratka DATETIME,
	Šifra_cjenika INT REFERENCES Cjenik(Šifra_cjenika),
	CONSTRAINT Posudba_FK PRIMARY KEY (Èlanski_broj, Šifra_filma, Datum_posudbe)
	);

	-- umetnuti 3 retka u ŽANR

	INSERT INTO Žanr VALUES ('1', 'Drama'),('2', 'Akcija'),('3', 'KOMEDIJA');

	select * from Žanr

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
WHERE sifPred=146 AND ocjena >1; -- položeni ispiti

-- 3.5 Select * FROM tablica - * ispisuje sav sadržaj

SELECT imeNastavnik, prezNastavnik, (koef +0.4)*800 AS Plaæa  FROM nastavnik;

--3.6
SELECT imeNastavnik, prezNastavnik, (koef +0.4)*800 AS Plaæa  
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
SELECT DISTINCT S.imeStud,S.prezStud   --student je mogao polagati više ispita i dobiti više 3-ki - zato stavljamo DISTINCT
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

--- ili pisano drugaèije

SELECT DISTINCT * --P.nazPred
FROM pred P , ispit I
	WHERE P.sifPred = I.sifPred;

--3.11
SELECT S.imeStud, S.prezStud
FROM stud S
--WHERE S.prezStud LIKE 'K%' -- prezime poèinje sa K 
--WHERE S.prezStud LIKE '%K%'

WHERE S.imeStud LIKE '[AEIOU]%' -- ime poèinje SAMOGLASNIKOM A,E,I,O ili U

--3.12
SELECT S.imeStud, S.prezStud
FROM stud S
WHERE S.imeStud LIKE '[^AEIOU]%' -- ime NE POÈINJE samoglasnikom A,E,I,O ili U jer smo stavili znak ^ ili ukoliko stavimo NOT LIKE

--3.13
SELECT S.imeStud, S.prezStud
FROM stud S
WHERE S.imeStud LIKE '[^AEIOU]%' --poèinje SAMOGLASNIKOM
OR S.imeStud LIKE '%[^AEIOU]'   -- ili završava SAMOGLASNIKOM

--3.14
SELECT S.imeStud, S.prezStud
FROM stud S
WHERE S.imeStud LIKE '%nk%' --sadržava "nk" jedan iza drugoga u IMENU
OR S.prezStud LIKE '%nk%' --sadržava "nk" jedan iza drugoga u PREZIMENU

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
		MR.nazMjesto AS MJESTO_ROÐENJA,
		ZR.nazZupanija AS ŽUPANIJA_ROÐENJA,
		--STANOVANJE
		MS.nazMjesto AS MJESTO_STANOVANJA,         --//nešto nedostaje
		ZS.nazZupanija AS ŽUPANIJA_STANOVANJA  
		        
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
--STUD, MJESTO (PBRSTAN) - vežemo preko PBR stanovanja
SELECT DISTINCT M.nazMjesto 
FROM stud S JOIN mjesto M ON S.pbrStan= M.pbr; -- 29

--3.19
SELECT DISTINCT M.nazMjesto 
FROM stud S JOIN mjesto M ON S.pbrStan= M.pbr
AND S.pbrRod=S.pbrStan;  --26 
 

