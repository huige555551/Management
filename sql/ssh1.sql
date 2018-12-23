-- MySQL dump 10.13  Distrib 8.0.13, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: car
-- ------------------------------------------------------
-- Server version	8.0.13

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `accident`
--

DROP TABLE IF EXISTS `accident`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `accident` (
  `order_number` varchar(10) NOT NULL,
  `time` datetime NOT NULL,
  `place` varchar(50) DEFAULT NULL,
  `type` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`order_number`,`time`),
  CONSTRAINT `FK_Reference_11` FOREIGN KEY (`order_number`) REFERENCES `order_info` (`order_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accident`
--

LOCK TABLES `accident` WRITE;
/*!40000 ALTER TABLE `accident` DISABLE KEYS */;
INSERT INTO `accident` VALUES ('1','2018-11-29 10:45:00','1','1'),('3','2018-11-28 09:25:00','3','3');
/*!40000 ALTER TABLE `accident` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bac`
--

DROP TABLE IF EXISTS `bac`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `bac` (
  `order_number` varchar(10) NOT NULL,
  `amount` float(11,2) DEFAULT NULL,
  `type` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`order_number`),
  CONSTRAINT `FK_Reference_10` FOREIGN KEY (`order_number`) REFERENCES `order_info` (`order_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bac`
--

LOCK TABLES `bac` WRITE;
/*!40000 ALTER TABLE `bac` DISABLE KEYS */;
INSERT INTO `bac` VALUES ('1',1.00,'1'),('3',3.00,'3');
/*!40000 ALTER TABLE `bac` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `car`
--

DROP TABLE IF EXISTS `car`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `car` (
  `car_number` varchar(10) NOT NULL,
  `plate_number` varchar(9) NOT NULL,
  `car_name` varchar(10) NOT NULL,
  `car_state` enum('已租','未租','报修') NOT NULL,
  `shop_number` varchar(5) NOT NULL,
  PRIMARY KEY (`car_number`),
  KEY `FK_Reference_4` (`car_name`),
  KEY `FK_Reference_8` (`shop_number`),
  CONSTRAINT `FK_Reference_4` FOREIGN KEY (`car_name`) REFERENCES `car_type` (`car_name`),
  CONSTRAINT `FK_Reference_8` FOREIGN KEY (`shop_number`) REFERENCES `shop` (`shop_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `car`
--

LOCK TABLES `car` WRITE;
/*!40000 ALTER TABLE `car` DISABLE KEYS */;
INSERT INTO `car` VALUES ('1','1','a','未租','1'),('3','3','b','报修','s005');
/*!40000 ALTER TABLE `car` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `car_type`
--

DROP TABLE IF EXISTS `car_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `car_type` (
  `car_name` varchar(10) NOT NULL,
  `car_picture` LONGTEXT DEFAULT NULL,
  `car_brand` varchar(4) NOT NULL,
  `car_type` enum('经济型','商务型','豪华型') NOT NULL,
  `daily_rent` float(11,2) NOT NULL,
  `car_deposit` float(11,2) NOT NULL,
  PRIMARY KEY (`car_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `car_type`
--

LOCK TABLES `car_type` WRITE;
/*!40000 ALTER TABLE `car_type` DISABLE KEYS */;
INSERT INTO `car_type` VALUES ('1',NULL,'1','商务型',1.00,1.00),('a',NULL,'c','商务型',150.00,1.00),('b',NULL,'b','商务型',1.00,2.00);
/*!40000 ALTER TABLE `car_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `manager`
--

DROP TABLE IF EXISTS `manager`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `manager` (
  `manager_id` varchar(11) NOT NULL,
  `manager_pwd` varchar(11) DEFAULT NULL,
  PRIMARY KEY (`manager_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manager`
--

LOCK TABLES `manager` WRITE;
/*!40000 ALTER TABLE `manager` DISABLE KEYS */;
INSERT INTO `manager` VALUES ('admin','123');
/*!40000 ALTER TABLE `manager` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_info`
--

DROP TABLE IF EXISTS `order_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `order_info` (
  `order_number` varchar(10) NOT NULL,
  `user_phone` varchar(11) NOT NULL,
  `car_number` varchar(10) NOT NULL,
  `take_shop` varchar(5) DEFAULT NULL,
  `return_shop` varchar(5) DEFAULT NULL,
  `take_time` datetime NOT NULL,
  `return_time` datetime DEFAULT NULL,
  `order_amount` float(11,2) DEFAULT NULL,
  `order_time` datetime NOT NULL,
  `order_state` enum('未取车','未还车','已还车','已完成','已取消','已延长') NOT NULL,
  `take_oil` float(11,2) DEFAULT NULL,
  `return_oil` float(11,2) DEFAULT NULL,
  `oil_amount` float(11,2) DEFAULT '0.00',
  PRIMARY KEY (`order_number`),
  KEY `FK_Reference_14` (`return_shop`),
  KEY `FK_Reference_5` (`user_phone`),
  KEY `FK_Reference_6` (`car_number`),
  KEY `take_shop` (`take_shop`),
  CONSTRAINT `FK_Reference_14` FOREIGN KEY (`return_shop`) REFERENCES `shop` (`shop_number`),
  CONSTRAINT `FK_Reference_5` FOREIGN KEY (`user_phone`) REFERENCES `user` (`user_phone`),
  CONSTRAINT `FK_Reference_6` FOREIGN KEY (`car_number`) REFERENCES `car` (`car_number`),
  CONSTRAINT `take_shop` FOREIGN KEY (`take_shop`) REFERENCES `shop` (`shop_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_info`
--

LOCK TABLES `order_info` WRITE;
/*!40000 ALTER TABLE `order_info` DISABLE KEYS */;
INSERT INTO `order_info` VALUES ('1','1','1','1','1','2018-12-12 19:31:59','2018-12-12 20:08:48',100.00,'2018-11-26 00:00:00','已还车',10.00,10.00,0.00),('3','55','1','s005','s005','2018-12-13 10:50:00','2018-12-12 19:57:21',0.00,'2018-12-12 19:51:48','已还车',0.00,0.00,0.00);
/*!40000 ALTER TABLE `order_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `peccancy`
--

DROP TABLE IF EXISTS `peccancy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `peccancy` (
  `order_number` varchar(10) NOT NULL,
  `amount` float(11,2) NOT NULL,
  `type` varchar(100) NOT NULL,
  PRIMARY KEY (`order_number`),
  CONSTRAINT `FK_Reference_12` FOREIGN KEY (`order_number`) REFERENCES `order_info` (`order_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `peccancy`
--

LOCK TABLES `peccancy` WRITE;
/*!40000 ALTER TABLE `peccancy` DISABLE KEYS */;
INSERT INTO `peccancy` VALUES ('1',100.00,'1');
/*!40000 ALTER TABLE `peccancy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shop`
--

DROP TABLE IF EXISTS `shop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `shop` (
  `shop_number` varchar(5) NOT NULL,
  `shop_city` varchar(5) NOT NULL,
  `shop_area` varchar(5) DEFAULT NULL,
  `shop_name` varchar(10) NOT NULL,
  `shop_address` varchar(20) NOT NULL,
  `shop_phone` varchar(11) NOT NULL,
  `shop_hours` varchar(15) NOT NULL,
  PRIMARY KEY (`shop_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shop`
--

LOCK TABLES `shop` WRITE;
/*!40000 ALTER TABLE `shop` DISABLE KEYS */;
INSERT INTO `shop` VALUES ('1','b','c','a','d','00000000002','9:00-18:00'),('s001','a','a','a','a','12345678901','9:00-18:00'),('s005','长沙','长沙','雨花区','雨花路55号','13762769230','9:00-18:00');
/*!40000 ALTER TABLE `shop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `user` (
  `user_phone` varchar(11) NOT NULL,
  `user_name` varchar(20) NOT NULL,
  `id` varchar(18) DEFAULT '',
  `user_pwd` varchar(20) NOT NULL,
  `deposit` float(11,2) DEFAULT '0.00',
  `balance` float(11,2) DEFAULT '0.00',
  `score` float(11,2) DEFAULT '60.00',
  `state` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_phone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('1','1','1','123456',1.00,100.00,100.00,1),('11111111111','1','1','1',1.00,1.00,1.00,1),('12345678900','1',NULL,'222222',3.00,4.00,5.00,0),('22222222222','1',NULL,'1',2.00,3.00,4.00,0),('33333333333','3',NULL,'23',2.00,3.00,2.00,1),('4','4','4','4',4.00,4.00,4.00,1),('44','4','4','4',4.00,4.00,4.00,1),('44444444444','4',NULL,'444444',4.00,4.00,4.00,1),('5','5','5','5',5.00,5.00,5.00,1),('55','5','5','5',5.00,5.00,5.00,1),('55555555555','55',NULL,'555555',5.00,5.00,5.00,1),('6','6','6','6',6.00,6.00,6.00,1),('66','6','6','6',6.00,6.00,6.00,1),('66666666666','6',NULL,'666666',6.00,6.00,6.00,1),('7','7','7','7',7.00,7.00,7.00,1),('77','7','7','7',7.00,7.00,7.00,1),('77777777777','7',NULL,'777777',7.00,7.00,7.00,1),('8','8','8','8',8.00,8.00,8.00,1),('88','8','8','8',8.00,8.00,8.00,1);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wallet_detail`
--

DROP TABLE IF EXISTS `wallet_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `wallet_detail` (
  `user_phone` varchar(11) NOT NULL,
  `time` datetime NOT NULL,
  `operation` enum('提现余额','提现押金','充值余额','充值押金','退款','租车') NOT NULL,
  `amount` float(11,2) NOT NULL,
  PRIMARY KEY (`user_phone`,`time`),
  CONSTRAINT `user_phone` FOREIGN KEY (`user_phone`) REFERENCES `user` (`user_phone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wallet_detail`
--

LOCK TABLES `wallet_detail` WRITE;
/*!40000 ALTER TABLE `wallet_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `wallet_detail` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-12-23 11:21:13
