CREATE DATABASE  IF NOT EXISTS `readcart_ecommerce` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `readcart_ecommerce`;
-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: readcart_ecommerce
-- ------------------------------------------------------
-- Server version	8.0.46

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
-- Table structure for table `cart_items`
--

DROP TABLE IF EXISTS `cart_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart_items` (
  `cart_item_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `quantity` int NOT NULL DEFAULT '1',
  `added_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`cart_item_id`),
  UNIQUE KEY `user_id` (`user_id`,`product_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `cart_items_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `cart_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart_items`
--

LOCK TABLES `cart_items` WRITE;
/*!40000 ALTER TABLE `cart_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `category_name` varchar(100) NOT NULL,
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `category_name` (`category_name`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (5,'Biography'),(6,'Business'),(4,'Fantasy'),(1,'Fiction'),(7,'History'),(2,'Self-Help'),(3,'Technology');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_items` (
  `order_item_id` int NOT NULL AUTO_INCREMENT,
  `order_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `quantity` int NOT NULL,
  `price_at_purchase` decimal(10,2) NOT NULL,
  PRIMARY KEY (`order_item_id`),
  KEY `order_id` (`order_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_items`
--

LOCK TABLES `order_items` WRITE;
/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
INSERT INTO `order_items` VALUES (1,1,7,1,650.00),(2,1,2,1,349.00),(3,2,4,1,499.00),(4,2,10,1,399.00);
/*!40000 ALTER TABLE `order_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `order_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `shipping_address` varchar(255) NOT NULL,
  `status` varchar(30) DEFAULT 'PENDING',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`order_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,2,848.00,'Indiranagar, Bangalore, Karnataka','DELIVERED','2026-07-19 19:44:12'),(2,1,898.00,'MG Road, Bangalore, Karnataka','PENDING','2026-07-22 05:18:04');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `product_id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL,
  `author` varchar(150) DEFAULT NULL,
  `category_id` int DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `stock` int NOT NULL DEFAULT '0',
  `description` text,
  `image_url` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`product_id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'To Kill a Mockingbird','Harper Lee',1,399.00,25,'A gripping tale of racial injustice and childhood innocence in the American South.','images/products/mockingbird.jpg','2026-07-19 19:42:05'),(2,'1984','George Orwell',1,349.00,30,'A dystopian novel exploring totalitarianism, surveillance, and truth.','images/products/1984.jpg','2026-07-19 19:42:05'),(3,'The Great Gatsby','F. Scott Fitzgerald',1,299.00,20,'A tragic tale of wealth, love, and the American Dream in the Jazz Age.','images/products/gatsby.jpg','2026-07-19 19:42:05'),(4,'Atomic Habits','James Clear',2,499.00,40,'A practical guide to building good habits and breaking bad ones.','images/products/atomic_habits.jpg','2026-07-19 19:42:05'),(5,'The 7 Habits of Highly Effective People','Stephen R. Covey',2,450.00,35,'A principle-centered approach to personal and professional effectiveness.','images/products/7habits.jpg','2026-07-19 19:42:05'),(6,'Ikigai','Hector Garcia',2,350.00,28,'Japanese wisdom on finding purpose and living a long, meaningful life.','images/products/ikigai.jpg','2026-07-19 19:42:05'),(7,'Clean Code','Robert C. Martin',3,650.00,15,'A handbook of agile software craftsmanship for writing clean, maintainable code.','images/products/clean_code.jpg','2026-07-19 19:42:05'),(8,'The Pragmatic Programmer','David Thomas, Andrew Hunt',3,700.00,12,'Timeless advice for becoming a more effective and adaptive programmer.','images/products/pragmatic_programmer.jpg','2026-07-19 19:42:05'),(9,'Introduction to Algorithms','Thomas H. Cormen',3,950.00,10,'A comprehensive textbook covering a broad range of algorithms in depth.','images/products/clrs.jpg','2026-07-19 19:42:05'),(10,'Harry Potter and the Sorcerer\'s Stone','J.K. Rowling',4,399.00,50,'The first book in the beloved Harry Potter series.','images/products/hp1.jpg','2026-07-19 19:42:05'),(11,'The Hobbit','J.R.R. Tolkien',4,449.00,22,'A fantasy adventure following Bilbo Baggins on an unexpected journey.','images/products/hobbit.jpg','2026-07-19 19:42:05'),(12,'A Game of Thrones','George R.R. Martin',4,550.00,18,'The first novel in the epic fantasy series A Song of Ice and Fire.','images/products/got.jpg','2026-07-19 19:42:05'),(13,'Steve Jobs','Walter Isaacson',5,599.00,16,'The definitive biography of Apple co-founder Steve Jobs.','images/products/steve_jobs.jpg','2026-07-19 19:42:05'),(14,'Long Walk to Freedom','Nelson Mandela',5,499.00,14,'The autobiography of Nelson Mandela, chronicling his fight against apartheid.','images/products/mandela.jpg','2026-07-19 19:42:05'),(15,'Wings of Fire','A.P.J. Abdul Kalam',5,299.00,30,'The autobiography of India\'s Missile Man and former President.','images/products/wings_of_fire.jpg','2026-07-19 19:42:05'),(16,'Zero to One','Peter Thiel',6,399.00,20,'Notes on startups and how to build the future.','images/products/zero_to_one.jpg','2026-07-19 19:42:05'),(17,'The Lean Startup','Eric Ries',6,449.00,18,'A methodology for developing businesses and products efficiently.','images/products/lean_startup.jpg','2026-07-19 19:42:05'),(18,'Rich Dad Poor Dad','Robert T. Kiyosaki',6,349.00,45,'A guide to financial literacy and building wealth through investing.','images/products/rich_dad.jpg','2026-07-19 19:42:05'),(19,'The Psychology of Money','Morgan Housel',6,399.00,32,'Timeless lessons on wealth, greed, and happiness through the lens of behavioral finance.','images/products/psychology_of_money.jpg','2026-07-20 05:33:30'),(20,'Sapiens: A Brief History of Humankind','Yuval Noah Harari',7,499.00,25,'A sweeping narrative of how Homo sapiens came to dominate the world.','images/products/sapiens.jpg','2026-07-20 05:33:30');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Rahul Sharma','rahul.sharma@example.com','hashed_password_1','9876543210','MG Road, Bangalore, Karnataka','2026-07-19 19:43:19'),(2,'Priya Nair','priya.nair@example.com','hashed_password_2','9123456780','Indiranagar, Bangalore, Karnataka','2026-07-19 19:43:19'),(3,'Arjun Mehta','arjun.mehta@example.com','hashed_password_3','9988776655','Andheri West, Mumbai, Maharashtra','2026-07-19 19:43:19');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-08-19 13:49:08
