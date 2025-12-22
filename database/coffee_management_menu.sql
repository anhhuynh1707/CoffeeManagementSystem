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
-- Table structure for table `menu`
--

DROP TABLE IF EXISTS `menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` text,
  `price` decimal(10,0) NOT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `category` varchar(50) DEFAULT NULL,
  `status` varchar(20) DEFAULT 'available',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu`
--

LOCK TABLES `menu` WRITE;
/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
INSERT INTO `menu` VALUES (1,'Matcha Latte','Smooth Japanese matcha whisked with milk',45000,'matcha_latte.jpg','Matcha','available','2025-12-04 17:02:21','2025-12-18 18:27:00'),(2,'Iced Matcha Latte','Cold refreshing matcha drink',48000,'iced_matcha_latte.jpg','Matcha','available','2025-12-04 17:02:21','2025-12-18 18:27:00'),(3,'Matcha Frappe','Icy blended matcha with sweet cream',52000,'matcha_frappe.jpg','Matcha','available','2025-12-04 17:02:21','2025-12-18 18:27:00'),(4,'Matcha Espresso Fusion','Matcha layered with espresso',50000,'matcha_espresso_fusion.jpg','Matcha','available','2025-12-04 17:02:21','2025-12-18 18:27:00'),(5,'Americano','Smooth hot americano',30000,'americano.jpg','Coffee','available','2025-12-04 17:02:21','2025-12-18 18:27:00'),(6,'Cappuccino','Espresso with steamed milk foam',38000,'cappuccino.jpg','Coffee','available','2025-12-04 17:02:21','2025-12-18 18:27:00'),(7,'Latte','Rich espresso with steamed milk',42000,'latte.jpg','Coffee','available','2025-12-04 17:02:21','2025-12-18 18:27:00'),(8,'Mocha','Chocolate-flavored caffe latte',46000,'mocha.jpg','Coffee','available','2025-12-04 17:02:21','2025-12-18 18:27:00'),(9,'Iced Coffee','Cold brewed arabica coffee',38000,'iced_coffee.jpg','Coffee','available','2025-12-04 17:02:21','2025-12-18 18:27:00'),(10,'Jasmine Green Tea','Light and floral green tea infusion',32000,'jasmine_tea.jpg','Tea','available','2025-12-04 17:02:21','2025-12-18 18:27:00'),(11,'Peach Tea','Sweet peach-flavored iced tea',36000,'peach_tea.jpg','Tea','available','2025-12-04 17:02:21','2025-12-18 18:27:00'),(12,'Lemon Black Tea','Bold black tea with lemon',35000,'lemon_black_tea.jpg','Tea','available','2025-12-04 17:02:21','2025-12-18 18:27:00'),(13,'Classic Milk Tea','Authentic Taiwanese milk tea',39000,'classic_milk_tea.jpg','Milk Tea','available','2025-12-04 17:02:21','2025-12-18 18:27:00'),(14,'Brown Sugar Milk Tea','Brown sugar with tapioca pearls',46000,'brown_sugar_milk_tea.jpg','Milk Tea','available','2025-12-04 17:02:21','2025-12-18 18:27:00'),(15,'Matcha Milk Tea','Creamy matcha mixed with milk tea',45000,'matcha_milk_tea.jpg','Milk Tea','available','2025-12-04 17:02:21','2025-12-18 18:27:00'),(16,'Matcha Cheesecake','Soft cheesecake infused with matcha',55000,'matcha_cheesecake.jpg','Bakery','available','2025-12-04 17:02:21','2025-12-18 18:27:00'),(17,'Chocolate Croissant','Flaky croissant with chocolate',32000,'chocolate_croissant.jpg','Bakery','available','2025-12-04 17:02:21','2025-12-18 18:27:00'),(18,'Butter Croissant','Classic buttery French croissant',28000,'butter_croissant.jpg','Bakery','available','2025-12-04 17:02:21','2025-12-18 18:27:00'),(19,'Tiramisu Cup','Italian dessert with mascarpone',49000,'tiramisu_cup.jpg','Bakery','available','2025-12-04 17:02:21','2025-12-18 18:27:00'),(20,'Banana Muffin','Moist banana muffin baked daily',25000,'banana_muffin.jpg','Bakery','available','2025-12-04 17:02:21','2025-12-18 18:27:00');
/*!40000 ALTER TABLE `menu` ENABLE KEYS */;
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
