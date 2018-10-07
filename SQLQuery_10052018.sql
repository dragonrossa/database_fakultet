
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
 

USE Fakultet

-- 3.21
-- pred, orgjed, rezervacija

SELECT DISTINCT P.nazPred, R.oznDvorana, O.sifOrgjed  --DISTINCT prikazuje samo one termine koji su slobodni
FROM pred P JOIN rezervacija R ON P.sifPred=r.sifPred
JOIN orgjed O ON O.sifOrgjed = P.sifOrgjed;
--ili

SELECT DISTINCT P.nazPred, R.oznDvorana, O.sifOrgjed
FROM pred P, rezervacija R, orgjed O
WHERE p.sifPred = R.sifPred
AND o.sifOrgjed = P.sifOrgjed;   -- 71 je rezultat


-- 3.22
--stud, ispit, nastavnik, mjesto (x2)
SELECT DISTINCT N.imeNastavnik, N.prezNastavnik, n.sifNastavnik
FROM stud S JOIN ispit I ON S.mbrStud = I.mbrStud
JOIN nastavnik N ON N.sifNastavnik=I.sifNastavnik
JOIN mjesto MN ON MN.pbr=N.pbrStan
JOIN mjesto MS ON MS.pbr=S.pbrStan
WHERE MN.sifZupanija=ms.sifZupanija;  --> 24 je rezultat

-- 3.23
--studenti koji studiraju u mjestu <> mjesta ro�enja
--ali su mjesta u istoj �upaniji
--stud, mjesto

SELECT S.*
FROM stud S 
JOIN mjesto MR ON MR.pbr = S.pbrRod   --(MR - mjesto ro�enja, MS - mjesto stanovanja)
JOIN mjesto MS ON MS.pbr = S.pbrStan
WHERE MR.sifZupanija = MS.sifZupanija
AND S.pbrRod <> S.pbrStan;                        --> rezultat je 3 studenta (Karlo Krsnik, Igor Bogati, Nata�a Cerjan)

--3.24

--studenti i nastavnici koji imaju ista prezimena

SELECT S.imeStud, S.prezStud, N.imeNastavnik, N.prezNastavnik
FROM stud S JOIN nastavnik N
ON S.prezStud=N.prezNastavnik;   -- 20
 
 --3.25

 --trebaju nam 3 tablice >> STUD, ISPIT, PREDMET

SELECT DISTINCT S.* --Distinct( isti student je mogao ispit pasti vi�e puta)
FROM stud S JOIN ispit I ON s.mbrStud = i.mbrStud
			JOIN pred P ON p.sifPred=i.sifPred
			WHERE I.ocjena =1
			AND p.nazPred LIKE 'Osnove baza podat%';   -- rezultat je 2


-- ZADATAK KOJI NIJE NAVEDEN U SKRIPTI SQL

-- ispisati studente koji nisu polagali niti jedan ispit


SELECT S.* 
FROM stud S LEFT OUTER JOIN ispit I ON s.mbrStud=i.mbrStud
WHERE I.mbrStud IS NULL;   -- 194
			
-- ispisati predmete koje nitko nije polagao

SELECT  P.* 
FROM ispit I RIGHT OUTER JOIN pred P ON I.sifPred=P.sifPred
WHERE I.sifPred IS NULL;   -- 116
-------------------------------------------------------------


SELECT  P.* 
FROM ispit I RIGHT OUTER JOIN pred P ON I.sifPred=P.sifPred
WHERE I.sifPred IS NULL   -- 116
ORDER BY nazPred, sifOrgjed  ASC;   --ASC / DESC redosljedno 1.nazPred Adapriv..., Alarmni sustavi,Analiza, zatim ide sifOrgjed 100008...
---------------------

--ispisati predmete koje nitko nije polagao
SELECT  P.* 
INTO PREDMET_KOJI_NISU_POLAGANI   --INTO kreira novu tablicu
FROM ispit I RIGHT OUTER JOIN pred P ON I.sifPred=P.sifPred
WHERE I.sifPred IS NULL   

-- 4.4

