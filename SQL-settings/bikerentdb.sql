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

