CREATE DATABASE Opilane
use Opilane

-- 2. Tabelite loomine
CREATE TABLE kool (
    kool_id INT PRIMARY KEY IDENTITY(1,1),
    kool_nimi VARCHAR(100),
    aadress VARCHAR(200)
);

CREATE TABLE opilane (
    opilane_id INT PRIMARY KEY IDENTITY(1,1),
    eesnimi VARCHAR(50),
    perenimi VARCHAR(50),
    synniaeg DATE,
    kool_id INT FOREIGN KEY REFERENCES kool(kool_id)
);

CREATE TABLE logi (
    logi_id INT PRIMARY KEY IDENTITY(1,1),
    kuupaev DATETIME DEFAULT GETDATE(),
    andmed VARCHAR(200),
    kasutaja VARCHAR(200),
    operatsioon VARCHAR(10),
    tabel_nimi VARCHAR(30)
);


-- 3. INSERT triger 
CREATE TRIGGER trig_insert_opilane
ON opilane
AFTER INSERT
AS
BEGIN
    INSERT INTO logi (andmed, kasutaja, operatsioon, tabel_nimi)
    SELECT 
        CONCAT('Lisa: opilane_id=', i.opilane_id, 
               ', nimi=', i.eesnimi, ' ', i.perenimi, 
               ', kool_id=', i.kool_id,' ', kool.kool_nimi),
        SYSTEM_USER, 'INSERT', 'opilane'
    FROM inserted i inner join kool on i.kool_id = kool.kool_id;
END;


-- 4. DELETE triger 
CREATE TRIGGER trig_delete_opilane
ON opilane
AFTER DELETE
AS
BEGIN
    INSERT INTO logi (andmed, kasutaja, operatsioon, tabel_nimi)
    SELECT 
        CONCAT('Kustuta: opilane_id=', d.opilane_id, 
               ', nimi=', d.eesnimi, ' ', d.perenimi, 
               ', kool_id=', d.kool_id,' ', kool.kool_nimi),
        SYSTEM_USER, 'DELETE', 'opilane'
    FROM deleted d inner join kool on d.kool_id = kool.kool_id;
END;

-- 5. Näidisandmete sisestamine
INSERT INTO kool (kool_nimi, aadress) VALUES 
('Tallinna Reaalkool', 'Estonia pst 6, Tallinn'),
('Tartu Miina Härma Gümnaasium', 'J. Hurda 3, Tartu');

INSERT INTO opilane (eesnimi, perenimi, synniaeg, kool_id) VALUES 
('Andrey', 'Ivanov', '2008-05-12', 1),
('Mari', 'Kask', '2009-08-22', 2);


--Kontrollimiseks:
SELECT * FROM opilane;
SELECT * FROM kool;
SELECT * FROM logi;

DELETE FROM opilane
WHERE opilane_id = 1;














DENY SELECT, INSERT, UPDATE, DELETE ON dbo.logi TO Andrey;