CREATE VIEW Zadatak44 AS
SELECT P.nazPred, R.oznDvorana, R.oznVrstaDan, R.sat
FROM PRED P JOIN rezervacija R ON P.sifPred = R.sifPred

SELECT * FROM Zadatak44;   --rje�enje je 89

--4.5
--nastavnici s mjestom u kojem stanuju

CREATE VIEW Zadatak45 AS
SELECT N.* , M.nazMjesto
FROM NASTAVNIK N JOIN MJESTO M ON N.pbrStan = M.pbr;

SELECT * FROM Zadatak45;  -- rje�enje je 98

--4.6
--podaci o studentima, predmet, ocjenu i podatke o nastavniku koji je ispitivao

CREATE VIEW Zadatak46 AS
SELECT S.imeStud, S.prezStud, S.mbrStud, i.ocjena, p.nazPred, n.imeNastavnik, n.prezNastavnik
FROM stud S JOIN ispit I ON s.mbrStud=i.mbrStud
JOIN nastavnik N ON N.sifNastavnik = i.sifNastavnik
JOIN pred P ON P.sifPred = I.sifPred; 

SELECT * FROM Zadatak_46  -- rezultat je 435
--_____________________________________________--

print left ('Marica', 2)
print getdate()

select rtrim(s.imeStud) + ' ' + rtrim(s.prezStud) AS Ime_prezime
from stud s;

--5.1

select s.imeStud, s.prezStud, m.nazMjesto
from stud S JOIN mjesto M on S.pbrRod = M.pbr
---ime po�inje slovom 'F'
WHERE LEFT(imestud,1)= 'F';       ---alternativa je LIKE

--5.2

select n.imeNastavnik, n.prezNastavnik, m.nazMjesto, SUBSTRING(nazmjesto, 3,1) As Tre�e_slovo
from nastavnik N JOIN mjesto M ON N.pbrStan=M.pbr   --(tablicu nastavnik spajamo s tablicom mjeso preko PBR Stanovanja)
where SUBSTRING(nazmjesto,  3,1) ='Z'

--5.3

select N.imeNastavnik, N.prezNastavnik, s.imeStud, S.prezStud
from nastavnik N JOIN stud S ON  SUBSTRING(imeStud,5,1) = SUBSTRING(imenastavnik,5,1)
--duljina imena mora biti barem 5 znakova
WHERE LEN(imenastavnik) >=5 AND LEN(imestud) >=5      --rezultat 1723

--5.4

--  naziv �upanije >13 i manje <20

 SELECT Z.*, LEN(nazZupanija) AS Duljina_naziva
 FROM zupanija Z
 WHERE LEN(nazZupanija) > 13
 and LEN(nazZupanija) < 20            --rezultat je 8


 ---------------------------

 USE fakultet;

 --17. ispi�ite imena i prezimena nastavnika s nazivom mjesta u kojem stanuju.

 SELECT N.imeNastavnik, N.prezNastavnik, M.nazMjesto
 FROM nastavnik N 
 JOIN mjesto M ON N.pbrStan = M.pbr;   --rezultat je 98

 --18. ispi�imo imena i prezimena svih studenata zajedno s ispitima na koje su iza�li
 --i ocijenama koje su dobili. Naravno, biti �e studenata koji nisu ni jednom iza�li na neki ispit 
 --pa kod njih ne mo�emo ispisati �ifru ispita.

 SELECT DISTINCT S.imeStud, S.prezStud, I.sifPred, I.sifNastavnik, I.ocjena, I.datIspit
 FROM stud S LEFT OUTER JOIN ispit I ON S.mbrStud=I.mbrStud;
   --- rezultat 628 

 --19. Ispi�imo sve predmete i dvorane u kojima se predaje.
 --Kako se neki predmeti ne predaju ovaj semestar, oni nemaju rezerviranu dvoranu
 --pa �e to biti reprezentirano NULL vrijednostima

 SELECT *
 FROM pred P LEFT OUTER JOIN rezervacija R ON P.sifPred=R.sifPred
 ORDER BY P.sifPred, R.oznDvorana, r.oznDvorana, r.oznVrstaDan, R.sat;


 --20.Ispi�imo sve studente koji su iza�li na ispite i sve predmete.
 --Naravno, biti �e studenata koji nisu iza�li ni na jedan predmet, ali
 --isto tako biti �e predmeta na koje nitko nije iza�ao.

 SELECT *
 FROM stud S LEFT OUTER JOIN ispit I ON S.mbrStud=I.mbrStud
 FULL OUTER JOIN pred P ON I.sifPred=P.sifPred;   -->Mario says 628, meni ispadne 745

 --21. Ispi�ite sve organizacijske jedinice s pripadaju�im nadre�enim organizacijskim jedinicama

 SELECT O.*, N.nazOrgjed AS Nadre�ena
 FROM orgjed O LEFT OUTER JOIN orgjed N ON O.sifNadorgjed=N.sifOrgjed  --134

