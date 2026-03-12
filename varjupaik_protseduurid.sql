-- Andmebaasi loomine ja valimine
CREATE DATABASE SQLGaponenko;
USE SQLGaponenko;

-- TABEL: boks
-- Salvestab loomade boksid: nimetus, asukoht, mahutavus
CREATE TABLE boks (
    boks_id int IDENTITY(1,1) PRIMARY KEY,
    nimetus varchar(30) NOT NULL,
    asukoht varchar(50) NOT NULL,
    mahutavus int NOT NULL CHECK(mahutavus > 0) -- mahutavus peab olema positiivne
);

-- Bokside lisamine
INSERT INTO boks (nimetus, asukoht, mahutavus) VALUES
('Kasside maja', 'Sektor A', 10),
('Koerte aedik', 'Sektor B', 15),
('Kuulikute maja', 'Sektor C', 8),
('Lindude voljuur', 'Sektor D', 20),
('Roomajate maja', 'Sektor E', 5);

SELECT * FROM boks;

-- TABEL: vabatahtlik
-- Salvestab vabatahtlike andmed: nimi ja kontakt
CREATE TABLE vabatahtlik (
    vabatahtlik_id int IDENTITY(1,1) PRIMARY KEY,
    nimi varchar(30) NOT NULL,
    kontakt varchar(50) NOT NULL UNIQUE -- e-post peab olema unikaalne
);

-- Vabatahtlike lisamine
INSERT INTO vabatahtlik (nimi, kontakt) VALUES
('Mari Tamm', 'mari.tamm@email.ee'),
('Jaan Kask', 'jaan.kask@email.ee'),
('Anna Magi', 'anna.magi@email.ee'),
('Peeter Lepp', 'peeter.lepp@email.ee'),
('Liisa Parn', 'liisa.parn@email.ee');

SELECT * FROM vabatahtlik;

-- TABEL: loom
-- Salvestab loomade andmed: liik, tõug, sugu, saabumiskuupäev, boks
CREATE TABLE loom (
    loom_id int IDENTITY(1,1) PRIMARY KEY,
    nimi varchar(50) NOT NULL,
    liik varchar(30) NOT NULL,
    toug varchar(30),
    sugu char(1) NOT NULL CHECK(sugu IN ('M','F')), -- ainult M või F
    saabumise_kuupaev date,
    boks_id int NOT NULL,
    FOREIGN KEY (boks_id) REFERENCES boks(boks_id)
);

-- Loomade lisamine
INSERT INTO loom (nimi, liik, toug, sugu, saabumise_kuupaev, boks_id) VALUES
('Miisu', 'Kass', 'Siberi kass', 'F', '2024-01-15', 1),
('Puhvis', 'Kass', 'Maine Coon', 'M', '2024-02-20', 1),
('Rex', 'Koer', 'Labrador', 'M', '2024-03-10', 2),
('Bella', 'Koer', 'Golden Retriever', 'F', '2024-04-05', 2),
('Musti', 'Kuulik', 'Holland Lop', 'M', '2024-05-12', 3);

SELECT * FROM loom;

-- TABEL: koristus
-- Salvestab koristuste andmed: loom, vabatahtlik, kuupäev, kestus
CREATE TABLE koristus (
    koristus_id int IDENTITY(1,1) PRIMARY KEY,
    loom_id int NOT NULL,
    vabatahtlik_id int NOT NULL,
    kuupaev date,
    kestus int CHECK(kestus > 0), -- kestus minutites, peab olema positiivne
    FOREIGN KEY (loom_id) REFERENCES loom(loom_id),
    FOREIGN KEY (vabatahtlik_id) REFERENCES vabatahtlik(vabatahtlik_id)
);

-- Koristuste lisamine
INSERT INTO koristus (loom_id, vabatahtlik_id, kuupaev, kestus) VALUES
(1, 1, '2025-01-10', 30),
(2, 2, '2025-01-11', 45),
(3, 3, '2025-01-12', 60),
(4, 4, '2025-01-13', 30),
(5, 5, '2025-01-14', 20);

SELECT * FROM koristus;

-- TABEL: tervisekaart
-- Salvestab loomade terviseandmed: diagnoos, ravi, arst
CREATE TABLE tervisekaart (
    tervisekaart_id int IDENTITY(1,1) PRIMARY KEY,
    loom_id int NOT NULL,
    kuupäev date NOT NULL,
    diagnoos varchar(100),
    ravi varchar(100),
    arsti_nimi varchar(100) NOT NULL,
    FOREIGN KEY (loom_id) REFERENCES loom(loom_id)
);

-- Tervisekaartide lisamine
INSERT INTO tervisekaart (loom_id, kuupäev, diagnoos, ravi, arsti_nimi) VALUES
(1, '2025-01-05', 'Terve', NULL, 'Dr. Sepp'),
(2, '2025-01-06', 'Külmetus', 'Antibiotikumid', 'Dr. Sepp'),
(3, '2025-01-07', 'Terve', NULL, 'Dr. Kull'),
(4, '2025-01-08', 'Luumurd (käpp)', 'Kips, puhkus', 'Dr. Kull'),
(5, '2025-01-09', 'Terve', NULL, 'Dr. Rand');

SELECT * FROM tervisekaart;

-- PROTSEDUUR 1: otsaLoom
-- Otsib looma nime järgi
CREATE PROCEDURE otsaLoom
    @p_nimi varchar(100)
AS
BEGIN
    SELECT * FROM loom
    WHERE nimi = @p_nimi;
END;

-- Kutse: otsi looma nimega Rex
EXEC otsaLoom 'Rex';

-- PROTSEDUUR 2: GetKoristusedKuupaeval
-- Kuvab kõik koristused valitud kuupäeval koos looma ja vabatahtliku nimega
CREATE PROCEDURE GetKoristusedKuupaeval
    @p_kuupaev date
AS
BEGIN
    SELECT
        k.koristus_id,
        l.nimi AS loom_nimi,
        v.nimi AS vabatahtlik_nimi,
        k.kestus
    FROM koristus k
    JOIN loom l ON k.loom_id = l.loom_id
    JOIN vabatahtlik v ON k.vabatahtlik_id = v.vabatahtlik_id
    WHERE k.kuupaev = @p_kuupaev;
END;

-- Kutse: kuva koristused 2025-01-10
EXEC GetKoristusedKuupaeval '2025-01-10';

-- PROTSEDUUR 3: GetLoomadLiigi
-- Kuvab kõik loomad valitud liigi järgi koos boksi nimega
CREATE PROCEDURE GetLoomadLiigi
    @p_liik varchar(100)
AS
BEGIN
    SELECT
        l.loom_id,
        l.nimi,
        l.toug,
        l.sugu,
        b.nimetus AS boks_nimetus
    FROM loom l
    JOIN boks b ON l.boks_id = b.boks_id
    WHERE l.liik = @p_liik;
END;

-- Kutse: kuva kõik kassid
EXEC GetLoomadLiigi 'Kass';

-- Kõigi tabelite vaatamine
SELECT * FROM vabatahtlik;
SELECT * FROM boks;
SELECT * FROM loom;
SELECT * FROM koristus;
SELECT * FROM tervisekaart;
