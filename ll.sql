-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Loomise aeg: Märts 16, 2026 kell 09:00 EL
-- Serveri versioon: 10.4.32-MariaDB
-- PHP versioon: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Andmebaas: `ll`
--

DELIMITER $$
--
-- Toimingud
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `kustuta_tabel` (IN `p_tabeliNimi` VARCHAR(64))   BEGIN
    SET @sql = CONCAT('DROP TABLE IF EXISTS `', p_tabeliNimi, '`');
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `kustuta_zanr` (IN `p_zanrID` INT)   BEGIN
    DELETE FROM zanr WHERE zanrID = p_zanrID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `lisa_film` (IN `p_filmNimetus` VARCHAR(25), IN `p_zanrID` INT, IN `p_keelID` INT, IN `p_pikkus` INT, IN `p_rezisorID` INT, IN `p_filmtypeID` INT, IN `p_reklaam` TEXT)   BEGIN
    INSERT INTO film (filmNimetus, zanrID, keelID, pikkus, rezisorID, filmtypeID, reklaam)
    VALUES (p_filmNimetus, p_zanrID, p_keelID, p_pikkus, p_rezisorID, p_filmtypeID, p_reklaam);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `muuda_rezisor_struktuur` (IN `valik` VARCHAR(10), IN `veerunimi` VARCHAR(64), IN `veerutyyp` VARCHAR(50))   BEGIN
    SET @sql = CASE
        WHEN valik = 'add'  THEN CONCAT('ALTER TABLE rezisoor ADD COLUMN `', veerunimi, '` ', veerutyyp)
        WHEN valik = 'drop' THEN CONCAT('ALTER TABLE rezisoor DROP COLUMN `', veerunimi, '`')
    END;
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `uuenda_rezisor` (IN `p_rezisoorID` INT, IN `p_eesnimi` VARCHAR(25), IN `p_perenimi` VARCHAR(25))   BEGIN
    UPDATE rezisoor SET eesnimi = p_eesnimi, perenimi = p_perenimi
    WHERE rezisoorID = p_rezisoorID;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `film`
--

