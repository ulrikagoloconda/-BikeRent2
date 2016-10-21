CREATE TABLE bike
(
  bikeID INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
  brandid INT(11),
  modelyear SMALLINT(6),
  color VARCHAR(50),
  image LONGBLOB,
  size SMALLINT(6),
  insertDateTime DATETIME,
  typeID INT(10),
  imageFileName VARCHAR(50),
  CONSTRAINT bikebrand_fk FOREIGN KEY (brandid) REFERENCES brand (brandid) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT biketype_fk FOREIGN KEY (typeID) REFERENCES type (typeID) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE INDEX bikebrand_fk ON bike (brandid);
CREATE INDEX biketype_fk ON bike (typeID);
CREATE TABLE bikeuser
(
  userID INT(10) PRIMARY KEY NOT NULL AUTO_INCREMENT,
  fname VARCHAR(50),
  lname VARCHAR(50),
  memberlevel INT(50),
  email VARCHAR(50),
  phone INT(50),
  username VARCHAR(50) NOT NULL,
  passw VARBINARY(56),
  memberSince DATE
);
CREATE TABLE brand
(
  brandid INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
  brandname VARCHAR(50),
  comments VARCHAR(100)
);
CREATE TABLE rentbridge
(
  userID INT(10) NOT NULL,
  bikeID INT(11) NOT NULL,
  dayOfRent DATE,
  dayOfReturn DATE,
  dayOfActualReturn DATE,
  CONSTRAINT `PRIMARY` PRIMARY KEY (userID, bikeID),
  CONSTRAINT userrent_fk FOREIGN KEY (userID) REFERENCES bikeuser (userID) ON UPDATE CASCADE,
  CONSTRAINT bikerent_fk FOREIGN KEY (bikeID) REFERENCES bike (bikeID) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE INDEX bikerent_fk ON rentbridge (bikeID);
CREATE INDEX userrent_fk ON rentbridge (userID);
CREATE TABLE type
(
  typeID INT(10) PRIMARY KEY NOT NULL AUTO_INCREMENT,
  typeName VARCHAR(30)
);
CREATE TABLE alterduser
(
  alterID INT(10) PRIMARY KEY NOT NULL AUTO_INCREMENT,
  userID INT(10) NOT NULL,
  alterDate DATE NOT NULL,
  fname VARCHAR(40),
  lname VARCHAR(40),
  memberlevel INT(10),
  email VARCHAR(50),
  phone INT(11),
  username VARCHAR(40) NOT NULL,
  passw VARBINARY(56),
  CONSTRAINT useridalter_fk FOREIGN KEY (userID) REFERENCES bikeuser (userID)
);
CREATE INDEX useridalter_fk ON alterduser (userID);
CREATE TABLE errorevent
(
  id INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
  date TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  errortext VARCHAR(10000),
  userID INT(10)
);
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_bike`(IN idIn INT(11))
  BEGIN
    DELETE FROM bike WHERE bikeID=idIn;
  END
  ;
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
  END;

CREATE DEFINER=`root`@`localhost` PROCEDURE `getUserFromUserName`(in_username varchar(50))
  BEGIN
    SELECT * FROM bikeuser
    WHERE username = in_username;
  END
  ;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_bikes`()
  BEGIN
    SELECT bike.bikeID, bike.modelyear, bike.color, bike.size, bike.modelyear, brand.brandname, type.typeName
    FROM bike
      JOIN type ON bike.typeID = type.typeID
      JOIN brand On bike.brandid = brand.brandid;
  END
  ;
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

  END
  ;
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
  END
  ;
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
  END
  ;
CREATE DEFINER=`root`@`localhost` PROCEDURE `search_available_bikes`()
  BEGIN
    SELECT * FROM bike_object

    WHERE bike_object.bikeID NOT IN
          (SELECT rentbridge.bikeID FROM rentbridge WHERE dayOfActualReturn is null);
  END

  ;
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
  END
  ;
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
  END
  ;

CREATE DEFINER=`root`@`localhost` PROCEDURE `users_current_bikes`(
  IN userIDIn INT(11))
  BEGIN
    SELECT bikeID FROM rentbridge
    WHERE userID = userIDIn
          AND dayOfActualReturn IS NULL;
  END
  ;
CREATE DEFINER=`root`@`localhost` PROCEDURE `users_total_loan`(
  IN userIDIn INT(11)
)
  BEGIN
    SELECT bikeID FROM rentbridge WHERE userID = userIDIn;
  END
  ;
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
  END
  ;

CREATE TRIGGER bikeuser UPDATE BEFORE
BEGIN
INSERT INTO alterdUser (userID, alterDate, fname, lname, memberlevel, email, phone, username, passw)
VALUES(old.userID, NOW(), old.fname, old.lname, old.memberlevel,
old.email, old.phone, old.username, AES_ENCRYPT( old.passw,'tackforkaffet'));
END
;

CREATE VIEW bike_object AS
  SELECT bike.bikeID, brand.brandname, bike.image, bike.modelyear, bike.size, bike.color, type.typeName
  FROM bike
  JOIN brand ON bike.brandid = brand.brandid
  JOIN type on bike.typeID = type.typeID
;

