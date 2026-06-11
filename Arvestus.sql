-- ============================================================
-- ANDMEBAASIDE ARVESTUSTÖÖ
-- Teema: Lennujaam / Lend / Reisija
-- ============================================================

-- ============================================================
-- 1. Kasutaja loomine ja õigused
-- ============================================================

-- Loo login ja kasutaja
CREATE LOGIN reisijanimi_login WITH PASSWORD = 'Parool123!';
CREATE USER reisijaNimi FOR LOGIN reisijanimi_login;

-- Õigused: tabelite loomine
GRANT CREATE TABLE TO reisijaNimi;

-- Õigused: andmete lisamine ja kustutamine tabelisse Reisija ja Lend
GRANT INSERT, DELETE ON dbo.Reisija TO reisijaNimi;
GRANT INSERT, DELETE ON dbo.Lend TO reisijaNimi;

-- Õigused: andmete vaatamine kõikides tabelites
GRANT SELECT ON dbo.Lennujaam TO reisijaNimi;
GRANT SELECT ON dbo.Lend TO reisijaNimi;
GRANT SELECT ON dbo.Reisija TO reisijaNimi;
GRANT SELECT ON dbo.logi TO reisijaNimi;


-- ============================================================
-- 2. Tabelite loomine
-- ============================================================

CREATE TABLE Lennujaam (
    LennujaamID INT PRIMARY KEY IDENTITY(1,1),
    LennujaamaNimi VARCHAR(100) NOT NULL,
    Linn VARCHAR(100) NOT NULL
);

CREATE TABLE Lend (
    LendID INT PRIMARY KEY IDENTITY(1,1),
    LennuNumber VARCHAR(20) NOT NULL,
    Väljumisaeg DATETIME NOT NULL,
    LennujaamID INT NOT NULL,
    CONSTRAINT FK_Lend_Lennujaam FOREIGN KEY (LennujaamID) REFERENCES Lennujaam(LennujaamID)
);

CREATE TABLE Reisija (
    ReisijaID INT PRIMARY KEY IDENTITY(1,1),
    Nimi VARCHAR(100) NOT NULL,
    Piletinumber VARCHAR(50) NOT NULL,
    LendID INT NOT NULL,
    CONSTRAINT FK_Reisija_Lend FOREIGN KEY (LendID) REFERENCES Lend(LendID)
);


-- ============================================================
-- 3. Tabelid on seotud (FK on juba defineeritud ülal)
-- Lennujaam (1) --> (∞) Lend (1) --> (∞) Reisija
-- ============================================================


-- ============================================================
-- 4 & 5. Kasutaja reisijaNimi ei saa muuta tabeli struktuuri (ALTER)
-- ============================================================

-- Keelame ALTER TABLE õiguse (ALTER on automaatselt keelatud ilma
-- db_ddladmin rolli andmata, aga teeme selle eksplitsiitselt selgeks)
DENY ALTER ON dbo.Reisija TO reisijaNimi;
DENY ALTER ON dbo.Lend TO reisijaNimi;
DENY ALTER ON dbo.Lennujaam TO reisijaNimi;


-- ============================================================
-- 6. Logi tabel
-- ============================================================

CREATE TABLE logi (
    id INT PRIMARY KEY IDENTITY(1,1),
    kasutaja VARCHAR(200) NOT NULL,
    kuupaev DATETIME DEFAULT GETDATE(),
    sisestatudAndmed VARCHAR(500)
);


-- ============================================================
-- 7. Trigger: jälgib andmete KUSTUTAMINE tabelis Lend
-- ============================================================

CREATE TRIGGER trig_delete_lend
ON Lend
AFTER DELETE
AS
BEGIN
    INSERT INTO logi (kasutaja, kuupaev, sisestatudAndmed)
    SELECT
        SYSTEM_USER,
        GETDATE(),
        CONCAT(
            'KUSTUTATUD | Lend: LendID=', d.LendID,
            ', LennuNumber=', d.LennuNumber,
            ', Väljumisaeg=', CONVERT(VARCHAR, d.Väljumisaeg, 120),
            ', LennujaamID=', d.LennujaamID,
            ' | Lennujaam: ', lj.LennujaamaNimi, ' (', lj.Linn, ')'
        )
    FROM deleted d
    LEFT JOIN Lennujaam lj ON d.LennujaamID = lj.LennujaamID;
END;


-- ============================================================
-- 8. Trigger: jälgib andmete LISAMINE tabelis Lend
-- ============================================================

