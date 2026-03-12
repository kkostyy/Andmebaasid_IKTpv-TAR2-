-- Andmebaasi loomine ja valimine
CREATE DATABASE gaponenkoSQL;
USE gaponenkoSQL;

-- TABEL: opilane
-- Salvestab õpilaste andmed: nimi, sünniaeg, aadress, õpib
CREATE TABLE opilane (
    opilaneID int PRIMARY KEY IDENTITY(1,1),
    eesnimi varchar(25),
    perenimi varchar(30) NOT NULL UNIQUE, -- perenimi peab olema unikaalne
    synniaeg date,
    aadress text,
    kas_opib bit -- 1=õpib, 0=ei õpi
);

-- Kõigi õpilaste vaatamine
SELECT * FROM opilane;

-- Tabeli kustutamine (vajadusel)
DROP TABLE opilane;

-- Õpilaste lisamine
INSERT INTO opilane (eesnimi, perenimi, synniaeg, kas_opib) VALUES
('Oleg', 'Berejevski', '2009-12-02', 1),
('Konstantin', 'Gaponenko', '2009-12-02', 0);

SELECT * FROM opilane;

-- Piirangu lisamine olemasolevale veerule
ALTER TABLE opilane ALTER COLUMN perenimi varchar(30);

-- Ühe kirje kustutamine ID järgi
DELETE FROM opilane WHERE opilaneID = 5;

-- Kirje uuendamine: muudab õpimise staatust
UPDATE opilane SET kas_opib = 0
WHERE opilaneID = 3;
