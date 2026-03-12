-- Andmebaasi loomine ja valimine
CREATE DATABASE gaponenkoSQL;
USE gaponenkoSQL;

-- TABEL: auto
-- Salvestab autode andmed: number, mark, mudel, värv, valmistamisaasta
CREATE TABLE auto (
    autoID int PRIMARY KEY,
    autoNumber char(6) NOT NULL,
    mark varchar(50) NOT NULL,
    mudel varchar(50),
    varv varchar(50),
    v_aasta int
);

-- Autode lisamine
INSERT INTO auto (autoID, autoNumber, mark, mudel, varv, v_aasta) VALUES (1, 'BA7952', 'Hyundai', 'Elantra', 'Pink', 2003);
INSERT INTO auto (autoID, autoNumber, mark, mudel, varv, v_aasta) VALUES (2, 'QR4818', 'Chevrolet', 'Suburban 2500', 'Green', 2003);
INSERT INTO auto (autoID, autoNumber, mark, mudel, varv, v_aasta) VALUES (3, 'DL4964', 'Lexus', 'SC', 'Aquamarine', 1996);
INSERT INTO auto (autoID, autoNumber, mark, mudel, varv, v_aasta) VALUES (4, 'AC9772', 'Lexus', 'SC', 'Green', 1997);
INSERT INTO auto (autoID, autoNumber, mark, mudel, varv, v_aasta) VALUES (5, 'AV5603', 'Ford', 'Econoline E350', 'Khaki', 1999);
INSERT INTO auto (autoID, autoNumber, mark, mudel, varv, v_aasta) VALUES (6, 'AV6614', 'Ford', 'Transit Connect', 'Turquoise', 2012);
INSERT INTO auto (autoID, autoNumber, mark, mudel, varv, v_aasta) VALUES (7, 'KL3967', 'Morgan', 'Aero 8', 'Puce', 2006);
INSERT INTO auto (autoID, autoNumber, mark, mudel, varv, v_aasta) VALUES (8, 'UA6429', 'Ford', 'Bronco II', 'Mauv', 1986);
INSERT INTO auto (autoID, autoNumber, mark, mudel, varv, v_aasta) VALUES (9, 'SK9472', 'Honda', 'FCX Clarity', 'Khaki', 2012);
INSERT INTO auto (autoID, autoNumber, mark, mudel, varv, v_aasta) VALUES (10, 'BA8980', 'Mercury', 'Cougar', 'Mauv', 2000);
INSERT INTO auto (autoID, autoNumber, mark, mudel, varv, v_aasta) VALUES (11, 'LA9341', 'MINI', 'Clubman', 'Turquoise', 2009);
INSERT INTO auto (autoID, autoNumber, mark, mudel, varv, v_aasta) VALUES (12, 'QR6387', 'Maserati', 'Biturbo', 'Mauv', 1984);
INSERT INTO auto (autoID, autoNumber, mark, mudel, varv, v_aasta) VALUES (13, 'SK4443', 'Subaru', 'Outback', 'Pink', 2000);
INSERT INTO auto (autoID, autoNumber, mark, mudel, varv, v_aasta) VALUES (14, 'KL4860', 'Nissan', 'Maxima', 'Violet', 1994);
INSERT INTO auto (autoID, autoNumber, mark, mudel, varv, v_aasta) VALUES (15, 'SA7408', 'Mitsubishi', 'Montero', 'Violet', 1992);
INSERT INTO auto (autoID, autoNumber, mark, mudel, varv, v_aasta) VALUES (16, 'QF1757', 'Toyota', 'Matrix', 'Goldenrod', 2007);
INSERT INTO auto (autoID, autoNumber, mark, mudel, varv, v_aasta) VALUES (17, 'NH2788', 'GMC', '2500 Club Coupe', 'Turquoise', 1995);
INSERT INTO auto (autoID, autoNumber, mark, mudel, varv, v_aasta) VALUES (18, 'AZ1212', 'Subaru', 'Outback', 'Goldenrod', 2002);
INSERT INTO auto (autoID, autoNumber, mark, mudel, varv, v_aasta) VALUES (19, 'SK7231', 'Buick', 'Regal', 'Pink', 1992);
INSERT INTO auto (autoID, autoNumber, mark, mudel, varv, v_aasta) VALUES (20, 'LH7411', 'Mercedes-Benz', 'E-Class', 'Yellow', 1988);
INSERT INTO auto (autoID, autoNumber, mark, mudel, varv, v_aasta) VALUES (21, 'NH7554', 'Toyota', 'T100', 'Puce', 1996);
INSERT INTO auto (autoID, autoNumber, mark, mudel, varv, v_aasta) VALUES (22, 'KL4572', 'Land Rover', 'Range Rover', 'Puce', 2010);
INSERT INTO auto (autoID, autoNumber, mark, mudel, varv, v_aasta) VALUES (23, 'AC5771', 'Toyota', 'Tundra', 'Mauv', 2004);
INSERT INTO auto (autoID, autoNumber, mark, mudel, varv, v_aasta) VALUES (24, 'QR2909', 'Scion', 'tC', 'Fuscia', 2013);
INSERT INTO auto (autoID, autoNumber, mark, mudel, varv, v_aasta) VALUES (25, 'BA2226', 'BMW', '7 Series', 'Maroon', 2009);

