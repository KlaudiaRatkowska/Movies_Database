INSERT INTO Czlowiek (ID, Imie, Nzwisko, Rok_urodzenia) VALUES
(195769594, 'Tom', 'Shelby', 2000),
(180849285, 'Ann', 'Swan', 2010),
(195737485, 'Thomas', 'Kraig', 1980),
(295739275, 'Kate', 'Addams', 1988),
(275937584, 'Rosa', 'Mela', 1995),
(098457394, 'Jan', 'Kowal', 1993),
(174839284, 'Peter', 'Bruhn', 1995),
(088295391, 'Alice', 'Smith', 1994),
(284719283, 'Caroline', 'Baker', 1992),
(123456789, 'Cara', 'Mad', 1999),
(124312431, 'Antionio', 'Meck', 1980),
(119382736, 'Mark', 'Sean', 1985),
(112938129, 'Mary', 'Luu', 1982),
(275938475, 'Alicja', 'Mack', 2001),
(123382736, 'Sean', 'Schubert', 1998),
(112364129, 'Sarah', 'Ansil', 2002),
(103769594, 'Ronald', 'McDonald', 1959),
(180849582, 'Claudia', 'Belluci', 1972),
(195387485, 'Mark', 'Soel', 1986),
(229349275, 'Tim', 'Guteborg', 1960),
(123437485, 'Greta', 'Tasm', 1955),
(104439275, 'Alex', 'Mash', 1949),
(111149285, 'Martha', 'Beck', 1934),
(232339275, 'Andy', 'Cold', 1977),
(174039984, 'Piotr', 'Mroz', 1949),
(080000391, 'Jaroslaw', 'Babel', 1980),
(172933284, 'Selena', 'Wiliams', 1969),
(024515391, 'Melania', 'Flow', 1957),
(120000789, 'Tomasz', 'Sznuk', 1972),
(109232431, 'Mary', 'Robbin', 1983),
(120912789, 'Cole', 'Noel', 1970),
(127439431, 'Hannah', 'Seaside', 1955),
(101286789, 'George', 'Koop', 1949),
(000012431, 'Emma', 'Esta', 1978),
(123451392, 'Hugh', 'Hooles', 1974),
(178212431, 'Samantha', 'Holmes', 1995);


INSERT INTO Rezyserzy (Kraj_pochodzenia, Szkola, ID) VALUES
('Polska', 'SFL', 195769594),
('USA', 'NY Film Academy', 180849285),
('Niemcy', 'Babelsberg Film School', 195737485),
('Anglia', 'National Film and Television School', 295739275),
('Polska', 'SFL', 103769594),
('USA', 'NY Film Academy', 180849582),
('Kanada', 'BFS', 195387485),
('Szwecja', 'NFT', 229349275),
('Niemcy', 'NST', 123437485),
('USA', 'National Film School', 104439275);

INSERT INTO Producenci (Ilosc_pracownikow, Ilosc_nominacji, ID) VALUES
(250, 20, 180849285),
(390, 15, 295739275),
(200, 10, 174839284),
(450, 25, 088295391),
(250, 20, 111149285),
(350, 15, 232339275),
(900, 10, 174039984),
(400, 25, 080000391),
(300, 10, 172933284),
(550, 25, 024515391);

INSERT INTO Aktorzy (Plec, Kraj_urodzenia, Wzrost, Rok_zaczecia_dzialalnosci, ID) VALUES
('M', 'Polska', 183, 2010, 195769594),
('K', 'USA', 170, 2000, 180849285),
('M', 'Niemcy', 185, 2003, 195737485),
('K', 'Anglia', 168, 2005, 295739275),
('K', 'Polska', 175, 2008, 275937584),
('M', 'USA', 188, 1999, 119382736),
('K', 'USA', 178, 1989, 112938129),
('K', 'Polska', 169, 2010, 275938475),
('M', 'Norwegia', 190, 2015, 123382736),
('K', 'USA', 170, 2017, 112364129);


INSERT INTO Filmy (Tytul, Rok_produkcji, Jezyk, Dlugosc, ID_rezysera, Zyski_z_filmu, Koszty, ID_producenta) VALUES
('Film1', 2010, 'Polski', 120, 195769594, 10000000, 2000000, 180849285),
('Film2', 2015, 'Angielski', 140, 295739275, 12000000, 4000000, 295739275),
('Film3', 2020, 'Niemiecki', 130, 195737485, 11000000, 2300000, 174839284),
('Film4', 2018, 'Polski', 155, 123437485, 13000000, 3000000, 088295391),
('Film5', 1999, 'Polski', 129, 195769594, 1000000, 200000, 172933284),
('Film6', 1980, 'Angielski', 119, 195387485, 1500000, 2200000, 295739275),
('Film7', 1997, 'Angielski', 105, 195737485, 1600000, 2100000, 174839284),
('Film8', 2001, 'Hiszpanski', 152, 229349275, 1300000, 2900000, 232339275),
('Film9', 1992, 'Niemiecki', 139, 195737485, 1900000, 200000, 080000391),
('Film10', 2018, 'Polski', 134, 104439275, 12000000, 350000, 024515391);

INSERT INTO Rola (Wiek, Nazwa_postaci, Czas_grania_w_filmie, Tytul_filmu, Grana_przez) VALUES
(30, 'Postac1', 90, 'Film1', 195769594),
(40, 'Postac2', 100, 'Film2', 180849285),
(25, 'Postac3', 80, 'Film3', 195737485),
(35, 'Postac4', 70, 'Film4', 112938129),
(34, 'Postac5', 9, 'Film1', 195769594),
(14, 'Postac6', 60, 'Film2', 112938129),
(25, 'Postac7', 20, 'Film10', 123382736),
(38, 'Postac8', 10, 'Film8', 195769594),
(21, 'Postac9', 90, 'Film8', 123382736),
(29, 'Postac10', 70, 'Film1', 112364129);

INSERT INTO Krytycy (Rok_zaczecia_dzialalnosci, Uzywany_jezyk, ID) VALUES
(1999, 'angielski', 123456789),
(2000, 'angielski', 124312431),
(1999, 'polski', 120000789),
(2005, 'angielski', 109232431),
(1990, 'niemiecki', 120912789),
(1980, 'angielski', 127439431),
(1997, 'niemiecki', 101286789),
(2000, 'hiszpanski', 000012431),
(1999, 'angielski', 123451392),
(2020, 'angielski', 178212431);

INSERT INTO Oceny (Ocena, Tytul_filmu, ID_krytyka, Data_oceny) VALUES
(9, 'Film1', 123456789, '2022-01-01'),
(8, 'Film2', 123456789, '2020-02-16'),
(7, 'Film3', 124312431, '2015-03-01'),
(9, 'Film1', 000012431, '2018-10-09'),
(8, 'Film10', 123456789, '1999-02-10'),
(7, 'Film10', 127439431, '2000-08-01'),
(5, 'Film7', 123456789, '2001-01-18'),
(7, 'Film8', 120000789, '2003-07-01'),
(7, 'Film3', 000012431, '2022-03-29'),
(2, 'Film1', 178212431, '2013-11-03');