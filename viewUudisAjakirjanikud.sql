CREATE DATABASE gaponenkoSQL;
USE gaponenkoSQL;

-- 1. TABELITE LOOMINE

CREATE TABLE ajakirjanik (
    ajakirjanikID INT PRIMARY KEY IDENTITY(1,1),
    nimi VARCHAR(50),
    telefon VARCHAR(13)
);

CREATE TABLE ajaleht (
    ajalehtID INT PRIMARY KEY IDENTITY(1,1),
    ajalehtNimetus VARCHAR(50)
);

CREATE TABLE uudised (
    uudisID INT PRIMARY KEY IDENTITY(1,1),
    uudisPealkiri VARCHAR(50),
    kuupaev DATE,
    kirjeldus TEXT,
    ajakirjanikID INT,
    ajalehtID INT,
    CONSTRAINT fk_ajakirjanik FOREIGN KEY (ajakirjanikID) REFERENCES ajakirjanik(ajakirjanikID),
    CONSTRAINT fk_ajaleht FOREIGN KEY (ajalehtID) REFERENCES ajaleht(ajalehtID)
);

-- 2. ANDMETE LISAMINE

INSERT INTO ajakirjanik (nimi, telefon)
VALUES ('Lev', '5757755874'), ('Anton', '57357597');

INSERT INTO ajaleht (ajalehtNimetus)
VALUES ('Postimees'), ('Delfi');

INSERT INTO uudised (uudisPealkiri, kuupaev, ajakirjanikID, ajalehtID)
VALUES
    ('Homme on iseseisev too paev', '2025-03-12', 1, 2),
    ('Tana on andmebaaside tund', '2025-03-12', 1, 2),
    ('Tana on vihane ilm', '2025-03-12', 2, 2);

-- 3. ANDMETE VAATAMINE

SELECT * FROM ajakirjanik;
SELECT * FROM ajaleht;
SELECT * FROM uudised;

-- 4. SELECT - 2 TABELI POHHJAL

-- Vana suntaks
SELECT * FROM uudised u, ajakirjanik a
WHERE u.ajakirjanikID = a.ajakirjanikID;

-- INNER JOIN
SELECT u.uudisPealkiri, a.nimi AS autor, u.kuupaev
FROM uudised AS u
INNER JOIN ajakirjanik AS a ON u.ajakirjanikID = a.ajakirjanikID;

-- Kitsam tulemus
SELECT u.uudisPealkiri, a.nimi
FROM uudised u
INNER JOIN ajakirjanik a ON u.ajakirjanikID = a.ajakirjanikID;

-- 5. SELECT - 3 TABELI POHHJAL

SELECT u.uudisPealkiri, a.nimi AS autor, aj.ajalehtNimetus
FROM uudised AS u
INNER JOIN ajakirjanik AS a ON u.ajakirjanikID = a.ajakirjanikID
INNER JOIN ajaleht AS aj ON u.ajalehtID = aj.ajalehtID;

-- 6. VAADETE LOOMINE (VIEW)

CREATE VIEW loodudUudised AS
SELECT u.uudisPealkiri, a.nimi
FROM uudised u
INNER JOIN ajakirjanik a ON u.ajakirjanikID = a.ajakirjanikID;

CREATE VIEW kuupaevaUudised AS
SELECT u.uudisPealkiri, a.nimi AS autor, u.kuupaev
FROM uudised AS u
INNER JOIN ajakirjanik AS a ON u.ajakirjanikID = a.ajakirjanikID;

CREATE VIEW autorUudisAjalehes AS
SELECT u.uudisPealkiri, a.nimi AS autor, aj.ajalehtNimetus
FROM uudised AS u
INNER JOIN ajakirjanik AS a ON u.ajakirjanikID = a.ajakirjanikID
INNER JOIN ajaleht AS aj ON u.ajalehtID = aj.ajalehtID;

-- 7. PARINGUD VAADETE POHHJAL

SELECT * FROM loodudUudised;

SELECT * FROM loodudUudised
WHERE nimi = 'Lev';

SELECT * FROM kuupaevaUudised;

SELECT uudisPealkiri, YEAR(kuupaev) AS aasta
FROM kuupaevaUudised;

SELECT * FROM autorUudisAjalehes;

-- 8. VAATE KUSTUTAMINE JA UUENDAMINE

-- Kustutame vaate
DROP VIEW autorUudisAjalehes;

-- Parime kustutatud vaadet - annab vea, sest vaade on kustutatud
-- SELECT * FROM autorUudisAjalehes;

-- Uuendame otse alustabelis (vaate kaudu UPDATE ei toimi 3 tabeli puhul)
UPDATE uudised SET kuupaev = '2026-03-18';
SELECT * FROM uudised;
--viewUudisAjakirjanikud.sql

-- Vaade: uudised konkreetsel kuupaeval
CREATE VIEW uudisedKuupaeval AS
SELECT u.uudisPealkiri, u.kuupaev, a.nimi AS autor
FROM uudised AS u
INNER JOIN ajakirjanik AS a ON u.ajakirjanikID = a.ajakirjanikID
WHERE u.kuupaev = '2025-03-12';

-- oma1: ajakirjaniku vaade - naitab ajakirjaniku nime ja tema uudised
CREATE VIEW ajakirjanikuVaade AS
SELECT a.nimi AS autor, u.uudisPealkiri
FROM ajakirjanik AS a
INNER JOIN uudised AS u ON a.ajakirjanikID = u.ajakirjanikID;

SELECT * FROM ajakirjanikuVaade;

-- oma2: ajakirjaniku vaade - naitab ajakirjaniku nime ja uudise kuupaev
CREATE VIEW ajakirjanikuKuupaev AS
SELECT a.nimi AS autor, u.kuupaev
FROM ajakirjanik AS a
INNER JOIN uudised AS u ON a.ajakirjanikID = u.ajakirjanikID;

SELECT * FROM ajakirjanikuKuupaev;
