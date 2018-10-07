USE Fakultet

-- Ispisati prosjeènu ocjenu dobivenu na ispitima iz predmeta s nazivom Fizika materijala. 
-- U prosjek ulaze samo pozitivne ocjene

-- Ako se mjeseèna plaæa nastavnika dobije množenjem broja 800 s koeficijentom koji je prije 
-- toga uveæan za 0.4, odredite koliko ukupno novaca mjeseèno treba za isplatu plaæa u organizacijskoj 
-- jedinici sa šifrom 100001

-- Ispisati šifru, ime i prezime za nastavnike èije ime poèinje slovom D i koji u toku prva dva 
-- mjeseca prethodne godine nisu negativno ocijenili niti jednog studenta. Upit mora biti neovisan 
-- o datumu izvoðenja

-- Ispisati dvorane (oznaku dvorane i kapacitet) èiji je kapacitet barem èetiri puta veæi od 
-- kapaciteta najmanje dvorane

-- Ispisati šifru, naziv i broj upisanih studenata za predmete koje je upisalo manje studenata nego 
-- što za taj predmet ima evidentiranih ispita

-- Ispisati nastavnike èiji je koeficijent za plaæu veæi od koeficijenata svih drugih nastavnika koji 
-- stanuju u istom mjestu. Ispisati šifru, ime, prezime, koeficijent i naziv mjesta stanovanja takvih 
-- nastavnika. Smatra se da jedini nastavnik koji stanuje u nekom mjestu ima koeficijent veæi "od svih 
-- drugih nastavnika" u tom mjestu, unatoè tome što tih "drugih nastavnika" u tom mjestu nema

-- Ispisati matièni broj, ime i prezime studenata koji niti jedan ispit nisu polagali u danu u tjednu 
-- u kojem su roðeni. Npr. ako je student roðen u utorak, niti na jednom ispitu nije bio utorkom
--________________________________________________
--________________________________________________

--1>
-- Ispisati prosjeènu ocjenu dobivenu na ispitima iz predmeta s nazivom Fizika materijala. 
-- U prosjek ulaze samo pozitivne ocjene

USE Fakultet

SELECT p.nazpred, AVG(cast(i.ocjena AS float)) AS 'Prosjeèna_ocjena'
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
-- Ako se mjeseèna plaæa nastavnika dobije množenjem broja 800 s koeficijentom koji je prije 
-- toga uveæan za 0.4, odredite koliko ukupno novaca mjeseèno treba za isplatu plaæa u organizacijskoj 
-- jedinici sa šifrom 100001

SELECT SUM((n.koef+0.4)*800)
FROM nastavnik n
WHERE sifOrgjed = 100001           --rezultat je 47040.00


--3>
-- Ispisati šifru, ime i prezime za nastavnike èije ime poèinje slovom D i koji u toku prva dva 
-- mjeseca prethodne godine nisu negativno ocijenili niti jednog studenta. Upit mora biti neovisan 
-- o datumu izvoðenja

SELECT DISTINCT N.sifNastavnik, N.imeNastavnik, n.prezNastavnik
FROM nastavnik n JOIN ispit I ON n.sifNastavnik=i.sifNastavnik
WHERE n.imeNastavnik LIKE 'D%' AND i.ocjena>1
AND YEAR(datispit)=2003 --YEAR(getdate())-1 -tekuæa godina -1 daje prethodnu godinu (2017.)
AND MONTH(datispit) IN (1,2)    --ili BETWEEN 1 AND 2

--rezultat je 3 profesora, Davorka, Dubravko i Damjan


--4>
-- Ispisati dvorane (oznaku dvorane i kapacitet) èiji je kapacitet barem èetiri puta veæi od 
-- kapaciteta najmanje dvorane

SELECT *
FROM dvorana D
WHERE d.kapacitet>4* (SELECT MIN(kapacitet) FROM dvorana)

--B1   	64
--B4   	64

--5>
-- Ispisati šifru, naziv i broj upisanih studenata za predmete koje je upisalo manje studenata nego 
-- što za taj predmet ima evidentiranih ispita

SELECT *
FROM pred P
WHERE upisanoStud < (SELECT COUNT(*) FROM ispit I WHERE i.sifPred=p.sifPred) -- rezultat je 9  >>>--KORELIRALIN PODUPIT GDJE NAM JE VEZA sifPred iz podupita


--6>
-- Ispisati nastavnike èiji je koeficijent za plaæu veæi od koeficijenata svih drugih nastavnika koji 
-- stanuju u istom mjestu. Ispisati šifru, ime, prezime, koeficijent i naziv mjesta stanovanja takvih 
-- nastavnika. Smatra se da jedini nastavnik koji stanuje u nekom mjestu ima koeficijent veæi "od svih 
-- drugih nastavnika" u tom mjestu, unatoè tome što tih "drugih nastavnika" u tom mjestu nema

