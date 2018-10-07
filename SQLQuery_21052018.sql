use Fakultet
--3.2
select mbrStud, imeStud + prezStud AS 'Ime i prezime studenta'
from stud

--3.3

select distinct  imeStud  --302 bez distincta, 171 sa ukljuèenim distinct-om
from stud

--3.4

select s.mbrStud, imeStud, ocjena
from ispit I JOIN stud S ON
i.mbrStud=s.mbrStud 
WHERE sifPred=146
AND i.ocjena>1             

--4 studenta su položili  --mbrStud     ocjena
----------- ------
--1464        2  + 
--1419        4  +
--1173        3  +
--1202        4  +

--(4 rows affected)
------------------------------

--3.5

SELECT n.sifNastavnik ,imenastavnik, preznastavnik, (koef+0.4)*800 AS plaæa
FROM nastavnik n
ORDER BY koef ASC    --187,273 i 452 imaju plaæu 2800 što znaèi da im je koef 3,1 što možemo provjeriti u SELECT-u niže:

SELECT koef, sifNastavnik
FROM nastavnik
WHERE koef=3.1            + + + 
-------------------------------

--3.6

SELECT n.sifNastavnik ,imenastavnik, preznastavnik, (koef+0.4)*800 AS plaæa
FROM nastavnik n
where (koef+0.4)*800 < 3500
 OR (koef+0.4)*800 > 8000         --18 ih ima manju plaæu od 3500, a samo 4 veæu od 8000 = ukupno 22 nastavnika

 --3.7

 SELECT  s.imeStud, s.prezStud,s.mbrStud, i.ocjena
 FROM stud S JOIN ispit I on
 S.mbrStud=I.mbrStud 
 WHERE i.ocjena=1 
 AND i.sifPred between 220 AND 240   -- 4 studenta
 
 
 --
 SELECT mbrStud, ocjena
 FROM ispit
 WHERE sifPred=('229')   
 AND ocjena!=1
--1434 i 1167 na sifPred 229, i 1421 i 1498 na sifPred 238

 --3.8

 SELECT s.imeStud, s.prezStud,s.mbrStud, i.sifPred, i.ocjena
 FROM stud S JOIN ispit I on
 S.mbrStud=I.mbrStud 
 WHERE i.ocjena=3      --113 studenata
 
 --ili

 SELECT imeStud, prezStud
 FROM stud s, ispit I
 WHERE s.mbrStud=i.mbrStud
 AND ocjena=3           ---113 studenata
 -------------------------

 --3.9

 SELECT  p.nazPred, p.sifPred
 FROM pred P LEFT OUTER JOIN ispit I ON
 p.sifPred=i.sifPred
 WHERE I.sifPred IS NULL          --116 predmeta

 SELECT  s.imeStud, s.prezStud, i.sifPred, i.ocjena
 FROM stud S
 LEFT OUTER JOIN ispit I ON i.mbrStud=s.mbrStud   --str 53. left outer join

 SELECT DISTINCT p.nazPred
 FROM pred P                 --183  predmeta razlièite šifre, a 156 predmeta razlièitog naziva!!!
-----------------------

--3.10
SELECT DISTINCT  p.nazPred
 FROM pred P JOIN ispit I ON
 p.sifPred=i.sifPred
 WHERE I.sifPred IS NOT NULL         --60 predmeta 

 SELECT DISTINCT P.nazpred
 FROM pred P, ispit I
 WHERE p.sifPred=i.sifPred

----
--3.11
SELECT *
FROM stud
WHERE imeStud LIKE '[aeiou]%'-- provjeriti >> za LIKE '[aeiou]%' RADI, 51 student èije ime
							 -- poèinje s A,E,I,O ili U
----------
--3.12
SELECT *
FROM stud
WHERE imeStud NOT LIKE '[aeiou]%' -- 251 student èije ime ne poèinje samoglasnikom

SELECT imestud
FROM stud       --> provjera govori da imamo ukupno 302 studenta, dakle 51+251= 302.
--------

--3.13

SELECT S.imeStud, S.prezStud
FROM stud S
WHERE S.imeStud LIKE '[^AEIOU]%' --NE poèinje SAMOGLASNIKOM
OR S.imeStud LIKE '%[^AEIOU]' -- NE završava samoglasnikom - KRIVO!

--3.14

SELECT imeStud, prezStud
FROM stud
WHERE imeStud LIKE '%nk%'
OR prezStud LIKE '%nk%'      -- 16 studenata
--------------

--3.15

SELECT  s.imeStud, s.prezStud, i.mbrStud, i.ocjena
FROM ispit I, stud s
WHERE s.mbrStud=i.mbrStud
ORDER BY i.ocjena DESC           --nisam koristio DISTINCT jer su neki studenti položili više ispita
								 --TAKVIH JE 435, s DISTINCT-om ima 242 studenta


--student Ninoslav Novak ima 19 izlazaka na ispit, od toga 8 poz. i 11 neg.ocjena								 
SELECT  s.imeStud + s.prezStud AS 'IME I PREZIME STUDENTA', p.nazPred, i.ocjena
FROM stud S, pred P, ispit I
WHERE s.mbrStud=i.mbrStud
AND p.sifPred=i.sifPred
--3 tablice, n-1; 3-1; 2 uvjeta!
AND i.ocjena>0 AND i.ocjena<2
AND s.imeStud='ninoslav'
----------

--3.16
--IME,PREZ STUD, MJESTO I ŽUPANIJA U KOJOJ JE ROÐEN, ZATIM DODATI MJESTO I ŽUPANIJU U KOJOJ STANUJU

SELECT DISTINCT s.imeStud, s.prezStud, s.pbrStan, ZR.sifZupanija, mr.nazMjesto, 
FROM stud S JOIN mjesto M
ON s.mbrStud=m.pbr
AND s.mbrStud=m.nazMjesto

----

--3.16
--STUD (pbrrod), mjesto(pbr, sifzupanija), zupanija

-- SELECT DISTINCT S.imeStud,S.prezStud, ZU.sifZupanija, M.pbr, M.sifZupanija 
--FROM stud S, zupanija ZU, mjesto M
--WHERE S.mbrStud = S.prezStud
--AND ZU.sifZupanija = M.sifZupanija

------------
------------

--4.4 

CREATE VIEW PredmetiDvorane AS 
SELECT p.nazPred, r.oznDvorana, r.oznVrstaDan, r.sat
FROM pred P JOIN rezervacija R ON p.sifPred=r.sifPred

SELECT * FROM PredmetiDvorane

--4.5

CREATE VIEW Mjesto_stanovanja_nastavnika AS
SELECT n.imeNastavnik, n.prezNastavnik, n.pbrStan, m.nazMjesto
FROM nastavnik n JOIN mjesto m ON
n.pbrStan=m.pbr                     --rezultat je 98

SELECT * from Mjesto_stanovanja_nastavnika

--4.6
CREATE VIEW Ocjene_predmeta  AS
SELECT s.imeStud, s.prezStud, p.nazPred, i.ocjena, n.imeNastavnik, n.prezNastavnik
FROM stud S JOIN ispit I ON s.mbrStud=i.mbrStud
JOIN nastavnik N ON n.sifNastavnik=i.sifNastavnik
JOIN pred P ON p.sifPred=i.sifPred

SELECT * FROM Ocjene_predmeta        --435 rezultata

-----

SELECT rtrim(s.imeStud)+' se preziva '+s.prezStud AS 'IME I PREZIME STUDENTA'
FROM stud s --302 rezultata jer je u bazi toliko studenata

















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

