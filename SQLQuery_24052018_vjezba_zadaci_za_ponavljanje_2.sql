------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------
-- Napredni SQL -------
------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------

--ZADACI IZ PRIRUÈNIKA


use Fakultet

--Zadatak 1.1--

SELECT count(DISTINCT pbrRod) as Broj_mjesta
From stud           --rješenje je 66

--Zadatak 1.2--

SELECT Count(*) AS Broj_studenata
FROM stud S LEFT JOIN ispit I ON S.mbrStud=I.mbrStud  -- (ukoliko upišem samo JOIN - rezultat je 0, LEFT JOIN je 194)
WHERE I.mbrStud IS NULL

--Zadatak 1.3--

SELECT count(*) AS Broj_studenata
FROM pred P
WHERE P.upisanoStud > 5       --rezultat je 69

--Zadatak 1.4--

SELECT count(*) AS Broj_studenata
FROM pred P
WHERE P.upisanoStud=0       --rezultat je 47

--Zadatak 1.5--

SELECT S.mbrStud, S.prezStud, S.imeStud, AVG(i.ocjena) AS Prosjeèna_ocijena
FROM stud S JOIN ispit I ON s.mbrStud=I.mbrStud
WHERE i.ocjena > 1
GROUP BY S.mbrStud, S.prezStud, S.imeStud;      -- CAST za pretvaranje INT u FLOAT (cijeli u dec.broj)


--ili--

SELECT S.mbrStud, S.prezStud, S.imeStud, AVG(CAST(i.ocjena AS float)) AS Prosjek
FROM stud S JOIN ispit I ON s.mbrStud=I.mbrStud
WHERE i.ocjena > 1
GROUP BY S.mbrStud, S.prezStud, S.imeStud
ORDER BY Prosjek DESC;


--Zadatak 1.6--

SELECT P.nazPred, AVG(CAST(I.ocjena AS float)) AS Pros
FROM Pred P JOIN ispit I ON p.sifPred=I.sifPred
GROUP BY P.nazPred
ORDER BY Pros DESC;     --rezultat je 60

--Zadatak 1.7

SELECT S.mbrStud, s.prezStud, s.imeStud, AVG(CAST(I.ocjena AS float)) AS Pros
FROM stud S JOIN ispit I ON S.mbrStud=I.mbrStud
WHERE I.ocjena > 1
GROUP BY S.mbrStud, S.prezStud, S.imeStud
ORDER BY Pros DESC;      --rezultat je 109

--Zadatak 1.8

SELECT S.mbrStud, s.prezStud, s.imeStud, AVG(CAST(I.ocjena AS float)) AS Pros
FROM stud S JOIN ispit I ON S.mbrStud=I.mbrStud
WHERE I.ocjena > 1					--> FILTRIRANJE ULAZNIH PODATAKA
GROUP BY S.mbrStud, S.prezStud, S.imeStud
HAVING AVG(CAST(I.ocjena AS float)) > 2.5 --> FILTRIRANJE ULAZNIH PODATAKA
ORDER BY Pros DESC;          ---rezultat je 76

--Zadatak 1.9

SELECT COUNT(*) AS Broj_predmeta    
FROM ispit I RIGHT OUTER JOIN pred P ON P.sifPred=I.sifPred         --TREBA nam vanjski spoj izmeðu ispita i predmeta)
WHERE I.sifPred IS NULL;        --rezultat je 116

--Zadatak 1.10

SELECT N.pbrStan, MAX(koef) AS Maksimalni_koef, COUNT(*) AS Broj_nast
FROM nastavnik N
GROUP BY N.pbrStan   --rezultat 24

--ili MIN

SELECT N.pbrStan, MAX(koef) AS Maksimalni_koef, MIN (koef) AS Minimalni_koef, COUNT(*) AS Broj_nast
FROM nastavnik N
GROUP BY N.pbrStan   --rezultat je isti ali imamo MAX i MIN polje dodano

--Zadatak 1.11

SELECT TOP 3 n.*
FROM nastavnik N
ORDER BY koef DESC --3 nastavnika (Želimir Prester, Sandra Stanojeviæ, Sandra Mihaeljeviæ)

--OBRATITI POZORNOST !!!! 


SELECT TOP 4 n.*   --TOP 4 (èetiri)
FROM nastavnik N
ORDER BY koef DESC --3 nastavnika (Želimir Prester, Sandra Stanojeviæ, Sandra Mihaeljeviæ i BERNARD JURJEVIÆ)--svi imaju jednak koeficijent

