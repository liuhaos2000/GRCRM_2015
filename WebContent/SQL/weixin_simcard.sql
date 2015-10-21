/*
SQLyog Enterprise Trial - MySQL GUI v7.11 
MySQL - 5.6.25-log : Database - weixin
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

CREATE DATABASE /*!32312 IF NOT EXISTS*/`weixin` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `weixin`;

/*Table structure for table `addressinfo` */

DROP TABLE IF EXISTS `addressinfo`;

CREATE TABLE `addressinfo` (
  `AddressId` varchar(100) NOT NULL,
  `UserId` varchar(100) DEFAULT NULL,
  `ZipCode` varchar(6) DEFAULT NULL,
  `ContryCode` varchar(3) DEFAULT NULL,
  `ProvinceCode` varchar(6) DEFAULT NULL,
  `CityCode` varchar(6) DEFAULT NULL,
  `Address` varchar(200) DEFAULT NULL,
  `CreatedDate` datetime(6) DEFAULT NULL,
  `ModifiedDate` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`AddressId`),
  UNIQUE KEY `AddressId_UNIQUE` (`AddressId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='出荷先住所情報テーブル';

/*Table structure for table `bankcardinfo` */

DROP TABLE IF EXISTS `bankcardinfo`;

CREATE TABLE `bankcardinfo` (
  `userid` int(11) NOT NULL,
  `cardid` int(11) NOT NULL,
  `bankno` varchar(45) DEFAULT NULL,
  `bankname` varchar(45) DEFAULT NULL,
  `bankcardno` varchar(50) DEFAULT NULL,
  `counttimes` int(11) DEFAULT NULL,
  `paytotal` varchar(45) DEFAULT NULL,
  `transferdivision` varchar(25) DEFAULT NULL,
  `madeday` date DEFAULT NULL,
  `maker` varchar(45) DEFAULT NULL,
  `updatedday` date DEFAULT NULL,
  `updater` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`userid`,`cardid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `m_city` */

DROP TABLE IF EXISTS `m_city`;

CREATE TABLE `m_city` (
  `CityId` varchar(100) NOT NULL,
  `CountryCode` varchar(3) DEFAULT NULL,
  `ProvinceCode` varchar(6) DEFAULT NULL,
  `CityCode` varchar(6) DEFAULT NULL,
  `CityName` varchar(100) DEFAULT NULL,
  `CityNameEN` varchar(200) DEFAULT NULL,
  `CreatedDate` datetime(6) DEFAULT NULL,
  `ModifiedDate` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`CityId`),
  UNIQUE KEY `CityId_UNIQUE` (`CityId`),
  KEY `FK_CountryCode_idx` (`CountryCode`),
  KEY `FK_ProvinceCode_idx` (`ProvinceCode`),
  CONSTRAINT `FK_CountryCode` FOREIGN KEY (`CountryCode`) REFERENCES `m_country` (`CountryCode`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_ProvinceCode` FOREIGN KEY (`ProvinceCode`) REFERENCES `m_province` (`ProvinceCode`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='市マスタ';

/*Table structure for table `m_country` */

DROP TABLE IF EXISTS `m_country`;

CREATE TABLE `m_country` (
  `CountryId` varchar(100) NOT NULL,
  `CountryCode` varchar(3) NOT NULL,
  `CountryName` varchar(100) DEFAULT NULL,
  `CountryNameEN` varchar(200) DEFAULT NULL,
  `Abbreviation` varchar(3) DEFAULT NULL,
  `TELCode` varchar(6) DEFAULT NULL,
  `CreatedDate` datetime(6) DEFAULT NULL,
  `ModifiedDate` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`CountryId`),
  UNIQUE KEY `ContryId_UNIQUE` (`CountryId`),
  UNIQUE KEY `CountryCode_UNIQUE` (`CountryCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='国マスタ';

/*Table structure for table `m_province` */

DROP TABLE IF EXISTS `m_province`;

CREATE TABLE `m_province` (
  `ProvinceId` varchar(100) NOT NULL,
  `CountryCode` varchar(3) DEFAULT NULL,
  `ProvinceCode` varchar(6) NOT NULL,
  `ProvinceName` varchar(100) DEFAULT NULL,
  `ProvinceNameEN` varchar(200) DEFAULT NULL,
  `CreatedDate` datetime(6) DEFAULT NULL,
  `ModifiedDate` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`ProvinceId`),
  UNIQUE KEY `ProvinceId_UNIQUE` (`ProvinceId`),
  UNIQUE KEY `ProvinceCode_UNIQUE` (`ProvinceCode`),
  KEY `FK_CountryCode_idx` (`CountryCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='省マスタ';

/*Table structure for table `m_zip` */

DROP TABLE IF EXISTS `m_zip`;

CREATE TABLE `m_zip` (
  `ZipId` varchar(100) NOT NULL,
  `ZipCode` varchar(100) DEFAULT NULL,
  `ContryCode` varchar(3) DEFAULT NULL,
  `ProvinceCode` varchar(6) DEFAULT NULL,
  `CityCode` varchar(6) DEFAULT NULL,
  `Area` varchar(200) DEFAULT NULL,
  `TelCode` varchar(5) DEFAULT NULL,
  `CreatedDate` datetime(6) DEFAULT NULL,
  `ModifiedDate` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`ZipId`),
  UNIQUE KEY `AddressId_UNIQUE` (`ZipId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='郵便番号マスタ';

/*Table structure for table `orderinfo` */

DROP TABLE IF EXISTS `orderinfo`;

CREATE TABLE `orderinfo` (
  `orderid` int(11) NOT NULL,
  `userid` varchar(80) NOT NULL,
  `cardid` int(11) NOT NULL,
  `productid` int(11) NOT NULL,
  `quantity` varchar(40) NOT NULL,
  `price` varchar(45) DEFAULT NULL,
  `totalamount` varchar(45) DEFAULT NULL,
  `otherdiscount` varchar(50) DEFAULT NULL,
  `orderdate` varchar(80) DEFAULT NULL,
  `status` varchar(25) DEFAULT NULL,
  `payee` varchar(35) DEFAULT NULL,
  `amount` varchar(45) DEFAULT NULL,
  `kampenexistence` varchar(50) DEFAULT NULL,
  `kampendeadline` date DEFAULT NULL,
  `discount` varchar(40) DEFAULT NULL,
  `fee` varchar(50) DEFAULT NULL,
  `rebate` varchar(45) DEFAULT NULL,
  `madeday` date DEFAULT NULL,
  `maker` varchar(45) DEFAULT NULL,
  `updatedday` date DEFAULT NULL,
  `updater` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`orderid`,`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `paymentinfo` */

DROP TABLE IF EXISTS `paymentinfo`;

CREATE TABLE `paymentinfo` (
  `orderid` varchar(30) NOT NULL,
  `shopid` varchar(45) DEFAULT NULL,
  `productid` varchar(45) DEFAULT NULL,
  `paymentmount` varchar(50) DEFAULT NULL,
  `remainamount` varchar(50) DEFAULT NULL,
  `status` varchar(30) DEFAULT NULL,
  `makedday` date DEFAULT NULL,
  `maker` varchar(45) DEFAULT NULL,
  `updatedday` date DEFAULT NULL,
  `updater` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`orderid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `personchargedinfo` */

DROP TABLE IF EXISTS `personchargedinfo`;

CREATE TABLE `personchargedinfo` (
  `shopid` int(11) NOT NULL,
  `pichargedid` varchar(45) DEFAULT NULL,
  `lastname` varchar(40) DEFAULT NULL,
  `firstname` varchar(40) DEFAULT NULL,
  `cana` varchar(50) DEFAULT NULL,
  `sex` varchar(15) DEFAULT NULL,
  `tel` varchar(45) NOT NULL,
  `mail` varchar(40) DEFAULT NULL,
  `jobtitle` varchar(50) DEFAULT NULL,
  `image1` varchar(45) DEFAULT NULL,
  `image2` varchar(45) DEFAULT NULL,
  `madeday` date DEFAULT NULL,
  `maker` varchar(45) DEFAULT NULL,
  `updatedday` date DEFAULT NULL,
  `updater` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`shopid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `productinfo` */

DROP TABLE IF EXISTS `productinfo`;

CREATE TABLE `productinfo` (
  `productid` int(11) NOT NULL,
  `shopid` int(11) NOT NULL,
  `pichargedid` int(11) NOT NULL,
  `productcode` int(11) NOT NULL,
  `prodprice` varchar(45) DEFAULT NULL,
  `kampenexistence` varchar(50) DEFAULT NULL,
  `kampendeadline` date DEFAULT NULL,
  `discount` varchar(45) DEFAULT NULL,
  `fee` varchar(35) DEFAULT NULL,
  `rebaterate` varchar(25) DEFAULT NULL,
  `madeday` date DEFAULT NULL,
  `maker` varchar(45) DEFAULT NULL,
  `updatedday` date DEFAULT NULL,
  `updater` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`productid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `productmaster` */

DROP TABLE IF EXISTS `productmaster`;

CREATE TABLE `productmaster` (
  `productcode` int(11) NOT NULL,
  `productname` varchar(45) NOT NULL,
  `unitprice` varchar(45) DEFAULT NULL,
  `largeclassification` varchar(50) DEFAULT NULL,
  `middleclassification` varchar(50) DEFAULT NULL,
  `smallclassification` varchar(50) DEFAULT NULL,
  `quantityclassification` varchar(50) DEFAULT NULL,
  `image1` varchar(45) DEFAULT NULL,
  `image2` varchar(45) DEFAULT NULL,
  `image3` varchar(45) DEFAULT NULL,
  `manufacturer` varchar(40) DEFAULT NULL,
  `productidentificationcode` varchar(45) DEFAULT NULL,
  `madeday` date DEFAULT NULL,
  `maker` varchar(35) DEFAULT NULL,
  `updatedday` date DEFAULT NULL,
  `updater` varchar(35) DEFAULT NULL,
  PRIMARY KEY (`productcode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `shopinfo` */

DROP TABLE IF EXISTS `shopinfo`;

CREATE TABLE `shopinfo` (
  `shopid` int(11) NOT NULL,
  `shopname` varchar(45) NOT NULL,
  `business` varchar(45) DEFAULT NULL,
  `delineation` varchar(80) DEFAULT NULL,
  `streetaddress` varchar(100) DEFAULT NULL,
  `longitude` varchar(25) DEFAULT NULL,
  `latitude` varchar(25) DEFAULT NULL,
  `telno` varchar(45) NOT NULL,
  `personincharge` varchar(40) DEFAULT NULL,
  `salesrepresentative` varchar(45) DEFAULT NULL,
  `mail` varchar(50) DEFAULT NULL,
  `message1` varchar(45) DEFAULT NULL,
  `message2` varchar(45) DEFAULT NULL,
  `message3` varchar(45) DEFAULT NULL,
  `message4` varchar(45) DEFAULT NULL,
  `message5` varchar(45) DEFAULT NULL,
  `payee` varchar(25) DEFAULT NULL,
  `madeday` date DEFAULT NULL,
  `maker` varchar(45) DEFAULT NULL,
  `updatedday` date DEFAULT NULL,
  `updater` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`shopid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `userinfo` */

DROP TABLE IF EXISTS `userinfo`;

CREATE TABLE `userinfo` (
  `userid` varchar(100) NOT NULL,
  `username` varchar(50) DEFAULT NULL,
  `sex` varchar(10) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `telno` varchar(20) DEFAULT NULL,
  `mail` varchar(45) DEFAULT NULL,
  `wrchaid` varchar(20) DEFAULT NULL,
  `tojapanforpurpose` varchar(60) DEFAULT NULL,
  `destination` varchar(45) DEFAULT NULL,
  `startdate` date DEFAULT NULL,
  `enddate` date DEFAULT NULL,
  `address` varchar(80) DEFAULT NULL,
  `simcard` varchar(20) DEFAULT NULL,
  `madeday` date DEFAULT NULL,
  `maker` varchar(25) DEFAULT NULL,
  `updatedday` date DEFAULT NULL,
  `updater` varchar(45) DEFAULT NULL,
  `language` varchar(40) DEFAULT NULL,
  `shortname` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
