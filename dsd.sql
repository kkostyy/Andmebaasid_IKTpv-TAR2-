create database IKTpv25_1_TAR;
use IKTpv25_1_TAR;

create table kasutaja(
kasutaja_id int primary key identity(1,1),
kasutajanimi varchar(25) not null,
parool char(10) not null);
select * from kasutaja;
insert into kasutaja(kasutajanimi, parool)
values ('oleg','testik');

--uus veeru lisamine
ALTER TABLE kasutaja ADD epost varchar(20);

UPDATE kasutaja SET epost='test@gmail.com' WHERE kasutaja_id = 1;

--veeru kustutamine
ALTER TABLE kasutaja DROP COLUMN epost;

--veeru andmetüübi muutmine
ALTER TABLE kasutaja ALTER COLUMN parool varchar(25);

--protseduuri tabeli muutmiseks loomine
create procedure alterTable
@valik varchar(20),
@tabeliNimi varchar(25),
@veeruNimi varchar(25),
@tyyp varchar(20)=null
as
begin
	DECLARE @sql as varchar(max)
	SET @sql = case
	when @valik = 'add' then 
	concat('ALTER TABLE ', @tabeliNimi, ' ADD ', @veeruNimi, ' ',@tyyp)
	when @valik = 'drop' then 
	concat('ALTER TABLE ', @tabeliNimi, ' DROP COLUMN ', @veeruNimi)
	when @valik = 'alter' then 
	concat('ALTER TABLE ', @tabeliNimi, ' ALTER COLUMN ', @veeruNimi, ' ', @tyyp)
	END;
	print @sql;
	BEGIN
	exec (@sql);
	END;
end;

--kutse
--liisamine
EXEC alterTable @valik = 'add', @tabeliNimi = 'kasutaja', @veeruNimi = 'elukoht', @tyyp = 'int';
--kustutamine
EXEC alterTable @valik = 'drop', @tabeliNimi = 'kasutaja', @veeruNimi = 'mobiil';
--veeru muutmine
EXEC alterTable @valik = 'alter', @tabeliNimi = 'kasutaja', @veeruNimi = 'elukoht', @tyyp = 'varchar(30)';

--procedure kustutamine
DROP PROCEDURE alterTable

--piirangud
--PK lisamine
CREATE TABLE city(
ID int not null,
cityName varchar(50));

SELECT * FROM city;

--PK lisamine
ALTER TABLE City
ADD CONSTRAINT pk_ID PRIMARY KEY(ID);

--UNIQUE lisamine
ALTER TABLE City
ADD CONSTRAINT cityName_unique UNIQUE(cityName);

--FK lisamine
ALTER TABLE kasutaja ALTER COLUMN elukoht int;
SELECT * FROM kasutaja;
ALTER TABLE kasutaja
ADD CONSTRAINT fk_city FOREIGN KEY(elukoht)
REFERENCES City(ID);
