/* 1.	U�ytkownik chce zobaczy� oceny danego krytyka z film�w z danego roku. 
Wypisz oceny konkretnego krytyka dla film�w z danego roku.
2p. */
CREATE VIEW OcenyKrytyka AS
SELECT Ocena, ID_krytyka, Data_oceny
FROM Oceny
JOIN Krytycy ON Oceny.ID_krytyka = Krytycy.ID
WHERE Data_oceny >= '2022-01-01' AND Data_oceny <= '2022-12-31' AND ID_krytyka=123456789;
SELECT * FROM OcenyKrytyka;


/* 2.	U�ytkownik chce wiedzie� dla kt�rego re�ysera aktor gra� najcz�ciej.
Posortuj i wy�wietl zliczenie wszystkich film�w, w kt�rych dany aktor gra� rol� dla ka�dego re�ysera.
2p.  */
SELECT COUNT(Ro.Tytul_filmu) as 'Ilosc', Re.ID 
FROM Rezyserzy as Re
inner join Filmy as Fi on Re.ID = Fi.ID_rezysera
inner join Rola as Ro on Fi.Tytul = Ro.Tytul_filmu
inner join Aktorzy as Ak on Ak.ID = Ro.Grana_przez
where Ak.ID = 195769594
GROUP BY Re.ID
ORDER BY COUNT(Ro.Tytul_filmu) DESC;

/* 3.	U�ytkownik chce wiedzie� jakie s� najlepiej ocenione filmy w kt�rych gra� aktor.
Wypisz i posortuj wed�ug ocen wszystkie filmy, w kt�rych aktor gra� rol�.
2p.  */
SELECT DISTINCT Ocena, Oc.ID_krytyka, Oc.Tytul_filmu, Oc.Data_oceny from Oceny as Oc
inner join Filmy as Fi on Oc.Tytul_filmu = Fi.Tytul
inner join Rola as Ro on Fi.Tytul = Ro.Tytul_filmu
inner join Aktorzy as Ak on Ro.Grana_przez = Ak.ID
where Ak.ID = 195769594
order by Ocena DESC;

/* 4.	Wypisz list� film�w ocenionych najgorzej wraz z ich u�rednionymi ocenami w porz�dku rosn�cym oraz danymi rezysera. 
Celem biznesowym jest nominowanie najgorzego re�ysera. 
2p.  */
SELECT Filmy.Tytul, (SELECT AVG(Ocena) FROM Oceny WHERE Oceny.Tytul_filmu = Filmy.Tytul) as 'Srednia_ocena', 
Czlowiek.Imie, Czlowiek.Nazwisko
FROM Filmy
JOIN Rezyserzy ON Filmy.ID_rezysera = Rezyserzy.ID
JOIN Oceny ON Filmy.Tytul = Oceny.Tytul_filmu
JOIN Czlowiek On Czlowiek.ID = Rezyserzy.ID
GROUP BY Filmy.Tytul, Czlowiek.Imie, Czlowiek.Nazwisko, Rezyserzy.ID
ORDER BY AVG(Oceny.Ocena) ASC;
     
/* 5.	Wymie� filmy, kt�rych cala ekipa (re�yserzy oraz aktorzy) pochodz� z tego samego pa�stwa. 
Efektem powinna by� lista z tytu�ami film�w i nazwa pa�stwa, z kt�rego jest ekipa. Cel biznesowy: nominacje do najlepszego filmu narodowego.  
2P */
SELECT DISTINCT Tytul, Kraj_pochodzenia, (SELECT AVG(Ocena) FROM Oceny WHERE Oceny.Tytul_filmu = Fi.Tytul) as 'Srednia_ocena' 
from Filmy as Fi
inner join Rola as Ro on Fi.Tytul = Ro.Tytul_filmu
inner join Aktorzy as Ak on Ak.ID = Ro.Grana_przez
inner join Rezyserzy as Re on Re.ID = Fi.ID_rezysera
inner join Czlowiek as Cz on Cz.ID = Re.ID
where Re.Kraj_pochodzenia = Ak.Kraj_urodzenia;

/* 6.	Wypisz zale�no�� koszt�w produkcji i zysk�w z filmu w stosunku do ich �redniej oceny. Wynikiem zapytania ma by� proporcja (zyski*�rednia ocena)/koszty oraz 
nazwa filmu, posortowane malej�co wzgl�dem proporcji. 
Celem jest wydanie przez filmweb rankingu film�w kt�re maj� najlepsza proporcje op�acalno�ci filmu do oceny. 
2P */
SELECT DISTINCT Tytul, Oc.Ocena*Fi.Zyski_z_filmu/Fi.Koszty as 'Ocena*Zyski/Koszty', Oc.Ocena as 'ocena', 
Zyski_z_filmu as 'zyski', Koszty as 'koszty' from Filmy as Fi
inner join Oceny as Oc on Oc.Tytul_filmu = Fi.Tytul
order by Oc.Ocena*Fi.Zyski_z_filmu/Fi.Koszty

/*7.	Producent chce zobaczy�, kt�ry zatrudniony przez niego re�yser wypu�ci� najlepszy film.
Wypisz i posortuj filmy wg najlepszych ocen produkcji danego producenta, wraz z danymi re�ysera.  */
SELECT Tytul, (SELECT AVG(Ocena) FROM Oceny WHERE Oceny.Tytul_filmu = Filmy.Tytul) AS 'Srednia ocena', Czlowiek.Imie, Czlowiek.Nazwisko FROM Filmy
INNER JOIN Oceny ON Oceny.Tytul_filmu = Filmy.Tytul
INNER JOIN Producenci ON Filmy.ID_producenta = Producenci.ID
INNER JOIN Rezyserzy ON Rezyserzy.ID = Filmy.ID_rezysera
INNER JOIN Czlowiek ON Czlowiek.ID = Rezyserzy.ID
WHERE Producenci.ID = 295739275 
GROUP BY Tytul, Czlowiek.Imie, Czlowiek.Nazwisko, Rezyserzy.ID, Producenci.ID

/* 8.	Filmweb chce zrobi� ranking, kt�ry producent odni�s� najwi�kszy doch�d z produkcji film�w.
Wypisz i posortuj producent�w wg ich dochod�w (zyski � koszty) z film�w.
 */
SELECT Czlowiek.Imie, Czlowiek.Nazwisko,Producenci.ID, SUM(Filmy.Zyski_z_filmu - Filmy.Koszty) as 'Dochod'
FROM Producenci
JOIN Filmy ON Producenci.ID = Filmy.ID_producenta
JOIN Czlowiek ON Czlowiek.ID = Producenci.ID
GROUP BY Czlowiek.Imie, Czlowiek.Nazwisko, Filmy.ID_producenta, Producenci.ID
ORDER BY SUM(Filmy.Zyski_z_filmu - Filmy.Koszty) DESC;

/* 9.	Netflix chce kupi� filmy nagrane po angielsku, kt�rych �rednia ocena jest >= 5.
Wypisz i posortuj filmy nagrane w j�zyku angielskim, kt�rych ocena jest >= 5. */
SELECT Filmy.Tytul, Filmy.Jezyk, AVG(Oceny.Ocena) as 'Srednia ocena'
FROM Filmy
JOIN Oceny ON Filmy.Tytul = Oceny.Tytul_filmu
WHERE Filmy.Jezyk = 'angielski'
GROUP BY Filmy.Tytul, Filmy.Jezyk
HAVING AVG(Oceny.Ocena) >= 5
ORDER BY 'Srednia ocena' DESC;