-- Kõigi autode vaatamine
SELECT * FROM auto;

-- SORTEERIMINE
-- Kasvavas järjekorras (vaikimisi ASC)
SELECT * FROM auto ORDER BY v_aasta;

-- Kahanevas järjekorras
SELECT * FROM auto ORDER BY v_aasta DESC;

-- Ainult kahe veeru kuvamine
SELECT mark, mudel FROM auto;

-- Korduvate väärtuste välistamine DISTINCT
SELECT DISTINCT mark FROM auto;

-- FILTREERIMINE JA VÕRDLEMINE
-- Kõik autod aastast 2000 alates
SELECT mark, mudel, v_aasta FROM auto
WHERE v_aasta >= 2000;

-- Autod vahemikus 2000–2005 (BETWEEN)
SELECT mark, mudel, v_aasta FROM auto
WHERE v_aasta BETWEEN 2000 AND 2005;

-- Sama päring AND operaatoriga
SELECT mark, mudel, v_aasta FROM auto
WHERE v_aasta >= 2000 AND v_aasta <= 2005;

-- Kõik Fordi autod (täpne vaste)
SELECT mark, mudel, v_aasta FROM auto
WHERE mark LIKE 'Ford';

-- IN: kuvab mitu marki korraga
SELECT mark, mudel, v_aasta FROM auto
WHERE mark IN ('Ford', 'Nissan', 'Jeep');

-- Sama päring OR operaatoriga (ilma IN-ita)
SELECT mark, mudel, v_aasta FROM auto
WHERE mark LIKE 'Ford' OR mark LIKE 'Nissan' OR mark LIKE 'Jeep';

-- MUSTRIGA OTSIMINE (LIKE)
-- Mark algab tähega F
SELECT mark, mudel, v_aasta FROM auto
WHERE mark LIKE 'F%';

-- Mark lõpeb tähega p
SELECT mark, mudel, v_aasta FROM auto
WHERE mark LIKE '%p';

-- Mark sisaldab tähte a
SELECT mark, mudel, v_aasta FROM auto
WHERE mark LIKE '%a%';

-- TOP 5: esimesed 5 rohelist autot tähestikulises järjekorras
SELECT TOP 5 mudel, varv FROM auto
WHERE varv LIKE 'Green'
ORDER BY varv;

-- AGRЕГAATFUNKTSIOONID
-- COUNT: autode koguarv
SELECT COUNT(*) AS autodeArv FROM auto;

-- MAX: uusim valmistamisaasta
SELECT MAX(v_aasta) AS suuremAasta FROM auto;

-- AVG: keskmine valmistamisaasta margi kaupa
SELECT mark, AVG(v_aasta) AS keskmineAasta FROM auto
GROUP BY mark;
