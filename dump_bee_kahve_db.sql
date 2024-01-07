-- MySQL dump 10.13  Distrib 8.0.35, for Linux (x86_64)
--
-- Host: localhost    Database: bee_kahve_db
-- ------------------------------------------------------
-- Server version	8.0.35-0ubuntu0.22.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Admins`
--
USE bee_kahve_db;

DROP TABLE IF EXISTS `Admins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Admins` (
  `admin_id` int NOT NULL AUTO_INCREMENT,
  `admin_name` varchar(50) NOT NULL,
  `stock_id` int DEFAULT NULL,
  `admin_email` varchar(50) NOT NULL,
  `admin_password` varchar(255) NOT NULL,
  `admin_address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`admin_id`),
  UNIQUE KEY `admin_email` (`admin_email`),
  UNIQUE KEY `stock_id` (`stock_id`),
  CONSTRAINT `Admins_ibfk_1` FOREIGN KEY (`stock_id`) REFERENCES `Stocks` (`stock_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Admins`
--

LOCK TABLES `Admins` WRITE;
/*!40000 ALTER TABLE `Admins` DISABLE KEYS */;
INSERT INTO `Admins` VALUES (1,'Novruz Amirov',1,'admin@itu.edu.tr','b1d632f26e83babf1c80709208e1b6ed01312cc94860c327d82107ff3f073e65e81f902169d4ddfe3f837f8297ea8d80085f0ed1f6fc6ee7a84e0383abadf5ba',NULL),(2,'Novruz Amirov',NULL,'novruz.amirov2004@gmail.com','b1d632f26e83babf1c80709208e1b6ed01312cc94860c327d82107ff3f073e65e81f902169d4ddfe3f837f8297ea8d80085f0ed1f6fc6ee7a84e0383abadf5ba',NULL);
/*!40000 ALTER TABLE `Admins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Customers`
--

DROP TABLE IF EXISTS `Customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Customers` (
  `customer_id` int NOT NULL AUTO_INCREMENT,
  `customer_name` varchar(50) NOT NULL,
  `customer_email` varchar(50) NOT NULL,
  `customer_password` varchar(50) NOT NULL,
  `customer_address` varchar(500) DEFAULT NULL,
  `loyalty_coffee_count` int DEFAULT '0',
  PRIMARY KEY (`customer_id`),
  UNIQUE KEY `customer_email` (`customer_email`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Customers`
--

LOCK TABLES `Customers` WRITE;
/*!40000 ALTER TABLE `Customers` DISABLE KEYS */;
INSERT INTO `Customers` VALUES (1,'Customer Name','Customer Email','Customer Password','Ayazağa Sarıyer/Istanbul',33),(2,'buse','buse@mail.com','string','ITU Electrical and Electronical Faculty Sarıyer/Istanbul',33),(3,'Leminur Celik','celik@gmail.com','123789','Kirecburnu, Sariyer/Istanbul',33),(4,'Adil','a@gmail.com','123456789','BAKu',15),(5,'Adil','b@gmail.com','123456789','Itu macka',18),(6,'Buse','buse@gmail.com','busbus','ITU EHB',31),(7,'suarez','suarez1899@gmail.com','123456789','itu',33),(8,'Adil Mahmudlu','adil@gmail.com','123456789','ITU Ayazaga',33),(9,'Test','test@gmail.com','123456','ITU Informatics',33),(10,'Bilal','bilal@gmail.com','987654','ITU Kovan',33),(11,'tset','tst@gmail.com','345678','ITU',33),(12,'Leminur','c@gmail.com','1237896','ITU',0),(13,'John Doe','demo@gmail.com','demojohn','ITU MACKA',0);
/*!40000 ALTER TABLE `Customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Employees`
--

DROP TABLE IF EXISTS `Employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Employees` (
  `employee_id` int NOT NULL AUTO_INCREMENT,
  `employee_name` varchar(50) NOT NULL,
  `employee_email` varchar(50) NOT NULL,
  `employee_password` varchar(200) NOT NULL,
  `admin_id` int NOT NULL,
  `is_employee_active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`employee_id`),
  UNIQUE KEY `employee_email` (`employee_email`),
  KEY `admin_id` (`admin_id`),
  CONSTRAINT `Employees_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `Admins` (`admin_id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Employees`
--

LOCK TABLES `Employees` WRITE;
/*!40000 ALTER TABLE `Employees` DISABLE KEYS */;
INSERT INTO `Employees` VALUES (1,'Employee Name','Employee Email','Employee Password',1,1),(4,'Novruz Amirov','employee@itu.edu.tr','ada3197469dbc37df5789eda636a6c4c24f4cf368ec089f640c7981b2a450fe9be9a0d6896ec5714cb00a1e1b63571f34e9d63c5845b165211fcdab83651f2a5',1,1),(5,'Novruz Amirov','employee1@itu.edu.tr','ada3197469dbc37df5789eda636a6c4c24f4cf368ec089f640c7981b2a450fe9be9a0d6896ec5714cb00a1e1b63571f34e9d63c5845b165211fcdab83651f2a5',1,1),(6,'Novruz Amirov','admin@itu.edu.tr','ada3197469dbc37df5789eda636a6c4c24f4cf368ec089f640c7981b2a450fe9be9a0d6896ec5714cb00a1e1b63571f34e9d63c5845b165211fcdab83651f2a5',1,1),(7,'Novruz Amirov','emp1@itu.edu.tr','3c9909afec25354d551dae21590bb26e38d53f2173b8d3dc3eee4c047e7ab1c1eb8b85103e3be7ba613b31bb5c9c36214dc9f14a42fd7a2fdb84856bca5c44c2',1,1),(8,'Adil Mahmudlu','emp2@itu.edu.tr','18bff0f161aea88bd8d137c335f188063ff22b9fb3d106cb7b01f08f1bc72d943fa72e7ab0f70d6429fc8d8e91b3fe266bc641a62c0c584e99ae7f62af73865e',1,1),(9,'Bilal Tuncer','emp3@itu.edu.tr','18bff0f161aea88bd8d137c335f188063ff22b9fb3d106cb7b01f08f1bc72d943fa72e7ab0f70d6429fc8d8e91b3fe266bc641a62c0c584e99ae7f62af73865e',1,1),(10,'Bilal Tuncer','emp4@itu.edu.tr','3c9909afec25354d551dae21590bb26e38d53f2173b8d3dc3eee4c047e7ab1c1eb8b85103e3be7ba613b31bb5c9c36214dc9f14a42fd7a2fdb84856bca5c44c2',1,1),(11,'Novruz Amirov','e@itu.edu.tr','3c9909afec25354d551dae21590bb26e38d53f2173b8d3dc3eee4c047e7ab1c1eb8b85103e3be7ba613b31bb5c9c36214dc9f14a42fd7a2fdb84856bca5c44c2',1,1),(12,'Novruz Amirov','e2@itu.edu.tr','3c9909afec25354d551dae21590bb26e38d53f2173b8d3dc3eee4c047e7ab1c1eb8b85103e3be7ba613b31bb5c9c36214dc9f14a42fd7a2fdb84856bca5c44c2',1,1),(13,'Novruz Amirov','e4@itu.edu.tr','3c9909afec25354d551dae21590bb26e38d53f2173b8d3dc3eee4c047e7ab1c1eb8b85103e3be7ba613b31bb5c9c36214dc9f14a42fd7a2fdb84856bca5c44c2',1,1),(14,'Novruz Amirov','s@gmail.com','3c9909afec25354d551dae21590bb26e38d53f2173b8d3dc3eee4c047e7ab1c1eb8b85103e3be7ba613b31bb5c9c36214dc9f14a42fd7a2fdb84856bca5c44c2',1,1),(15,'Novruz Amirov','emp@itu.edu.tr','3c9909afec25354d551dae21590bb26e38d53f2173b8d3dc3eee4c047e7ab1c1eb8b85103e3be7ba613b31bb5c9c36214dc9f14a42fd7a2fdb84856bca5c44c2',1,1),(16,'Novruz Amirov','em@gmail.com','5aadb45520dcd8726b2822a7a78bb53d794f557199d5d4abdedd2c55a4bd6ca73607605c558de3db80c8e86c3196484566163ed1327e82e8b6757d1932113cb8',1,1),(17,'Novruz Amirov','test@gmail.com','3c9909afec25354d551dae21590bb26e38d53f2173b8d3dc3eee4c047e7ab1c1eb8b85103e3be7ba613b31bb5c9c36214dc9f14a42fd7a2fdb84856bca5c44c2',1,1),(18,'Novruz Amirov','a@gmail.com','5aadb45520dcd8726b2822a7a78bb53d794f557199d5d4abdedd2c55a4bd6ca73607605c558de3db80c8e86c3196484566163ed1327e82e8b6757d1932113cb8',1,1),(19,'Novruz Amirov','1@gmail.com','3c9909afec25354d551dae21590bb26e38d53f2173b8d3dc3eee4c047e7ab1c1eb8b85103e3be7ba613b31bb5c9c36214dc9f14a42fd7a2fdb84856bca5c44c2',1,1),(20,'Novruz Amirov','b@itu.edu.tr','3c9909afec25354d551dae21590bb26e38d53f2173b8d3dc3eee4c047e7ab1c1eb8b85103e3be7ba613b31bb5c9c36214dc9f14a42fd7a2fdb84856bca5c44c2',1,1),(21,'Leminur Celik','leminur@gmail.com','3c9909afec25354d551dae21590bb26e38d53f2173b8d3dc3eee4c047e7ab1c1eb8b85103e3be7ba613b31bb5c9c36214dc9f14a42fd7a2fdb84856bca5c44c2',1,1),(22,'new test account','new@mail.com','aa54def9e0bb11c1ebbfc97a9ee63af9e95c4fdf1d032b1ddcc0f21661f748651d2b2b8fb94e9ae041780554db29815daa1c0fe991ddae54eff0c4c28cd9d20c',1,1),(23,'Novruz Amirov','y@mail.com','3c9909afec25354d551dae21590bb26e38d53f2173b8d3dc3eee4c047e7ab1c1eb8b85103e3be7ba613b31bb5c9c36214dc9f14a42fd7a2fdb84856bca5c44c2',1,1),(24,'Novruz Amirov','1@mail.com','3c9909afec25354d551dae21590bb26e38d53f2173b8d3dc3eee4c047e7ab1c1eb8b85103e3be7ba613b31bb5c9c36214dc9f14a42fd7a2fdb84856bca5c44c2',1,1),(25,'Novruz Amirov','novruz.amirov2004@gmail.com','3c9909afec25354d551dae21590bb26e38d53f2173b8d3dc3eee4c047e7ab1c1eb8b85103e3be7ba613b31bb5c9c36214dc9f14a42fd7a2fdb84856bca5c44c2',1,1),(26,'Novruz Amirov','pass@gmail.com','a4bb2827d9c4d150e32be67b9b2cd21f93cfaf638dc61affba40206830998df9090b787ee2cdb58c4688307a4e43b9fd1248b806f26d853cf7566e1f0f09afae',1,1),(27,'Leminur','leminur@itu.edu.tr','00f3f9a6c61eeec5fdf0b3db42fab75173955dd32338a2a273828350559005f372fd482f50a76e3536421b44f5ec3e0d106e59a7ee335d5aece6a006baa7a2b5',1,1),(28,'Buse Orak','orakb21@itu.edu.tr','d145962363bde4bb77e2676db3da154a1c071cfc6bbfb84297b9e2715ee67a20c2ec2cafe2fdf091c3dcb3d41cb719542b4bb97a46f1a76080d165e1eadd893c',1,1),(29,'123','123@mail.com','bef88a4d33d89c10d4d35635c903d5cbd4002ba353655edfb19500624ff5778d7cf62ec6fae3a2cf75bb2de98af7f427a5b9308c18634480ebeb13522a0296f5',1,1),(30,'John Doe','johndoe@gmail.com','bef88a4d33d89c10d4d35635c903d5cbd4002ba353655edfb19500624ff5778d7cf62ec6fae3a2cf75bb2de98af7f427a5b9308c18634480ebeb13522a0296f5',1,1),(31,'John Doe','johndoe1@gmail.com','dc008276fa71fd80afbfe902bc16179b86421c783a8eed6616c89d0c0cd7a24bf7470492e26ab8b4f866fa8fe4a7b6f663fe01cabab96278b3fc22a29dfe965d',1,1),(32,'John Doe','johnd@gmail.com','f9eb2053a7e2365c5ecb18438e43bc28bd9ea7263572acf29f822baaeff82177f3ef1e484084f84098fa6f8299f56fac07ccbdc515fbf41c618b9ac12e8f5e3a',1,1),(33,'John Doe','johndoe2@gmail.com','bf211400b590d3ab8f423fda189852af6aa279b21abb9a844b2ab5cd6c31f3629104e5872b83d8c8c2c0d457a37ff5f7b6d695a31f96196ad2be1eb44f6cf864',1,1),(34,'John Doe','johndoe3@gmail.com','4f6ff81173f763582a67e9f366f40281f7c240e25f2d8381762ce20e2485191c07aa22413b469f0f474377ef6223fc2a0eda9aaf847bc6bdf947c93ff69ef926',1,1),(35,'John Doe','jogndoe5@gmail.com','3a3d104a79d86f8405457bb1a4b640892a2f544a6e9d81c12864bced075ad24e03dd83597517034c4cfbd47ff9876ce809d1609f36e1ad88418bd9de1bfd97a9',1,1);
/*!40000 ALTER TABLE `Employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Line_Items`
--

DROP TABLE IF EXISTS `Line_Items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Line_Items` (
  `item_id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `product_id` int NOT NULL,
  `size_choice` varchar(50) NOT NULL,
  `milk_choice` varchar(50) NOT NULL,
  `extra_shot_choice` tinyint(1) NOT NULL,
  `caffein_choice` tinyint(1) NOT NULL,
  `price` float NOT NULL,
  PRIMARY KEY (`item_id`),
  KEY `order_id` (`order_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `Line_Items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `Orders` (`order_id`),
  CONSTRAINT `Line_Items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `Products` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=184 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Line_Items`
--

LOCK TABLES `Line_Items` WRITE;
/*!40000 ALTER TABLE `Line_Items` DISABLE KEYS */;
INSERT INTO `Line_Items` VALUES (2,1,37,'small','reduced_fat_milk',1,1,83.4),(3,1,37,'small','reduced_fat_milk',1,1,83.4),(5,1,39,'small','reduced_fat_milk',1,1,93.2),(6,2,39,'small','reduced_fat_milk',1,1,93.2),(7,2,39,'small','reduced_fat_milk',1,1,93.2),(8,3,39,'small','reduced_fat_milk',1,1,93.2),(9,3,39,'small','reduced_fat_milk',1,1,93.2),(10,3,39,'small','reduced_fat_milk',1,1,93.2),(11,3,39,'small','reduced_fat_milk',1,1,93.2),(12,27,39,'small','reduced_fat_milk',0,1,70),(13,28,37,'small','reduced_fat_milk',1,1,0),(14,29,34,'large','reduced_fat_milk',1,1,0),(15,30,35,'large','reduced_fat_milk',1,1,0),(16,31,33,'small','reduced_fat_milk',1,1,0),(17,32,33,'small','reduced_fat_milk',1,1,0),(18,33,33,'small','reduced_fat_milk',1,1,0),(19,34,33,'small','reduced_fat_milk',1,1,0),(20,35,33,'small','reduced_fat_milk',1,1,0),(21,36,33,'small','reduced_fat_milk',1,1,0),(22,37,33,'small','reduced_fat_milk',1,1,0),(23,38,33,'small','reduced_fat_milk',1,1,0),(24,39,33,'small','reduced_fat_milk',1,1,0),(25,40,33,'small','reduced_fat_milk',1,1,0),(26,41,33,'small','reduced_fat_milk',1,1,0),(27,42,34,'small','reduced_fat_milk',1,1,0),(28,43,37,'small','reduced_fat_milk',1,1,0),(29,44,39,'small','reduced_fat_milk',1,1,0),(30,45,40,'small','reduced_fat_milk',1,1,0),(31,49,34,'large','whole_milk',1,1,152.66),(32,50,34,'medium','reduced_fat_milk',1,1,116.74),(33,51,34,'large','lactose_free_milk',1,1,152.66),(34,52,34,'small','lactose_free_milk',1,1,89.8),(35,53,35,'large','whole_milk',1,1,130.73),(36,53,35,'large','whole_milk',1,1,130.73),(37,53,39,'medium','oat_milk',1,1,121.16),(38,54,34,'large','oat_milk',1,1,152.66),(39,54,34,'large','oat_milk',1,1,152.66),(40,54,37,'small','lactose_free_milk',1,1,83.4),(41,54,43,'large','reduced_fat_milk',1,1,138.89),(42,54,43,'large','reduced_fat_milk',1,1,138.89),(43,54,43,'large','reduced_fat_milk',1,1,138.89),(44,55,36,'large','reduced_fat_milk',1,1,117.13),(45,56,36,'large','whole_milk',1,1,117.13),(46,57,34,'medium','reduced_fat_milk',1,1,116.74),(47,58,35,'small','reduced_fat_milk',1,1,76.9),(48,58,36,'large','reduced_fat_milk',1,1,117.13),(49,58,36,'medium','lactose_free_milk',1,1,89.57),(50,58,36,'medium','oat_milk',1,1,89.57),(51,58,43,'small','reduced_fat_milk',1,1,81.7),(52,59,34,'large','whole_milk',1,1,152.66),(53,59,36,'medium','oat_milk',1,1,89.57),(54,59,36,'medium','reduced_fat_milk',1,1,89.57),(55,59,36,'medium','lactose_free_milk',1,1,89.57),(56,60,34,'medium','lactose_free_milk',1,1,116.74),(57,60,35,'small','lactose_free_milk',1,1,76.9),(58,60,33,'medium','reduced_fat_milk',1,1,110.37),(59,60,33,'medium','reduced_fat_milk',1,1,110.37),(60,61,34,'medium','whole_milk',1,1,116.74),(61,62,34,'medium','reduced_fat_milk',1,1,116.74),(62,63,36,'medium','reduced_fat_milk',1,1,89.57),(63,64,35,'large','oat_milk',1,1,130.73),(64,65,36,'small','whole_milk',1,1,68.9),(65,66,35,'medium','lactose_free_milk',1,1,99.97),(66,67,36,'large','reduced_fat_milk',1,1,0),(67,68,34,'small','lactose_free_milk',1,1,0),(68,69,35,'large','lactose_free_milk',1,1,0),(69,70,34,'medium','reduced_fat_milk',1,1,116.74),(70,70,34,'medium','reduced_fat_milk',1,1,116.74),(71,70,34,'medium','reduced_fat_milk',1,1,116.74),(72,71,35,'medium','whole_milk',1,1,0),(73,72,36,'large','oat_milk',1,1,117.13),(74,72,36,'large','oat_milk',1,1,117.13),(75,72,36,'large','oat_milk',1,1,117.13),(76,72,35,'large','oat_milk',1,1,130.73),(77,72,35,'large','oat_milk',1,1,130.73),(78,73,36,'medium','reduced_fat_milk',1,1,0),(79,74,36,'large','oat_milk',1,1,117.13),(80,74,36,'large','oat_milk',1,1,117.13),(81,74,36,'large','oat_milk',1,1,117.13),(82,74,36,'large','oat_milk',1,1,117.13),(83,75,36,'medium','whole_milk',1,1,89.57),(84,76,41,'medium','whole_milk',1,1,82.42),(85,76,45,'large','whole_milk',1,1,161.33),(86,77,34,'medium','lactose_free_milk',1,1,116.74),(87,78,40,'large','whole_milk',1,1,157.59),(88,79,39,'medium','whole_milk',1,1,121.16),(89,79,36,'medium','whole_milk',1,1,89.57),(90,80,34,'medium','lactose_free_milk',1,1,116.74),(91,81,34,'medium','oat_milk',1,1,0),(92,82,39,'medium','whole_milk',1,1,0),(93,83,37,'large','whole_milk',1,1,0),(94,84,35,'large','whole_milk',1,1,0),(95,85,35,'large','whole_milk',1,1,0),(96,86,33,'large','whole_milk',1,1,0),(97,87,37,'medium','whole_milk',1,1,0),(98,88,33,'medium','whole_milk',1,1,0),(99,89,34,'large','oat_milk',1,1,152.66),(100,89,37,'medium','whole_milk',1,1,108.42),(101,90,36,'large','whole_milk',1,1,117.13),(102,90,37,'small','lactose_free_milk',1,1,83.4),(103,91,36,'medium','whole_milk',1,1,89.57),(104,91,34,'large','lactose_free_milk',1,1,152.66),(105,92,39,'medium','oat_milk',1,1,0),(106,93,39,'medium','oat_milk',1,1,0),(107,94,39,'medium','lactose_free_milk',1,1,0),(108,95,39,'medium','oat_milk',1,1,121.16),(109,95,39,'medium','oat_milk',1,1,121.16),(110,95,39,'medium','oat_milk',1,1,121.16),(111,96,36,'small','whole_milk',1,1,0),(112,97,37,'medium','reduced_fat_milk',1,1,108.42),(113,97,37,'medium','reduced_fat_milk',1,1,108.42),(114,97,37,'medium','reduced_fat_milk',1,1,108.42),(115,98,36,'medium','almond_milk',1,1,0),(116,101,39,'medium','reduced_fat_milk',1,1,0),(117,102,37,'medium','whole_milk',1,1,0),(118,103,36,'small','whole_milk',1,1,0),(119,104,39,'large','whole_milk',1,1,0),(120,105,35,'small','whole_milk',1,1,0),(121,108,36,'medium','whole_milk',1,1,0),(122,109,36,'medium','whole_milk',1,1,0),(123,110,41,'medium','no_milk',1,1,82.42),(124,111,34,'medium','whole_milk',1,1,0),(125,112,41,'medium','no_milk',1,1,82.42),(126,112,41,'medium','no_milk',1,1,82.42),(127,112,41,'medium','no_milk',1,1,82.42),(128,113,41,'large','no_milk',1,1,107.78),(129,114,35,'medium','whole_milk',1,1,0),(130,115,37,'large','whole_milk',1,1,141.78),(131,116,46,'medium','whole_milk',1,1,118.3),(132,117,34,'large','whole_milk',1,1,0),(133,118,34,'medium','whole_milk',1,1,116.74),(134,118,34,'medium','whole_milk',1,1,116.74),(135,118,34,'medium','whole_milk',1,1,116.74),(136,118,34,'medium','whole_milk',1,1,116.74),(137,118,34,'medium','whole_milk',1,1,116.74),(138,118,34,'medium','whole_milk',1,1,116.74),(139,118,34,'medium','whole_milk',1,1,116.74),(140,118,34,'medium','whole_milk',1,1,116.74),(141,118,34,'medium','whole_milk',1,1,116.74),(142,119,36,'large','whole_milk',1,1,0),(143,120,34,'large','whole_milk',1,1,0),(144,121,39,'medium','whole_milk',1,1,121.16),(145,122,34,'large','whole_milk',1,1,0),(146,123,37,'medium','whole_milk',1,1,0),(147,124,35,'large','whole_milk',1,1,130.73),(148,125,35,'small','whole_milk',1,1,0),(149,126,34,'medium','whole_milk',1,1,0),(150,127,36,'small','oat_milk',1,1,0),(151,128,36,'small','whole_milk',1,1,0),(152,129,36,'small','whole_milk',1,1,0),(153,130,39,'small','whole_milk',1,1,0),(154,131,39,'medium','oat_milk',1,1,121.16),(155,131,37,'large','whole_milk',1,1,141.78),(156,131,41,'medium','no_milk',1,1,82.42),(157,131,46,'large','whole_milk',1,1,154.7),(158,132,35,'medium','whole_milk',1,1,99.97),(159,132,36,'small','oat_milk',1,1,68.9),(160,132,36,'small','oat_milk',1,1,68.9),(161,132,36,'small','oat_milk',1,1,68.9),(162,132,36,'small','oat_milk',1,1,68.9),(163,132,37,'medium','whole_milk',1,1,108.42),(164,133,39,'large','whole_milk',1,1,0),(165,134,34,'medium','whole_milk',1,1,116.74),(166,135,43,'medium','lactose_free_milk',1,1,0),(167,136,39,'medium','lactose_free_milk',1,1,0),(168,137,39,'small','lactose_free_milk',1,1,0),(169,138,39,'medium','whole_milk',1,1,0),(170,139,50,'large','no_milk',1,1,0),(171,140,46,'medium','whole_milk',1,1,0),(172,141,41,'medium','no_milk',1,1,0),(173,142,36,'large','lactose_free_milk',1,1,117.13),(174,142,41,'small','no_milk',1,1,63.4),(175,142,41,'small','no_milk',1,1,63.4),(176,142,41,'small','no_milk',1,1,63.4),(177,142,46,'medium','whole_milk',1,1,118.3),(178,143,36,'large','lactose_free_milk',1,1,117.13),(179,143,50,'medium','no_milk',1,1,107.51),(180,143,50,'medium','no_milk',1,1,107.51),(181,143,50,'medium','no_milk',1,1,107.51),(182,143,46,'medium','oat_milk',1,1,118.3),(183,144,34,'medium','reduced_fat_milk',1,1,0);
/*!40000 ALTER TABLE `Line_Items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Orders`
--

DROP TABLE IF EXISTS `Orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Orders` (
  `order_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `order_date` varchar(255) NOT NULL,
  `order_status` varchar(255) NOT NULL,
  `employee_id` int DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `customer_id` (`customer_id`),
  KEY `employee_id` (`employee_id`),
  CONSTRAINT `Orders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `Customers` (`customer_id`),
  CONSTRAINT `Orders_ibfk_2` FOREIGN KEY (`employee_id`) REFERENCES `Employees` (`employee_id`)
) ENGINE=InnoDB AUTO_INCREMENT=145 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Orders`
--

LOCK TABLES `Orders` WRITE;
/*!40000 ALTER TABLE `Orders` DISABLE KEYS */;
INSERT INTO `Orders` VALUES (1,1,'string','delivered',NULL),(2,1,'string','delivered',NULL),(3,1,'string','cancelled',NULL),(4,1,'string','cancelled',NULL),(5,1,'string','cancelled',NULL),(6,1,'string','cancelled',NULL),(7,1,'string','cancelled',NULL),(8,1,'string','cancelled',NULL),(9,1,'string','cancelled',NULL),(10,1,'string','cancelled',NULL),(11,1,'string','cancelled',NULL),(12,1,'string','cancelled',NULL),(13,1,'2024-01-01 17:46:05.31','cancelled',NULL),(14,1,'2024-01-01 17:46:05.94','cancelled',NULL),(15,1,'2024-01-01 17:46:06.76','cancelled',NULL),(16,1,'2024-01-01 17:46:56.12','cancelled',NULL),(17,1,'2024-01-01 17:47:18.95','cancelled',NULL),(18,1,'2024-01-01 18:05:07.42','cancelled',NULL),(19,1,'2024-01-01 18:08:55.54','cancelled',NULL),(20,1,'2024-01-01 18:24:12.34','cancelled',NULL),(21,1,'2024-01-01 18:25:01.78','cancelled',NULL),(22,1,'2024-01-01 18:29:35.78','cancelled',NULL),(23,1,'2024-01-01 18:32:35.65','cancelled',NULL),(24,1,'2024-01-01 18:33:34.28','cancelled',NULL),(25,1,'2024-01-01 18:43:36.55','cancelled',NULL),(26,1,'2024-01-01 18:56:21.10','cancelled',NULL),(27,1,'2024-01-01 19:06:31.62','delivered',NULL),(28,1,'2024-01-02 10:34:21.70','delivered',NULL),(29,1,'2024-01-02 17:39:55.83','delivered',NULL),(30,1,'2024-01-02 17:40:15.13','cancelled',NULL),(31,1,'2024-01-03 10:34:42.93','delivered',NULL),(32,1,'2024-01-03 10:40:57.67','delivered',NULL),(33,1,'2024-01-03 10:44:42.84','cancelled',NULL),(34,1,'2024-01-03 10:44:43.23','delivered',NULL),(35,1,'2024-01-03 10:44:43.75','cancelled',NULL),(36,1,'2024-01-03 10:54:33.24','cancelled',NULL),(37,1,'2024-01-03 10:54:33.58','cancelled',NULL),(38,1,'2024-01-03 10:55:06.42','delivered',NULL),(39,1,'2024-01-03 10:55:06.58','cancelled',NULL),(40,1,'2024-01-03 10:55:07.55','cancelled',NULL),(41,1,'2024-01-03 10:55:42.35','cancelled',NULL),(42,1,'2024-01-03 10:55:45.45','delivered',NULL),(43,1,'2024-01-03 10:55:50.73','cancelled',NULL),(44,1,'2024-01-03 10:55:54.46','cancelled',NULL),(45,1,'2024-01-03 10:56:05.68','delivered',NULL),(46,4,'2024-01-04 13:48:32.36','cancelled',NULL),(47,4,'2024-01-04 13:48:37.74','cancelled',NULL),(48,4,'2024-01-04 13:48:53.08','cancelled',NULL),(49,4,'2024-01-04 14:29:46.60','cancelled',NULL),(50,4,'2024-01-04 14:30:56.10','cancelled',NULL),(51,4,'2024-01-04 15:30:18.46','cancelled',NULL),(52,5,'2024-01-04 17:18:13.94','cancelled',NULL),(53,5,'2024-01-04 17:48:40.83','cancelled',NULL),(54,5,'2024-01-04 18:44:22.62','cancelled',NULL),(55,5,'2024-01-04 18:49:54.78','delivered',NULL),(56,5,'2024-01-04 18:50:58.57','delivered',NULL),(57,5,'2024-01-04 19:23:14.16','cancelled',NULL),(58,5,'2024-01-04 19:29:37.75','cancelled',NULL),(59,5,'2024-01-04 19:31:56.23','delivered',NULL),(60,5,'2024-01-04 19:32:43.81','delivered',NULL),(61,5,'2024-01-04 19:41:20.82','delivered',NULL),(62,5,'2024-01-04 19:44:18.02','cancelled',NULL),(63,5,'2024-01-04 19:48:03.32','cancelled',NULL),(64,5,'2024-01-04 20:31:33.41','cancelled',NULL),(65,6,'2024-01-04 20:38:28.95','delivered',NULL),(66,6,'2024-01-04 20:44:22.02','cancelled',NULL),(67,5,'2024-01-04 21:55:55.34','cancelled',NULL),(68,5,'2024-01-04 21:56:27.69','cancelled',NULL),(69,5,'2024-01-04 21:56:40.21','delivered',NULL),(70,6,'2024-01-04 21:57:31.51','waiting',NULL),(71,6,'2024-01-04 22:01:03.02','cancelled',NULL),(72,6,'2024-01-04 22:01:39.41','waiting',NULL),(73,6,'2024-01-04 22:01:50.70','waiting',NULL),(74,6,'2024-01-04 22:02:14.56','waiting',NULL),(75,7,'2024-01-04 22:14:27.76','waiting',NULL),(76,5,'2024-01-04 23:05:49.47','waiting',NULL),(77,5,'2024-01-04 23:17:15.73','waiting',NULL),(78,5,'2024-01-04 23:27:32.92','waiting',NULL),(79,5,'2024-01-04 23:40:50.34','waiting',NULL),(80,5,'2024-01-05 06:10:23.67','waiting',NULL),(81,5,'2024-01-05 06:19:27.41','waiting',NULL),(82,5,'2024-01-05 06:19:42.51','waiting',NULL),(83,5,'2024-01-05 06:19:46.80','waiting',NULL),(84,5,'2024-01-05 06:19:51.65','waiting',NULL),(85,5,'2024-01-05 06:19:56.56','waiting',NULL),(86,5,'2024-01-05 06:20:33.99','waiting',NULL),(87,6,'2024-01-05 06:21:09.93','waiting',NULL),(88,6,'2024-01-05 06:21:15.59','waiting',NULL),(89,8,'2024-01-05 06:27:42.63','delivered',NULL),(90,8,'2024-01-05 06:50:37.59','cancelled',NULL),(91,5,'2024-01-05 09:48:21.51','waiting',NULL),(92,6,'2024-01-05 09:51:37.28','waiting',NULL),(93,6,'2024-01-05 09:54:46.52','waiting',NULL),(94,6,'2024-01-05 09:55:14.12','waiting',NULL),(95,6,'2024-01-05 09:55:47.28','waiting',NULL),(96,6,'2024-01-05 09:55:53.90','waiting',NULL),(97,4,'2024-01-05 09:56:49.05','waiting',NULL),(98,4,'2024-01-05 09:56:54.20','waiting',NULL),(99,6,'2024-01-05 11:06:23.88','waiting',NULL),(100,6,'2024-01-05 11:06:25.05','waiting',NULL),(101,6,'2024-01-05 11:15:32.55','waiting',NULL),(102,6,'2024-01-05 11:15:41.18','waiting',NULL),(103,6,'2024-01-05 11:17:33.70','waiting',NULL),(104,6,'2024-01-05 11:17:38.53','waiting',NULL),(105,6,'2024-01-05 11:17:42.29','waiting',NULL),(106,6,'2024-01-05 11:17:57.36','waiting',NULL),(107,6,'2024-01-05 11:17:58.41','waiting',NULL),(108,6,'2024-01-05 11:26:17.68','waiting',NULL),(109,6,'2024-01-05 11:30:58.86','waiting',NULL),(110,6,'2024-01-05 11:35:16.43','waiting',NULL),(111,6,'2024-01-05 11:35:28.57','waiting',NULL),(112,6,'2024-01-05 11:39:47.71','waiting',NULL),(113,6,'2024-01-05 11:40:04.27','waiting',NULL),(114,6,'2024-01-05 11:40:32.60','waiting',NULL),(115,5,'2024-01-05 11:46:12.86','waiting',NULL),(116,6,'2024-01-05 11:47:57.97','waiting',NULL),(117,5,'2024-01-05 11:48:18.81','waiting',NULL),(118,6,'2024-01-05 11:49:30.07','waiting',NULL),(119,6,'2024-01-05 11:49:41.81','waiting',NULL),(120,5,'2024-01-05 11:50:10.48','waiting',NULL),(121,5,'2024-01-05 12:06:16.85','waiting',NULL),(122,4,'2024-01-05 12:06:38.07','waiting',NULL),(123,6,'2024-01-05 12:07:07.33','waiting',NULL),(124,5,'2024-01-05 12:08:21.91','waiting',NULL),(125,4,'2024-01-05 12:09:18.56','waiting',NULL),(126,5,'2024-01-05 12:09:37.01','waiting',NULL),(127,4,'2024-01-05 12:10:29.56','waiting',NULL),(128,6,'2024-01-05 12:10:58.75','waiting',NULL),(129,6,'2024-01-05 12:11:04.50','waiting',NULL),(130,6,'2024-01-05 12:11:09.53','waiting',NULL),(131,5,'2024-01-05 12:13:17.62','waiting',NULL),(132,4,'2024-01-05 12:18:50.76','waiting',NULL),(133,4,'2024-01-05 12:20:01.98','delivered',NULL),(134,5,'2024-01-05 12:32:54.28','waiting',NULL),(135,5,'2024-01-05 12:33:41.32','waiting',NULL),(136,5,'2024-01-05 12:56:06.59','delivered',NULL),(137,4,'2024-01-05 12:58:53.32','delivered',NULL),(138,4,'2024-01-05 13:00:33.64','delivered',NULL),(139,5,'2024-01-05 13:16:56.94','waiting',NULL),(140,5,'2024-01-05 13:17:30.21','waiting',NULL),(141,5,'2024-01-05 13:18:15.69','waiting',NULL),(142,5,'2024-01-05 13:22:28.08','cancelled',NULL),(143,13,'2024-01-05 13:29:32.49','cancelled',NULL),(144,13,'2024-01-05 13:30:42.20','waiting',NULL);
/*!40000 ALTER TABLE `Orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Products`
--

DROP TABLE IF EXISTS `Products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Products` (
  `product_id` int NOT NULL AUTO_INCREMENT,
  `coffee_name` varchar(50) NOT NULL,
  `photo_path` varchar(200) NOT NULL,
  `espresso_amount` float NOT NULL,
  `milk_amount` float DEFAULT NULL,
  `foam_amount` float DEFAULT NULL,
  `chocolate_syrup_amount` float DEFAULT NULL,
  `caramel_syrup_amount` float DEFAULT NULL,
  `white_chocolate_syrup_amount` float DEFAULT NULL,
  `sugar_amount` float DEFAULT NULL,
  `ice_amount` int DEFAULT NULL,
  `small_cup_only` tinyint(1) DEFAULT '0',
  `price` float NOT NULL,
  `rate` float DEFAULT '0',
  `rate_count` int DEFAULT '0',
  `is_product_disabled` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`product_id`),
  UNIQUE KEY `coffee_name` (`coffee_name`)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Products`
--

LOCK TABLES `Products` WRITE;
/*!40000 ALTER TABLE `Products` DISABLE KEYS */;
INSERT INTO `Products` VALUES (33,'Ristretto Bianco','https://drive.google.com/uc?id=1XMGog5t20jutfjLY5IDCCL20iO-KdRw6',40,30,20,0,10,0,25,0,0,84.9,0,0,0),(34,'Caffee Macchiato','https://drive.google.com/uc?id=1v1KTqUT7aQiBAI5yFKqnm9KepgGjDzXj',30,30,20,0,20,0,20,0,0,89.8,3.3077,13,0),(35,'Cappucino','https://drive.google.com/uc?id=15m4pMJAOeeBJgHTqW8yybkLYP2Zg8B_Y',30,40,30,0,0,0,40,0,0,76.9,2.5,2,0),(36,'Caffe Latte','https://drive.google.com/uc?id=1_yE3Kz1I956UCYHoxxmMW0c9Nnx6g3gT',20,20,40,0,20,0,30,0,NULL,68.9,3.75,4,1),(37,'Mocha','https://drive.google.com/uc?id=1Qnd7P5cyCbJ_EN85d-nMGszEf452NCUb',25,35,25,0,15,0,70,0,NULL,83.4,4.5,4,0),(39,'Americano','https://drive.google.com/uc?id=1JvYCgQgu-RWx9gjs779yrnofpE2iNbPT',70,10,20,0,0,0,5,0,NULL,93.2,0,0,0),(40,'Flat White','https://drive.google.com/uc?id=1hercKUB1HiY6y_KqZR3N4JR_JMF3N63T',35,35,30,0,0,0,40,0,NULL,92.7,0,0,0),(41,'Espresso','https://drive.google.com/uc?id=1DZfx1XHUPCCRCktDOCV7xj7S3NauIfxi',89,0,11,0,0,0,0,0,1,63.4,4.6,5,0),(42,'Doppio','https://drive.google.com/uc?id=1_c0YNYfvnAQBu0d8Uo4UjjKvuyznjVaB',100,0,0,0,0,0,0,0,0,78.2,0,0,0),(43,'Iced Caramel Macchiato','https://drive.google.com/uc?id=15k7_zBo-1-eMjjU1vUvcf9qPi6JfJVn0',20,50,0,0,30,0,20,5,0,81.7,0,0,0),(45,'White Chocalate Mocha','https://drive.google.com/uc?id=1nahfVhh15noZcei4wlC_rJEOffO-ZIaA',40,0,20,0,0,30,20,0,0,94.9,0,0,0),(46,'Affagato','https://drive.google.com/uc?id=1OfRPCgDyT44vE3Wyl1-FHiBnB5HV7Fps',30,40,0,20,10,0,55,6,NULL,91,4.85714,7,0),(47,'Irish Coffee','https://drive.google.com/uc?id=1VXXTlaN39aES6r7dGmJDhOkFS4F7Y4U5',90,0,0,0,10,0,40,0,1,72.9,0,0,0),(48,'Con Panna','https://drive.google.com/uc?id=1LcCcw7tWvAkwrXub8Da2oDVIjkNZ8CFb',40,40,10,0,10,0,60,0,NULL,61.9,0,0,0),(49,'Cortado','https://drive.google.com/uc?id=1JcjEB6AVuIB9bhnCsNixtdNzcXTiIxCl',40,50,0,10,0,0,50,0,NULL,78.9,0,0,0),(50,'Lungo Coffee','https://drive.google.com/uc?id=1FeVxKUdmyFdu3WtMm0Aclv0VdnGCQjuA',70,0,10,20,0,0,12,0,0,82.7,3.9,10,0),(59,'Coffee Latte','https://drive.google.com/uc?id=1_yE3Kz1I956UCYHoxxmMW0c9Nnx6g3gT',40,40,20,0,0,0,20,0,0,65.3,0,0,1),(62,'Latte','https://drive.google.com/uc?id=1_yE3Kz1I956UCYHoxxmMW0c9Nnx6g3gT',100,0,0,0,0,0,20,0,0,12.9,0,0,1),(65,'test','https://drive.google.com/uc?id=1_yE3Kz1I956UCYHoxxmMW0c9Nnx6g3gT',1,99,0,0,0,0,0,0,0,12,0,0,1),(67,'Novruz','https://drive.google.com/uc?id=1_yE3Kz1I956UCYHoxxmMW0c9Nnx6g3gT',100,0,0,0,0,0,0,0,0,12,0,0,1),(68,'new_coffee','https://drive.google.com/uc?id=1_yE3Kz1I956UCYHoxxmMW0c9Nnx6g3gT',80,15,0,0,0,5,20,0,0,95.3,0,0,0);
/*!40000 ALTER TABLE `Products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Stocks`
--

DROP TABLE IF EXISTS `Stocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Stocks` (
  `stock_id` int NOT NULL AUTO_INCREMENT,
  `small_cup_count` int NOT NULL,
  `medium_cup_count` int NOT NULL,
  `large_cup_count` int NOT NULL,
  `espresso_amount` float NOT NULL,
  `decaff_espresso_amount` float NOT NULL,
  `whole_milk_amount` float NOT NULL,
  `reduced_fat_milk_amount` float NOT NULL,
  `lactose_free_milk_amount` float NOT NULL,
  `oat_milk_amount` float NOT NULL,
  `almond_milk_amount` float NOT NULL,
  `chocolate_syrup_amount` float NOT NULL,
  `white_chocolate_syrup_amount` float NOT NULL,
  `caramel_syrup_amount` float NOT NULL,
  `white_sugar_amount` float NOT NULL,
  `brown_sugar_amount` float NOT NULL,
  `ice_amount` int NOT NULL,
  PRIMARY KEY (`stock_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Stocks`
--

LOCK TABLES `Stocks` WRITE;
/*!40000 ALTER TABLE `Stocks` DISABLE KEYS */;
INSERT INTO `Stocks` VALUES (1,784,3000,1500,82791,100000,96553.7,98650,99029,98646,99958,99710,99940,96950,93429.5,140,99910);
/*!40000 ALTER TABLE `Stocks` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-01-06 11:59:58