CREATE TABLE `film` (
  `filmID` int(11) NOT NULL,
  `filmNimetus` varchar(25) NOT NULL,
  `zanrID` int(11) NOT NULL,
  `keelID` int(11) NOT NULL,
  `pikkus` int(11) NOT NULL,
  `rezisorID` int(11) NOT NULL,
  `filmtypeID` int(11) NOT NULL,
  `reklaam` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `film`
--

INSERT INTO `film` (`filmID`, `filmNimetus`, `zanrID`, `keelID`, `pikkus`, `rezisorID`, `filmtypeID`, `reklaam`) VALUES
(1, 'Pulp Fiction', 8, 1, 154, 1, 1, ''),
(2, 'Vabastatud Django', 1, 1, 165, 1, 2, ''),
(3, 'Ongi Karloson!', 4, 2, 80, 2, 2, ''),
(4, 'Roheline elevant', 7, 2, 86, 3, 1, ''),
(5, 'Kaardid, rahad, kaks püst', 4, 3, 107, 5, 2, ''),
(11, 'Sipsik', 3, 2, 120, 5, 1, 'hea film');

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `filmtype`
--

CREATE TABLE `filmtype` (
  `filmTypeID` int(11) NOT NULL,
  `filmType` varchar(25) NOT NULL,
  `kirjeldus` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `filmtype`
--

INSERT INTO `filmtype` (`filmTypeID`, `filmType`, `kirjeldus`) VALUES
(1, '2D', '2D-arvutigraafika on pildi esitamine digitaalsete kahemõõtmeliste mudelitena, näiteks tasandilise geomeetria ja teksti abil.'),
(2, '3D', '3D-arvutigraafika on pildi esitamine digitaalsete kolmemõõtmeliste mudelitena, näiteks ruumilise geomeetria abil.\r\n\r\n3D-mudel on kolmemõõtmelise objekti matemaatiline esitus. Mudelit saab kuvada kahemõõtmelisena 3D-renderdamise kaudu või kasutada mittevisuaalse arvutisimulatsiooni või arvutuste jaoks. On olemas ka 3D-arvutigraafika tarkvara.'),
(3, '4D', '3D-arvutigraafika lisaeffektidega.');

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `keel`
--

CREATE TABLE `keel` (
  `keelID` int(11) NOT NULL,
  `keelNimi` varchar(25) NOT NULL,
  `keelNimiVene` varchar(25) NOT NULL,
  `keelNimiInglise` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `keel`
--

INSERT INTO `keel` (`keelID`, `keelNimi`, `keelNimiVene`, `keelNimiInglise`) VALUES
(1, 'Eesti', 'Эстонский', 'Estonian'),
(2, 'Vene', 'Русский', 'Russian'),
(3, 'Inglise', 'Английский', 'English'),
(4, 'Saksa', 'Немецкий', 'German'),
(5, 'Prantsuse', 'Французский', 'French');

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `kinokava`
--

CREATE TABLE `kinokava` (
  `kinokavaID` int(11) NOT NULL,
  `kuupaev` datetime DEFAULT NULL,
  `filmNimetus` int(11) DEFAULT NULL,
  `pilethind` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `kinokava`
--

INSERT INTO `kinokava` (`kinokavaID`, `kuupaev`, `filmNimetus`, `pilethind`) VALUES
(1, '2020-03-20 16:20:00', 5, 5),
(2, '2020-03-17 20:00:00', 1, 8),
(3, '2020-03-18 13:00:00', 4, 2),
(4, '2020-03-19 20:00:00', 2, 7),
(5, '2020-03-21 21:00:00', 3, 4);

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `piletimyyk`
--

CREATE TABLE `piletimyyk` (
  `piletimyykID` int(11) NOT NULL,
  `kogus` int(11) NOT NULL,
  `kinokavaID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `piletimyyk`
--

INSERT INTO `piletimyyk` (`piletimyykID`, `kogus`, `kinokavaID`) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 5);

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `rezisoor`
--

CREATE TABLE `rezisoor` (
  `rezisoorID` int(11) NOT NULL,
  `eesnimi` varchar(25) DEFAULT NULL,
  `perenimi` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `rezisoor`
--

INSERT INTO `rezisoor` (`rezisoorID`, `eesnimi`, `perenimi`) VALUES
(1, 'Quentin', 'Tarantino'),
(2, 'Sarik', 'Andreasjan'),
(3, 'Svetlana', 'Baskova'),
(4, 'Michael', 'Bay'),
(5, 'Guy', 'Ritchie'),
(6, 'Woody', 'Allen');

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `zanr`
--

CREATE TABLE `zanr` (
  `zanrID` int(11) NOT NULL,
  `zanrNimi` varchar(25) NOT NULL,
  `zanrKirjeldus` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `zanr`
--

INSERT INTO `zanr` (`zanrID`, `zanrNimi`, `zanrKirjeldus`) VALUES
(1, 'Draama', 'Tõsise teema, sisu, ainestiku ja süžeega, realistlikus elu- ja tegevuskeskkonnas ning usutavates elusituatsioonides tegutsevate realistlike tegelastega lavastatud filmiteos, mis on rajatud filmikangelaste (aktiivsele) suhtlemisele, tegevusele, karakterite muutumisele ja arengule. Tavaliselt ei kasutata filmiefekte, komöödia- või märulielemente. Väga levinud filmižanr, mille peamised alaliigid on melodraama, ajalooline (eepiline) draama, romantiline draama ja elulooline film, mida on käesolevas loendis käsitletud eraldiseisvate kategooriatena.'),
(2, 'Fantaasia', 'Žanr, milles toimub või kujundatud midagi ebareaalne elus.'),
(3, 'Animatsioon', 'Teemad on enamasti mõeldud lastele ja käsitlus on lastepärane ja lastele lihtsalt arusaadav ja mõistetav. Filmi kangelased on tavaliselt lapsed, nende vanemad (kes vahel asuvad kaugel või on tegu), loomad, ka kurjad tegelased, kellest tuleneb oht.'),
(4, 'Komöödia', 'Komöödiafilm on enamasti kergema sisu ja tahtlikult meelelahutusliku, publikut lõbustava, lõõgastava ja naerma ajava eesmärgiga tehtud filmiteos rõhutatult, liialdatult ja ülemäärase situatsioonilahenduse, keelekasutuse, tegevuse, suhete ja karakteritega.'),
(5, 'Krimi', 'Krimi- ja gangsterfilmide tegevus hargneb kriminaalkurjategijate, kuritegelike jõukude ja sündikaatide, enamasti pangaröövlite, allmaailma tegelaste ja pättide ümber, kes tegutsevad väljaspool seadust, tegelevad narkootikumidega, võitlevad omavahel, varastavad ja tapavad. Film keskendub enamasti kurjategijate mõttemaailmale, ambitsioonidele, suurusehullustusele ja kompleksidele, mis lõpuks viivad nende hukkumiseni. Sageli liigitatakse need krimifilme sarnasuse tõttu ka film noir või detektiiv/uurijafilmideks. Sellesse kategooriasse peaks paigutama ka filmid sarimõrvaritest. Sageli soovitatakse kasutada (kui võimalik) spetsiifilisemad žanrimääratlusi: röövlifilm, film noir, gangsterifilm, uurijafilm, politseifilm või põnevusfilm '),
(6, 'Müsteerium', 'Detektiiv/uurijafilmi peetakse tavaliselt kriminaalfilmi (krimifilmi), film noir või põnevusfilmi (põneviku) alaliigiks. Film põhineb enamasti lahendamata mõrva või kadumise loo uurimisele, filmi peategelaseks on tugeva ja omapärase karakteri ja tegutsemisviisiga detektiiv-uurija, kes tegutseb metoodiliselt ja sihikindlalt kurjategija või mõrvari tabamiseks.'),
(7, 'Õudus', 'Filmilavastused, mis tegelevad elu varjatud, tundmatu, keelatud, üleloomuliku või seletamatu poolega, kutsuvad esile varjatud alateadvuslikku pinget, kartust, hirmutunnet või õudust, millel on reeglina hirmus või šokeeriv lõpplahendus, kuid mis samal ajal köidavad vaatajat ja lahutavad meelt siduva vaatamispinge tekitamise, kaasaelamise ja tugeva läbielamise (katarsise) kaudu. Filmide stilistika on mitmekesine, ulatudes õudusfilmide klassikast (Nosferatu) kuni arvutites loodud üleloomulike lugudeni. Õudusfilmides tegutsevad kummitused, vaimud, libahundid, zombid, vampiirid, saatanad, monstrumid.   Nüüdisajal on õudusfilmi žanr sageli kombineeritud ulmefilmiga, kus monstrumeid sünnitab tehnoloogiline viga, väärkäsitlus, võimu-, raha- või kättemaksiha, korruptsioon või Maad ohustavad tulnukad. Õudusfilmides võib leida sarnaseid elemente muinasjuttfilmide ja üleloomulikele nähtustele rajatud filmidega. Õudusfilmidel on mitmeid alaliike: filmid lõikujatest, sarimõrvaritest, noorteõudukad, satanismifilmid, Dracula, Frankenstein jm. Vajadusel tuleks kasutada lisamääranguid (sagedasemad Ulmefilm, Üleloomulik film).         '),
(8, 'Thriller', 'Põnevusfilmid on enamasti žanrihübriidid – esineb märulipõnevik (Action-Thriller), krimipõnevik (Crime-Caper-Thriller), vesternipõnevik (Western-Thriller), film noir põnevik, isegi romantilise komöödia põnevik (Romantic comedy-Thriller). Põnevikud on lähedalt seotud õudusfilmižanriga. Põnevikud haaravad sellega, et kutsuvad esile intensiivse erutuse, pakuvad põnevust ja kaasaelamisvõimalust, tekitavad rahutut ootust ja närvesöövat pinget. Põnevikud on sageli seotud krimiteemaga, ent põhirõhk ei ole detektiividel, gangsteritel, röövlitel, isegi krimiaktil mitte. Selle asemel fokuseerub narratiiv põnevusel, mis tuleneb sellest, et indiviid või grupp tegelasi on ohtlikkus olukorras, millest pääsemine sõltub juhuslikust saatuse pöördest. Sageli on filmiteemaks poliitiline vandenõu, terrorism, süütu süüdistatava põgenemine, mõrvani viiv armukolmnurk, psüühikahäiretega tegelased.'),
(9, 'Seiklus', 'Enamasti köitvad filmilavastused eksootilistes paikades, seotud uue kogemuse ja tundmatu avastamisega, sageli sarnane märuližanriga. Tegutsevad uljad ja julged inimesed, tegemist võib olla eepilistele ja ajaloolistele filmidele omaste lahendustega (kus kangelased on sageli julged, altruistlikud, patriootilised inimesed, kes tegutsevad oma ideaalide nimel), kadunud kontinentide otsimise, džungli- ja kõrbefilmidega, aaretejahiga, katastroofide, otsingute ja avastamisega, võitlusega vabaduse eest ja vallutajate vastu, püüdega aidata taastada õiglust ja mõistlikku ühiskonnakorraldust jms.   LOC žanrinimistu: seotud sisu- ja žanrikategooriad: seiklusfilm, antiikmaailma film, loomafilm, lennundusaineline film, röövlifilm, krimifilm, katastrooffilm, spioonifilm, muinasjuttfilm, gangsterifilm, džunglifilm, võitluskunstide film, uurijafilm, politseifilm, eelajalooline film, vanglafilm, ulmefilm, laulev kauboi, spordifilm, ellujäämise film, õudusfilm, sõjafilm, vestern. '),
(10, 'Action', 'Aktiivse, enamasti katkematu tegevusega, paljude kaskadöörinippidega filmid, tagaajamise ja jälitamisega, võitluse, päästeaktsioonide, lahingute, põgenemiste, kriiside ja katastroofidega (üleujutused, plahvatused, loodusõnnetused), võitluskunste kasutavad, seikluslikud, köitva rütmi ja tempoga ning vastuoluliste positiivsete kangelastega, kes võitlevad halbade vastu. Loodud ennekõike vaataja köitmise ja meelelahutuse eesmärgil. ');

--
-- Indeksid tõmmistatud tabelitele
--

--
-- Indeksid tabelile `film`
--
ALTER TABLE `film`
  ADD PRIMARY KEY (`filmID`),
  ADD KEY `zanr_fk` (`zanrID`),
  ADD KEY `rezisor_fk` (`rezisorID`),
  ADD KEY `filmtype_fk` (`filmtypeID`),
  ADD KEY `keel_fk` (`keelID`);

--
-- Indeksid tabelile `filmtype`
--
ALTER TABLE `filmtype`
  ADD PRIMARY KEY (`filmTypeID`);

--
-- Indeksid tabelile `keel`
--
ALTER TABLE `keel`
  ADD PRIMARY KEY (`keelID`);

--
-- Indeksid tabelile `kinokava`
--
ALTER TABLE `kinokava`
  ADD PRIMARY KEY (`kinokavaID`),
  ADD KEY `film_fk` (`filmNimetus`);

--
-- Indeksid tabelile `piletimyyk`
--
ALTER TABLE `piletimyyk`
  ADD PRIMARY KEY (`piletimyykID`),
  ADD KEY `kinokava_fk` (`kinokavaID`);

--
-- Indeksid tabelile `rezisoor`
--
ALTER TABLE `rezisoor`
  ADD PRIMARY KEY (`rezisoorID`);

--
-- Indeksid tabelile `zanr`
--
ALTER TABLE `zanr`
  ADD PRIMARY KEY (`zanrID`);

--
-- AUTO_INCREMENT tõmmistatud tabelitele
--

--
-- AUTO_INCREMENT tabelile `film`
--
ALTER TABLE `film`
  MODIFY `filmID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT tabelile `filmtype`
--
ALTER TABLE `filmtype`
  MODIFY `filmTypeID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT tabelile `keel`
--
ALTER TABLE `keel`
  MODIFY `keelID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT tabelile `kinokava`
--
ALTER TABLE `kinokava`
  MODIFY `kinokavaID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT tabelile `piletimyyk`
--
ALTER TABLE `piletimyyk`
  MODIFY `piletimyykID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT tabelile `rezisoor`
--
ALTER TABLE `rezisoor`
  MODIFY `rezisoorID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT tabelile `zanr`
--
ALTER TABLE `zanr`
  MODIFY `zanrID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Tõmmistatud tabelite piirangud
--

--
-- Piirangud tabelile `film`
--
ALTER TABLE `film`
  ADD CONSTRAINT `filmtype_fk` FOREIGN KEY (`filmtypeID`) REFERENCES `filmtype` (`filmTypeID`),
  ADD CONSTRAINT `keel_fk` FOREIGN KEY (`keelID`) REFERENCES `keel` (`keelID`),
  ADD CONSTRAINT `rezisor_fk` FOREIGN KEY (`rezisorID`) REFERENCES `rezisoor` (`rezisoorID`),
  ADD CONSTRAINT `zanr_fk` FOREIGN KEY (`zanrID`) REFERENCES `zanr` (`zanrID`);

--
-- Piirangud tabelile `kinokava`
--
ALTER TABLE `kinokava`
  ADD CONSTRAINT `film_fk` FOREIGN KEY (`filmNimetus`) REFERENCES `film` (`filmID`);

--
-- Piirangud tabelile `piletimyyk`
--
ALTER TABLE `piletimyyk`
  ADD CONSTRAINT `kinokava_fk` FOREIGN KEY (`kinokavaID`) REFERENCES `kinokava` (`kinokavaID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
