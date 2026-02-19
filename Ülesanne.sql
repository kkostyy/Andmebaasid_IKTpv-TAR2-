CREATE DATABASE SQLGaponenko;
USE SQLGaponenko;

--boks tabeli loomine
CREATE TABLE boks (
boks_id INT IDENTITY(1,1) PRIMARY KEY,
nimetus VARCHAR(30) NOT NULL,
asukoht VARCHAR(50) NOT NULL,
mahutavus INT NOT NULL CHECK(mahutavus > 0),
);

--boks tabeli täitmine
INSERT INTO boks (nimetus, asukoht, mahutavus) VALUES
('Kasside maja','Sektor A',10),
('Koerte aedik','Sektor B',15),
('Kuulikute maja','Sektor C',8),
('Lindude voljuur','Sektor D',20),
('Roomajate maja','Sektor E',5);
SELECT * FROM boks;

--vabatahtlik tabeli loomine
CREATE TABLE vabatahtlik (
vabatahtlik_id INT IDENTITY(1,1) PRIMARY KEY,
nimi VARCHAR(30) NOT NULL,
kontakt VARCHAR(50) NOT NULL UNIQUE,
);

--vabatahtlik tabeli täitmine
INSERT INTO vabatahtlik (nimi, kontakt) VALUES
('Mari Tamm','mari.tamm@email.ee'),
('Jaan Kask','jaan.kask@email.ee'),
('Anna Magi','anna.magi@email.ee'),
('Peeter Lepp','peeter.lepp@email.ee'),
('Liisa Parn','liisa.parn@email.ee');
SELECT * FROM vabatahtlik;

--loom tabeli loomine
CREATE TABLE loom (
loom_id INT IDENTITY(1,1) PRIMARY KEY,
nimi VARCHAR(50) NOT NULL,
liik VARCHAR(30) NOT NULL,
toug VARCHAR(30),
sugu CHAR(1) NOT NULL CHECK(sugu IN ('M','F')),
saabumise_kuupaev DATE,
boks_id INT NOT NULL,
FOREIGN KEY (boks_id) REFERENCES boks(boks_id),
);

--loom tabeli täitmine
INSERT INTO loom (nimi, liik, toug, sugu, saabumise_kuupaev, boks_id) VALUES
('Miisu','Kass','Siberi kass','F','2024-01-15',1),
('Puhvis','Kass','Maine Coon','M','2024-02-20',1),
('Rex','Koer','Labrador','M', '2024-03-10',2),
('Bella','Koer','Golden Retriever','F','2024-04-05',2),
('Musti','Kuulik','Holland Lop','M','2024-05-12',3);
SELECT * FROM loom;

--koristus tabeli loomine
CREATE TABLE koristus (
koristus_id INT IDENTITY(1,1) PRIMARY KEY,
loom_id INT NOT NULL,
vabatahtlik_id INT NOT NULL,
kuupaev DATE,
kestus INT CHECK (kestus > 0),
FOREIGN KEY (loom_id) REFERENCES loom(loom_id),
FOREIGN KEY (vabatahtlik_id) REFERENCES vabatahtlik(vabatahtlik_id),
);

--koristus tabeli täitmine
INSERT INTO koristus (loom_id, vabatahtlik_id, kuupaev, kestus) VALUES
(1,1,'2025-01-10',30),
(2,2,'2025-01-11',45),
(3,3,'2025-01-12',60),
(4,4,'2025-01-13',30),
(5,5,'2025-01-14',20);
SELECT * FROM koristus;

CREATE TABLE tervisekaart (
tervisekaart_id INT IDENTITY(1,1) PRIMARY KEY,
loom_id INT NOT NULL,
kuupäev DATE NOT NULL,
diagnoos VARCHAR(100),
ravi VARCHAR(100),
arsti_nimi VARCHAR(100) NOT NULL,
FOREIGN KEY (loom_id) REFERENCES Loom(loom_id)
);

INSERT INTO tervisekaart (loom_id, kuupäev, diagnoos, ravi, arsti_nimi) VALUES
(1,'2025-01-05','Terve',NULL,'Dr. Sepp'),
(2,'2025-01-06','Külmetus','Antibiotikumid','Dr. Sepp'),
(3,'2025-01-07','Terve',NULL,'Dr. Kull'),
(4,'2025-01-08','Luumurd (käpp)','Kips, puhkus','Dr. Kull'),
(5,'2025-01-09','Terve',NULL,'Dr. Rand');
SELECT * FROM tervisekaart;

-- 1 Protseduur
CREATE PROCEDURE otsaLoom
@p_nimi VARCHAR(100)
AS
BEGIN
SELECT * FROM Loom
WHERE nimi = @p_nimi;
END;
EXEC OtsaLoom 'Rex';

-- 2 Protseduur
CREATE PROCEDURE GetKoristusedKuupaeval
@p_kuupaev DATE
AS
BEGIN
SELECT
k.koristus_id,
l.nimi  AS loom_nimi,
v.nimi  AS vabatahtlik_nimi,
k.kestus
FROM Koristus k
JOIN Loom l ON k.loom_id = l.loom_id
JOIN Vabatahtlik v ON k.vabatahtlik_id = v.vabatahtlik_id
WHERE k.kuupaev = @p_kuupaev;
END;
EXEC GetKoristusedKuupaeval '2025-01-10';

-- 3 Protseduur
CREATE PROCEDURE GetLoomadLiigi
@p_liik VARCHAR(100)
AS
BEGIN
SELECT
l.loom_id,
l.nimi,
l.toug,
l.sugu,
b.nimetus AS boks_nimetus
FROM Loom l
JOIN Boks b ON l.boks_id = b.boks_id
WHERE l.liik = @p_liik;
END;
EXEC GetLoomadLiigi 'Kass';


EXEC OtsaLoom 'Rex';
EXEC GetKoristusedKuupaeval '2025-01-10';
EXEC GetLoomadLiigi 'Kass';


SELECT * FROM vabatahtlik;
SELECT * FROM boks;
SELECT * FROM loom;
SELECT * FROM koristus;
SELECT * FROM tervisekaart;