--Zadatak 1.12

SELECT CAST(N.koef AS INT) AS Grupa, AVG(N.koef) AS Pros_koef, COUNT(*) as Broj_nast
FROM nastavnik N
GROUP BY CAST(N.koef AS INT)   --rezultat je 7. 

--Zadatak 1.13
--OrgJed navodimo 2x sa razlièitim ALIAS-ima jer je ORG JED ima NADREÐENU JED, a to je refleksivna veza -tablica na tablicu)


SELECT N.sifOrgjed, COUNT(*) AS Podreðenih
 FROM orgjed O LEFT OUTER JOIN orgjed N    --orgjed O - 1.navoðenje,  orgjed N - 2. navoðenje tablice
 ON O.sifNadorgjed=N.sifOrgjed
 GROUP BY N.sifOrgjed               --rezultat je 19 
------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------
  --ZADACI IZ ZBIRKE
------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------
 
--1.1

select	COUNT(nazpred) AS 'Ukupno ima ___ predmeta '
from pred							   
						  --183 predmeta

--1.2

SELECT p.nazpred, SUM(upisanoStud) Broj
FROM pred p
GROUP BY nazPred          --156 rows, 156 predmeta? VIDI ZADATAK GORE- postoje predmeti istog naziva, a razlièite šifre
 
 --1.3

 SELECT nazmjesto, COUNT(*) AS 'Broj studenata'
 FROM stud JOIN mjesto ON
 stud.pbrStan=mjesto.pbr
 GROUP BY nazMjesto 
 --sort po najveæem broju
 ORDER BY [Broj studenata] DESC      -- 29 razlièitih mjesta, od toga 162 iz Zagreba (ukupno 302 studenta)

 --1.4

SELECT COUNT(stud.mbrStud) AS 'Broj studenata koji nije izašao na ispit'
FROM stud LEFT JOIN ispit
ON stud.mbrStud=ispit.mbrStud
WHERE ocjena IS NULL                 -- zašto LEFT OUTER JOIN? - INNER JOIN vraæa rezultat 0. Inaèe, rezultat je 193.

--1.5

SELECT COUNT(p.nazPred) AS 'Više od 5'
FROM pred P
WHERE p.upisanoStud > 5				--69 predmeta je upisalo više od 5 studenata

--1.6

SELECT COUNT(p.nazPred) 'Nula studenata'
FROM pred P
WHERE p.upisanoStud=0               --47 predmeta; ne koristimo NULL jer to znaèi da ne postoji podatak, a za SVE predmete
									--imamo barem nekakav podatak o broju upisanih, ukljuèujuæi i nulu '0'.

--1.7

SELECT COUNT(p.nazPred) 'Upisano 2 do 5 studenata'
FROM pred P
WHERE p.upisanoStud BETWEEN 2 AND 5    --43 predmeta

--1.8

SELECT COUNT(pred.sifPred) AS 'Broj PREDMETA na koje nije izašao niti jedan student'
FROM pred LEFT JOIN ispit
ON pred.sifPred=ispit.sifPred
WHERE ocjena IS NULL				--116 predmeta

--1.9

SELECT COUNT(DISTINCT I.sifPred) AS 'Broj izlazaka na na ispit'
FROM ispit I						
									--67 predmeta, koristimo šifru predmeta jer po datumu, ocijeni, mbr studenta ili nastavniku
									--ne možemo odrediti broj izlazaka

--1.10

SELECT MAX(koef) 
FROM nastavnik        --9.90

--1.11

SELECT MAX(koef), pbrStan, nazMjesto
FROM nastavnik N JOIN mjesto M
ON n.pbrStan=m.pbr
GROUP BY pbrStan, nazMjesto
ORDER BY MAX(koef) DESC            -- 29 razlièitih mjesta, dobijemo 24 redaka(mjesta) ??

------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------

--1.12
--1.13
--1.14
--1.15
--1.16
--1.17
--1.18
--1.19
--1.20
--1.21
--1.22
------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
-- ZADACI ZA VJEŽBU--
------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------

-- 1> Ispisati broj negativnih ocjena dobivenih na ispitu iz predmeta sa šifrom 474

USE Fakultet

SELECT COUNT(*) AS broj_neg
FROM ispit i
WHERE ocjena = 1 AND sifPred = 474;    --rezultat je 3!