CREATE TRIGGER trig_insert_lend
ON Lend
AFTER INSERT
AS
BEGIN
    INSERT INTO logi (kasutaja, kuupaev, sisestatudAndmed)
    SELECT
        SYSTEM_USER,
        GETDATE(),
        CONCAT(
            'LISATUD | Lend: LendID=', i.LendID,
            ', LennuNumber=', i.LennuNumber,
            ', Väljumisaeg=', CONVERT(VARCHAR, i.Väljumisaeg, 120),
            ', LennujaamID=', i.LennujaamID,
            ' | Lennujaam: ', lj.LennujaamaNimi, ' (', lj.Linn, ')'
        )
    FROM inserted i
    LEFT JOIN Lennujaam lj ON i.LennujaamID = lj.LennujaamID;
END;


-- ============================================================
-- Näidisandmed (testimiseks)
-- ============================================================

INSERT INTO Lennujaam (LennujaamaNimi, Linn) VALUES
('Lennart Meri Tallinna lennujaam', 'Tallinn'),
('Tartu lennujaam', 'Tartu'),
('Helsingi-Vantaa', 'Helsingi'),
('Riia rahvusvaheline lennujaam', 'Riia');

INSERT INTO Lend (LennuNumber, Väljumisaeg, LennujaamID) VALUES
('OV101', '2025-06-15 08:00', 1),
('OV102', '2025-06-15 12:30', 1),
('BT201', '2025-06-16 09:45', 4),
('AY301', '2025-06-17 14:00', 3);

INSERT INTO Reisija (Nimi, Piletinumber, LendID) VALUES
('Andrei Ivanov',  'PIL-001', 1),
('Mari Tamm',      'PIL-002', 1),
('Jüri Mägi',      'PIL-003', 2),
('Elena Saar',     'PIL-004', 3),
('Peeter Kask',    'PIL-005', 4);


-- ============================================================
-- 10. Triggerite kontroll (käivita kasutajana reisijaNimi)
-- ============================================================

-- Lisamine (peaks logimisel kirje tekkima)
INSERT INTO Lend (LennuNumber, Väljumisaeg, LennujaamID) VALUES ('TEST01', '2025-07-01 10:00', 2);

-- Kustutamine (peaks logimisel kirje tekkima)
DELETE FROM Lend WHERE LennuNumber = 'TEST01';

-- Vaata logi
SELECT * FROM logi ORDER BY kuupaev DESC;


-- ============================================================
-- 11. Kolm protseduuri parameetritega
-- ============================================================

-- Protseduur 1: Leia kõik reisijad konkreetsel lennul (LennuNumber järgi)
CREATE PROCEDURE sp_ReisijadLennul
    @LennuNumber VARCHAR(20)
AS
BEGIN
    SELECT
        r.ReisijaID,
        r.Nimi,
        r.Piletinumber,
        l.LennuNumber,
        l.Väljumisaeg,
        lj.LennujaamaNimi,
        lj.Linn
    FROM Reisija r
    INNER JOIN Lend l ON r.LendID = l.LendID
    INNER JOIN Lennujaam lj ON l.LennujaamID = lj.LennujaamID
    WHERE l.LennuNumber = @LennuNumber;
END;

-- Protseduur 2: Lisa uus reisija lennule
CREATE PROCEDURE sp_LisaReisija
    @Nimi VARCHAR(100),
    @Piletinumber VARCHAR(50),
    @LendID INT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Lend WHERE LendID = @LendID)
    BEGIN
        PRINT 'Viga: sellist lendu ei ole olemas.';
        RETURN;
    END

    INSERT INTO Reisija (Nimi, Piletinumber, LendID)
    VALUES (@Nimi, @Piletinumber, @LendID);

    PRINT 'Reisija edukalt lisatud.';
END;

-- Protseduur 3: Leia lennud kindlast linnast ajavahemikus
CREATE PROCEDURE sp_LennudLinnas
    @Linn VARCHAR(100),
    @AlgusKP DATETIME,
    @LõppKP DATETIME
AS
BEGIN
    SELECT
        l.LendID,
        l.LennuNumber,
        l.Väljumisaeg,
        lj.LennujaamaNimi,
        lj.Linn,
        COUNT(r.ReisijaID) AS ReisijaideArv
    FROM Lend l
    INNER JOIN Lennujaam lj ON l.LennujaamID = lj.LennujaamID
    LEFT JOIN Reisija r ON l.LendID = r.LendID
    WHERE lj.Linn = @Linn
      AND l.Väljumisaeg BETWEEN @AlgusKP AND @LõppKP
    GROUP BY l.LendID, l.LennuNumber, l.Väljumisaeg, lj.LennujaamaNimi, lj.Linn;
END;

-- Protseduuride testimine:
EXEC sp_ReisijadLennul @LennuNumber = 'OV101';
EXEC sp_LisaReisija @Nimi = 'Tiina Lepik', @Piletinumber = 'PIL-999', @LendID = 1;
EXEC sp_LennudLinnas @Linn = 'Tallinn', @AlgusKP = '2025-01-01', @LõppKP = '2025-12-31';


-- ============================================================
-- 12. Kolm vaadet (vähemalt 2 tabelist)
-- ============================================================

