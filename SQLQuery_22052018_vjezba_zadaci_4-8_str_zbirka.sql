
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

--1.12





----------------------------
-- 16.05.2018.

-- ZADACI ZA VJEŽBU--

-- 1> Ispisati broj negativnih ocjena dobivenih na ispitu iz predmeta sa šifrom 474
-- 2> Odredite kojeg je datuma roðen najstariji student
-- 3> ispisati koliko je dana proteklo izmeðu najranijeg i najkasnijeg datuma izlaska na ispit
-- 4> Ispisati broj pozivitno ocijenjenih ispita i prosjeènu ocjenu pozitivno ocijenjenih ispita
--	  koji su obavljeni u toku zadnja tri mjeseca 2002. godine
-- 5> U koliko razlièitih dvorana se obavlja nastava iz predmeta pod nazivom "Elektronièki materijali i tehnologija"
-- 6> Ispisati dvorane (oznaku dvorane i kapacitet) èiji je kapacitet barem èetiri puta (4x) veæi od kapaciteta najmanje dvorane
-- 7> Ispisati šifru, naziv i broj upisanin studenata za predmete koje je uspisalo manje studenata nego što za taj predmet ima evidentiranih ispita
-- 8> Ispisati šifru, ime i prezime za nastavnike koji stanuju u Dubrovaèko-neretvanskoj županiji
--	  i imaju veæi koeficijent za plaæu od barem jednog nastavnika koji stanuje u Splitsko-dalmatinskoj županiji

-------------------------------------
USE Fakultet

--1> 

SELECT COUNT(*) AS 'Neg.ocijenjenih studenata'
FROM ispit
WHERE ocjena =1 AND sifPred=474      -- rezultat je 3!

--2> 
SELECT MIN(datRodStud) AS 'Najstariji student roðen je na datum'
FROM stud							 -- 1980-02-29 00:00:00.000

--3>

SELECT DATEDIFF(MM,MIN(datispit), MAX(datispit))
FROM ispit							--Rezultat za DD je 764 dana, MM - 25 mjeseci, YY - 2 godine

--možemo korsititi i CAST: format datuma 1980-12-31 pretvara u brojèanu vrijenost

print CAST(getdate() AS int) -- 43241 (dan)  --raèuna od 01/01/1900.g.

print CAST(date(y(1980),m(12),d(31)) AS int)