-- 2> Odredite kojeg je datuma roðen najstariji student

SELECT MIN(datRodStud) AS Najstariji
FROM stud                            --rezultat je "1980-02-29 00:00:00.000"


-- 3> ispisati koliko je dana proteklo izmeðu najranijeg i najkasnijeg datuma izlaska na ispit

SELECT DATEDIFF (d, MIN(datIspit), MAX(datIspit))
FROM ispit                             --rezultat je 764

--ILI

SELECT CAST(MAX(datIspit) - MIN(datIspit) AS integer) as Dana
FROM ispit								--rezultat je 764

-- 4> Ispisati broj pozivitno ocijenjenih ispita i prosjeènu ocjenu pozitivno ocijenjenih ispita
--	  koji su obavljeni u toku zadnja tri mjeseca 2002. godine

SELECT AVG(CAST(ocjena AS float))
FROM ispit
WHERE DATEPART(m, datispit) > 9
AND DATEPART (yy, datispit) = 2002   --prosjek svih ocjena(ukljuèujuæi i negativne(1))

SELECT COUNT(*) AS broj_neg
FROM ispit 
WHERE ocjena > 1

---------------

SELECT COUNT(*) AS Broj_pozitivno_ocijenjenih_ispita, AVG(CAST(ocjena AS float)) AS Prosjek_ocjena
FROM ispit I
WHERE ocjena > 1
AND datIspit BETWEEN '2002.10.1' AND '2002.12.31';   --- rezultat je 39 poz.ocijenjenih ispita i prosjek istih je 2,8974358974359

-- 5> U koliko razlièitih dvorana se obavlja nastava iz predmeta pod nazivom "Elektronièki materijali i tehnologija"

SELECT COUNT(distinct r.oznDvorana) AS broj_dvorana
FROM pred p JOIN rezervacija R ON p.sifPred=r.sifPred
WHERE p.nazPred LIKE 'Elektrotehnièki mater%'            ---rezultat je 3!


-- 6> Ispisati dvorane (oznaku dvorane i kapacitet) èiji je kapacitet barem èetiri puta (4x) veæi od kapaciteta najmanje dvorane

SELECT *
FROM dvorana d
WHERE kapacitet > 4* (SELECT MIN(kapacitet) FROM dvorana)   -- rezultat su 2 dvorane; B1 i B4 s kapacitetom po 64 mjesta


-- 7> Ispisati šifru, naziv i broj upisanin studenata za predmete koje je uspisalo manje studenata nego što za taj predmet ima evidentiranih ispita

SELECT p.sifPred, p.nazPred, p.upisanoStud
FROM pred P
WHERE p.upisanoStud < (SELECT COUNT(*) FROM ispit I WHERE i.sifPred = p.sifPred) -- rezultat je 9!

-- 8> Ispisati šifru, ime i prezime za nastavnike koji stanuju u Dubrovaèko-neretvanskoj županiji
--	  i imaju veæi koeficijent za plaæu od barem jednog nastavnika koji stanuje u Splitsko-dalmatinskoj županiji

SELECT *
FROM nastavnik N JOIN mjesto M ON m.pbr=n.pbrStan
JOIN zupanija Z ON z.sifZupanija=m.sifZupanija
WHERE z.nazZupanija LIKE 'Dubrovaèko%'
AND n.koef > ANY (SELECT koef FROM nastavnik N JOIN mjesto m ON M.pbr=N.pbrStan
					JOIN zupanija z ON z.sifZupanija = m.sifZupanija
					WHERE z.nazZupanija LIKE 'Splitsko%')   -- rezultat je 4

------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

--Ispisati predmete koji su se polagali barem na 3 razlièita naèina (imam ih 5):

SELECT DISTINCT p.nazPred, p.sifPred
FROM pred P JOIN ispit I on P.sifPred=i.sifPred
WHERE i.sifPred is NOT NULL							--rezultat je 67!


SELECT DISTINCT p.nazPred, p.sifPred
FROM pred P
WHERE sifPred IN (SELECT DISTINCT sifPred FROM ispit);

SELECT DISTINCT p.nazPred, p.sifPred
FROM pred p WHERE EXISTS (SELECT 1 from ispit i WHERE p.sifPred=i.sifPred) -- 1 ILI 2X2 ILI bilo koja vrijednost - bazièno je upit DA LI POSTOJI nešto u tom retku!

