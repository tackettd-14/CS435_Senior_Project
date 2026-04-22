-- MySQL dump 10.13  Distrib 8.0.43, for macos15 (x86_64)
--
-- Host: localhost    Database: NonprofitDB
-- ------------------------------------------------------
-- Server version	8.0.43

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
-- Table structure for table `Donation_Categories`
--

DROP TABLE IF EXISTS `Donation_Categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Donation_Categories` (
  `DCategory_id` int NOT NULL,
  `CName` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`DCategory_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Donation_Categories`
--

LOCK TABLES `Donation_Categories` WRITE;
/*!40000 ALTER TABLE `Donation_Categories` DISABLE KEYS */;
INSERT INTO `Donation_Categories` VALUES (1,'Food'),(2,'Clothing'),(6,'Personal Hygiene Items'),(7,'Toys'),(8,'Baby items'),(9,'Cleaning Supplies/Household items'),(10,'Bedding');
/*!40000 ALTER TABLE `Donation_Categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Donation_Hours`
--

DROP TABLE IF EXISTS `Donation_Hours`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Donation_Hours` (
  `DHours_id` int NOT NULL,
  `Nonprofit_id` int DEFAULT NULL,
  `Day` varchar(10) DEFAULT NULL,
  `Open` varchar(5) DEFAULT NULL,
  `Close` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`DHours_id`),
  KEY `Nonprofit_id` (`Nonprofit_id`),
  CONSTRAINT `donation_hours_ibfk_1` FOREIGN KEY (`Nonprofit_id`) REFERENCES `Non_Profits` (`Nonprofit_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Donation_Hours`
--

LOCK TABLES `Donation_Hours` WRITE;
/*!40000 ALTER TABLE `Donation_Hours` DISABLE KEYS */;
INSERT INTO `Donation_Hours` VALUES (1,1,'Monday','9:30','13:30'),(2,1,'Tuesday','9:30','13:30'),(3,1,'Wednesday','9:30','13:30'),(4,1,'Thursday','9:30','13:30'),(5,1,'Friday','9:30','13:30'),(6,2,'Monday','9:00','16:00'),(7,2,'Tuesday','9:00','16:00'),(8,2,'Wednesday','9:00','16:00'),(9,2,'Thursday','9:00','16:00'),(10,2,'Friday','9:00','16:00'),(11,3,'Monday','9:00','17:00'),(12,3,'Tuesday','9:00','17:00'),(13,3,'Wednesday','9:00','17:00'),(14,3,'Thursday','9:00','17:00'),(15,3,'Friday','9:00','12:00'),(16,3,'Saturday','9:00','12:00'),(17,4,'Monday','8:00','15:00'),(18,4,'Tuesday','8:00','15:00'),(19,4,'Wednesday','8:00','15:00'),(20,4,'Thursday','8:00','15:00'),(21,4,'Friday','8:00','12:00'),(22,5,'Monday','8:00','15:00'),(23,5,'Tuesday','8:00','15:00'),(24,5,'Wednesday','8:00','15:00'),(25,5,'Thursday','8:00','15:00'),(26,5,'Friday','8:00','12:00'),(27,6,'Monday','8:00','14:00'),(28,6,'Tuesday','8:00','14:00'),(29,6,'Wednesday','8:00','14:00'),(30,6,'Thursday','8:00','14:00'),(31,6,'Friday','8:00','14:00'),(32,6,'Saturday','8:00','12:00'),(33,8,'Wednesday','16:30','18:30'),(34,8,'Friday','16:30','18:30'),(35,8,'Saturday','12:00','14:00'),(36,12,'Wednesday','19:00','19:30'),(37,18,'Monday','8:00','11:00'),(38,18,'Monday','12:00','15:00'),(39,18,'Tuesday','8:00','11:00'),(40,18,'Tuesday','12:00','15:00'),(41,18,'Wednesday','8:00','11:00'),(42,18,'Wednesday','12:00','15:00'),(43,18,'Thursday','8:00','11:00'),(44,18,'Thursday','12:00','15:00'),(45,18,'Friday','8:00','11:00'),(46,18,'Friday','12:00','15:00'),(47,18,'Sunday','13:00','15:00'),(48,19,'Monday','13:00','15:00'),(49,19,'Monday','8:30','10:00'),(50,19,'Wednesday','13:00','15:00'),(51,19,'Wednesday','8:30','10:00'),(52,19,'Friday','13:00','15:00'),(53,19,'Friday','8:30','10:00');
/*!40000 ALTER TABLE `Donation_Hours` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Donation_Lists`
--

DROP TABLE IF EXISTS `Donation_Lists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Donation_Lists` (
  `List_id` int NOT NULL,
  `Nonprofit_id` int DEFAULT NULL,
  `Donation_Category` int DEFAULT NULL,
  PRIMARY KEY (`List_id`),
  KEY `Nonprofit_id` (`Nonprofit_id`),
  KEY `Donation_Category` (`Donation_Category`),
  CONSTRAINT `donation_lists_ibfk_1` FOREIGN KEY (`Nonprofit_id`) REFERENCES `Non_Profits` (`Nonprofit_id`),
  CONSTRAINT `donation_lists_ibfk_2` FOREIGN KEY (`Donation_Category`) REFERENCES `Donation_Categories` (`DCategory_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Donation_Lists`
--

LOCK TABLES `Donation_Lists` WRITE;
/*!40000 ALTER TABLE `Donation_Lists` DISABLE KEYS */;
INSERT INTO `Donation_Lists` VALUES (1,1,1),(2,1,2),(6,2,10),(7,2,2),(9,2,6),(10,2,9),(11,3,1),(12,3,6),(13,3,9),(14,3,10),(15,4,8),(16,5,8),(18,6,1),(19,6,2),(20,6,6),(21,8,1),(22,8,6),(23,8,9),(24,12,1),(26,18,6),(27,18,8);
/*!40000 ALTER TABLE `Donation_Lists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Non_Profits`
--

DROP TABLE IF EXISTS `Non_Profits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Non_Profits` (
  `Nonprofit_id` int NOT NULL,
  `Name` varchar(64) DEFAULT NULL,
  `Area_code` varchar(3) DEFAULT NULL,
  `Phone_number` varchar(10) DEFAULT NULL,
  `Street_address` varchar(64) DEFAULT NULL,
  `City` varchar(23) DEFAULT NULL,
  `State` varchar(2) DEFAULT NULL,
  `Zip` varchar(5) DEFAULT NULL,
  `Email` varchar(64) DEFAULT NULL,
  `Website` varchar(64) DEFAULT NULL,
  `Description` varchar(1000) DEFAULT NULL,
  `Last_updated` varchar(16) DEFAULT NULL,
  `Latitude` float DEFAULT NULL,
  `Longitude` float DEFAULT NULL,
  PRIMARY KEY (`Nonprofit_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Non_Profits`
--

LOCK TABLES `Non_Profits` WRITE;
/*!40000 ALTER TABLE `Non_Profits` DISABLE KEYS */;
INSERT INTO `Non_Profits` VALUES (1,'Mission of Hope','319','200-6130','1700 B Ave NE Ste 101','Cedar Rapids','IA','52402','N/A','https://missionofhopecr.org/','Mission of Hope (Cedar Rapids) is a faith-based nonprofit that supports people in need by providing free meals, food pantry services, clothing, and recovery support, while also offering spiritual guidance and community programs to help restore and transform lives.','2026-04-15',42.0008,-91.6463),(2,'Willis Dady','319','362-7555','1247 4th Ave SE','Cedar Rapids','IA','52403','services@willisdady.org','https://www.willisdady.org/','Willis Dady Homeless Services is a nonprofit that helps people experiencing homelessness by providing shelter, housing support, and employment services, with the goal of helping them become self-sufficient and achieve stable, permanent housing.','2026-04-15',41.9709,-91.6519),(3,'Catherine McAuley Center (CMC)','319','363-4993','1220 5th Ave SE','Cedar Rapids','IA','52402','info@cmc-cr.org','https://cmc-cr.org/','The Catherine McAuley Center (CMC) is a nonprofit organization in Cedar Rapids, Iowa that welcomes adult learners, refugee and immigrant populations, and women to participate in educational and supportive services.','2026-04-15',41.9702,-91.6511),(4,'Eastern Iowa Diaper Bank','319','364-8909','420 6th St SE','Cedar Rapids','IA','52402','info@eidiaperbank.org','https://eidiaperbank.org/','Eastern Iowa Diaper Bank is a nonprofit that provides free diapers and wipes to low-income families.','2026-04-15',41.9765,-91.6582),(5,'We Care Shop','319','364-8909','420 6th St SE Ste 180','Cedar Rapids','IA','52403','N/A','https://www.ypniowa.org/give/we-care-shop/','The YPN We Care Shop is an incentive project that allows families to earn points and redeem them for essential items.','2026-04-15',41.9765,-91.6582),(6,'Freedom Foundation','319','826-2010','4001 Center Point Rd NE','Cedar Rapids','IA','52404','info@usfreedomfoundation.org','https://usfreedomfoundation.org/','U.S. Freedom Foundation supports military veterans by providing community space, basic needs, and access to resources.','2026-04-15',42.0226,-91.667),(7,'Good Shepherd Baptist Church','515','573-0379','327 35th St NE','Cedar Rapids','IA','52402','N/A','https://www.goodshepherdbaptistcr.com/','Good Shepherd Baptist Church provides worship services, biblical teaching, and a supportive church community.','2026-04-15',42.0142,-91.6661),(8,'Together We Achieve','319','432-9754','1150 27th Ave SW','Cedar Rapids','IA','52404','N/A','https://togetherweachieve.org/','Together We Achieve provides food assistance and essential resources including a choice pantry and meals.','2026-04-15',41.9552,-91.6816),(9,'Bethany Lutheran Food Pantry','319','364-6026','2202 Forest Drive SE','Cedar Rapids','IA','52403','office.bethanycr@gmail.com','https://www.bethanycr.org/','Bethany Lutheran Church provides worship services, outreach, and a community food pantry.','2026-04-15',41.9598,-91.6315),(10,'Loaves & Fishes','319','366-7185','1285 3rd Ave SE','Cedar Rapids','IA','52403','westmin@crwpc.org','https://www.crwpc.org/loaves-and-fishes','Loaves & Fishes is a volunteer-run food pantry providing free groceries and fresh food.','2026-04-15',41.9756,-91.6613),(11,'Maranatha Bible Church','319','362-8784','526 3rd Ave SW','Cedar Rapids','IA','52404','contact@maranathabible.org','https://www.maranathabible.org','Maranatha Bible Church provides worship services, biblical teaching, and community programs.','2026-04-15',41.974,-91.6705),(12,'Life Line Ministry','319','366-1787','1101 Oakland Road NE','Cedar Rapids','IA','52402','lifelineministrieschurch@outlook.com','https://www.lifelineministrieschurch.org','Lifeline Ministries Church provides worship, spiritual guidance, and community support including food assistance.','2026-04-15',42.0127,-91.6522),(13,'Christ Holiness Apostolic Temple: The King\'s Kitchen','319','365-9594','19th St SE','Cedar Rapids','IA','52403','N/A','N/A','Food assistance program.','2026-04-15',41.981,-91.64),(14,'Cedar Hill Community Church: Open Hands Food Pantry','319','390-6918','6455 E Avenue NW','Cedar Rapids','IA','52405','N/A','https://cedarhillscr.org/contact/','Open Hands Food Pantry provides groceries and essential pantry items.','2026-04-15',42.0438,-91.7402),(15,'Elayne Fisher Community Cupboard / Unity Center Cedar Rapids','319','393-5422','3791 Blairs Ferry Rd NE','Cedar Rapids','IA','52402','office@unitycr.org','https://unitycr.org/ministry-teams/community-cupboard/','Provides food support and basic necessities to individuals and families.','2026-04-15',42.0349,-91.6678),(16,'First Church of the Open Bible','319','363-3117','1911 E Avenue NW','Cedar Rapids','IA','52405','info@firstopenbible.com','https://www.firstopenbible.com/contact/','Faith-based organization.','2026-04-15',41.9946,-91.7078),(17,'St. Vincent de Paul Society','319','365-5091','928 7th St SE','Cedar Rapids','IA','52401','help@crsvdp.org','https://crsvdp.org','Provides assistance with food, clothing, rent, utilities, and more.','2026-04-15',41.9648,-91.6575),(18,'Families Helping Families','319','294-9706','6000 7th St SW','Cedar Rapids','IA','52404','office@fhfia.org','https://familieshelpingfamiliesofiowa.org','Nonprofit supporting foster families.','2026-04-15',41.9212,-91.7376),(19,'Linn Community Food Pantry','319','364-3543','310 5th St SE','Cedar Rapids','IA','52401','lincofb@gmail.com','https://linncommunityfoodbank.org/','Provides short-term emergency food supplies.','2026-04-15',41.976,-91.663),(20,'First Presbyterian Church','319','364-6148','310 5th St SE','Cedar Rapids','IA','52401','office@fpccr.org','https://fpccr.org/','Provides free hot meal every Sunday.','2026-04-15',41.979,-91.663);
/*!40000 ALTER TABLE `Non_Profits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Resource_Categories`
--

DROP TABLE IF EXISTS `Resource_Categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Resource_Categories` (
  `RCategory_id` int NOT NULL,
  `Name` varchar(64) DEFAULT NULL,
  `Description` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`RCategory_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Resource_Categories`
--

LOCK TABLES `Resource_Categories` WRITE;
/*!40000 ALTER TABLE `Resource_Categories` DISABLE KEYS */;
INSERT INTO `Resource_Categories` VALUES (1,'food pantry','community-based service that distributes free groceries to people who are experiencing food insecurity'),(2,'hot meal service','serves a community meal to those in need free of cost'),(3,'clothing closet','a distribution program that provides free or very low-cost clothing to individuals and families who cannot afford to purchase adequate apparel.');
/*!40000 ALTER TABLE `Resource_Categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Resource_Hours`
--

DROP TABLE IF EXISTS `Resource_Hours`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Resource_Hours` (
  `RHours_id` int NOT NULL,
  `Resource_id` int DEFAULT NULL,
  `Week` int DEFAULT NULL,
  `Day` varchar(10) DEFAULT NULL,
  `Open` varchar(5) DEFAULT NULL,
  `Close` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`RHours_id`),
  KEY `Resource_id` (`Resource_id`),
  KEY `Week` (`Week`),
  CONSTRAINT `resource_hours_ibfk_1` FOREIGN KEY (`Resource_id`) REFERENCES `Resources` (`Resource_id`),
  CONSTRAINT `resource_hours_ibfk_2` FOREIGN KEY (`Week`) REFERENCES `Resource_Week` (`RWeek_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Resource_Hours`
--

LOCK TABLES `Resource_Hours` WRITE;
/*!40000 ALTER TABLE `Resource_Hours` DISABLE KEYS */;
INSERT INTO `Resource_Hours` VALUES (1,1,5,'Monday','9:30','13:30'),(2,2,5,'Monday','11:30','12:30'),(3,3,5,'Monday','9:30','13:30'),(4,1,5,'Tuesday','9:30','13:30'),(5,2,5,'Tuesday','11:30','12:30'),(6,3,5,'Tuesday','9:30','13:30'),(7,1,5,'Wednesday','9:30','13:30'),(8,2,5,'Wednesday','11:30','12:30'),(9,3,5,'Wednesday','9:30','13:30'),(10,1,5,'Thursday','9:30','13:30'),(11,2,5,'Thursday','11:30','12:30'),(12,3,5,'Thursday','9:30','13:30'),(13,1,5,'Friday','9:30','13:30'),(14,2,5,'Friday','11:30','12:30'),(15,3,5,'Friday','9:30','13:30'),(16,4,5,'Tuesday','11:00','13:00'),(17,4,5,'Tuesday','17:00','19:00'),(18,4,5,'Wednesday','10:30','12:30'),(19,4,5,'Thursday','9:00','12:00'),(20,4,5,'Friday','10:00','12:00'),(21,4,5,'Sunday','9:00','11:00'),(22,5,5,'Monday','11:00','13:00'),(23,5,5,'Wednesday','11:00','13:00'),(24,5,5,'Thursday','10:00','11:15'),(25,5,5,'Saturday','10:00','12:00'),(26,6,5,'Monday','13:00','15:00'),(27,7,5,'Monday','13:00','15:00'),(28,8,5,'Tuesday','16:30','18:30'),(29,8,5,'Wednesday','16:30','18:30'),(30,8,5,'Friday','16:30','18:30'),(31,8,5,'Saturday','12:00','14:00'),(32,9,5,'Sunday','13:00','15:00'),(33,10,5,'Tuesday','14:30','17:00'),(34,11,2,'Wednesday','17:00','18:30'),(35,11,4,'Wednesday','17:00','18:30'),(36,12,5,'Sunday','9:30','12:00'),(37,12,5,'Wednesday','19:00','20:00'),(38,12,5,'Saturday','10:00','11:00'),(39,13,3,'Wednesday','13:00','15:00'),(40,13,4,'Friday','13:00','15:00'),(41,14,5,'Monday','17:00','18:00'),(42,14,5,'Wednesday','10:00','12:00'),(43,15,5,'Tuesday','10:00','12:30'),(44,16,4,'Sunday','10:00','12:00'),(45,17,5,'Tuesday','9:00','12:00'),(46,17,5,'Wednesday','9:00','12:00'),(47,17,5,'Thursday','9:00','12:00'),(48,17,5,'Friday','9:00','12:00'),(49,18,5,'Monday','8:00','11:00'),(50,18,5,'Monday','12:00','15:00'),(51,18,5,'Tuesday','8:00','11:00'),(52,18,5,'Tuesday','12:00','15:00'),(53,18,5,'Wednesday','8:00','11:00'),(54,18,5,'Wednesday','12:00','15:00'),(55,18,5,'Thursday','8:00','11:00'),(56,18,5,'Thursday','12:00','15:00'),(57,18,5,'Friday','8:00','11:00'),(58,18,5,'Friday','12:00','15:00'),(59,18,5,'Sunday','13:00','15:00'),(60,19,5,'Monday','13:00','15:00'),(61,19,5,'Wednesday','13:00','15:00'),(62,19,5,'Friday','13:00','15:00'),(63,20,5,'Sunday','16:30','17:30');
/*!40000 ALTER TABLE `Resource_Hours` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Resource_Week`
--

DROP TABLE IF EXISTS `Resource_Week`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Resource_Week` (
  `RWeek_id` int NOT NULL,
  `Description` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`RWeek_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Resource_Week`
--

LOCK TABLES `Resource_Week` WRITE;
/*!40000 ALTER TABLE `Resource_Week` DISABLE KEYS */;
INSERT INTO `Resource_Week` VALUES (1,'avaible on 1st week of month'),(2,'avaible on 2nd week of month'),(3,'avaible on 3rd week of month'),(4,'avaible on 4th week of month'),(5,'avaible every week of the month');
/*!40000 ALTER TABLE `Resource_Week` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Resources`
--

DROP TABLE IF EXISTS `Resources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Resources` (
  `Resource_id` int NOT NULL,
  `Nonprofit_id` int DEFAULT NULL,
  `RCategory_id` int DEFAULT NULL,
  PRIMARY KEY (`Resource_id`),
  KEY `Nonprofit_id` (`Nonprofit_id`),
  KEY `RCategory_id` (`RCategory_id`),
  CONSTRAINT `resources_ibfk_1` FOREIGN KEY (`Nonprofit_id`) REFERENCES `Non_Profits` (`Nonprofit_id`),
  CONSTRAINT `resources_ibfk_2` FOREIGN KEY (`RCategory_id`) REFERENCES `Resource_Categories` (`RCategory_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Resources`
--

LOCK TABLES `Resources` WRITE;
/*!40000 ALTER TABLE `Resources` DISABLE KEYS */;
INSERT INTO `Resources` VALUES (1,1,1),(2,1,2),(3,1,3),(4,3,1),(5,6,1),(6,7,1),(7,7,3),(8,8,1),(9,9,1),(10,10,1),(11,11,1),(12,12,1),(13,13,1),(14,14,1),(15,15,1),(16,16,1),(17,17,1),(18,18,3),(19,19,1),(20,20,2);
/*!40000 ALTER TABLE `Resources` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-21 18:53:43
