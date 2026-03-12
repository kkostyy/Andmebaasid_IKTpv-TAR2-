-- Andmebaasi loomine ja valimine
CREATE DATABASE IKTpv25_1_TAR;
USE IKTpv25_1_TAR;

-- TABEL: kasutaja
-- Salvestab kasutajate andmed: kasutajanimi ja parool
CREATE TABLE kasutaja (
    kasutaja_id int PRIMARY KEY IDENTITY(1,1),
    kasutajanimi varchar(25) NOT NULL,
    parool char(10) NOT NULL
);

-- Kõigi kasutajate vaatamine
SELECT * FROM kasutaja;

-- Kasutaja lisamine
INSERT INTO kasutaja (kasutajanimi, parool)
VALUES ('oleg', 'testik');

-- Uue veeru lisamine tabelisse
ALTER TABLE kasutaja ADD epost varchar(20);

-- Konkreetse kasutaja e-posti uuendamine
UPDATE kasutaja SET epost = 'test@gmail.com' WHERE kasutaja_id = 1;

-- Veeru kustutamine tabelist
ALTER TABLE kasutaja DROP COLUMN epost;

-- Veeru andmetüübi muutmine
ALTER TABLE kasutaja ALTER COLUMN parool varchar(25);

-- PROTSEDUUR: alterTable
-- Universaalne protseduur tabeli struktuuri muutmiseks (add / drop / alter)
CREATE PROCEDURE alterTable
    @valik varchar(20),
    @tabeliNimi varchar(25),
    @veeruNimi varchar(25),
    @tyyp varchar(20) = NULL
AS
BEGIN
    DECLARE @sql varchar(max);

    -- SQL-lause koostamine valiku järgi
    SET @sql = CASE
        WHEN @valik = 'add'   THEN CONCAT('ALTER TABLE ', @tabeliNimi, ' ADD ', @veeruNimi, ' ', @tyyp)
        WHEN @valik = 'drop'  THEN CONCAT('ALTER TABLE ', @tabeliNimi, ' DROP COLUMN ', @veeruNimi)
        WHEN @valik = 'alter' THEN CONCAT('ALTER TABLE ', @tabeliNimi, ' ALTER COLUMN ', @veeruNimi, ' ', @tyyp)
    END;

    PRINT @sql;   -- koostatud päringu kuvamine
    EXEC (@sql);  -- päringu käivitamine
END;

-- Veeru lisamine
EXEC alterTable @valik = 'add', @tabeliNimi = 'kasutaja', @veeruNimi = 'elukoht', @tyyp = 'int';

-- Veeru kustutamine
EXEC alterTable @valik = 'drop', @tabeliNimi = 'kasutaja', @veeruNimi = 'mobiil';

-- Veeru andmetüübi muutmine
EXEC alterTable @valik = 'alter', @tabeliNimi = 'kasutaja', @veeruNimi = 'elukoht', @tyyp = 'varchar(30)';

-- Protseduuri kustutamine
DROP PROCEDURE alterTable;

-- TABEL: city
-- Salvestab linnade andmed
CREATE TABLE city (
    ID int NOT NULL,
    cityName varchar(50)
);

SELECT * FROM city;

-- Primaarvõtme lisamine (PK)
ALTER TABLE city
ADD CONSTRAINT pk_ID PRIMARY KEY (ID);

-- Unikaalse piirangu lisamine — linna nimi peab olema unikaalne
ALTER TABLE city
ADD CONSTRAINT cityName_unique UNIQUE (cityName);

-- Veeru andmetüübi muutmine enne võõrvõtme lisamist
ALTER TABLE kasutaja ALTER COLUMN elukoht int;

SELECT * FROM kasutaja;

-- Võõrvõtme lisamine (FK): kasutaja.elukoht → city.ID
ALTER TABLE kasutaja
ADD CONSTRAINT fk_city FOREIGN KEY (elukoht)
REFERENCES city (ID);
