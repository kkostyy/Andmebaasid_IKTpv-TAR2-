-- Andmebaasi loomine ja valimine
CREATE DATABASE select2tabeli_Gaponenko;
USE select2tabeli_Gaponenko;

-- TABEL: laps
-- Salvestab laste andmed: nimi, pikkus, sünniaasta, sünnilinn
CREATE TABLE laps (
    lapsID int NOT NULL PRIMARY KEY IDENTITY(1,1),
    nimi varchar(40) NOT NULL, -- lapse nimi
    pikkus smallint, -- pikkus (cm)
    synniaasta int NULL, -- sünniaasta
    synnilinn varchar(15) -- sünnikoht
);

-- Laste lisamine
INSERT INTO laps (nimi, pikkus, synniaasta, synnilinn)
VALUES
    ('Oleg',  165, 2011, 'Tallinn'),
    ('Egor',  160, 2010, 'Tallinn'),
    ('Dasha', 150, 2012, 'Tallinn'),
    ('Alisa', 148, 2013, 'Tallinn'),
    ('Danil', 155, 2011, 'Tallinn');

-- TABEL: loom
-- Salvestab loomade andmed: liik, kaal, omanik (laps)
CREATE TABLE loom (
    loomID int NOT NULL PRIMARY KEY IDENTITY(1,1),
    nimi varchar(40) NOT NULL, -- looma liik
    kaal smallint, -- kaal (kg)
    lapsID int, -- viide omanikule (lapsele)
    FOREIGN KEY (lapsID) REFERENCES laps(lapsID)
);

-- Loomade lisamine
INSERT INTO loom (nimi, kaal, lapsID)
VALUES
    ('Koer', 12, 4), -- omanik: Alisa
    ('Kass',  3, 5), -- omanik: Danil
    ('Koer',  8, 3), -- omanik: Dasha
    ('Kass',  5, 1), -- omanik: Oleg
    ('Kass',  1, 2); -- omanik: Egor

-- Alias-nimede kasutamine
SELECT l.nimi, l.kaal
FROM loom AS l;

-- VALE: puudub tingimus, tekib korrutustabel (iga laps × iga loom)
-- SELECT * FROM laps, loom;

-- ÕIGE: liitmine WHERE tingimuse kaudu
SELECT * FROM laps, loom
WHERE loom.lapsID = laps.lapsID;

-- Sama päring alias-nimedega
SELECT * FROM laps AS lp, loom AS l
WHERE l.lapsID = lp.lapsID;

-- Ainult vajalikud veerud alias-nimedega
SELECT lp.nimi AS lapsenimi, l.nimi AS loomanimi, l.kaal
FROM laps AS lp, loom AS l
WHERE l.lapsID = lp.lapsID;

-- INNER JOIN: tagastab ainult mõlemast tabelist vastavad read
SELECT lp.nimi AS lapsenimi, l.nimi AS loomanimi, l.kaal
FROM laps AS lp INNER JOIN loom AS l 
ON l.lapsID = lp.lapsID;

-- LEFT JOIN: kõik lapsed, ka need kellel pole looma (NULL)
SELECT lp.nimi AS lapsenimi, l.nimi AS loomanimi, l.kaal
FROM laps AS lp LEFT JOIN loom AS l 
ON l.lapsID = lp.lapsID;

-- RIGHT JOIN: kõik loomad, ka need kellel pole omanikku (NULL)
SELECT lp.nimi AS lapsenimi, l.nimi AS loomanimi, l.kaal
FROM laps AS lp RIGHT JOIN loom AS l 
ON l.lapsID = lp.lapsID;

-- CROSS JOIN: korrutustabel — iga laps iga loomaga
SELECT lp.nimi AS lapsenimi, l.nimi AS loomanimi
FROM laps AS lp CROSS JOIN loom AS l;

-- TABEL: varjupaik
-- Salvestab loomade varjupaikade andmed
CREATE TABLE varjupaik (
    varjupaikID int NOT NULL PRIMARY KEY IDENTITY(1,1),
    koht varchar(50) NOT NULL, -- varjupaiga asukoht
    firma varchar(30) -- organisatsiooni nimi
);

-- Veeru varjupaikID lisamine tabelisse loom
ALTER TABLE loom ADD varjupaikID int;

-- Võõrvõtme lisamine: loom → varjupaik
ALTER TABLE loom ADD CONSTRAINT fk_varjupaik
    FOREIGN KEY (varjupaikID) REFERENCES varjupaik(varjupaikID);

-- Varjupaiga lisamine
INSERT INTO varjupaik (koht, firma)
VALUES ('Paljasaare', 'Varjupaikade MTÜ');
SELECT * FROM varjupaik;

-- Kõigile loomadele määratakse varjupaik ID=1
UPDATE loom SET varjupaikID = 1;
SELECT * FROM loom;

-- Kolme tabeli liitmine WHERE kaudu
SELECT lp.nimi AS lapsenimi, l.nimi AS loomanimi, v.koht
FROM laps AS lp, loom AS l, varjupaik AS v
WHERE l.lapsID = lp.lapsID AND l.varjupaikID = v.varjupaikID;

-- INNER JOIN: ainult vastavad read kõigist kolmest tabelist
SELECT lp.nimi AS lapsenimi, l.nimi AS loomanimi, v.koht
FROM (laps AS lp INNER JOIN loom AS l ON l.lapsID = lp.lapsID)
INNER JOIN varjupaik AS v ON l.varjupaikID = v.varjupaikID;

-- LEFT JOIN: kõik lapsed, ka need kellel pole looma või varjupaika (NULL)
SELECT lp.nimi AS lapsenimi, l.nimi AS loomanimi, v.koht
FROM (laps AS lp LEFT JOIN loom AS l ON l.lapsID = lp.lapsID)
LEFT JOIN varjupaik AS v ON l.varjupaikID = v.varjupaikID;

-- RIGHT JOIN: kõik varjupaikade kirjed, ka need millel pole looma või last (NULL)
SELECT lp.nimi AS lapsenimi, l.nimi AS loomanimi, v.koht
FROM (laps AS lp RIGHT JOIN loom AS l ON l.lapsID = lp.lapsID)
RIGHT JOIN varjupaik AS v ON l.varjupaikID = v.varjupaikID;

-- CROSS JOIN: korrutustabel — iga laps iga looma ja varjupaigaga
SELECT lp.nimi AS lapsenimi, l.nimi AS loomanimi, v.koht
FROM laps AS lp CROSS JOIN loom AS l CROSS JOIN varjupaik AS v;
