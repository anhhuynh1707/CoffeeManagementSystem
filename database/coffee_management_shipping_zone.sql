-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: localhost    Database: coffee_management
-- ------------------------------------------------------
-- Server version	8.0.43

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `shipping_zone`
--

DROP TABLE IF EXISTS `shipping_zone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shipping_zone` (
  `zone_id` int NOT NULL AUTO_INCREMENT,
  `city` varchar(100) NOT NULL,
  `district` varchar(100) NOT NULL,
  `shipping_fee` int NOT NULL,
  PRIMARY KEY (`zone_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shipping_zone`
--

LOCK TABLES `shipping_zone` WRITE;
/*!40000 ALTER TABLE `shipping_zone` DISABLE KEYS */;
INSERT INTO `shipping_zone` VALUES (1,'Ho Chi Minh City','Thu Duc',15000),(2,'Ho Chi Minh City','Binh Thanh',15000),(3,'Ho Chi Minh City','District 1',30000),(4,'Ho Chi Minh City','District 3',30000),(5,'Ho Chi Minh City','District 4',30000),(6,'Ho Chi Minh City','District 5',30000),(7,'Ho Chi Minh City','District 7',30000),(8,'Ho Chi Minh City','District 10',30000),(9,'Ho Chi Minh City','Phu Nhuan',30000),(10,'Ho Chi Minh City','District 6',50000),(11,'Ho Chi Minh City','District 8',50000),(12,'Ho Chi Minh City','District 11',50000),(13,'Ho Chi Minh City','District 12',50000),(14,'Ho Chi Minh City','Tan Binh',50000),(15,'Ho Chi Minh City','Go Vap',50000),(16,'Ho Chi Minh City','Binh Tan',50000),(17,'Ho Chi Minh City','Tan Phu',50000);
/*!40000 ALTER TABLE `shipping_zone` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-21  9:11:58
