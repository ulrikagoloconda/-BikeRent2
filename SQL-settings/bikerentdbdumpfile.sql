CREATE DATABASE  IF NOT EXISTS `bikerentdb` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `bikerentdb`;
-- MySQL dump 10.13  Distrib 5.7.9, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: bikerentdb
-- ------------------------------------------------------
-- Server version	5.7.11-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `alterduser`
--

DROP TABLE IF EXISTS `alterduser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alterduser` (
  `alterID` int(10) NOT NULL AUTO_INCREMENT,
  `userID` int(10) NOT NULL,
  `alterDate` date NOT NULL,
  `fname` varchar(40) DEFAULT NULL,
  `lname` varchar(40) DEFAULT NULL,
  `memberlevel` int(10) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `phone` int(11) DEFAULT NULL,
  `username` varchar(40) NOT NULL,
  `passw` varbinary(56) DEFAULT NULL,
  PRIMARY KEY (`alterID`),
  KEY `useridalter_fk` (`userID`),
  CONSTRAINT `useridalter_fk` FOREIGN KEY (`userID`) REFERENCES `bikeuser` (`userID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bike`
--

DROP TABLE IF EXISTS `bike`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bike` (
  `bikeID` int(11) NOT NULL AUTO_INCREMENT,
  `brandid` int(11) DEFAULT NULL,
  `modelyear` smallint(6) DEFAULT NULL,
  `color` varchar(50) DEFAULT NULL,
  `image` longblob,
  `size` smallint(6) DEFAULT NULL,
  `insertDateTime` datetime DEFAULT NULL,
  `typeID` int(10) DEFAULT NULL,
  `imageFileName` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`bikeID`),
  KEY `bikebrand_fk` (`brandid`),
  KEY `biketype_fk` (`typeID`),
  CONSTRAINT `bikebrand_fk` FOREIGN KEY (`brandid`) REFERENCES `brand` (`brandid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `biketype_fk` FOREIGN KEY (`typeID`) REFERENCES `type` (`typeID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `bike_object`
--

DROP TABLE IF EXISTS `bike_object`;
/*!50001 DROP VIEW IF EXISTS `bike_object`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `bike_object` AS SELECT 
 1 AS `bikeID`,
 1 AS `modelyear`,
 1 AS `color`,
 1 AS `image`,
 1 AS `imageFileName`,
 1 AS `size`,
 1 AS `typeName`,
 1 AS `brandname`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `bikeuser`
--

DROP TABLE IF EXISTS `bikeuser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bikeuser` (
  `userID` int(10) NOT NULL AUTO_INCREMENT,
  `fname` varchar(40) DEFAULT NULL,
  `lname` varchar(40) DEFAULT NULL,
  `memberlevel` int(10) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `phone` int(11) DEFAULT NULL,
  `username` varchar(40) NOT NULL,
  `passw` varbinary(56) DEFAULT NULL,
  `memberSince` date DEFAULT NULL,
  PRIMARY KEY (`userID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER alterTrigger BEFORE UPDATE ON bikeuser
  FOR EACH ROW
BEGIN
  INSERT INTO alterdUser (userID, alterDate, fname, lname, memberlevel, email, phone, username, passw)
  VALUES(old.userID, NOW(), old.fname, old.lname, old.memberlevel,
         old.email, old.phone, old.username, AES_ENCRYPT( old.passw,'tackforkaffet'));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `brand`
--

DROP TABLE IF EXISTS `brand`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `brand` (
  `brandid` int(11) NOT NULL AUTO_INCREMENT,
  `brandname` varchar(50) DEFAULT NULL,
  `comments` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`brandid`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `errorevent`
--

DROP TABLE IF EXISTS `errorevent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `errorevent` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `errortext` varchar(10000) DEFAULT NULL,
  `userID` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `event_occured`
--

DROP TABLE IF EXISTS `event_occured`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_occured` (
  `eventid` int(11) NOT NULL AUTO_INCREMENT,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `message` varchar(200) DEFAULT NULL,
  `rand_int` int(11) DEFAULT NULL,
  PRIMARY KEY (`eventid`)
) ENGINE=InnoDB AUTO_INCREMENT=141 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rentbridge`
--

DROP TABLE IF EXISTS `rentbridge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rentbridge` (
  `rentID` int(10) NOT NULL AUTO_INCREMENT,
  `userID` int(10) NOT NULL,
  `bikeID` int(11) NOT NULL,
  `dayOfRent` date NOT NULL,
  `dayOfReturn` date DEFAULT NULL,
  `dayOfActualReturn` date DEFAULT NULL,
  PRIMARY KEY (`rentID`),
  KEY `userrent_fk` (`userID`),
  KEY `bikerent_fk` (`bikeID`),
  CONSTRAINT `bikerent_fk` FOREIGN KEY (`bikeID`) REFERENCES `bike` (`bikeID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `userrent_fk` FOREIGN KEY (`userID`) REFERENCES `bikeuser` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER delay_trigger BEFORE UPDATE ON rentbridge
FOR EACH ROW
  BEGIN
    DECLARE diff INT(11);
      SET diff = DATEDIFF(old.dayOfReturn, new.dayOfActualReturn);
    IF (diff < 0)
    THEN
      INSERT INTO returnDelay (rentID, userID, numberOfDayDelay)
      VALUES (old.rentID, old.userID, DATEDIFF(old.dayOfReturn, new.dayOfActualReturn));
    END IF;
  END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `returndelay`
--

DROP TABLE IF EXISTS `returndelay`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `returndelay` (
  `delayID` int(11) NOT NULL AUTO_INCREMENT,
  `rentID` int(10) NOT NULL,
  `userID` int(10) NOT NULL,
  `numberOfDayDelay` int(11) DEFAULT NULL,
  PRIMARY KEY (`delayID`),
  KEY `rentdelay_fk` (`rentID`),
  KEY `userdelay_fk` (`userID`),
  CONSTRAINT `rentdelay_fk` FOREIGN KEY (`rentID`) REFERENCES `rentbridge` (`rentID`) ON UPDATE CASCADE,
  CONSTRAINT `userdelay_fk` FOREIGN KEY (`userID`) REFERENCES `bikeuser` (`userID`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `type`
--

DROP TABLE IF EXISTS `type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `type` (
  `typeID` int(10) NOT NULL AUTO_INCREMENT,
  `typeName` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`typeID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping events for database 'bikerentdb'
--
/*!50106 SET @save_time_zone= @@TIME_ZONE */ ;
/*!50106 DROP EVENT IF EXISTS `update_memberlevel_event` */;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8 */ ;;
/*!50003 SET character_set_results = utf8 */ ;;
/*!50003 SET collation_connection  = utf8_general_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`localhost`*/ /*!50106 EVENT `update_memberlevel_event` ON SCHEDULE EVERY 12 HOUR STARTS '2016-10-25 09:42:18' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
  CALL update_memberlevel();
END */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
DELIMITER ;
/*!50106 SET TIME_ZONE= @save_time_zone */ ;

--
-- Dumping routines for database 'bikerentdb'
--
/*!50003 DROP FUNCTION IF EXISTS `insert_new_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `insert_new_user`(in_fname varchar(50),in_lname varchar(11),in_memberlevel varchar(11),in_email varchar(50),in_phone varchar(11),in_username varchar(11), in_passw varchar(50)) RETURNS smallint(6)
BEGIN
    DECLARE pw VARBINARY(56);
    DECLARE userNameAvalible VARCHAR(11);
    if exists(SELECT username FROM bikeuser WHERE userName=in_username)
    THEN
      RETURN 0;
    ELSE
      INSERT INTO bikeuser (fname, lname, memberlevel, email, phone , username , passw , membersince)
      VALUES (in_fname, in_lname, in_memberlevel, in_email, in_phone , in_username , AES_ENCRYPT(in_passw,'tackforkaffet') , CURDATE());
      RETURN 1;
    END IF;
  END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `update_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `update_user`(in_fname varchar(50),in_lname varchar(50),in_memberlevel varchar(50),in_email varchar(50),in_phone varchar(50),in_username varchar(50), in_passw varchar(50)) RETURNS smallint(6)
BEGIN
    DECLARE pw VARBINARY(56);
    DECLARE userNameAvalible VARCHAR(50);
    if exists(SELECT username FROM bikeuser WHERE userName=in_username)
    THEN
      UPDATE bikeuser SET fname = in_fname, lname = in_lname, email = in_email, memberlevel = in_memberlevel, phone = in_phone, passw = AES_ENCRYPT(in_passw,'tackforkaffet')
      WHERE username = in_username;
      RETURN 1;
    ELSE
      RETURN 0;
    END IF;
  END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `check_password_get_bikeuser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `check_password_get_bikeuser`(
  IN tryusername varchar(50),
  IN trypassword varchar(50),
  OUT message INT(10))
BEGIN
DECLARE id INT(10);
SET id = (SELECT userID FROM bikeuser WHERE username = tryusername AND passw = AES_ENCRYPT(trypassword,'tackforkaffet') );
    if (id > 0)
    THEN
      SELECT * FROM bikeuser WHERE userID = id;
      SET message = id;
    ELSE
      SET message = -50;
    END IF;
  END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_bike` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_bike`(IN idIn INT(11))
BEGIN
    DELETE FROM bike WHERE bikeID=idIn; 
  END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `execute_bike_loan` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `execute_bike_loan`(
  IN userIDIn INTEGER(10),
  IN bikeIDIn INTEGER(11),
  IN dayOfLoanIn DATE,
  OUT expReturn DATE)
BEGIN
    SET expReturn = (SELECT DATE_ADD(dayOfLoanIn, INTERVAL 1 MONTH));
    INSERT INTO rentbridge
    (userID, bikeID,dayOfRent, dayOfReturn)
    VALUE (userIDIn, bikeIDIn, dayOfLoanIn, expReturn);

  END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getUserFromUserName` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getUserFromUserName`(in_username varchar(50))
BEGIN
    SELECT * FROM bikeuser
    WHERE username = in_username;
  END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_all_bikes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_bikes`()
BEGIN
    SELECT bike.bikeID, bike.modelyear, bike.color, bike.size, bike.modelyear, brand.brandname, type.typeName
    FROM bike
      JOIN type ON bike.typeID = type.typeID
      JOIN brand On bike.brandid = brand.brandid;
  END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_bike_returnedDate_from_ID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_bike_returnedDate_from_ID`(IN bikeIDIn INT(11))
BEGIN
SELECT bike.bikeID, brand.brandname, type.typeName, bike.modelyear, bike.color, bike.image, bike.size,
  rentbridge.dayOfRent, rentbridge.dayOfActualReturn
from bike
  JOIN brand
    ON bike.brandid = brand.brandid
  JOIN type
    ON bike.typeID = type.typeID
  LEFT JOIN rentbridge
  ON bike.bikeID = rentbridge.bikeID
WHERE bike.bikeID=bikeIDIn;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_bike` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_bike`(IN brandNameIn VARCHAR(50),
                                                          IN typeIn VARCHAR(30),
                                                          IN modelYearIn SMALLINT(6),
                                                          IN colorIn VARCHAR(50),
                                                          IN sizeIn SMALLINT(6),
                                                          IN imageIn LONGBLOB)
BEGIN
    DECLARE brandIDDec INT(11);
    DECLARE typeIDDec INT(10);

    IF EXISTS(SELECT DISTINCT brandid FROM brand WHERE brandname=brandNameIn)
    THEN
      SET brandIDDec = (SELECT DISTINCT brandid FROM brand WHERE brandname=brandNameIn);
    ELSE
      INSERT INTO brand (brandname) VALUE (brandNameIn) ;
      SELECT DISTINCT last_insert_id() INTO brandIDDec FROM brand;
    END IF;
    IF EXISTS(SELECT DISTINCT typeID FROM type WHERE typeName=typeIn)
    THEN
      SET typeIDDec = (SELECT DISTINCT typeID FROM type WHERE typeName=typeIn);
    ELSE
      INSERT INTO type (typeName)VALUE (typeIn);

    END IF;

    INSERT INTO bike (brandid, modelyear, color, size, insertDateTime, typeID,image)
    VALUES (brandIDDec, modelYearIn, colorIn, sizeIn, CURRENT_TIMESTAMP(),typeIDDec,imageIn );
  END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `return_bike` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `return_bike`(
  IN bikeIDin INTEGER(11),
  IN userIDIn INTEGER(11))
BEGIN
    DECLARE tempRentID INTEGER(10);
    if exists(SELECT rentID  FROM rentbridge  WHERE userID=userIDIn AND bikeID=bikeIDin AND dayOfActualReturn is null )
    THEN
      Set tempRentID = (SELECT rentID FROM rentbridge WHERE userID=userIDIn AND bikeID=bikeIDin AND dayOfActualReturn is null);
      UPDATE rentbridge SET dayOfActualReturn=NOW() WHERE rentID=tempRentID;
      SELECT  'det funkar ';
    ELSE
      SELECT 'Inget lån matchar kriterierna';
    END IF;
  END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `search_available_bikes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `search_available_bikes`()
BEGIN
    SELECT  * FROM bike_object
      LEFT JOIN rentbridge ON bike_object.bikeID = rentbridge.bikeID
    WHERE not EXISTS
    (SELECT 1 FROM rentbridge WHERE bikeID = bike_object.bikeID AND dayOfActualReturn is null)
    GROUP BY bike_object.bikeID;
  END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `search_by_string` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `search_by_string`(
  IN text VARCHAR(100)
)
BEGIN
    SELECT bike.bikeID, bike.color, brand.brandname, type.typeName
    FROM bike
      JOIN brand
        ON bike.brandid = brand.brandid
      JOIN type
        ON bike.typeID = type.typeID
    WHERE bike.color LIKE CONCAT('%',text,'%')
          OR brand.brandname LIKE CONCAT('%',text,'%')
          OR type.typeName LIKE CONCAT('%',text, '%');
  END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `temp_return_password_binary` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `temp_return_password_binary`(
  IN userNameIn NVARCHAR(40),
  IN tryPasswordIn NVARCHAR(40),
  out passwordBin VARBINARY(56),
  out tryPasswordOut VARBINARY(56),
  out userIDOut int(10))
BEGIN

    IF EXISTS (SELECT userID FRom bikeuser WHERE username = userNameIn)
    THEN
      SET passwordBin = (SELECT passw FROM bikeuser WHERE username = userNameIn);
      SET tryPasswordOut = (AES_ENCRYPT(tryPasswordIn,'tackforkaffet'));
      SET userIDOut = (SELECT userID FRom bikeuser WHERE username = userNameIn);
    ELSE
      SET tryPasswordOut = '';
      SET passwordBin = '';
      SELECT userIDOut = -1;
    END IF;
  END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_memberlevel` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_memberlevel`()
BEGIN
  DECLARE finished INTEGER DEFAULT 0;
DECLARE userIDTemp INT(11) DEFAULT 0;
DECLARE sum_delayTemp INT(11) DEFAULT 0;
DECLARE number_of_loan INT(11) DEFAULT 0;
DECLARE row_cursor CURSOR FOR SELECT userid
                              FROM bikeuser;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;
  INSERT INTO event_occured (time, message) VALUE ( now(), 'update_memberlevel() körs');

  OPEN row_cursor;
get_userid:LOOP
  FETCH row_cursor INTO userIDTemp;
    IF finished = 1 THEN
      LEAVE get_userid;
    END IF;

SET sum_delayTemp = (SELECT sum(returndelay.numberOfDayDelay)
                     FROM returndelay
                     WHERE userID = userIDTemp);
SET number_of_loan = (SELECT COUNT(*)
                      FROM rentbridge
                      WHERE userID = userIDTemp);
IF((sum_delayTemp/number_of_loan)< -5)
  THEN
      UPDATE bikeuser
      SET memberlevel = 1
      WHERE userID = userIDTemp;
  END IF;
END LOOP get_userid;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `users_current_bikes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `users_current_bikes`(
  IN userIDIn INT(11))
BEGIN

    SELECT DISTINCT * FROM bike_object
      JOIN rentbridge ON bike_object.bikeID = rentbridge.bikeID
    WHERE dayOfActualReturn IS NULL
          AND userID = userIDIn ;
COMMIT;
  END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `users_total_loan` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `users_total_loan`(
IN userIDIn INT(11)
)
BEGIN 
    SELECT bikeID FROM rentbridge WHERE userID = userIDIn;
  END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `bike_object`
--

/*!50001 DROP VIEW IF EXISTS `bike_object`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `bike_object` AS select `bike`.`bikeID` AS `bikeID`,`bike`.`modelyear` AS `modelyear`,`bike`.`color` AS `color`,`bike`.`image` AS `image`,`bike`.`imageFileName` AS `imageFileName`,`bike`.`size` AS `size`,`type`.`typeName` AS `typeName`,`brand`.`brandname` AS `brandname` from (((`bike` left join `rentbridge` on((`bike`.`bikeID` = `rentbridge`.`bikeID`))) join `brand` on((`bike`.`brandid` = `brand`.`brandid`))) join `type` on((`bike`.`typeID` = `type`.`typeID`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-10-25 17:21:30
