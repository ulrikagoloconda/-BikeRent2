CREATE TABLE `bike` (
  `bikeID` int(11) NOT NULL AUTO_INCREMENT,
  `brandid` int(11) DEFAULT NULL,
  `modelyear` smallint(6) DEFAULT NULL,
  `color` varchar(50) DEFAULT NULL,
  `image` longblob,
  `size` smallint(6) DEFAULT NULL,
  `typeID` int(10) DEFAULT NULL,
  `imageFileName` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`bikeID`),
  KEY `bikebrand_fk` (`brandid`),
  KEY `biketype_fk` (`typeID`),
  CONSTRAINT `bikebrand_fk` FOREIGN KEY (`brandid`) REFERENCES `brand` (`brandid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `biketype_fk` FOREIGN KEY (`typeID`) REFERENCES `type` (`typeID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8


CREATE TABLE `bikeuser` (
  `userID` int(10) NOT NULL AUTO_INCREMENT,
  `fname` varchar(40) DEFAULT NULL,
  `lname` varchar(40) DEFAULT NULL,
  `memberlevel` int(10) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `phone` int(11) DEFAULT NULL,
  `username` varchar(40) NOT NULL,
  `passw` varbinary(56) NOT NULL,
  `memberSince` date DEFAULT NULL,
  PRIMARY KEY (`userID`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8

CREATE TABLE `brand` (
  `brandid` int(11) NOT NULL AUTO_INCREMENT,
  `brandname` varchar(50) DEFAULT NULL,
  `comments` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`brandid`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8


CREATE TABLE `rentbridge` (
  `userID` int(10) NOT NULL,
  `bikeID` int(11) NOT NULL,
  `dayOfRent` date DEFAULT NULL,
  `dayOfReturn` date DEFAULT NULL,
  `dayOfActualReturn` date DEFAULT NULL,
  KEY `userrent_fk` (`userID`),
  KEY `bikerent_fk` (`bikeID`),
  CONSTRAINT `bikerent_fk` FOREIGN KEY (`bikeID`) REFERENCES `bike` (`bikeID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `userrent_fk` FOREIGN KEY (`userID`) REFERENCES `bikeuser` (`userID`) ON UPDATE CASCADE,
  PRIMARY KEY (userID, bikeID, dayOfRent)
) ENGINE=InnoDB DEFAULT CHARSET=utf8

CREATE TABLE `type` (
  `typeID` int(10) NOT NULL AUTO_INCREMENT,
  `typeName` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`typeID`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8





  USE bikerent ;
create TABLE alterdUser(
  alterID int(10) AUTO_INCREMENT NOT NULL PRIMARY KEY,
  `userID` int(10) NOT NULL,
  alterDate DATE NOT NULL,
  `fname` nvarchar(40) DEFAULT NULL,
  `lname` nvarchar(40) DEFAULT NULL,
  `memberlevel` int(10) DEFAULT NULL,
  `email` nvarchar(50) DEFAULT NULL,
  `phone` int(11) DEFAULT NULL,
  `username` nvarchar(40) NOT NULL,
  `passw` varbinary(56) DEFAULT NULL,
  CONSTRAINT useridalter_fk FOREIGN KEY (`userID`) REFERENCES `bikeuser` (`userID`)
);

DELIMITER //
CREATE TRIGGER alterTrigger BEFORE UPDATE ON bikeuser
FOR EACH ROW
  BEGIN
    INSERT INTO alterdUser (userID, alterDate, fname, lname, memberlevel, email, phone, username, passw)
    VALUES(old.userID, NOW(), old.fname, old.lname, old.memberlevel,
           old.email, old.phone, old.username, AES_ENCRYPT( old.passw,'tackforkaffet'));
  END //

DELIMITER ;

USE bikerent ;

CREATE TABLE bikerent.errorevent
(
  id INT PRIMARY KEY AUTO_INCREMENT,
  date TIMESTAMP NOT NULL,
  username VARCHAR(30),
  errortext VARCHAR(100)
);
CREATE UNIQUE INDEX errorevent_id_uindex ON bikerent.errorevent (id)

drop FUNCTION insert_new_ErrorEvent;
DELIMITER //
CREATE FUNCTION insert_new_ErrorEvent(in_username varchar(30), in_error varchar(500)) RETURNS smallint(6)
  BEGIN
    INSERT INTO errorevent (date,username , errortext)
    VALUES (CURRENT_TIMESTAMP() , in_username , in_error);
    RETURN 1;
  END//
DELIMITER ;

SELECT insert_new_ErrorEvent(
    'cykeltur', 'errortest...1234ÅÖÄ');

USE bikerent ;

DROP PROCEDURE IF EXISTS bikerent.insert_bike;
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
  END;

CREATE VIEW bike_object AS
  SELECT bike.bikeID,bike.modelyear, bike.color, bike.image, bike.imageFileName,
    bike.size, type.typeName, brand.brandname
  FROM bike
    LEFT JOIN rentbridge
      ON bike.bikeID = rentbridge.bikeID
    JOIN brand
      ON bike.brandid = brand.brandid
    JOIN type
      ON bike.typeID = type.typeID;