
CREATE DATABASE IKTpv25_1_Transaktsioonid ;
USE IKTpv25_1_Transaktsioonid ;

CREATE TABLE tblMailingAddress
(
    AddressId int PRIMARY KEY NOT NULL,
    EmployeeNumber int,
    HouseNumber nvarchar(50),
    StreetAddress nvarchar(50),
    City nvarchar(10),
    PostalCode nvarchar(50)
);

CREATE TABLE tblPhysicalAddress
(
    AddressId int PRIMARY KEY NOT NULL,
    EmployeeNumber int,
    HouseNumber nvarchar(50),
    StreetAddress nvarchar(50),
    City nvarchar(10),
    PostalCode nvarchar(50)
);

INSERT INTO tblMailingAddress
VALUES (1, 101, '#10', 'King Street', 'Londoon', 'CR27DW');

INSERT INTO tblPhysicalAddress
VALUES (1, 101, '#10', 'King Street', 'Londoon', 'CR27DW');

SELECT * FROM tblMailingAddress;
SELECT * FROM tblPhysicalAddress;

CREATE PROCEDURE spUpdateAddress
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        UPDATE tblMailingAddress
        SET City = 'LONDON'
        WHERE EmployeeNumber = 101;

        UPDATE tblPhysicalAddress
        SET City = 'LONDON'
        WHERE EmployeeNumber = 101;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;

        PRINT ERROR_MESSAGE();
    END CATCH;
END;

EXEC spUpdateAddress;

SELECT * FROM tblMailingAddress;
SELECT * FROM tblPhysicalAddress;



ALTER PROCEDURE spUpdateAddress
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        UPDATE tblMailingAddress
        SET City = 'LONDON12'
        WHERE EmployeeNumber = 101;

        UPDATE tblPhysicalAddress
        SET City = 'LONDON LONDON'
        WHERE EmployeeNumber = 101;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;

        PRINT ERROR_MESSAGE();
    END CATCH;
END;

EXEC spUpdateAddress;

SELECT * FROM tblMailingAddress;
SELECT * FROM tblPhysicalAddress;

UPDATE tblMailingAddress
SET City = 'LONDON12'
WHERE EmployeeNumber = 101;

UPDATE tblPhysicalAddress
SET City = 'LONDON LONDON'
WHERE EmployeeNumber = 101;

SELECT * FROM tblMailingAddress;
SELECT * FROM tblPhysicalAddress;

CREATE TABLE tblArveldusarve
(
    KontoId int PRIMARY KEY NOT NULL,
    KliendiNr int,
    Omanik nvarchar(30),
    Saldo decimal(10,2) CHECK (Saldo >= 0)
);

CREATE TABLE tblHoiusarve
(
    KontoId int PRIMARY KEY NOT NULL,
    KliendiNr int,
    Omanik nvarchar(30),
    Saldo decimal(10,2) CHECK (Saldo >= 0)
);

INSERT INTO tblArveldusarve
VALUES (1, 201, 'Mari Maasikas', 500.00);

INSERT INTO tblHoiusarve
VALUES (1, 201, 'Mari Maasikas', 1000.00);

SELECT * FROM tblArveldusarve;
SELECT * FROM tblHoiusarve;

CREATE PROCEDURE spUlekanne
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        UPDATE tblHoiusarve
        SET Saldo = Saldo + 200
        WHERE KliendiNr = 201;

        UPDATE tblArveldusarve
        SET Saldo = Saldo - 200
        WHERE KliendiNr = 201;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;

        PRINT ERROR_MESSAGE();
    END CATCH;
END;

EXEC spUlekanne;

SELECT * FROM tblArveldusarve;
SELECT * FROM tblHoiusarve;

UPDATE tblHoiusarve
SET Saldo = Saldo + 1000
WHERE KliendiNr = 201;

UPDATE tblArveldusarve
SET Saldo = Saldo - 1000
WHERE KliendiNr = 201;

SELECT * FROM tblArveldusarve;
SELECT * FROM tblHoiusarve;

UPDATE tblArveldusarve
SET Saldo = 300.00
WHERE KliendiNr = 201;

UPDATE tblHoiusarve
SET Saldo = 1200.00
WHERE KliendiNr = 201;


ALTER PROCEDURE spUlekanne
    @Summa decimal(10,2)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        UPDATE tblHoiusarve
        SET Saldo = Saldo + @Summa
        WHERE KliendiNr = 201;

        UPDATE tblArveldusarve
        SET Saldo = Saldo - @Summa
        WHERE KliendiNr = 201;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;

        PRINT ERROR_MESSAGE();
    END CATCH;
END;

EXEC spUlekanne @Summa = 50;

SELECT * FROM tblArveldusarve;
SELECT * FROM tblHoiusarve;