SELECT DISTINCT p.nazPred, p.sifPred
FROM pred P WHERE sifPred = ANY (SELECT DISTINCT sifPred FROM ispit)

SELECT DISTINCT p.nazPred, p.sifPred
FROM pred P JOIN (SELECT DISTINCT sifpred FROM ispit) I   -- I definira SELECT u zagradi 
ON p.sifPred = i.sifPred;

------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

--VJEŽBA na 4 RAZLIÈITA NAÈINA

---ispisati studente koji nisu izašli niti na jedan ispit na barem 3 razlièita naèina

select s.imeStud, s.prezStud 
from stud s LEFT JOIN ispit I
ON S.mbrStud=I.mbrStud
where I.ocjena IS NULL; --1.

select * 
from stud s
where mbrstud not in (select distinct mbrstud from ispit); --2.

select *
from stud s
where not exists (select 1 from ispit i where i.mbrStud=s.mbrStud) --3.

select * from stud where mbrstud !=all (select distinct mbrstud from ispit); --4.

------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

---Ispisati studente koji nisu izašli niti na jedan ispis na barem 3 razlièita naèina (poželjno i više od 3) --rezultat je 194. rješenje se nalazi ispod.

SELECT S.* 
FROM stud S LEFT OUTER JOIN ispit I ON S.mbrStud=i.mbrStud         --bez LEFT OUTER JOIN ništa ne dobijem, dakle ako samo stavim JOIN
WHERE i.mbrStud IS NULL
---------------

SELECT *
FROM stud S
WHERE mbrStud NOT IN (SELECT DISTINCT mbrStud FROM ispit);

---------------
--korelirani podupit -- vanjski i unutarnji SELECT povezani su preko polja..

SELECT *
FROM stud S
WHERE NOT EXISTS (SELECT 1 FROM ispit I WHERE I.mbrStud=S.mbrStud); --SELECT 1 - true
---------------

--DA LI POSTOJI STUD GDJE JE MBR RAZLIÈIT IZ SVIH POLJA KOJA POSTOJE U ISPITU
SELECT *
FROM stud WHERE mbrStud !=ALL (SELECT DISTINCT mbrStud FROM ispit);

------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
--2. cjelina - PODUPITI (subquery)
-------------------------------------

--Zadatak 2.1

SELECT TOP 1 *
FROM nastavnik
ORDER BY koef DESC -- Želimir Prester (ovo nam je poznato i ovako jer tražimo samo onog nastavnika koji ima najveæi koef.)

SELECT *
FROM nastavnik
WHERE koef=(SELECT MAX(koef) FROM nastavnik)  -- 4 nastavnika (Želimir Prester, Sandra Stanojeviæ, Sandra Mihaeljeviæ i BERNARD JURJEVIÆ)--svi imaju jednak koeficijent 9.90

--Zadatak 2.2

SELECT *
FROM nastavnik
WHERE koef > (SELECT MAX(koef) FROM nastavnik)/2;

--ili 

SELECT *
FROM nastavnik
WHERE koef > (SELECT MAX(koef)/2 FROM nastavnik);

--Zadatak 2.3

SELECT TOP 1 *
FROM stud S
WHERE datRodStud is not null
order by datRodStud ASC   ---rješenje je Gordan Boršiæ

SELECT * 
FROM stud 
WHERE datRodStud = (SELECT MIN(datRodStud) FROM stud)  ---rješenje je Gordan Boršiæ

--Zadatak 2.4

SELECT N.* 
FROM nastavnik N JOIN orgjed O ON n.sifOrgjed=o.sifOrgjed
WHERE o.nazOrgjed LIKE 'Prirodoslovno-matematièki%'  -- rezultat je 0

--ili-

SELECT *
FROM nastavnik
WHERE sifOrgjed IN (SELECT sifOrgjed FROM orgjed WHERE nazOrgjed LIKE 'Prirodoslovno-matematièki%')


--Zadatak 2.5

SELECT *
FROM nastavnik N
WHERE N.pbrStan IN (SELECT pbr FROM mjesto WHERE nazMjesto LIKE 'Zagreb%') --rezultat je 51


SELECT *
FROM nastavnik N JOIN mjesto M ON N.pbrStan=M.pbr
WHERE nazMjesto LIKE 'Zagreb%'       --rezultat je 51

SELECT *
FROM nastavnik N
WHERE N.pbrStan = ANY (select pbr FROM mjesto WHERE nazMjesto LIKE 'Zagreb%') --rezultat je 51

