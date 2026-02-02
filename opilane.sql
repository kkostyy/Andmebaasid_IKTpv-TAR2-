CREATE DATABASE gaponenkoSQL;
use gaponenkoSQL;

--tabel loomine 
CREATE TABLE opilane(
opilaneID int PRIMARY KEY identity(1,1),
eesnimi varchar(25),
perenimi varchar(30) NOT null UNIQUE,
synniaeg date,
aadress TEXT,
kas_opib bit);
--kuvab tabeli, * - kõik väljad
SELECT * FROM opilane;

--tabeli kustutamine
DROP TABLE opilane;

--andmete lisamine tabelise opilane
INSERT INTO opilane(eesnimi, perenimi,synniaeg,kas_opib)
VALUES ('Konstantyn','Fuksov','2009-12-02',1),
('Kostya','Aljosha','2009-12-02',0);
Select * from opilane;

--muudame tabeli ja lisame piirangu
ALTER TABLE opilane Alter column perenimi varchar(30) UNIQUE;
