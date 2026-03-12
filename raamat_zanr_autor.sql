-- Andmebaasi loomine ja valimine
CREATE DATABASE raamatGaponenko;
USE raamatGaponenko;

-- TABEL: zanr
-- Salvestab raamatute žanrid ja kirjeldused
CREATE TABLE zanr (
    zanrID int PRIMARY KEY IDENTITY(1,1),
    zanrNimetus varchar(50) NOT NULL,
    kirjeldus text
);

SELECT * FROM zanr;

-- Žanri lisamine
INSERT INTO zanr (zanrNimetus, kirjeldus) VALUES
('luuletus', 'see on luuletus zanr');

-- TABEL: autor
-- Salvestab autorite andmed: nimi, sünniaasta, elukoht
CREATE TABLE autor (
    autorID int PRIMARY KEY IDENTITY(1,1),
    eesnimi varchar(50),
    perenimi varchar(50),
    synniaasta int CHECK(synniaasta > 1900), -- peab olema pärast 1900
    elukoht varchar(30)
);

SELECT * FROM autor;

-- Autori lisamine
INSERT INTO autor (eesnimi, perenimi, synniaasta) VALUES
('Anton', 'Tammsaare', 1901);

-- Kõigi autorite elukoha uuendamine
UPDATE autor SET elukoht = 'Eesti';

-- Autori kustutamine ID järgi (täida ID enne käivitamist)
-- DELETE FROM autor WHERE autorID = ?;

-- TABEL: raamat
-- Salvestab raamatud koos autori ja žanri viitega
CREATE TABLE raamat (
    raamatID int PRIMARY KEY IDENTITY(1,1),
    raamatNimetus varchar(100) UNIQUE,
    lk int, -- lehekülgede arv
    autorID int,
    FOREIGN KEY (autorID) REFERENCES autor(autorID),
    zanrID int,
    FOREIGN KEY (zanrID) REFERENCES zanr(zanrID)
);

-- Raamatu lisamine
INSERT INTO raamat (raamatNimetus, lk, autorID, zanrID) VALUES
('sipsik', 300, 3, 2);

SELECT * FROM autor;
SELECT * FROM zanr;
SELECT * FROM raamat;

-- TABEL: trykikoda
-- Salvestab trükikodade andmed: nimetus ja aadress
-- NB! Peab olema loodud enne trykitudRaamat tabelit
CREATE TABLE trykikoda (
    trykikodaID int IDENTITY(1,1) PRIMARY KEY,
    nimetus varchar(30) UNIQUE,
    aadress varchar(30)
);

-- TABEL: trykitudRaamat
-- Seob raamatu trükikojaga (vahe-tabel)
CREATE TABLE trykitudRaamat (
    trRaamatID int IDENTITY(1,1) PRIMARY KEY,
    trykikodaID int,
    raamatID int,
    FOREIGN KEY (trykikodaID) REFERENCES trykikoda(trykikodaID),
    FOREIGN KEY (raamatID) REFERENCES raamat(raamatID)
);

SELECT * FROM trykitudRaamat;