-- Vaade 1: Kõik lennud koos lennujaama infoga
CREATE VIEW v_LennudJaLennujaamad AS
SELECT
    l.LendID,
    l.LennuNumber,
    l.Väljumisaeg,
    lj.LennujaamaNimi,
    lj.Linn AS LähteLinn
FROM Lend l
INNER JOIN Lennujaam lj ON l.LennujaamID = lj.LennujaamID;

-- Vaade 2: Kõik reisijad koos lennuinfo ja lennujaamaga
CREATE VIEW v_ReisijadKoguInfo AS
SELECT
    r.ReisijaID,
    r.Nimi AS ReisijaName,
    r.Piletinumber,
    l.LennuNumber,
    l.Väljumisaeg,
    lj.LennujaamaNimi,
    lj.Linn
FROM Reisija r
INNER JOIN Lend l ON r.LendID = l.LendID
INNER JOIN Lennujaam lj ON l.LennujaamID = lj.LennujaamID;

-- Vaade 3: Lennud koos reisijate arvuga (statistika vaade)
CREATE VIEW v_LennuStatistika AS
SELECT
    l.LennuNumber,
    l.Väljumisaeg,
    lj.LennujaamaNimi,
    lj.Linn,
    COUNT(r.ReisijaID) AS ReisijaideArv
FROM Lend l
INNER JOIN Lennujaam lj ON l.LennujaamID = lj.LennujaamID
LEFT JOIN Reisija r ON l.LendID = r.LendID
GROUP BY l.LennuNumber, l.Väljumisaeg, lj.LennujaamaNimi, lj.Linn;

-- Vaadete testimine:
SELECT * FROM v_LennudJaLennujaamad;
SELECT * FROM v_ReisijadKoguInfo;
SELECT * FROM v_LennuStatistika ORDER BY ReisijaideArv DESC;


-- ============================================================
-- 13. LOOV LISATEGEVUS: Automaatne reisijate arvu jälgimine
--     Trigger, mis keeldub lennule lisama uut reisijat,
--     kui lennu maht (MAX 3 reisijat demo eesmärgil) on täis.
--     + Eraldi tabel lennumahtude jaoks.
-- ============================================================

-- Lennumahu tabel
CREATE TABLE LennuMaht (
    LendID INT PRIMARY KEY,
    MaksReisijaid INT NOT NULL DEFAULT 150,
    CONSTRAINT FK_LennuMaht_Lend FOREIGN KEY (LendID) REFERENCES Lend(LendID)
);

-- Täida mahtude tabel olemasolevatele lendudele
INSERT INTO LennuMaht (LendID, MaksReisijaid) VALUES (1, 150), (2, 150), (3, 150), (4, 150);

-- Trigger: kontrollib enne Reisija lisamist, kas lennul on kohti
CREATE TRIGGER trig_kontroll_maht
ON Reisija
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @LendID INT, @Praegune INT, @Maks INT;

    SELECT @LendID = LendID FROM inserted;

    SELECT @Praegune = COUNT(*) FROM Reisija WHERE LendID = @LendID;

    SELECT @Maks = MaksReisijaid FROM LennuMaht WHERE LendID = @LendID;

    IF @Maks IS NULL
    BEGIN
        -- Kui mahtude tabelis pole kirjet, lubame vaikimisi
        INSERT INTO Reisija (Nimi, Piletinumber, LendID)
        SELECT Nimi, Piletinumber, LendID FROM inserted;
        RETURN;
    END

    IF @Praegune >= @Maks
    BEGIN
        RAISERROR('Viga: lennul pole vabu kohti!', 16, 1);
        RETURN;
    END

    -- Kõik korras - lisame reisija
    INSERT INTO Reisija (Nimi, Piletinumber, LendID)
    SELECT Nimi, Piletinumber, LendID FROM inserted;

    PRINT 'Reisija lisatud. Vabu kohti lennul: ' + 
          CAST(@Maks - @Praegune - 1 AS VARCHAR) + '.';
END;

/*
  SELGITUS (ülesanne 13):
  -------------------------------------------------------
  Lõin lennumahu kontrolli süsteemi, mis koosneb:
  1. Tabelist LennuMaht - hoiab iga lennu maksimaalset reisijate arvu
  2. Triggerist trig_kontroll_maht - kontrollib ENNE iga reisija lisamist,
     kas lennul on veel vabu kohti.

  See erineb eelnevatest ülesannetest, sest:
  - Kasutab INSTEAD OF INSERT trigerit (mitte AFTER)
  - Teostab äriloogika kontrolli andmebaasi tasemel
  - Annab kasutajale informatiivse veateate kui kohad täis
  - Näitab pärast lisamist, mitu kohta on järel

  Praktiline väärtus: lennuettevõte ei saa kunagi müüa rohkem pileteid
  kui lennukil on kohti - see on automaatne kaitse ülemüümise eest.
*/
