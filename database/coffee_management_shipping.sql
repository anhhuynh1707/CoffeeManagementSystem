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
-- Table structure for table `shipping`
--

DROP TABLE IF EXISTS `shipping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shipping` (
  `shipping_id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `receiver_name` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `district` varchar(100) DEFAULT NULL,
  `ward` varchar(100) DEFAULT NULL,
  `shipping_fee` double DEFAULT NULL,
  `method` varchar(50) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`shipping_id`),
  KEY `order_id` (`order_id`),
  CONSTRAINT `shipping_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shipping`
--

LOCK TABLES `shipping` WRITE;
/*!40000 ALTER TABLE `shipping` DISABLE KEYS */;
INSERT INTO `shipping` VALUES (1,30,'Huỳnh Tuấn Anh','0559868875','49/12 Hung Vuong, Thu Duc','Ho Chi Minh City','Thu Duc','',15000,'standard','pending','2025-12-19 12:26:31','2025-12-19 12:26:31'),(2,31,'Huỳnh Tuấn Anh','0559868875','49/12 Hung Vuong, Thu Duc','Ho Chi Minh City','Thu Duc','',15000,'standard','pending','2025-12-20 11:00:44','2025-12-20 11:00:44'),(3,32,'Huỳnh Tuấn Anh','0559868875','49/12 Hung Vuong, Thu Duc','Ho Chi Minh City','Thu Duc','',15000,'standard','pending','2025-12-20 13:12:33','2025-12-20 13:12:33'),(4,33,'Huỳnh Tuấn Anh','0559868875','49/12 Hung Vuong, Thu Duc','Ho Chi Minh City','Thu Duc','',15000,'standard','pending','2025-12-20 13:16:53','2025-12-20 13:16:53'),(5,34,'Huỳnh Tuấn Anh','0559868875','49/12 Hung Vuong, Thu Duc','Ho Chi Minh City','Thu Duc','',15000,'standard','pending','2025-12-20 13:51:14','2025-12-20 13:51:14'),(6,35,'Huỳnh Tuấn Anh','0559868875','49/12 Hung Vuong, Thu Duc','Ho Chi Minh City','Thu Duc','',15000,'standard','pending','2025-12-20 14:16:14','2025-12-20 14:16:14'),(7,36,'Huỳnh Tuấn Anh','0559868875','49/12 Hung Vuong, Thu Duc','Ho Chi Minh City','Thu Duc','',15000,'standard','pending','2025-12-20 14:16:35','2025-12-20 14:16:35'),(8,37,'Huỳnh Tuấn Anh','0559868875','49/12 Hung Vuong, Thu Duc','Ho Chi Minh City','Thu Duc','',15000,'standard','pending','2025-12-20 14:19:50','2025-12-20 14:19:50'),(9,38,'Huỳnh Tuấn Anh','0559868875','49/12 Hung Vuong, Thu Duc','Ho Chi Minh City','Thu Duc','',15000,'standard','pending','2025-12-20 14:20:28','2025-12-20 14:20:28'),(10,39,'Huỳnh Tuấn Anh','0559868875','49/12 Hung Vuong, Thu Duc','Ho Chi Minh City','Thu Duc','',15000,'standard','pending','2025-12-20 14:20:41','2025-12-20 14:20:41'),(11,40,'Huỳnh Tuấn Anh','0559868875','49/12 Hung Vuong, Thu Duc','Ho Chi Minh City','Thu Duc','',15000,'standard','pending','2025-12-20 14:24:51','2025-12-20 14:24:51'),(12,41,'Huỳnh Tuấn Anh','0559868875','49/12 Hung Vuong, Thu Duc','Ho Chi Minh City','Thu Duc','',15000,'standard','pending','2025-12-20 14:25:19','2025-12-20 14:25:19'),(13,42,'Huỳnh Tuấn Anh','0559868875','49/12 Hung Vuong, Thu Duc','Ho Chi Minh City','Thu Duc','',15000,'standard','pending','2025-12-20 14:25:55','2025-12-20 14:25:55'),(14,43,'Huỳnh Tuấn Anh','0559868875','49/12 Hung Vuong, Thu Duc','Ho Chi Minh City','Thu Duc','',15000,'standard','pending','2025-12-20 14:26:05','2025-12-20 14:26:05'),(15,44,'Huỳnh Tuấn Anh','0559868875','49/12 Hung Vuong, Thu Duc','Ho Chi Minh City','Thu Duc','',15000,'standard','pending','2025-12-20 14:26:10','2025-12-20 14:26:10'),(16,45,'Huỳnh Tuấn Anh','0559868875','49/12 Hung Vuong, Thu Duc','Ho Chi Minh City','Thu Duc','',15000,'standard','pending','2025-12-20 14:26:28','2025-12-20 14:26:28'),(17,46,'Huỳnh Tuấn Anh','0559868875','49/12 Hung Vuong, Thu Duc','Ho Chi Minh City','Thu Duc','',15000,'standard','pending','2025-12-20 14:42:18','2025-12-20 14:42:18'),(18,47,'Huỳnh Tuấn Anh','0559868875','49/12 Hung Vuong, Thu Duc','Ho Chi Minh City','Thu Duc','',15000,'standard','pending','2025-12-20 14:42:39','2025-12-20 14:42:39'),(19,48,'Huỳnh Tuấn Anh','0933448207','35 Cu Lao, Phu Nhuan','Ho Chi Minh City','Phu Nhuan','',30000,'standard','pending','2025-12-20 14:44:03','2025-12-20 14:44:03'),(20,49,'Huỳnh Tuấn Anh','0559868875','49/12 Hung Vuong, Thu Duc','Ho Chi Minh City','Thu Duc','',15000,'standard','pending','2025-12-20 15:28:05','2025-12-20 15:28:05'),(21,50,'Huỳnh Tuấn Anh','0559868875','49/12 Hung Vuong, Thu Duc','Ho Chi Minh City','Thu Duc','',15000,'standard','pending','2025-12-20 15:28:11','2025-12-20 15:28:11'),(22,51,'Huỳnh Tuấn Anh','0559868875','49/12 Hung Vuong, Thu Duc','Ho Chi Minh City','Thu Duc','',15000,'standard','pending','2025-12-20 15:28:16','2025-12-20 15:28:16'),(23,52,'Huỳnh Tuấn Anh','0559868875','49/12 Hung Vuong, Thu Duc','Ho Chi Minh City','Thu Duc','',15000,'standard','pending','2025-12-20 15:29:07','2025-12-20 15:29:07'),(24,53,'Huỳnh Tuấn Anh','0559868875','49/12 Hung Vuong, Thu Duc','Ho Chi Minh City','Thu Duc','',15000,'standard','pending','2025-12-20 16:59:12','2025-12-20 16:59:12'),(25,54,'Huỳnh Tuấn Anh','0559868875','49/12 Hung Vuong, Thu Duc','Ho Chi Minh City','Thu Duc','',15000,'standard','pending','2025-12-20 17:00:59','2025-12-20 17:00:59'),(26,55,'Huỳnh Tuấn Anh','0559868875','49/12 Hung Vuong, Thu Duc','Ho Chi Minh City','Thu Duc','',15000,'standard','pending','2025-12-20 17:17:50','2025-12-20 17:17:50'),(27,56,'Huỳnh Tuấn Anh','0559868875','49/12 Hung Vuong, Thu Duc','Ho Chi Minh City','Thu Duc','',15000,'standard','pending','2025-12-20 17:19:10','2025-12-20 17:19:10'),(28,57,'Huỳnh Tuấn Anh','0559868875','49/12 Hung Vuong, Thu Duc','Ho Chi Minh City','Thu Duc','',15000,'standard','pending','2025-12-20 17:32:06','2025-12-20 17:32:06'),(29,58,'Huỳnh Tuấn Anh','0559868875','49/12 Hung Vuong, Thu Duc','Ho Chi Minh City','Thu Duc','',15000,'standard','pending','2025-12-20 17:32:14','2025-12-20 17:32:14'),(30,59,'Huỳnh Tuấn Anh','0559868875','49/12 Hung Vuong, Thu Duc','Ho Chi Minh City','Thu Duc','',15000,'standard','pending','2025-12-20 17:33:20','2025-12-20 17:33:20'),(31,60,'Huỳnh Tuấn Anh','0933448207','35 Cu Lao, Phu Nhuan','Ho Chi Minh City','Phu Nhuan','',30000,'standard','pending','2025-12-20 17:41:00','2025-12-20 17:41:00'),(32,61,'Huỳnh Tuấn Anh','0933448207','35 Cu Lao, Phu Nhuan','Ho Chi Minh City','Phu Nhuan','',30000,'standard','pending','2025-12-20 17:41:40','2025-12-20 17:41:40'),(33,62,'Huỳnh Tuấn Anh','0933448207','35 Cu Lao, Phu Nhuan','Ho Chi Minh City','Phu Nhuan','',30000,'standard','pending','2025-12-20 17:42:13','2025-12-20 17:42:13'),(34,63,'Huỳnh Tuấn Anh','0559868875','49/12 Hung Vuong, Thu Duc','Ho Chi Minh City','Thu Duc','',15000,'standard','pending','2025-12-20 17:42:44','2025-12-20 17:42:44'),(35,64,'Huỳnh Tuấn Anh','0559868875','49/12 Hung Vuong, Thu Duc','Ho Chi Minh City','Thu Duc','',15000,'standard','pending','2025-12-20 17:45:17','2025-12-20 17:45:17'),(36,65,'Huỳnh Tuấn Anh','0933448207','35 Cu Lao, Phu Nhuan','Ho Chi Minh City','Phu Nhuan','',30000,'standard','pending','2025-12-20 17:50:09','2025-12-20 17:50:09'),(37,66,'Huỳnh Tuấn Anh','0933448207','35 Cu Lao, Phu Nhuan','Ho Chi Minh City','Phu Nhuan','',30000,'standard','pending','2025-12-20 17:54:33','2025-12-20 17:54:33'),(38,67,'Huỳnh Tuấn Anh','0933448207','35 Cu Lao, Phu Nhuan','Ho Chi Minh City','Phu Nhuan','',30000,'standard','pending','2025-12-20 18:00:32','2025-12-20 18:00:32'),(39,68,'Huỳnh Tuấn Anh','0933448207','35 Cu Lao, Phu Nhuan','Ho Chi Minh City','Phu Nhuan','',30000,'standard','pending','2025-12-20 19:21:33','2025-12-20 19:21:33'),(40,69,'Huỳnh Tuấn Anh','0933448207','35 Cu Lao, Phu Nhuan','Ho Chi Minh City','Phu Nhuan','',30000,'standard','pending','2025-12-20 19:35:36','2025-12-20 19:35:36'),(41,70,'Huỳnh Tuấn Anh','0933448207','35 Cu Lao, Phu Nhuan','Ho Chi Minh City','Phu Nhuan','',30000,'standard','pending','2025-12-20 19:38:19','2025-12-20 19:38:19'),(42,71,'Huỳnh Tuấn Anh','0933448207','35 Cu Lao, Phu Nhuan','Ho Chi Minh City','Phu Nhuan','',30000,'standard','pending','2025-12-20 19:38:32','2025-12-20 19:38:32'),(43,72,'Huỳnh Tuấn Anh','0933448207','35 Cu Lao, Phu Nhuan','Ho Chi Minh City','Phu Nhuan','',30000,'standard','pending','2025-12-20 19:38:39','2025-12-20 19:38:39'),(44,73,'Huỳnh Tuấn Anh','0933448207','35 Cu Lao, Phu Nhuan','Ho Chi Minh City','Phu Nhuan','',30000,'standard','pending','2025-12-20 19:38:50','2025-12-20 19:38:50'),(45,74,'Huỳnh Tuấn Anh','0933448207','35 Cu Lao, Phu Nhuan','Ho Chi Minh City','Phu Nhuan','',30000,'standard','pending','2025-12-20 19:41:18','2025-12-20 19:41:18'),(46,75,'Huỳnh Tuấn Anh','0933448207','35 Cu Lao, Phu Nhuan','Ho Chi Minh City','Phu Nhuan','',30000,'standard','pending','2025-12-20 19:41:53','2025-12-20 19:41:53');
/*!40000 ALTER TABLE `shipping` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-21  9:11:57
