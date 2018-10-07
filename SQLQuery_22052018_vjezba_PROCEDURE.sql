USE Fakultet

-- Ispisati prosje�nu ocjenu dobivenu na ispitima iz predmeta s nazivom Fizika materijala. 
-- U prosjek ulaze samo pozitivne ocjene

-- Ako se mjese�na pla�a nastavnika dobije mno�enjem broja 800 s koeficijentom koji je prije 
-- toga uve�an za 0.4, odredite koliko ukupno novaca mjese�no treba za isplatu pla�a u organizacijskoj 
-- jedinici sa �ifrom 100001

-- Ispisati �ifru, ime i prezime za nastavnike �ije ime po�inje slovom D i koji u toku prva dva 
-- mjeseca prethodne godine nisu negativno ocijenili niti jednog studenta. Upit mora biti neovisan 
-- o datumu izvo�enja

-- Ispisati dvorane (oznaku dvorane i kapacitet) �iji je kapacitet barem �etiri puta ve�i od 
-- kapaciteta najmanje dvorane

-- Ispisati �ifru, naziv i broj upisanih studenata za predmete koje je upisalo manje studenata nego 
-- �to za taj predmet ima evidentiranih ispita

-- Ispisati nastavnike �iji je koeficijent za pla�u ve�i od koeficijenata svih drugih nastavnika koji 
-- stanuju u istom mjestu. Ispisati �ifru, ime, prezime, koeficijent i naziv mjesta stanovanja takvih 
-- nastavnika. Smatra se da jedini nastavnik koji stanuje u nekom mjestu ima koeficijent ve�i "od svih 
-- drugih nastavnika" u tom mjestu, unato� tome �to tih "drugih nastavnika" u tom mjestu nema

-- Ispisati mati�ni broj, ime i prezime studenata koji niti jedan ispit nisu polagali u danu u tjednu 
-- u kojem su ro�eni. Npr. ako je student ro�en u utorak, niti na jednom ispitu nije bio utorkom
--________________________________________________
--________________________________________________

--1>
-- Ispisati prosje�nu ocjenu dobivenu na ispitima iz predmeta s nazivom Fizika materijala. 
-- U prosjek ulaze samo pozitivne ocjene

USE Fakultet

SELECT p.nazpred, AVG(cast(i.ocjena AS float)) AS 'Prosje�na_ocjena'
FROM pred P JOIN ispit I ON p.sifPred=i.sifPred 
WHERE i.ocjena > 1 AND nazPred LIKE 'Fizika m%'        --(SELECT nazPred FROM pred WHERE nazPred LIKE 'Fizika m%')
GROUP BY nazpred
--rezultat je Fizika materijala  , 	2,90909090909091                 
-------------------------
(--select *
--from pred
--where nazPred LIKE 'fizika m%'   --367	sifpred, kratpred ZFI03O5  ime:Fizika materijala  orgjed: 100001 upisanostud:45, brojsattjed:	3)


-------------------------
--2> 
-- Ako se mjese�na pla�a nastavnika dobije mno�enjem broja 800 s koeficijentom koji je prije 
-- toga uve�an za 0.4, odredite koliko ukupno novaca mjese�no treba za isplatu pla�a u organizacijskoj 
-- jedinici sa �ifrom 100001

SELECT SUM((n.koef+0.4)*800)
FROM nastavnik n
WHERE sifOrgjed = 100001           --rezultat je 47040.00


--3>
-- Ispisati �ifru, ime i prezime za nastavnike �ije ime po�inje slovom D i koji u toku prva dva 
-- mjeseca prethodne godine nisu negativno ocijenili niti jednog studenta. Upit mora biti neovisan 
-- o datumu izvo�enja

SELECT DISTINCT N.sifNastavnik, N.imeNastavnik, n.prezNastavnik
FROM nastavnik n JOIN ispit I ON n.sifNastavnik=i.sifNastavnik
WHERE n.imeNastavnik LIKE 'D%' AND i.ocjena>1
AND YEAR(datispit)=2003 --YEAR(getdate())-1 -teku�a godina -1 daje prethodnu godinu (2017.)
AND MONTH(datispit) IN (1,2)    --ili BETWEEN 1 AND 2

--rezultat je 3 profesora, Davorka, Dubravko i Damjan


--4>
-- Ispisati dvorane (oznaku dvorane i kapacitet) �iji je kapacitet barem �etiri puta ve�i od 
-- kapaciteta najmanje dvorane

SELECT *
FROM dvorana D
WHERE d.kapacitet>4* (SELECT MIN(kapacitet) FROM dvorana)

--B1   	64
--B4   	64

--5>
-- Ispisati �ifru, naziv i broj upisanih studenata za predmete koje je upisalo manje studenata nego 
-- �to za taj predmet ima evidentiranih ispita

SELECT *
FROM pred P
WHERE upisanoStud < (SELECT COUNT(*) FROM ispit I WHERE i.sifPred=p.sifPred) -- rezultat je 9  >>>--KORELIRALIN PODUPIT GDJE NAM JE VEZA sifPred iz podupita


