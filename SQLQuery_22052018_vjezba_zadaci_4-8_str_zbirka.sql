
--1.1

select	COUNT(nazpred) AS 'Ukupno ima ___ predmeta '
from pred							   
						  --183 predmeta

--1.2

SELECT p.nazpred, SUM(upisanoStud) Broj
FROM pred p
GROUP BY nazPred          --156 rows, 156 predmeta? VIDI ZADATAK GORE- postoje predmeti istog naziva, a razli�ite �ifre
 
 --1.3

 SELECT nazmjesto, COUNT(*) AS 'Broj studenata'
 FROM stud JOIN mjesto ON
 stud.pbrStan=mjesto.pbr
 GROUP BY nazMjesto 
 --sort po najve�em broju
 ORDER BY [Broj studenata] DESC      -- 29 razli�itih mjesta, od toga 162 iz Zagreba (ukupno 302 studenta)

 --1.4

SELECT COUNT(stud.mbrStud) AS 'Broj studenata koji nije iza�ao na ispit'
FROM stud LEFT JOIN ispit
ON stud.mbrStud=ispit.mbrStud
WHERE ocjena IS NULL                 -- za�to LEFT OUTER JOIN? - INNER JOIN vra�a rezultat 0. Ina�e, rezultat je 193.

--1.5

SELECT COUNT(p.nazPred) AS 'Vi�e od 5'
FROM pred P
WHERE p.upisanoStud > 5				--69 predmeta je upisalo vi�e od 5 studenata

--1.6

SELECT COUNT(p.nazPred) 'Nula studenata'
FROM pred P
WHERE p.upisanoStud=0               --47 predmeta; ne koristimo NULL jer to zna�i da ne postoji podatak, a za SVE predmete
									--imamo barem nekakav podatak o broju upisanih, uklju�uju�i i nulu '0'.

--1.7

SELECT COUNT(p.nazPred) 'Upisano 2 do 5 studenata'
FROM pred P
WHERE p.upisanoStud BETWEEN 2 AND 5    --43 predmeta

--1.8

SELECT COUNT(pred.sifPred) AS 'Broj PREDMETA na koje nije iza�ao niti jedan student'
FROM pred LEFT JOIN ispit
ON pred.sifPred=ispit.sifPred
WHERE ocjena IS NULL				--116 predmeta

--1.9

SELECT COUNT(DISTINCT I.sifPred) AS 'Broj izlazaka na na ispit'
FROM ispit I						
									--67 predmeta, koristimo �ifru predmeta jer po datumu, ocijeni, mbr studenta ili nastavniku
									--ne mo�emo odrediti broj izlazaka

--1.10

SELECT MAX(koef) 
FROM nastavnik        --9.90

--1.11

SELECT MAX(koef), pbrStan, nazMjesto
FROM nastavnik N JOIN mjesto M
ON n.pbrStan=m.pbr
GROUP BY pbrStan, nazMjesto
ORDER BY MAX(koef) DESC            -- 29 razli�itih mjesta, dobijemo 24 redaka(mjesta) ??

--1.12





----------------------------
-- 16.05.2018.

-- ZADACI ZA VJE�BU--

-- 1> Ispisati broj negativnih ocjena dobivenih na ispitu iz predmeta sa �ifrom 474
-- 2> Odredite kojeg je datuma ro�en najstariji student
-- 3> ispisati koliko je dana proteklo izme�u najranijeg i najkasnijeg datuma izlaska na ispit
-- 4> Ispisati broj pozivitno ocijenjenih ispita i prosje�nu ocjenu pozitivno ocijenjenih ispita
--	  koji su obavljeni u toku zadnja tri mjeseca 2002. godine
-- 5> U koliko razli�itih dvorana se obavlja nastava iz predmeta pod nazivom "Elektroni�ki materijali i tehnologija"
-- 6> Ispisati dvorane (oznaku dvorane i kapacitet) �iji je kapacitet barem �etiri puta (4x) ve�i od kapaciteta najmanje dvorane
-- 7> Ispisati �ifru, naziv i broj upisanin studenata za predmete koje je uspisalo manje studenata nego �to za taj predmet ima evidentiranih ispita
-- 8> Ispisati �ifru, ime i prezime za nastavnike koji stanuju u Dubrova�ko-neretvanskoj �upaniji
--	  i imaju ve�i koeficijent za pla�u od barem jednog nastavnika koji stanuje u Splitsko-dalmatinskoj �upaniji

-------------------------------------
USE Fakultet

--1> 

SELECT COUNT(*) AS 'Neg.ocijenjenih studenata'
FROM ispit
WHERE ocjena =1 AND sifPred=474      -- rezultat je 3!

--2> 
SELECT MIN(datRodStud) AS 'Najstariji student ro�en je na datum'
FROM stud							 -- 1980-02-29 00:00:00.000

--3>

SELECT DATEDIFF(MM,MIN(datispit), MAX(datispit))
FROM ispit							--Rezultat za DD je 764 dana, MM - 25 mjeseci, YY - 2 godine

--mo�emo korsititi i CAST: format datuma 1980-12-31 pretvara u broj�anu vrijenost

print CAST(getdate() AS int) -- 43241 (dan)  --ra�una od 01/01/1900.g.

print CAST(date(y(1980),m(12),d(31)) AS int)