--Zadatak 2.6

SELECT *
FROM stud S
WHERE pbrRod = (SELECT pbrRod FROM stud WHERE mbrStud = 1127) --rezultat je 6
---osim njega samog!
AND mbrStud != 1127 -- rezultat je 5, dakle bez studenta 1127

--Zadatak 2.7

SELECT *
FROM stud
WHERE datRodStud > (SELECT datRodStud FROM stud WHERE imeStud = 'Tibor' AND prezStud ='Poljanec')  --rezultat je 216

--Zadatak 2.8

SELECT d.*
FROM dvorana d
WHERE d.kapacitet > (SELECT AVG(kapacitet) from dvorana) --rezultat je 12

--Zadatak 2.9

SELECT DISTINCT P.nazpred
FROM pred P JOIN ispit I ON p.sifPred=i.sifPred
WHERE i.ocjena > (SELECT AVG(CAST(ocjena as float)) from ispit WHERE sifPred=98) --rezultat je 56

--Zadatak 2.10

SELECT O.sifOrgjed, O.nazOrgjed, AVG(P.upisanoStud) AS Pros_upisano, MAX(p.brojSatiTjedno) AS Max_sati  --nije nužno pisati AS
FROM pred P  JOIN orgjed O  ON p.sifOrgjed=O.sifOrgjed
GROUP BY O.sifOrgjed, O.nazOrgjed						--rezultat je 10
ORDER BY 1;                             

SELECT O.nazOrgjed, po.*
FROM orgjed O JOIN (SELECT siforgjed, AVG(p.upisanostud) Pros_upisano, MAX(p.brojSatiTjedno) Max_sati
			FROM pred P GROUP BY sifOrgjed) po 
ON O.sifOrgjed=po.sifOrgjed                              ---rezultat je 10

--Zadatak 2.11

SELECT DISTINCT N.imeNastavnik, n.prezNastavnik
FROM nastavnik N JOIN ispit I ON n.sifNastavnik = I.sifNastavnik
JOIN stud S ON S.mbrStud=I.mbrStud
WHERE N.pbrstan=S.pbrStan;                 --rezultat je 24, a bez DISTINCT rezuzltat je 179


------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

--ZADACI ZA VJEŽBU (MARIO_2)


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
WHERE upisanoStud < (SELECT COUNT(*) FROM ispit I WHERE i.sifPred=p.sifPred)
-- rezultat je 9 -->>>--KORELIRALIN PODUPIT GDJE NAM JE VEZA sifPred iz podupita


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

------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------

--INDEKSI 

-- Zadatak str. 14
------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------

CREATE CLUSTERED INDEX C_STUDENT
ON stud (mbrstud)

DROP INDEX stud.C_STUDENT

CREATE NONCLUSTERED INDEX NCL_prezime
ON stud(prezstud)

DROP INDEX stud.NCL_prezime

------------------------------
SELECT * 
INTO KOPIJA_STUD
FROM stud;

BEGIN TRAN

DELETE FROM Kopija_Stud
WHERE pbrRod=10000

SELECT * FROM Kopija_Stud
WHERE pbrRod=10000

ROLLBACK

------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------

--NAPRAVITI VIEW 
--koji prikazuje predmete sa prosjeènom ocjenom položenih ispita i brojem ispita,
--šifra i naziv predmeta + broj ispita + prosjeèna ocjena

CREATE VIEW POLOŽENI_PREDMETI
WITH ENCRYPTION
AS
SELECT p.sifPred, p.nazPred, COUNT(*) AS Broj, AVG(CAST(OCJENA as float)) AS Prosjek
FROM pred P JOIN ispit I on P.sifPred=i.sifPred
WHERE i.ocjena > 1
GROUP BY P.sifPred, P.nazPred										---ako kombiniramo polja sa agregatnim funkcijama potreban nam je GROUP BY
									
																	--> rezultat je 67 
SELECT * FROM POLOŽENI_PREDMETI
---------------------------------------

CREATE VIEW STUDENTI_IZ_ZAGREBA
AS
SELECT *
FROM stud
WHERE pbrRod=10000									---WITH CHECK OPTION stoji nakon naredbe SELECT (str.40 Napredni SQL)
WITH CHECK OPTION