--6>
-- Ispisati nastavnike �iji je koeficijent za pla�u ve�i od koeficijenata svih drugih nastavnika koji 
-- stanuju u istom mjestu. Ispisati �ifru, ime, prezime, koeficijent i naziv mjesta stanovanja takvih 
-- nastavnika. Smatra se da jedini nastavnik koji stanuje u nekom mjestu ima koeficijent ve�i "od svih 
-- drugih nastavnika" u tom mjestu, unato� tome �to tih "drugih nastavnika" u tom mjestu nema

SELECT *
FROM nastavnik n WHERE n.koef =(SELECT MAX(koef) maks FROM nastavnik ni where ni.pbrStan=n.pbrStan)  -- rezultat je 25 - opet korelirani upit.

SELECT *
FROM nastavnik N JOIN (SELECT pbrStan, MAX(koef) maks FROM nastavnik GROUP BY pbrStan) k 
ON n.pbrStan=k.pbrStan WHERE n.koef=k.maks															 -- rezultat je 25 

--SELECT *
--FROM nastavnik n JOIN (SELECT pbrStan, MAX(koef)   >>>>>>>>>>> DOPISATI

--7> 
-- Ispisati mati�ni broj, ime i prezime studenata koji niti jedan ispit nisu polagali u danu u tjednu 
-- u kojem su ro�eni. Npr. ako je student ro�en u utorak, niti na jednom ispitu nije bio utorkom

SELECT s.*, i.*, DATEPART(dw, i.datispit) danIspita, DATEPART(dw,datRodStud) danro�enja
FROM stud S JOIN ispit I ON s.mbrStud=i.mbrStud
WHERE DATEPART(dw, datispit) != DATEPART(dw ,datrodstud)    --rje�enje je 375  ; dw-dayweek - dan u tjednu (1-7), PON,UTO,SRI...

--------------------------------------------

-->>>>> 6. POGLAVLJE - KORISNI�KI DEFINIRANE FUNKCIJE

CREATE FUNCTION FN_Ime_Zupanije (@sifra INT)    --klju�na rije� je CREATE FUNCTION, zatim naziv FN_XXXXXXX_YYYYYY 
RETURNS varchar(100)             --returns javlja kakav tip podatka vra�a korisniku
AS
BEGIN
	RETURN (SELECT nazzupanija FROM zupanija WHERE sifZupanija = @sifra)   --return je klju�na rije� koji vra�a rezultat

END

PRINT dbo.FN_Ime_Zupanije(21)

---------------------------------

--ZADACI ZA VJE�BU , ZBIRKA, str 20.

--Zadatak 4.7

CREATE FUNCTION FN_PLA�A (@STR1 DECIMAL(10,3), @BAZ DECIMAL (10))
RETURNS DECIMAL (20,4)
AS
BEGIN
	RETURN @STR1 * @BAZ
END

--TEST

SELECT n.*, dbo.FN_PLA�A(n.koef,1000) AS Pla�a             --1000 je osnovica 
FROM nastavnik N

--Zadatak 4.8

CREATE FUNCTION FN_GRUPA (@KOEF DECIMAL(3,2))
RETURNS CHAR(4) -- tip podatka je veli�ina 9-10 - 4 znaka, mo�emo pisati varchar(100)
AS
BEGIN
	RETURN    CONCAT(FLOOR(@KOEF),'_',CEILING(@KOEF))
END

SELECT N.*, dbo.FN_GRUPA(N.koef) AS GRUPA
FROM nastavnik N                                    --98 rows(koliko ima i nastavnika)


--SELECT N.*, FLOOR(koef), CEILING(KOEF)
--FROM Nastavnik N

--------

--Zadatak 4.9

CREATE FUNCTION FN_MJESTA (@SIFRA INT)
RETURNS TABLE
AS
RETURN (SELECT nazMjesto FROM Mjesto WHERE sifZupanija = @SIFRA)

SELECT * FROM dbo.FN_MJESTA (21)  --ili bilo koja �ifra izme�u 1-21 u npr.(13)

--Zadatak 4.10

CREATE FUNCTION FN_SPOJI (@STR1 varchar(50), @STR2 VARCHAR(50))
RETURNS VARCHAR(100)
AS
BEGIN
	RETURN  LTRIM(RTRIM(@STR1)) + ' ' + LTRIM(RTRIM(@STR2))
END

--TEST

SELECT imeNastavnik, prezNastavnik, dbo.FN_SPOJI(imeNastavnik, prezNastavnik)  --R: Antun Ivan          +     	Jonji�       =            	Antun Ivan Jonji�
FROM nastavnik

--Zadatak 4.11

CREATE FUNCTION FN_NASTAVNICI (@VRSTA VARCHAR(6))
RETURNS @NAST table (         --mo�emo staviti CHECK i PK i bolo koje ograni�enje kao kad kreiramo tablicu
	SIFRA INT PRIMARY KEY,
	NAZIV VARCHAR(60) NOT NULL
)
AS
BEGIN
	IF @VRSTA = 'KRATKO'
		INSERT @NAST SELECT sifNastavnik, prezNastavnik FROM nastavnik
	ELSE IF @VRSTA = 'DUGO'
		INSERT @NAST select sifNastavnik, dbo.FN_SPOJI(imeNastavnik, prezNastavnik)  from nastavnik
	RETURN
END

SELECT * FROM dbo.fn_nastavnici ('DUGO')   --122	Tin Grabovac
SELECT * FROM dbo.fn_nastavnici ('KRATKO')  --122	Grabovac                 
SELECT * FROM dbo.fn_nastavnici ('AAA')

--Zadatak 4.12

CREATE FUNCTION FN_PREDMET (@VRSTA VARCHAR(6))
RETURNS @PRED table (         --u ZBIRKI je netko c/p gornji zadatak i tamo se navodi @NAST, mi �emo navesti @PRED	
	SIFRA INT PRIMARY KEY,
	NAZIV NVARCHAR(60) NOT NULL
)
AS
BEGIN
	IF @VRSTA = 'KRATKO'
		INSERT @PRED SELECT sifPred, nazPred FROM pred
	ELSE IF @VRSTA = 'DUGO'
		INSERT @PRED select sifPred, dbo.FN_SPOJI(kratPred, nazPred)  from pred
	RETURN
END

--TEST

SELECT * FROM dbo.FN_PREDMET ('KRATKO')
SELECT * FROM dbo.FN_PREDMET ('DUGO')    --USPOREDITI SA ZBIRKOM. OVO JE 2. RJE�ENJE

--Zadatak 4.13

CREATE FUNCTION FN_POPISNASTAVNIKA (@SIFRA INT)
RETURNS TABLE
AS
RETURN (
		SELECT * FROM nastavnik N WHERE n.sifOrgjed = @SIFRA
		)

--TEST
SELECT * FROM FN_POPISNASTAVNIKA(100001) --poku�ati s drugim �iframa org.jedinice, npr. 100002

--__________________________________________

--PROCEDURE
--__________________________________________

CREATE PROCEDURE PROC_NAZIV @SIFRA INT
AS
BEGIN

	SELECT * FROM zupanija WHERE sifZupanija= @SIFRA
	
END

--test--- 

EXEC dbo.PROC_NAZIV 11

--Zadatak 5.6 (str. 27)

SELECT * INTO NASTAVNIK_KOPIJA
FROM nastavnik                              --kopirali smo tablicu NASTAVNIK da ne zaje*** tablicu koju ina�e koristimo

EXEC sp_rename 'NASTAVNIK_KOPIJA.IMENASTAVNIK', 'IME'    --kolona koju mijenjamo mora imati naziv tablice koja se mijenja, stupac ne mora

--REZULTAT JE UPOZORENJE: "Caution: Changing any part of an object name could break scripts and stored procedures."
----
--Zadatak 5.7

EXEC sp_databases        --javlja rezultat za sve BAZE koje su spremljene i nemo�emo specificirati pojedinu

--Zadatak 5.8

CREATE PROCEDURE ISPIT_NA_DAN @DAN SMALLDATETIME
AS
BEGIN

	SELECT s.mbrStud, s.prezStud, s.imeStud
	FROM ispit I JOIN stud S ON I.mbrStud=S.mbrStud
	WHERE I.datIspit= @DAN

END

EXEC ISPIT_NA_DAN '2002-08-23'
--
--Zadatak 5.9.

CREATE PROCEDURE ZADNJE_POLAGAO @MBR INT
AS
BEGIN

	SELECT nazPred, datIspit
	FROM pred P JOIN ispit I
	ON p.sifPred=i.sifPred
	WHERE mbrStud= @MBR
	AND datIspit IN (SELECT max(datIspit) FROM ispit WHERE mbrStud= @MBR)

END

--TEST

EXEC zadnje_polagao 1127                 ---rezultat je 1127	458	166	2002-12-30 00:00:00.000 ocijena	5 

--Zadatak 5.10.

CREATE PROCEDURE POLOZENIH_ISPITA @MBR INT
AS
BEGIN 

	SELECT COUNT(*) AS Polo�io
	FROM ispit I
	WHERE I.mbrStud = @MBR
	AND i.ocjena > 1

END

--TEST

EXEC Polozenih_ispita 1127               ---rezultat je 2 POLO�ENA ISPITA
---------------------------

--VARIJABLE, POGLAVLJE 10.2
---------------------------

 PRINT @@connections

 PRINT @@VERSION

 PRINT @@ERROR

 SELECT * FROM stud

 PRINT @@ROWCOUNT
 
 -- JOIN. PODUPIT, IN , BETWEEN, VE�E, MANJE, ANY... ispit N.SQL