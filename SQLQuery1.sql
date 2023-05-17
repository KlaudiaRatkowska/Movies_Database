CREATE TABLE Czlowiek (
    ID int NOT NULL PRIMARY KEY,
    Imie varchar(255) NOT NULL,
    Nzwisko varchar(255) NOT NULL,
    Rok_urodzenia INT NOT NULL
);
CREATE TABLE Rezyserzy (
    Kraj_pochodzenia varchar(30) NOT NULL,
    Szkola varchar(50) NOT NULL,
	ID int NOT NULL REFERENCES Czlowiek (ID),
	PRIMARY KEY (ID)
);
CREATE TABLE Producenci (
    Ilosc_pracownikow int NOT NULL,
    Ilosc_nominacji int NOT NULL,
	ID int NOT NULL REFERENCES Czlowiek (ID),
	PRIMARY KEY (ID)
);
CREATE TABLE Aktorzy (
    Plec char(1) NOT NULL CHECK(Plec IN('K','M')),
    Kraj_urodzenia varchar(30) NOT NULL,
    Wzrost int NOT NULL CHECK (Wzrost > 0 AND Wzrost < 220),
    Rok_zaczecia_dzialalnosci int NOT NULL,
	ID int NOT NULL REFERENCES Czlowiek (ID),
	PRIMARY KEY (ID)
);
CREATE TABLE Filmy (
    Tytul varchar(30) NOT NULL PRIMARY KEY,
    Rok_produkcji int NOT NULL,
    Jezyk varchar(30) NOT NULL,
    Dlugosc int NOT NULL CHECK (Dlugosc > 0 AND Dlugosc < 250),
    ID_rezysera int NOT NULL FOREIGN KEY REFERENCES Rezyserzy(ID),
    Zyski_z_filmu int NOT NULL CHECK (Zyski_z_filmu > 0 AND Zyski_z_filmu < 100000000),
    Koszty int NOT NULL CHECK (Koszty > 0 AND Koszty < 10000000),
    ID_producenta int FOREIGN KEY REFERENCES Producenci(ID)	ON DELETE SET DEFAULT ON UPDATE CASCADE
);
CREATE TABLE Rola (
    Wiek int NOT NULL,
    Nazwa_postaci varchar(30) NOT NULL PRIMARY KEY,
    Czas_grania_w_filmie int NOT NULL CHECK (Czas_grania_w_filmie > 0 AND Czas_grania_w_filmie < 250),
	Tytul_filmu varchar(30) NOT NULL FOREIGN KEY REFERENCES Filmy(Tytul),
    Grana_przez int NOT NULL FOREIGN KEY REFERENCES Aktorzy(ID) 
);
CREATE TABLE Krytycy (
    Rok_zaczecia_dzialalnosci int NOT NULL,
    Uzywany_jezyk varchar(30) NOT NULL,
	ID int NOT NULL REFERENCES Czlowiek (ID),
	PRIMARY KEY (ID)
);
CREATE TABLE Oceny (
    Ocena int NOT NULL CHECK (Ocena >= 0 AND Ocena <= 10),
    Tytul_filmu varchar(30) NOT NULL FOREIGN KEY REFERENCES Filmy(Tytul),
    ID_krytyka int NOT NULL FOREIGN KEY REFERENCES Krytycy(ID),
    Data_oceny date NOT NULL,
	PRIMARY KEY(Tytul_filmu, ID_krytyka)
);



