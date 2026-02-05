CREATE DATABASE raamatGaponenko;
use raamatGaponenko;

--tabeli zanr loomine
CREATE TABLE zanr(
zanrID int PRIMARY KEY identity(1,1),
zanrNimetus varchar(50) not null,
kirjeldus TEXT);
Select * from zanr

--zanr tabeli täitamine
INSERT INTO zanr(zanrNimetus, kirjeldus)
VALUES ('luuletus', 'see on luuletus  zanr');

--tabeli autor loomine
CREATE TABLE autor(
autorID int PRIMARY KEY identity(1,1),
eesnimi varchar(50),
perenimi varchar(50),
synniaasta int check(synniaasta > 1900),
elukoht varchar(30),
);
Select * from autor

--autor tabeli täitamine
INSERT INTO autor(eesnimi, perenimi,synniaasta)
VALUES ('Anton', 'Tammsaare', 1901);

--tabeli uuendamine
UPDATE autor SET elukoht = 'Eesti';

--kustutamine tabelist
DELETE FROM autor Where autorID =

--raamat tabeli loomine
CREATE TABLE raamat(
raamatID int PRIMARY KEY identity(1,1),
raamatNimetus varchar(100) UNIQUE,
lk int,
autorID int,
FOREIGN KEY (autorID) REFERENCES autor(autorID),
zanrID int,
FOREIGN KEY (zanrID) REFERENCES zanr(zanrID)
);

INSERT INTO raamat (raamatNimetus, lk, autorID, zanrID)
VALUES ('sipsik', 300, 3, 2)

Select * from autor
Select * from zanr
Select * from raamat

--trykitudRaamat tabeli loomine
CREATE TABLE trykitudRaamat(
    trRaamatID int IDENTITY(1,1) PRIMARY KEY,
    trykikodaID int,
    raamatID int,
    FOREIGN KEY (trykikodaID) REFERENCES trykikoda(trykikodaID),
    FOREIGN KEY (raamatID) REFERENCES raamat(raamatID)
);

Select * from trykitudRaamat

--trykikoda tabeli loomine
CREATE TABLE trykikoda(
    trykikodaID int IDENTITY(1,1) PRIMARY KEY,
    nimetus varchar(30) UNIQUE,
    aadress varchar(30)
);
