/* 1.	U¿ytkownik chce zobaczyæ oceny danego krytyka z filmów z danego roku. 
Wypisz oceny konkretnego krytyka dla filmów z danego roku.
2p. */
CREATE VIEW OcenyKrytyka AS
SELECT Ocena, ID_krytyka, Data_oceny
FROM Oceny
JOIN Krytycy ON Oceny.ID_krytyka = Krytycy.ID
WHERE Data_oceny >= '2022-01-01' AND Data_oceny <= '2022-12-31' AND ID_krytyka=123456789;
SELECT * FROM OcenyKrytyka;


/* 2.	U¿ytkownik chce wiedzieæ dla którego re¿ysera aktor gra³ najczêœciej.
Posortuj i wyœwietl zliczenie wszystkich filmów, w których dany aktor gra³ rolê dla ka¿dego re¿ysera.
2p.  */
SELECT COUNT(Ro.Tytul_filmu) as 'Ilosc', Re.ID 
FROM Rezyserzy as Re
inner join Filmy as Fi on Re.ID = Fi.ID_rezysera
inner join Rola as Ro on Fi.Tytul = Ro.Tytul_filmu
inner join Aktorzy as Ak on Ak.ID = Ro.Grana_przez
where Ak.ID = 195769594
GROUP BY Re.ID
ORDER BY COUNT(Ro.Tytul_filmu) DESC;

/* 3.	U¿ytkownik chce wiedzieæ jakie s¹ najlepiej ocenione filmy w których gra³ aktor.
Wypisz i posortuj wed³ug ocen wszystkie filmy, w których aktor gra³ rolê.
2p.  */
SELECT DISTINCT Ocena, Oc.ID_krytyka, Oc.Tytul_filmu, Oc.Data_oceny from Oceny as Oc
inner join Filmy as Fi on Oc.Tytul_filmu = Fi.Tytul
inner join Rola as Ro on Fi.Tytul = Ro.Tytul_filmu
inner join Aktorzy as Ak on Ro.Grana_przez = Ak.ID
where Ak.ID = 195769594
order by Ocena DESC;

/* 4.	Wypisz listê filmów ocenionych najgorzej wraz z ich uœrednionymi ocenami w porz¹dku rosn¹cym oraz danymi rezysera. 
Celem biznesowym jest nominowanie najgorzego re¿ysera. 
2p.  */
SELECT Filmy.Tytul, (SELECT AVG(Ocena) FROM Oceny WHERE Oceny.Tytul_filmu = Filmy.Tytul) as 'Srednia_ocena', 
Czlowiek.Imie, Czlowiek.Nazwisko
FROM Filmy
JOIN Rezyserzy ON Filmy.ID_rezysera = Rezyserzy.ID
JOIN Oceny ON Filmy.Tytul = Oceny.Tytul_filmu
JOIN Czlowiek On Czlowiek.ID = Rezyserzy.ID
GROUP BY Filmy.Tytul, Czlowiek.Imie, Czlowiek.Nazwisko, Rezyserzy.ID
ORDER BY AVG(Oceny.Ocena) ASC;
     
/* 5.	Wymieñ filmy, których cala ekipa (re¿yserzy oraz aktorzy) pochodz¹ z tego samego pañstwa. 
Efektem powinna byæ lista z tytu³ami filmów i nazwa pañstwa, z którego jest ekipa. Cel biznesowy: nominacje do najlepszego filmu narodowego.  
2P */
SELECT DISTINCT Tytul, Kraj_pochodzenia, (SELECT AVG(Ocena) FROM Oceny WHERE Oceny.Tytul_filmu = Fi.Tytul) as 'Srednia_ocena' 
from Filmy as Fi
inner join Rola as Ro on Fi.Tytul = Ro.Tytul_filmu
inner join Aktorzy as Ak on Ak.ID = Ro.Grana_przez
inner join Rezyserzy as Re on Re.ID = Fi.ID_rezysera
inner join Czlowiek as Cz on Cz.ID = Re.ID
where Re.Kraj_pochodzenia = Ak.Kraj_urodzenia;

/* 6.	Wypisz zale¿noœæ kosztów produkcji i zysków z filmu w stosunku do ich œredniej oceny. Wynikiem zapytania ma byæ proporcja (zyski*œrednia ocena)/koszty oraz 
nazwa filmu, posortowane malej¹co wzglêdem proporcji. 
Celem jest wydanie przez filmweb rankingu filmów które maj¹ najlepsza proporcje op³acalnoœci filmu do oceny. 
2P */
SELECT DISTINCT Tytul, Oc.Ocena*Fi.Zyski_z_filmu/Fi.Koszty as 'Ocena*Zyski/Koszty', Oc.Ocena as 'ocena', 
Zyski_z_filmu as 'zyski', Koszty as 'koszty' from Filmy as Fi
inner join Oceny as Oc on Oc.Tytul_filmu = Fi.Tytul
order by Oc.Ocena*Fi.Zyski_z_filmu/Fi.Koszty

/*7.	Producent chce zobaczyæ, który zatrudniony przez niego re¿yser wypuœci³ najlepszy film.
Wypisz i posortuj filmy wg najlepszych ocen produkcji danego producenta, wraz z danymi re¿ysera.  */
SELECT Tytul, (SELECT AVG(Ocena) FROM Oceny WHERE Oceny.Tytul_filmu = Filmy.Tytul) AS 'Srednia ocena', Czlowiek.Imie, Czlowiek.Nazwisko FROM Filmy
INNER JOIN Oceny ON Oceny.Tytul_filmu = Filmy.Tytul
INNER JOIN Producenci ON Filmy.ID_producenta = Producenci.ID
INNER JOIN Rezyserzy ON Rezyserzy.ID = Filmy.ID_rezysera
INNER JOIN Czlowiek ON Czlowiek.ID = Rezyserzy.ID
WHERE Producenci.ID = 295739275 
GROUP BY Tytul, Czlowiek.Imie, Czlowiek.Nazwisko, Rezyserzy.ID, Producenci.ID

/* 8.	Filmweb chce zrobiæ ranking, który producent odniós³ najwiêkszy dochód z produkcji filmów.
Wypisz i posortuj producentów wg ich dochodów (zyski – koszty) z filmów.
 */
SELECT Czlowiek.Imie, Czlowiek.Nazwisko,Producenci.ID, SUM(Filmy.Zyski_z_filmu - Filmy.Koszty) as 'Dochod'
FROM Producenci
JOIN Filmy ON Producenci.ID = Filmy.ID_producenta
JOIN Czlowiek ON Czlowiek.ID = Producenci.ID
GROUP BY Czlowiek.Imie, Czlowiek.Nazwisko, Filmy.ID_producenta, Producenci.ID
ORDER BY SUM(Filmy.Zyski_z_filmu - Filmy.Koszty) DESC;

/* 9.	Netflix chce kupiæ filmy nagrane po angielsku, których œrednia ocena jest >= 5.
Wypisz i posortuj filmy nagrane w jêzyku angielskim, których ocena jest >= 5. */
SELECT Filmy.Tytul, Filmy.Jezyk, AVG(Oceny.Ocena) as 'Srednia ocena'
FROM Filmy
JOIN Oceny ON Filmy.Tytul = Oceny.Tytul_filmu
WHERE Filmy.Jezyk = 'angielski'
GROUP BY Filmy.Tytul, Filmy.Jezyk
HAVING AVG(Oceny.Ocena) >= 5
ORDER BY 'Srednia ocena' DESC;