INSERT INTO STUDENTI_IZ_ZAGREBA												--Msg 550, Level 16, State 1, Line 1025
VALUES (9999, 'Pero','Periæ', 21000,21000,'1990.12.1','999') 				--The attempted insert or update failed because the target view either specifies WITH CHECK OPTION or spans a view that specifies WITH CHECK OPTION and one or more rows resulting from the operation did not qualify under the CHECK OPTION constraint.
																			--The statement has been terminated.

INSERT INTO STUDENTI_IZ_ZAGREBA												
VALUES (9999, 'Pero','Periæ', 10000,10000,'1990.12.1','999')     --Dodan je novi student! (1 row(s) affected)

---------------------------------------

CREATE TYPE Telefonski_broj
FROM varchar(20) NULL

CREATE TABLE Osobe1 (
	Ime		VARCHAR(50),
	Prezime  VARCHAR(100),
	Telefon Telefonski_broj
	);

---------------------------------------

--Zadatak 5.1 (str.43)

CREATE VIEW STUDENTI_KOJI_NISU_IZAŠLI_NA_ISPIT
AS
SELECT Count(*) AS Broj_studenata
FROM stud S LEFT JOIN ispit I ON S.mbrStud=I.mbrStud  --rezultat je 194 + Pero Peiæ kojeg smo dodali, dakle 195!
WHERE I.mbrStud IS NULL

--Mario--

CREATE VIEW Zadtak_5_1
AS
SELECT *
FROM stud S
WHERE mbrStud NOT IN (SELECT DISTINCT mbrStud FROM ispit);  --rezultat je 195!

----------------------------------------

CREATE VIEW Zadatak_5_2
AS
SELECT O.*, N.nazOrgjed AS Nadreðena
FROM orgjed O LEFT OUTER JOIN orgjed N ON O.sifNadorgjed = N.sifOrgjed;						--LEFT OUTER JOIN iz razloga što nadreðena nema iznad sebe još nadreðenih
																							--rezultat je 134!
SELECT * FROM sys.tables     -- prikaz tablica unutar baze fakultet
------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------



-->>>>> 6. POGLAVLJE - KORISNIÈKI DEFINIRANE FUNKCIJE

------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------


CREATE FUNCTION FN_Ime_Zupanije (@sifra INT)    --kljuèna rijeè je CREATE FUNCTION, zatim naziv FN_XXXXXXX_YYYYYY 
RETURNS varchar(100)             --returns javlja kakav tip podatka vraæa korisniku
AS
BEGIN
	RETURN (SELECT nazzupanija FROM zupanija WHERE sifZupanija = @sifra)   --return je kljuèna rijeè koji vraæa rezultat

END

PRINT dbo.FN_Ime_Zupanije(21)

------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------

--ZADACI ZA VJEŽBU , ZBIRKA, str 20.

------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------


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

------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------
--PROCEDURE
------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE PROC_NAZIV @SIFRA INT
AS
BEGIN

	SELECT * FROM zupanija WHERE sifZupanija= @SIFRA
	
END

--test--- 

EXEC dbo.PROC_NAZIV 11

--Zadatak 5.6 (str. 27)

SELECT * INTO NASTAVNIK_KOPIJA
FROM nastavnik                              --kopirali smo tablicu NASTAVNIK da ne zaje*** tablicu koju inaèe koristimo

EXEC sp_rename 'NASTAVNIK_KOPIJA.IMENASTAVNIK', 'IME'    --kolona koju mijenjamo mora imati naziv tablice koja se mijenja, stupac ne mora

--REZULTAT JE UPOZORENJE: "Caution: Changing any part of an object name could break scripts and stored procedures."
----
--Zadatak 5.7

EXEC sp_databases        --javlja rezultat za sve BAZE koje su spremljene i nemožemo specificirati pojedinu

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

	SELECT COUNT(*) AS Položio
	FROM ispit I
	WHERE I.mbrStud = @MBR
	AND i.ocjena > 1

END

--TEST

EXEC Polozenih_ispita 1127               ---rezultat je 2 POLOŽENA ISPITA


------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------
--VARIJABLE, POGLAVLJE 10.2
------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------

 PRINT @@connections

 PRINT @@VERSION

 PRINT @@ERROR

 SELECT * FROM stud

 PRINT @@ROWCOUNT
 
 -- JOIN. PODUPIT, IN , BETWEEN, VEÆE, MANJE, ANY... ispit N.SQL

 ------------------------------------------------------------------------------------------------------------------------------------
 