SELECT *
FROM nastavnik n WHERE n.koef =(SELECT MAX(koef) maks FROM nastavnik ni where ni.pbrStan=n.pbrStan)  -- rezultat je 25 - opet korelirani upit.

SELECT *
FROM nastavnik N JOIN (SELECT pbrStan, MAX(koef) maks FROM nastavnik GROUP BY pbrStan) k 
ON n.pbrStan=k.pbrStan WHERE n.koef=k.maks															 -- rezultat je 25 

--SELECT *
--FROM nastavnik n JOIN (SELECT pbrStan, MAX(koef)   >>>>>>>>>>> DOPISATI

--7> 
-- Ispisati matièni broj, ime i prezime studenata koji niti jedan ispit nisu polagali u danu u tjednu 
-- u kojem su roðeni. Npr. ako je student roðen u utorak, niti na jednom ispitu nije bio utorkom

SELECT s.*, i.*, DATEPART(dw, i.datispit) danIspita, DATEPART(dw,datRodStud) danroðenja
FROM stud S JOIN ispit I ON s.mbrStud=i.mbrStud
WHERE DATEPART(dw, datispit) != DATEPART(dw ,datrodstud)    --rješenje je 375  ; dw-dayweek - dan u tjednu (1-7), PON,UTO,SRI...

--------------------------------------------

-->>>>> 6. POGLAVLJE - KORISNIÈKI DEFINIRANE FUNKCIJE

CREATE FUNCTION FN_Ime_Zupanije (@sifra INT)    --kljuèna rijeè je CREATE FUNCTION, zatim naziv FN_XXXXXXX_YYYYYY 
RETURNS varchar(100)             --returns javlja kakav tip podatka vraæa korisniku
AS
BEGIN
	RETURN (SELECT nazzupanija FROM zupanija WHERE sifZupanija = @sifra)   --return je kljuèna rijeè koji vraæa rezultat

END

PRINT dbo.FN_Ime_Zupanije(21)

---------------------------------

--ZADACI ZA VJEŽBU , ZBIRKA, str 20.

--Zadatak 4.7

CREATE FUNCTION FN_PLAÆA (@STR1 DECIMAL(10,3), @BAZ DECIMAL (10))
RETURNS DECIMAL (20,4)
AS
BEGIN
	RETURN @STR1 * @BAZ
END

--TEST

SELECT n.*, dbo.FN_PLAÆA(n.koef,1000) AS Plaæa             --1000 je osnovica 
FROM nastavnik N

--Zadatak 4.8

CREATE FUNCTION FN_GRUPA (@KOEF DECIMAL(3,2))
RETURNS CHAR(4) -- tip podatka je velièina 9-10 - 4 znaka, možemo pisati varchar(100)
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

SELECT * FROM dbo.FN_MJESTA (21)  --ili bilo koja šifra izmeðu 1-21 u npr.(13)

--Zadatak 4.10

CREATE FUNCTION FN_SPOJI (@STR1 varchar(50), @STR2 VARCHAR(50))
RETURNS VARCHAR(100)
AS
BEGIN
	RETURN  LTRIM(RTRIM(@STR1)) + ' ' + LTRIM(RTRIM(@STR2))
END

--TEST

SELECT imeNastavnik, prezNastavnik, dbo.FN_SPOJI(imeNastavnik, prezNastavnik)  --R: Antun Ivan          +     	Jonjiæ       =            	Antun Ivan Jonjiæ
FROM nastavnik

--Zadatak 4.11

CREATE FUNCTION FN_NASTAVNICI (@VRSTA VARCHAR(6))
RETURNS @NAST table (         --možemo staviti CHECK i PK i bolo koje ogranièenje kao kad kreiramo tablicu
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
RETURNS @PRED table (         --u ZBIRKI je netko c/p gornji zadatak i tamo se navodi @NAST, mi æemo navesti @PRED	
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
SELECT * FROM dbo.FN_PREDMET ('DUGO')    --USPOREDITI SA ZBIRKOM. OVO JE 2. RJEŠENJE

--Zadatak 4.13

CREATE FUNCTION FN_POPISNASTAVNIKA (@SIFRA INT)
RETURNS TABLE
AS
RETURN (
		SELECT * FROM nastavnik N WHERE n.sifOrgjed = @SIFRA
		)

--TEST
SELECT * FROM FN_POPISNASTAVNIKA(100001) --pokušati s drugim šiframa org.jedinice, npr. 100002