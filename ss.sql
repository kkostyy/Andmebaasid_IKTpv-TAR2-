CREATE DATABASE gaponenkoSQL;
use gaponenkoSQL;

create table auto (
	autoID INT PRIMARY KEY,
	autoNumber CHAR(6)not null,
	mark VARCHAR(50)not null,
	mudel VARCHAR(50),
	varv VARCHAR(50),
	v_aasta int
);
insert into auto (autoID, autoNumber, mark, mudel, varv, v_aasta) values (1, 'BA7952', 'Hyundai', 'Elantra', 'Pink', 2003);
insert into auto (autoID, autoNumber, mark, mudel, varv, v_aasta) values (2, 'QR4818', 'Chevrolet', 'Suburban 2500', 'Green', 2003);
insert into auto (autoID, autoNumber, mark, mudel, varv, v_aasta) values (3, 'DL4964', 'Lexus', 'SC', 'Aquamarine', 1996);
insert into auto (autoID, autoNumber, mark, mudel, varv, v_aasta) values (4, 'AC9772', 'Lexus', 'SC', 'Green', 1997);
insert into auto (autoID, autoNumber, mark, mudel, varv, v_aasta) values (5, 'AV5603', 'Ford', 'Econoline E350', 'Khaki', 1999);
insert into auto (autoID, autoNumber, mark, mudel, varv, v_aasta) values (6, 'AV6614', 'Ford', 'Transit Connect', 'Turquoise', 2012);
insert into auto (autoID, autoNumber, mark, mudel, varv, v_aasta) values (7, 'KL3967', 'Morgan', 'Aero 8', 'Puce', 2006);
insert into auto (autoID, autoNumber, mark, mudel, varv, v_aasta) values (8, 'UA6429', 'Ford', 'Bronco II', 'Mauv', 1986);
insert into auto (autoID, autoNumber, mark, mudel, varv, v_aasta) values (9, 'SK9472', 'Honda', 'FCX Clarity', 'Khaki', 2012);
insert into auto (autoID, autoNumber, mark, mudel, varv, v_aasta) values (10, 'BA8980', 'Mercury', 'Cougar', 'Mauv', 2000);
insert into auto (autoID, autoNumber, mark, mudel, varv, v_aasta) values (11, 'LA9341', 'MINI', 'Clubman', 'Turquoise', 2009);
insert into auto (autoID, autoNumber, mark, mudel, varv, v_aasta) values (12, 'QR6387', 'Maserati', 'Biturbo', 'Mauv', 1984);
insert into auto (autoID, autoNumber, mark, mudel, varv, v_aasta) values (13, 'SK4443', 'Subaru', 'Outback', 'Pink', 2000);
insert into auto (autoID, autoNumber, mark, mudel, varv, v_aasta) values (14, 'KL4860', 'Nissan', 'Maxima', 'Violet', 1994);
insert into auto (autoID, autoNumber, mark, mudel, varv, v_aasta) values (15, 'SA7408', 'Mitsubishi', 'Montero', 'Violet', 1992);
insert into auto (autoID, autoNumber, mark, mudel, varv, v_aasta) values (16, 'QF1757', 'Toyota', 'Matrix', 'Goldenrod', 2007);
insert into auto (autoID, autoNumber, mark, mudel, varv, v_aasta) values (17, 'NH2788', 'GMC', '2500 Club Coupe', 'Turquoise', 1995);
insert into auto (autoID, autoNumber, mark, mudel, varv, v_aasta) values (18, 'AZ1212', 'Subaru', 'Outback', 'Goldenrod', 2002);
insert into auto (autoID, autoNumber, mark, mudel, varv, v_aasta) values (19, 'SK7231', 'Buick', 'Regal', 'Pink', 1992);
insert into auto (autoID, autoNumber, mark, mudel, varv, v_aasta) values (20, 'LH7411', 'Mercedes-Benz', 'E-Class', 'Yellow', 1988);
insert into auto (autoID, autoNumber, mark, mudel, varv, v_aasta) values (21, 'NH7554', 'Toyota', 'T100', 'Puce', 1996);
insert into auto (autoID, autoNumber, mark, mudel, varv, v_aasta) values (22, 'KL4572', 'Land Rover', 'Range Rover', 'Puce', 2010);
insert into auto (autoID, autoNumber, mark, mudel, varv, v_aasta) values (23, 'AC5771', 'Toyota', 'Tundra', 'Mauv', 2004);
insert into auto (autoID, autoNumber, mark, mudel, varv, v_aasta) values (24, 'QR2909', 'Scion', 'tC', 'Fuscia', 2013);
insert into auto (autoID, autoNumber, mark, mudel, varv, v_aasta) values (25, 'BA2226', 'BMW', '7 Series', 'Maroon', 2009);
SELECT * FROM auto

--andmete sorteerimine
--kasvavas järejekoras ASC
SELECT * FROM auto
ORDER BY v_aasta;
--kahanevas järejekoras
SELECT * FROM auto
ORDER BY v_aasta DESC;
--kuvab ainult kaks vergu
SELECT mark, mudel FROM auto;
--kordavate väärtuste  välistamine  DISTINCT
SELECT DISTINCT mark FROM auto;

--võrdlemine
--1. suurem  kui >, väiksem kui <, võrdub = 
--leia kõik autod , kus on v_aasta 2000 peale
SELECT mark, mudel,v_aasta FROM auto
WHERE v_aasta >= 2000;

--leia kõik autod mis on v_aasta vahemikus 2000-2005
--1.
SELECT mark, mudel,v_aasta FROM auto
WHERE v_aasta BETWEEN 2000 AND 2005;
--2.
SELECT mark, mudel,v_aasta FROM auto
WHERE v_aasta >= 2000 AND v_aasta <= 2005;

-- võrdlemine tekst või sümbooliga 
--kuvab kõik ford´i autod
SELECT mark, mudel,v_aasta FROM auto
WHERE mark LIKE 'Ford';

--IN lause kuvab vastavus loetelus
SELECT mark, mudel,v_aasta FROM auto
WHERE mark IN ('Ford', 'Nissan', 'Jeep');

--ilma IN
SELECT mark, mudel,v_aasta FROM auto
WHERE mark LIKE 'Ford' OR mark LIKE 'Nissan' OR mark LIKE 'Jeep';

--vastavus mustrile
--algab F tähega
SELECT mark, mudel,v_aasta FROM auto
WHERE mark LIKE 'F%';

--lõpeb p tähega
SELECT mark, mudel,v_aasta FROM auto
WHERE mark LIKE '%p';

--sisaldab a täht
SELECT mark, mudel,v_aasta FROM auto
WHERE mark LIKE '%a%';

--kuvada esimest 5 mudeli
SELECT * FROM auto;
SELECT TOP 5 mudel, varv
FROM auto
WHERE varv like 'Green'
Order by varv;

--agregaat funktsioonid: SUM, MIN, MAX, AVG, COUNT
--COUNT
SELECT COUNT(*) AS autodeArv FROM auto;
--MAX
SELECT MAX(v_aasta) AS suuremAasta FROM auto;
--AVG
SELECT mark, AVG(v_aasta) AS keskmineAasta FROM auto
GROUP By mark;

