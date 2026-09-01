Create database kordamineIKT25
use kordamineIKT25;
CREATE TABLE opilane(
opilaneId int Primary Key identity(1,1),
nimi varchar(50),
isikukood char(11) not null,
ryhmId int);

CREATE TABLE ryhm(
ryhmID int primary key identity(1,1),
ryhmNimi char(10) unique,
opilasteArv int);

--tabeli kustutamine
drop table opilane;
--valisvõiti - FK
alter table opilane add foreign key (ryhmId) references ryhm(ryhmID);
--õiguste määramine varem tehtud kasutajale
GRANT SELECT TO opilaneGap; -- saab vaadata kõik tabelist
GRANT INSERT ON opilane TO opilaneGap;-- saab losada ainult tabelisse opilane
DENY DELETE TO opilaneGap;

--------------------------------------------------------------------------------
use kordamineIKT25
select * from opilane, ryhm
where opilane.ryhmId=ryhm.ryhmId;

Delete from opilane;

insert into opilane values('Nikita', '14882285267', 1);