--22. Ispi�ite inicijal imena i prezimena studenta (npr.An. Mili�) u jednom stupcu nazvanom Student

SELECT LEFT(S.IMESTUD,2) + '.' + RTRIM(S.prezStud) AS INICIJAL
FROM stud S

-- Iz tablice Studenti ispi�ite re�enice oblika:
--Sanja Tarak ima mati�ni broj 2.                   //CAST i CONVERT f-je mogu povezati CHAR i INT

SELECT RTRIM(S.imeStud) + ' ' + RTRIM(S.prezStud) + 'ima mati�ni broj' + CAST(mbrStud AS varchar(10))
FROM stud S          --> rezultat je 303

--Izra�unajte koliko je dana ostalo do Nove godine.

PRINT DATEDIFF(d,getdate(), '2018.12.31') --> rje�enje je 235 (danas je 10.05.2018.)

PRINT '2018.12.31'-getdate() --> rje�enje je Aug 23 1900 5:04 AM (sada je 10.05.2018. 18:55h - SQL ra�una razliku datuma, poput Excela)
 
--Ispis svih podataka studenata koji su ro�eni izme�u 1.5. i 1.9.1985. i 
--ime im zavr�ava slovom 'A' ili slovom 'J' ili slovom 'R'.

SELECT *
FROM stud S
WHERE datRodStud BETWEEN '1985.5.1' AND '1985.9.1'
AND RIGHT(RTRIM(imeStud),1) IN ('A','J','R'); --> rezultat je 35


--------------------------------------
--2. PARCIJALNI ISPIT - SQL--
--------------------------------------

CREATE DATABASE Mihael

USE Mihael

CREATE TABLE Prijatelji (
�ifra_prijatelj CHAR(3) PRIMARY KEY,
Ime VARCHAR(25) NOT NULL,
Prezime VARCHAR(25) NOT NULL
);

CREATE TABLE Medij(
�ifra_medija CHAR(10) PRIMARY KEY,
Naziv_medija VARCHAR(50),
Posudba DATETIME
);

CREATE TABLE Posudba(
	�ifra CHAR(3) REFERENCES Prijatelji(�ifra_prijatelj),
	�ifra_medija CHAR(10)  REFERENCES Medij(�ifra_medija),
	Datum_posudbe DATETIME,
	Datum_povratka DATETIME
	);
	
		
	-- Svaku tablicu popunite sa po 3 zapisa (unesite 3 svoja prijatelja i 3 glazbena CD-a koja imate kod ku�e,
	-- te proizvoljno unesite �ta je koji prijatelj posudio, datum kada je posudio 
	-- i unesite datum kada je vratio samo za jednog prijatelja).   

INSERT INTO Prijatelji VALUES ('001','Nevenko','Pavlic'),
							  ('002','Zvonimir', 'Ivkovi�'),
							  ('003','Kre�imir', 'Horvath');

	select * from Prijatelji

INSERT INTO Medij (�ifra_medija, Naziv_medija)
 VALUES  ('AA','ABBA'),
		 ('BB','ROLLING STONES'),
		 ('CC','LAST ACTION HERO');

    select * from Medij

--DATE - format YYYY-MM-DD

SELECT * FROM Medij

SELECT * FROM Posudba

SELECT *
FROM Posudba POS JOIN Prijatelji P on P.�ifra=POS.Posudba

SELECT * datediff(d, dat.pos, getdate())