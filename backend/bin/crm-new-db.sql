-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Win64 (AMD64)
--
-- Host: 127.0.0.1    Database: crm_01_apr_2026
-- ------------------------------------------------------
-- Server version	10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `about`
--

DROP TABLE IF EXISTS `about`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `about` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `description` text CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `vision` text CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `mission` text CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `image1` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `image2` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `image3` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `about`
--

LOCK TABLES `about` WRITE;
/*!40000 ALTER TABLE `about` DISABLE KEYS */;
/*!40000 ALTER TABLE `about` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `mobile` varchar(11) NOT NULL,
  `email` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `date` date NOT NULL,
  `status` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `all_cast`
--

DROP TABLE IF EXISTS `all_cast`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `all_cast` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name_cast` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `status` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `all_cast`
--

LOCK TABLES `all_cast` WRITE;
/*!40000 ALTER TABLE `all_cast` DISABLE KEYS */;
/*!40000 ALTER TABLE `all_cast` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog`
--

DROP TABLE IF EXISTS `blog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `categori_id` int(11) NOT NULL,
  `title` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `image` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog`
--

LOCK TABLES `blog` WRITE;
/*!40000 ALTER TABLE `blog` DISABLE KEYS */;
/*!40000 ALTER TABLE `blog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog_category`
--

DROP TABLE IF EXISTS `blog_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blog_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` int(11) NOT NULL,
  `category_name` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_category`
--

LOCK TABLES `blog_category` WRITE;
/*!40000 ALTER TABLE `blog_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `blog_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `company_1`
--

DROP TABLE IF EXISTS `company_1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `company_1` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company_name` varchar(255) NOT NULL,
  `service_charge_value` varchar(255) NOT NULL,
  `vat_charge_value` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `country` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `currency` varchar(255) NOT NULL,
  `created_id` varchar(36) NOT NULL,
  `modified_time` datetime DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `modified_id` varchar(36) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `company_1`
--

LOCK TABLES `company_1` WRITE;
/*!40000 ALTER TABLE `company_1` DISABLE KEYS */;
/*!40000 ALTER TABLE `company_1` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contact`
--

DROP TABLE IF EXISTS `contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contact` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `address` text CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `mobile_number1` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `mobile_number2` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `email` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `facebook` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `youtube` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `instagram` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `twitter` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `whatsapp` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `map` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contact`
--

LOCK TABLES `contact` WRITE;
/*!40000 ALTER TABLE `contact` DISABLE KEYS */;
/*!40000 ALTER TABLE `contact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contact_1`
--

DROP TABLE IF EXISTS `contact_1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contact_1` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `full_name` varchar(50) DEFAULT NULL,
  `job_title` varchar(30) DEFAULT NULL,
  `type_id` varchar(36) DEFAULT NULL,
  `note` varchar(76) DEFAULT NULL,
  `phone_work` varchar(24) DEFAULT NULL,
  `phone_home` varchar(16) DEFAULT NULL,
  `phone_mobile` varchar(16) DEFAULT NULL,
  `email_work` varchar(50) DEFAULT NULL,
  `email_other` varchar(50) DEFAULT NULL,
  `im1_type_id` varchar(36) DEFAULT NULL,
  `im1_id` varchar(30) DEFAULT NULL,
  `im2_type_id` varchar(36) DEFAULT NULL,
  `im2_id` varchar(30) DEFAULT NULL,
  `fax` varchar(16) DEFAULT NULL,
  `company` varchar(50) DEFAULT NULL,
  `street1` varchar(50) DEFAULT NULL,
  `street2` varchar(50) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `zip` varchar(16) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `asset_id` varchar(36) DEFAULT NULL,
  `modified_time` datetime DEFAULT NULL,
  `modified_id` varchar(36) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uidx_contact_full_name` (`full_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contact_1`
--

LOCK TABLES `contact_1` WRITE;
/*!40000 ALTER TABLE `contact_1` DISABLE KEYS */;
/*!40000 ALTER TABLE `contact_1` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dept_1`
--

DROP TABLE IF EXISTS `dept_1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dept_1` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dept` varchar(30) DEFAULT NULL,
  `note` varchar(76) DEFAULT NULL,
  `manager_id` varchar(36) DEFAULT NULL,
  `modified_time` datetime DEFAULT NULL,
  `modified_id` varchar(36) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uidx_dept_dept` (`dept`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dept_1`
--

LOCK TABLES `dept_1` WRITE;
/*!40000 ALTER TABLE `dept_1` DISABLE KEYS */;
/*!40000 ALTER TABLE `dept_1` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `district`
--

DROP TABLE IF EXISTS `district`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `district` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `district_name` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` int(11) NOT NULL,
  `state_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `district`
--

LOCK TABLES `district` WRITE;
/*!40000 ALTER TABLE `district` DISABLE KEYS */;
/*!40000 ALTER TABLE `district` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `faq`
--

DROP TABLE IF EXISTS `faq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `faq` (
  `id` int(11) NOT NULL,
  `title` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `image` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faq`
--

LOCK TABLES `faq` WRITE;
/*!40000 ALTER TABLE `faq` DISABLE KEYS */;
/*!40000 ALTER TABLE `faq` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gallery`
--

DROP TABLE IF EXISTS `gallery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gallery` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `image` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `title` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gallery`
--

LOCK TABLES `gallery` WRITE;
/*!40000 ALTER TABLE `gallery` DISABLE KEYS */;
/*!40000 ALTER TABLE `gallery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `groups_1`
--

DROP TABLE IF EXISTS `groups_1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `groups_1` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_name` varchar(255) NOT NULL,
  `permission` text NOT NULL,
  `created_id` varchar(36) NOT NULL,
  `modified_time` datetime DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `modified_id` varchar(36) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_name` (`group_name`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `groups_1`
--

LOCK TABLES `groups_1` WRITE;
/*!40000 ALTER TABLE `groups_1` DISABLE KEYS */;
/*!40000 ALTER TABLE `groups_1` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `marrital_status`
--

DROP TABLE IF EXISTS `marrital_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `marrital_status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `marrital_status_name` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `status` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `marrital_status`
--

LOCK TABLES `marrital_status` WRITE;
/*!40000 ALTER TABLE `marrital_status` DISABLE KEYS */;
/*!40000 ALTER TABLE `marrital_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `member`
--

DROP TABLE IF EXISTS `member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `member` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `profile` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `member_profile_id` text NOT NULL,
  `full_name` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `gender` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `married_status` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `mobile_number` text NOT NULL,
  `email` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `comfirm_password` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `status` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17786 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member`
--

LOCK TABLES `member` WRITE;
/*!40000 ALTER TABLE `member` DISABLE KEYS */;
/*!40000 ALTER TABLE `member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `member_profile`
--

DROP TABLE IF EXISTS `member_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `member_profile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `member_profile_id` text NOT NULL,
  `profile` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `first_name` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `middle_name` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `last_name` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `profile_photo` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `cast` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `sub_cast` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `religion` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `married_status` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `date_of_birth` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `age` int(11) NOT NULL,
  `hieght` text NOT NULL,
  `blood_group` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `skin_type` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `weight` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `body_look` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `lence` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `gender` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `full_name` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `mobile_number` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `mobile_number1` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `email` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `comfirm_password` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `father_name` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `mother_name` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `all_brothers` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `all_sisters` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `family_work` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `diet` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `education` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `hobbies` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `income` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `job_work` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` int(11) NOT NULL,
  `gotra` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `devak` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `gan` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `naadi` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `nakashtra` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `charan` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `raas` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `birth_place` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `birth_time` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `currant_address` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `permanant_address` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `state` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `district` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `expectation` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `ads_info` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `deleted` int(11) NOT NULL,
  `profile_status` int(11) NOT NULL,
  `done_status` int(11) NOT NULL,
  `membership` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `aadhar` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17728 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member_profile`
--

LOCK TABLES `member_profile` WRITE;
/*!40000 ALTER TABLE `member_profile` DISABLE KEYS */;
/*!40000 ALTER TABLE `member_profile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `membership`
--

DROP TABLE IF EXISTS `membership`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `membership` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plan_name` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `plan_description` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `plan_price` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `plan_validity` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `number_profile` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `payment_link` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `membership`
--

LOCK TABLES `membership` WRITE;
/*!40000 ALTER TABLE `membership` DISABLE KEYS */;
/*!40000 ALTER TABLE `membership` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `selected_profile`
--

DROP TABLE IF EXISTS `selected_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `selected_profile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `member_profile_id` text NOT NULL,
  `selected_id` text NOT NULL,
  `date` datetime NOT NULL,
  `status` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `selected_profile`
--

LOCK TABLES `selected_profile` WRITE;
/*!40000 ALTER TABLE `selected_profile` DISABLE KEYS */;
/*!40000 ALTER TABLE `selected_profile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `slider`
--

DROP TABLE IF EXISTS `slider`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `slider` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `image` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `main_txt` text CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `text2` text CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `text3` text CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `slider`
--

LOCK TABLES `slider` WRITE;
/*!40000 ALTER TABLE `slider` DISABLE KEYS */;
/*!40000 ALTER TABLE `slider` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `state`
--

DROP TABLE IF EXISTS `state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `state` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `state_name` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `status` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `state`
--

LOCK TABLES `state` WRITE;
/*!40000 ALTER TABLE `state` DISABLE KEYS */;
/*!40000 ALTER TABLE `state` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `successstories`
--

DROP TABLE IF EXISTS `successstories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `successstories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `image` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `successstories`
--

LOCK TABLES `successstories` WRITE;
/*!40000 ALTER TABLE `successstories` DISABLE KEYS */;
/*!40000 ALTER TABLE `successstories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `team_1`
--

DROP TABLE IF EXISTS `team_1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `team_1` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `team` varchar(30) DEFAULT NULL,
  `note` varchar(76) DEFAULT NULL,
  `lead_id` int(11) DEFAULT NULL,
  `modified_time` datetime DEFAULT NULL,
  `modified_id` varchar(36) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uidx_team_team` (`team`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `team_1`
--

LOCK TABLES `team_1` WRITE;
/*!40000 ALTER TABLE `team_1` DISABLE KEYS */;
/*!40000 ALTER TABLE `team_1` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `terms_condition`
--

DROP TABLE IF EXISTS `terms_condition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `terms_condition` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `image` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `description1` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `terms_condition`
--

LOCK TABLES `terms_condition` WRITE;
/*!40000 ALTER TABLE `terms_condition` DISABLE KEYS */;
/*!40000 ALTER TABLE `terms_condition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `testimonial`
--

DROP TABLE IF EXISTS `testimonial`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `testimonial` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `image` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `title` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `testimonial`
--

LOCK TABLES `testimonial` WRITE;
/*!40000 ALTER TABLE `testimonial` DISABLE KEYS */;
/*!40000 ALTER TABLE `testimonial` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_group_1`
--

DROP TABLE IF EXISTS `user_group_1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_group_1` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_group_1`
--

LOCK TABLES `user_group_1` WRITE;
/*!40000 ALTER TABLE `user_group_1` DISABLE KEYS */;
INSERT INTO `user_group_1` VALUES (1,1,2),(7,35,5),(8,36,2),(9,37,3),(10,38,4),(11,39,5),(12,40,2),(13,41,2),(14,42,2),(15,43,5),(16,44,3),(17,45,4);
/*!40000 ALTER TABLE `user_group_1` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_1`
--

DROP TABLE IF EXISTS `users_1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_1` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `job_title` int(11) DEFAULT NULL,
  `firstname` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `status_id` tinyint(1) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `user_type_id` varchar(36) DEFAULT NULL,
  `emp_no` varchar(30) DEFAULT NULL,
  `contractor_id` varchar(36) DEFAULT NULL,
  `job_role_id` varchar(36) DEFAULT NULL,
  `login_allowed` tinyint(1) DEFAULT 1,
  `gender` varchar(50) DEFAULT NULL,
  `note` varchar(76) DEFAULT NULL,
  `acl_group_id` varchar(36) DEFAULT NULL,
  `admin_type_id` varchar(36) DEFAULT 'search_admin_none',
  `team_id` varchar(36) DEFAULT NULL,
  `supervisor_id` varchar(36) DEFAULT NULL,
  `dept_id` varchar(36) DEFAULT NULL,
  `costcode_id` varchar(36) DEFAULT NULL,
  `req_approval_id` varchar(36) DEFAULT NULL,
  `po_approval_id` varchar(36) DEFAULT NULL,
  `craft_id` varchar(36) DEFAULT NULL,
  `phone` varchar(24) DEFAULT NULL,
  `phone_home` varchar(16) DEFAULT NULL,
  `mobile` varchar(16) DEFAULT NULL,
  `email_other` varchar(50) DEFAULT NULL,
  `im1_type_id` varchar(36) DEFAULT NULL,
  `im1_id` varchar(30) DEFAULT NULL,
  `im2_type_id` varchar(36) DEFAULT NULL,
  `im2_id` varchar(30) DEFAULT NULL,
  `fax` varchar(16) DEFAULT NULL,
  `company` varchar(50) DEFAULT NULL,
  `street1` varchar(50) DEFAULT NULL,
  `street2` varchar(50) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `zip` varchar(16) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `modified_time` datetime DEFAULT NULL,
  `modified_id` varchar(36) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_1`
--

LOCK TABLES `users_1` WRITE;
/*!40000 ALTER TABLE `users_1` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_1` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `why_choose_us`
--

DROP TABLE IF EXISTS `why_choose_us`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `why_choose_us` (
  `id` int(11) NOT NULL,
  `title` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `image` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `why_choose_us`
--

LOCK TABLES `why_choose_us` WRITE;
/*!40000 ALTER TABLE `why_choose_us` DISABLE KEYS */;
/*!40000 ALTER TABLE `why_choose_us` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformaccounting_advance_amount`
--

DROP TABLE IF EXISTS `xformaccounting_advance_amount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformaccounting_advance_amount` (
  `advance_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id_fk` int(11) NOT NULL,
  `advance_pay` int(11) NOT NULL,
  `advance_pay_now` int(11) NOT NULL,
  `created_at` date NOT NULL,
  `updated_at` date NOT NULL,
  `uid` int(11) NOT NULL,
  PRIMARY KEY (`advance_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformaccounting_advance_amount`
--

LOCK TABLES `xformaccounting_advance_amount` WRITE;
/*!40000 ALTER TABLE `xformaccounting_advance_amount` DISABLE KEYS */;
/*!40000 ALTER TABLE `xformaccounting_advance_amount` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformaccounting_asset`
--

DROP TABLE IF EXISTS `xformaccounting_asset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformaccounting_asset` (
  `asset_id` int(11) NOT NULL,
  `asset` varchar(30) NOT NULL,
  `uid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformaccounting_asset`
--

LOCK TABLES `xformaccounting_asset` WRITE;
/*!40000 ALTER TABLE `xformaccounting_asset` DISABLE KEYS */;
/*!40000 ALTER TABLE `xformaccounting_asset` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformaccounting_bank_details`
--

DROP TABLE IF EXISTS `xformaccounting_bank_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformaccounting_bank_details` (
  `bank_id` int(11) NOT NULL AUTO_INCREMENT,
  `bank_name` varchar(255) NOT NULL,
  `account_number` int(11) NOT NULL,
  `account_type` varchar(20) NOT NULL,
  `bank_address` varchar(255) NOT NULL,
  `ifsc_code` int(11) NOT NULL,
  `state` varchar(20) NOT NULL,
  `status` varchar(10) NOT NULL,
  `comment` text NOT NULL,
  `initial_balance` int(11) NOT NULL,
  `minimum_allowed_balance` int(11) NOT NULL,
  `minimum_desired_balance` int(11) NOT NULL,
  `account_owner_name` varchar(255) NOT NULL,
  `account_owner_address` varchar(255) NOT NULL,
  `uid` int(11) NOT NULL,
  PRIMARY KEY (`bank_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformaccounting_bank_details`
--

LOCK TABLES `xformaccounting_bank_details` WRITE;
/*!40000 ALTER TABLE `xformaccounting_bank_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `xformaccounting_bank_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformaccounting_bank_transaction`
--

DROP TABLE IF EXISTS `xformaccounting_bank_transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformaccounting_bank_transaction` (
  `bank_transaction_id` int(11) NOT NULL AUTO_INCREMENT,
  `transaction_detail` varchar(50) NOT NULL,
  `bank_transaction_name` varchar(20) NOT NULL,
  `transaction_date` date NOT NULL,
  `withdrawal_amount` int(11) NOT NULL,
  `deposite_amount` int(11) NOT NULL,
  `balance_amount` int(11) NOT NULL,
  `description` varchar(255) NOT NULL,
  `uid` int(11) NOT NULL,
  PRIMARY KEY (`bank_transaction_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformaccounting_bank_transaction`
--

LOCK TABLES `xformaccounting_bank_transaction` WRITE;
/*!40000 ALTER TABLE `xformaccounting_bank_transaction` DISABLE KEYS */;
/*!40000 ALTER TABLE `xformaccounting_bank_transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformaccounting_barcode_master`
--

DROP TABLE IF EXISTS `xformaccounting_barcode_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformaccounting_barcode_master` (
  `barcode_master_id` int(11) NOT NULL AUTO_INCREMENT,
  `item` varchar(50) NOT NULL,
  `barcode` varchar(50) NOT NULL,
  `status` tinyint(1) NOT NULL,
  PRIMARY KEY (`barcode_master_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformaccounting_barcode_master`
--

LOCK TABLES `xformaccounting_barcode_master` WRITE;
/*!40000 ALTER TABLE `xformaccounting_barcode_master` DISABLE KEYS */;
/*!40000 ALTER TABLE `xformaccounting_barcode_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformaccounting_bom`
--

DROP TABLE IF EXISTS `xformaccounting_bom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformaccounting_bom` (
  `bom_id` int(11) NOT NULL AUTO_INCREMENT,
  `number` varchar(25) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `date` varchar(10) NOT NULL,
  `exp_date` varchar(10) NOT NULL,
  `item_name` varchar(255) NOT NULL,
  `quantity` int(11) NOT NULL,
  `description` text NOT NULL,
  `uid` int(11) NOT NULL,
  `item_no` varchar(50) NOT NULL,
  `drawing_no` varchar(50) NOT NULL,
  `unit` varchar(10) NOT NULL,
  `size` varchar(10) NOT NULL,
  `remark` text NOT NULL,
  `status_i` varchar(15) NOT NULL,
  `moc` int(11) NOT NULL,
  PRIMARY KEY (`bom_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformaccounting_bom`
--

LOCK TABLES `xformaccounting_bom` WRITE;
/*!40000 ALTER TABLE `xformaccounting_bom` DISABLE KEYS */;
/*!40000 ALTER TABLE `xformaccounting_bom` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformaccounting_bom_total`
--

DROP TABLE IF EXISTS `xformaccounting_bom_total`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformaccounting_bom_total` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number_fk` varchar(100) NOT NULL,
  `basic_total` double NOT NULL,
  `total` double NOT NULL,
  `customer_id_fk` int(11) NOT NULL,
  `payment_method` tinyint(4) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `enquiry` tinyint(4) NOT NULL,
  `uid` int(11) NOT NULL,
  `terms_and_conditions` text NOT NULL,
  `payment_terms` text NOT NULL,
  `process_schedule` text NOT NULL,
  `taxes` text NOT NULL,
  `exclusions` text NOT NULL,
  `bom_subheading` varchar(50) NOT NULL,
  `bom_footer` text NOT NULL,
  `bom_memo` text DEFAULT NULL,
  `approved_by` int(11) NOT NULL,
  `project_code` varchar(100) NOT NULL,
  `customer_code` varchar(100) NOT NULL,
  `po_number` varchar(100) NOT NULL,
  `note` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformaccounting_bom_total`
--

LOCK TABLES `xformaccounting_bom_total` WRITE;
/*!40000 ALTER TABLE `xformaccounting_bom_total` DISABLE KEYS */;
/*!40000 ALTER TABLE `xformaccounting_bom_total` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformaccounting_category`
--

DROP TABLE IF EXISTS `xformaccounting_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformaccounting_category` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(40) NOT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformaccounting_category`
--

LOCK TABLES `xformaccounting_category` WRITE;
/*!40000 ALTER TABLE `xformaccounting_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `xformaccounting_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformaccounting_cheque_details`
--

DROP TABLE IF EXISTS `xformaccounting_cheque_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformaccounting_cheque_details` (
  `cheque_id` int(11) NOT NULL AUTO_INCREMENT,
  `cheque_no` int(11) NOT NULL,
  `creation_date` date NOT NULL,
  `bank_account_name` varchar(50) NOT NULL,
  `no_of_cheque` int(11) NOT NULL,
  `status` varchar(20) NOT NULL,
  `uid` int(11) NOT NULL,
  PRIMARY KEY (`cheque_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformaccounting_cheque_details`
--

LOCK TABLES `xformaccounting_cheque_details` WRITE;
/*!40000 ALTER TABLE `xformaccounting_cheque_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `xformaccounting_cheque_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformaccounting_customer`
--

DROP TABLE IF EXISTS `xformaccounting_customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformaccounting_customer` (
  `customer_id` int(11) NOT NULL AUTO_INCREMENT,
  `fullname` varchar(50) NOT NULL,
  `email` varchar(255) NOT NULL,
  `mobile` varchar(22) NOT NULL,
  `address` text NOT NULL,
  `state_code` varchar(50) NOT NULL,
  `uid` int(11) NOT NULL,
  `pancard` varchar(20) NOT NULL,
  `gst` varchar(30) NOT NULL,
  `company_name` varchar(250) NOT NULL,
  `c_code` varchar(100) NOT NULL,
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=324 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformaccounting_customer`
--

LOCK TABLES `xformaccounting_customer` WRITE;
/*!40000 ALTER TABLE `xformaccounting_customer` DISABLE KEYS */;
/*!40000 ALTER TABLE `xformaccounting_customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformaccounting_customer_wise_rate`
--

DROP TABLE IF EXISTS `xformaccounting_customer_wise_rate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformaccounting_customer_wise_rate` (
  `customer_wise_rate_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id_fk` int(11) NOT NULL,
  `inventory_id_fk` int(11) NOT NULL,
  `customer_rate` varchar(20) NOT NULL,
  `rate_added_date` date NOT NULL,
  `rate_modified_date` date NOT NULL,
  PRIMARY KEY (`customer_wise_rate_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformaccounting_customer_wise_rate`
--

LOCK TABLES `xformaccounting_customer_wise_rate` WRITE;
/*!40000 ALTER TABLE `xformaccounting_customer_wise_rate` DISABLE KEYS */;
/*!40000 ALTER TABLE `xformaccounting_customer_wise_rate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformaccounting_delivery_challan`
--

DROP TABLE IF EXISTS `xformaccounting_delivery_challan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformaccounting_delivery_challan` (
  `invoice_id` int(11) NOT NULL AUTO_INCREMENT,
  `invoice_number` varchar(100) NOT NULL,
  `invoice_date` date NOT NULL,
  `customer_id` int(11) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `quantity` double NOT NULL,
  `unit` varchar(100) NOT NULL,
  `hsn_code` varchar(20) NOT NULL,
  `gst` varchar(20) NOT NULL,
  `sgst` double NOT NULL,
  `cgst` double NOT NULL,
  `igst` double NOT NULL,
  `gst_type` varchar(2) NOT NULL,
  `price` double NOT NULL,
  `amount` double NOT NULL,
  `description` text NOT NULL,
  `uid` int(11) NOT NULL,
  `barcode` varchar(50) NOT NULL,
  `discount` double NOT NULL,
  PRIMARY KEY (`invoice_id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformaccounting_delivery_challan`
--

LOCK TABLES `xformaccounting_delivery_challan` WRITE;
/*!40000 ALTER TABLE `xformaccounting_delivery_challan` DISABLE KEYS */;
/*!40000 ALTER TABLE `xformaccounting_delivery_challan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformaccounting_delivery_challan_invoice_payment_gst`
--

DROP TABLE IF EXISTS `xformaccounting_delivery_challan_invoice_payment_gst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformaccounting_delivery_challan_invoice_payment_gst` (
  `invocie_pay_id` int(11) NOT NULL AUTO_INCREMENT,
  `invoice_number_fk` varchar(100) NOT NULL,
  `invocie_pay_method` tinyint(4) NOT NULL,
  `invoice_pay_date` varchar(10) NOT NULL,
  `invocie_pay_amount` double NOT NULL,
  `invoice_pay_remark` varchar(200) NOT NULL,
  `payment_type` varchar(20) NOT NULL,
  `uid` int(11) NOT NULL,
  `customer_id_fk` int(11) NOT NULL,
  PRIMARY KEY (`invocie_pay_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformaccounting_delivery_challan_invoice_payment_gst`
--

LOCK TABLES `xformaccounting_delivery_challan_invoice_payment_gst` WRITE;
/*!40000 ALTER TABLE `xformaccounting_delivery_challan_invoice_payment_gst` DISABLE KEYS */;
/*!40000 ALTER TABLE `xformaccounting_delivery_challan_invoice_payment_gst` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformaccounting_delivery_challan_payment_gst`
--

DROP TABLE IF EXISTS `xformaccounting_delivery_challan_payment_gst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformaccounting_delivery_challan_payment_gst` (
  `invocie_pay_id` int(11) NOT NULL AUTO_INCREMENT,
  `invoice_number_fk` varchar(100) NOT NULL,
  `invocie_pay_method` tinyint(4) NOT NULL,
  `invoice_pay_date` varchar(10) NOT NULL,
  `invocie_pay_amount` double NOT NULL,
  `rem_balance` int(11) NOT NULL,
  `invoice_pay_remark` varchar(200) NOT NULL,
  `payment_type` varchar(20) NOT NULL,
  `bank_name` varchar(50) NOT NULL,
  `uid` int(11) NOT NULL,
  `customer_id_fk` int(11) NOT NULL,
  PRIMARY KEY (`invocie_pay_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformaccounting_delivery_challan_payment_gst`
--

LOCK TABLES `xformaccounting_delivery_challan_payment_gst` WRITE;
/*!40000 ALTER TABLE `xformaccounting_delivery_challan_payment_gst` DISABLE KEYS */;
/*!40000 ALTER TABLE `xformaccounting_delivery_challan_payment_gst` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformaccounting_delivery_challan_total`
--

DROP TABLE IF EXISTS `xformaccounting_delivery_challan_total`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformaccounting_delivery_challan_total` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number_fk` varchar(100) NOT NULL,
  `date` varchar(10) NOT NULL,
  `total` double NOT NULL,
  `paid` double NOT NULL,
  `balance` double NOT NULL,
  `customer_id_fk` int(11) NOT NULL,
  `payment_method` tinyint(4) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `note` text NOT NULL,
  `despatch_through` varchar(100) NOT NULL,
  `vehicle_no` varchar(100) NOT NULL,
  `delivery_date` varchar(20) NOT NULL,
  `delivery_note_no` varchar(50) NOT NULL,
  `payment_due_date` varchar(10) NOT NULL,
  `invoice_subheading` text NOT NULL,
  `invoice_footer` text NOT NULL,
  `invoice_memo` text NOT NULL,
  `customer_po` varchar(30) NOT NULL,
  `po_date` varchar(10) NOT NULL,
  `uid` int(11) NOT NULL,
  `shipping_address` text NOT NULL,
  `sales_person` varchar(50) DEFAULT NULL,
  `supplier_code` varchar(50) NOT NULL,
  `footer` text NOT NULL,
  `memo` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformaccounting_delivery_challan_total`
--

LOCK TABLES `xformaccounting_delivery_challan_total` WRITE;
/*!40000 ALTER TABLE `xformaccounting_delivery_challan_total` DISABLE KEYS */;
/*!40000 ALTER TABLE `xformaccounting_delivery_challan_total` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformaccounting_dispatch_table`
--

DROP TABLE IF EXISTS `xformaccounting_dispatch_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformaccounting_dispatch_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `DispatchDate` date DEFAULT NULL,
  `DeviceType` varchar(250) DEFAULT NULL,
  `KeypadType` varchar(250) DEFAULT NULL,
  `ClientName` varchar(250) DEFAULT NULL,
  `Location` varchar(250) DEFAULT NULL,
  `MACAddress` varchar(250) DEFAULT NULL,
  `BluetoothName` varchar(250) DEFAULT NULL,
  `QRCodes` varchar(250) DEFAULT NULL,
  `Status` varchar(250) DEFAULT NULL,
  `Remark` varchar(250) DEFAULT NULL,
  `ReasonOfReplacement` varchar(250) DEFAULT NULL,
  `BINFile` varchar(250) DEFAULT NULL,
  `HEXFile` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformaccounting_dispatch_table`
--

LOCK TABLES `xformaccounting_dispatch_table` WRITE;
/*!40000 ALTER TABLE `xformaccounting_dispatch_table` DISABLE KEYS */;
/*!40000 ALTER TABLE `xformaccounting_dispatch_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformaccounting_email_setting`
--

DROP TABLE IF EXISTS `xformaccounting_email_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformaccounting_email_setting` (
  `email_setting_id` int(11) NOT NULL AUTO_INCREMENT,
  `company_name` varchar(200) NOT NULL,
  `company_website` varchar(200) NOT NULL,
  `company_logo` varchar(150) NOT NULL,
  `from_email` varchar(100) NOT NULL,
  `password_email` varchar(100) NOT NULL,
  `cc_email` varchar(100) NOT NULL,
  `uid` int(11) NOT NULL,
  PRIMARY KEY (`email_setting_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformaccounting_email_setting`
--

LOCK TABLES `xformaccounting_email_setting` WRITE;
/*!40000 ALTER TABLE `xformaccounting_email_setting` DISABLE KEYS */;
/*!40000 ALTER TABLE `xformaccounting_email_setting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformaccounting_expense`
--

DROP TABLE IF EXISTS `xformaccounting_expense`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformaccounting_expense` (
  `expense_id` int(11) NOT NULL AUTO_INCREMENT,
  `expense_amount` double NOT NULL,
  `expense_note` varchar(50) NOT NULL,
  `date` date NOT NULL,
  `expense_upload` varchar(200) NOT NULL,
  `uid` int(11) NOT NULL,
  `expense_category` varchar(30) NOT NULL,
  `gst_class` int(11) NOT NULL,
  `employee_name` varchar(50) NOT NULL,
  `status` int(11) NOT NULL,
  PRIMARY KEY (`expense_id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformaccounting_expense`
--

LOCK TABLES `xformaccounting_expense` WRITE;
/*!40000 ALTER TABLE `xformaccounting_expense` DISABLE KEYS */;
/*!40000 ALTER TABLE `xformaccounting_expense` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformaccounting_expense_category`
--

DROP TABLE IF EXISTS `xformaccounting_expense_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformaccounting_expense_category` (
  `exp_cat_id` int(11) NOT NULL AUTO_INCREMENT,
  `exp_cat` varchar(250) NOT NULL,
  `uid` int(11) NOT NULL,
  PRIMARY KEY (`exp_cat_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformaccounting_expense_category`
--

LOCK TABLES `xformaccounting_expense_category` WRITE;
/*!40000 ALTER TABLE `xformaccounting_expense_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `xformaccounting_expense_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformaccounting_finished_products`
--

DROP TABLE IF EXISTS `xformaccounting_finished_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformaccounting_finished_products` (
  `product_id` int(11) NOT NULL AUTO_INCREMENT,
  `product_name` varchar(150) NOT NULL,
  `product_qty` int(11) NOT NULL,
  `product_unit` varchar(10) NOT NULL,
  `product_finished_date` date NOT NULL,
  `batch_fk` int(11) NOT NULL,
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformaccounting_finished_products`
--

LOCK TABLES `xformaccounting_finished_products` WRITE;
/*!40000 ALTER TABLE `xformaccounting_finished_products` DISABLE KEYS */;
/*!40000 ALTER TABLE `xformaccounting_finished_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformaccounting_grn`
--

DROP TABLE IF EXISTS `xformaccounting_grn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformaccounting_grn` (
  `grn_id` int(11) NOT NULL AUTO_INCREMENT,
  `grn_number` varchar(30) NOT NULL,
  `po_number_fk` varchar(25) NOT NULL,
  `supplier_id` int(11) NOT NULL,
  `date` varchar(12) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `quantity` int(11) NOT NULL,
  `hsn_code` varchar(20) NOT NULL,
  `gst` varchar(20) NOT NULL,
  `sgst` double NOT NULL,
  `cgst` double NOT NULL,
  `received_quantity` int(11) NOT NULL,
  `pending_quantity` int(11) NOT NULL,
  `price` double NOT NULL,
  `note` text NOT NULL,
  `description` text NOT NULL,
  `invoice_number` varchar(30) NOT NULL,
  `invoice_date` varchar(10) NOT NULL,
  `uid` int(11) NOT NULL,
  PRIMARY KEY (`grn_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformaccounting_grn`
--

LOCK TABLES `xformaccounting_grn` WRITE;
/*!40000 ALTER TABLE `xformaccounting_grn` DISABLE KEYS */;
/*!40000 ALTER TABLE `xformaccounting_grn` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformaccounting_grn_total`
--

DROP TABLE IF EXISTS `xformaccounting_grn_total`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformaccounting_grn_total` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number_fk` varchar(100) NOT NULL,
  `total` double NOT NULL,
  `uid` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformaccounting_grn_total`
--

LOCK TABLES `xformaccounting_grn_total` WRITE;
/*!40000 ALTER TABLE `xformaccounting_grn_total` DISABLE KEYS */;
/*!40000 ALTER TABLE `xformaccounting_grn_total` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformaccounting_gst_classes`
--

DROP TABLE IF EXISTS `xformaccounting_gst_classes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformaccounting_gst_classes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gst_class` varchar(10) NOT NULL,
  `uid` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformaccounting_gst_classes`
--

LOCK TABLES `xformaccounting_gst_classes` WRITE;
/*!40000 ALTER TABLE `xformaccounting_gst_classes` DISABLE KEYS */;
/*!40000 ALTER TABLE `xformaccounting_gst_classes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformaccounting_inventory`
--

DROP TABLE IF EXISTS `xformaccounting_inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformaccounting_inventory` (
  `inventory_id` int(11) NOT NULL AUTO_INCREMENT,
  `item_name` varchar(50) NOT NULL,
  `prod_description` text NOT NULL,
  `code` varchar(100) NOT NULL,
  `hsn` int(11) NOT NULL,
  `gst_per` varchar(10) NOT NULL,
  `inventory_qty` int(11) NOT NULL,
  `stock` int(11) NOT NULL DEFAULT 0,
  `cost_price` double NOT NULL,
  `sell_price` double NOT NULL,
  `date_added` date NOT NULL,
  `date_modified` varchar(10) NOT NULL,
  `uid` int(11) NOT NULL,
  `item_type` varchar(1) NOT NULL,
  `unit` varchar(15) NOT NULL,
  PRIMARY KEY (`inventory_id`)
) ENGINE=InnoDB AUTO_INCREMENT=204 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformaccounting_inventory`
--

LOCK TABLES `xformaccounting_inventory` WRITE;
/*!40000 ALTER TABLE `xformaccounting_inventory` DISABLE KEYS */;
/*!40000 ALTER TABLE `xformaccounting_inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformaccounting_invocie_payment_gst`
--

DROP TABLE IF EXISTS `xformaccounting_invocie_payment_gst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformaccounting_invocie_payment_gst` (
  `invocie_pay_id` int(11) NOT NULL AUTO_INCREMENT,
  `invoice_number_fk` varchar(100) NOT NULL,
  `invocie_pay_method` tinyint(4) NOT NULL,
  `invoice_pay_date` varchar(10) NOT NULL,
  `invocie_pay_amount` double NOT NULL,
  `rem_balance` int(11) NOT NULL,
  `invoice_pay_remark` varchar(200) NOT NULL,
  `payment_type` varchar(20) NOT NULL,
  `bank_name` varchar(50) NOT NULL,
  `uid` int(11) NOT NULL,
  `customer_id_fk` int(11) NOT NULL,
  PRIMARY KEY (`invocie_pay_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformaccounting_invocie_payment_gst`
--

LOCK TABLES `xformaccounting_invocie_payment_gst` WRITE;
/*!40000 ALTER TABLE `xformaccounting_invocie_payment_gst` DISABLE KEYS */;
/*!40000 ALTER TABLE `xformaccounting_invocie_payment_gst` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformaccounting_invoice`
--

DROP TABLE IF EXISTS `xformaccounting_invoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformaccounting_invoice` (
  `invoice_id` int(11) NOT NULL AUTO_INCREMENT,
  `invoice_number` varchar(25) NOT NULL,
  `invoice_date` date NOT NULL,
  `customer_id` int(11) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `quantity` double NOT NULL,
  `unit` varchar(100) NOT NULL,
  `hsn_code` varchar(20) NOT NULL,
  `gst` varchar(20) NOT NULL,
  `sgst` double NOT NULL,
  `cgst` double NOT NULL,
  `igst` double NOT NULL,
  `gst_type` varchar(2) NOT NULL,
  `price` double NOT NULL,
  `amount` double NOT NULL,
  `description` text NOT NULL,
  `uid` int(11) NOT NULL,
  `discount` double NOT NULL,
  PRIMARY KEY (`invoice_id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformaccounting_invoice`
--

LOCK TABLES `xformaccounting_invoice` WRITE;
/*!40000 ALTER TABLE `xformaccounting_invoice` DISABLE KEYS */;
/*!40000 ALTER TABLE `xformaccounting_invoice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformaccounting_invoice_total`
--

DROP TABLE IF EXISTS `xformaccounting_invoice_total`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformaccounting_invoice_total` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number_fk` varchar(100) NOT NULL,
  `date` date NOT NULL,
  `total` double NOT NULL,
  `paid` double NOT NULL,
  `balance` double NOT NULL,
  `customer_id_fk` int(11) NOT NULL,
  `payment_method` tinyint(4) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `note` text NOT NULL,
  `despatch_through` varchar(100) NOT NULL,
  `vehicle_no` varchar(100) NOT NULL,
  `delivery_date` varchar(20) NOT NULL,
  `delivery_note_no` varchar(50) NOT NULL,
  `payment_due_date` varchar(10) NOT NULL,
  `invoice_subheading` text NOT NULL,
  `invoice_footer` text NOT NULL,
  `invoice_memo` text NOT NULL,
  `customer_po` varchar(30) NOT NULL,
  `po_date` varchar(10) NOT NULL,
  `uid` int(11) NOT NULL,
  `shipping_address` text NOT NULL,
  `sales_person` varchar(50) NOT NULL,
  `total_before_tax` double NOT NULL,
  `total_gst_amount` double NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformaccounting_invoice_total`
--

LOCK TABLES `xformaccounting_invoice_total` WRITE;
/*!40000 ALTER TABLE `xformaccounting_invoice_total` DISABLE KEYS */;
/*!40000 ALTER TABLE `xformaccounting_invoice_total` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformaccounting_liabilities`
--

DROP TABLE IF EXISTS `xformaccounting_liabilities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformaccounting_liabilities` (
  `liabilities_id` int(11) NOT NULL AUTO_INCREMENT,
  `liabilities` varchar(30) NOT NULL,
  `uid` int(11) NOT NULL,
  PRIMARY KEY (`liabilities_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformaccounting_liabilities`
--

LOCK TABLES `xformaccounting_liabilities` WRITE;
/*!40000 ALTER TABLE `xformaccounting_liabilities` DISABLE KEYS */;
/*!40000 ALTER TABLE `xformaccounting_liabilities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformaccounting_loan_account`
--

DROP TABLE IF EXISTS `xformaccounting_loan_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformaccounting_loan_account` (
  `loan_id` int(11) NOT NULL AUTO_INCREMENT,
  `acc_name` varchar(50) NOT NULL,
  `acc_number` int(11) NOT NULL,
  `bank` varchar(50) NOT NULL,
  `loan_description` text NOT NULL,
  `current_balance` int(11) NOT NULL,
  `loan_date` date NOT NULL,
  `loan_recevied` varchar(10) NOT NULL,
  `interest_rate` int(11) NOT NULL,
  `duration` int(11) NOT NULL,
  `processing_fee` int(11) NOT NULL,
  `liabilities` varchar(20) NOT NULL,
  `sub_liabilities` varchar(20) NOT NULL,
  `processing_fee_paid_from` varchar(20) NOT NULL,
  `uid` int(11) NOT NULL,
  PRIMARY KEY (`loan_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformaccounting_loan_account`
--

LOCK TABLES `xformaccounting_loan_account` WRITE;
/*!40000 ALTER TABLE `xformaccounting_loan_account` DISABLE KEYS */;
/*!40000 ALTER TABLE `xformaccounting_loan_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformaccounting_moc`
--

DROP TABLE IF EXISTS `xformaccounting_moc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformaccounting_moc` (
  `moc_id` int(11) NOT NULL AUTO_INCREMENT,
  `moc` varchar(50) NOT NULL,
  `uid` int(11) NOT NULL,
  PRIMARY KEY (`moc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformaccounting_moc`
--

LOCK TABLES `xformaccounting_moc` WRITE;
/*!40000 ALTER TABLE `xformaccounting_moc` DISABLE KEYS */;
/*!40000 ALTER TABLE `xformaccounting_moc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformaccounting_payment_in`
--

DROP TABLE IF EXISTS `xformaccounting_payment_in`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformaccounting_payment_in` (
  `payment_id` int(11) NOT NULL AUTO_INCREMENT,
  `payment_customer_id` int(11) NOT NULL,
  `payment` double NOT NULL,
  `pay_balance` double NOT NULL,
  `pay_paid` double NOT NULL,
  `payment_date` date NOT NULL,
  `payment_type` varchar(100) NOT NULL,
  `payment_bank` varchar(100) NOT NULL,
  `payment_method` varchar(100) NOT NULL,
  `payment_note` text NOT NULL,
  `status` varchar(10) NOT NULL DEFAULT 'not used',
  PRIMARY KEY (`payment_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformaccounting_payment_in`
--

LOCK TABLES `xformaccounting_payment_in` WRITE;
/*!40000 ALTER TABLE `xformaccounting_payment_in` DISABLE KEYS */;
/*!40000 ALTER TABLE `xformaccounting_payment_in` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformaccounting_payment_methods`
--

DROP TABLE IF EXISTS `xformaccounting_payment_methods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformaccounting_payment_methods` (
  `payment_method_id` int(11) NOT NULL AUTO_INCREMENT,
  `payment_method_name` text DEFAULT NULL,
  PRIMARY KEY (`payment_method_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformaccounting_payment_methods`
--

LOCK TABLES `xformaccounting_payment_methods` WRITE;
/*!40000 ALTER TABLE `xformaccounting_payment_methods` DISABLE KEYS */;
/*!40000 ALTER TABLE `xformaccounting_payment_methods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformaccounting_payment_out`
--

DROP TABLE IF EXISTS `xformaccounting_payment_out`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformaccounting_payment_out` (
  `payment_id` int(11) NOT NULL AUTO_INCREMENT,
  `payment_supplier_id` int(11) NOT NULL,
  `payment` bigint(20) NOT NULL,
  `pay_balance` double NOT NULL,
  `pay_paid` double NOT NULL,
  `payment_date` date NOT NULL,
  `payment_type` varchar(100) NOT NULL,
  `payment_bank` varchar(100) NOT NULL,
  `payment_method` varchar(100) NOT NULL,
  `payment_note` text NOT NULL,
  `status` varchar(10) DEFAULT 'not used',
  PRIMARY KEY (`payment_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformaccounting_payment_out`
--

LOCK TABLES `xformaccounting_payment_out` WRITE;
/*!40000 ALTER TABLE `xformaccounting_payment_out` DISABLE KEYS */;
/*!40000 ALTER TABLE `xformaccounting_payment_out` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformaccounting_payment_terms`
--

DROP TABLE IF EXISTS `xformaccounting_payment_terms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformaccounting_payment_terms` (
  `payment_term_id` int(11) NOT NULL AUTO_INCREMENT,
  `payment_term` varchar(250) NOT NULL,
  `uid` int(11) NOT NULL,
  PRIMARY KEY (`payment_term_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformaccounting_payment_terms`
--

LOCK TABLES `xformaccounting_payment_terms` WRITE;
/*!40000 ALTER TABLE `xformaccounting_payment_terms` DISABLE KEYS */;
/*!40000 ALTER TABLE `xformaccounting_payment_terms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformaccounting_permission`
--

DROP TABLE IF EXISTS `xformaccounting_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformaccounting_permission` (
  `permission_id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id_fk` int(11) NOT NULL,
  `grp_perm` varchar(50) NOT NULL,
  PRIMARY KEY (`permission_id`)
) ENGINE=InnoDB AUTO_INCREMENT=409 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformaccounting_permission`
--

LOCK TABLES `xformaccounting_permission` WRITE;
/*!40000 ALTER TABLE `xformaccounting_permission` DISABLE KEYS */;
/*!40000 ALTER TABLE `xformaccounting_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformaccounting_po_total`
--

DROP TABLE IF EXISTS `xformaccounting_po_total`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformaccounting_po_total` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number_fk` varchar(100) NOT NULL,
  `total` double NOT NULL,
  `payment_method` tinyint(4) NOT NULL,
  `uid` int(11) NOT NULL,
  `po_terms_and_conditions` text NOT NULL,
  `po_payment_terms` text NOT NULL,
  `po_process_schedule` text NOT NULL,
  `po_taxes` text NOT NULL,
  `po_exclusions` text NOT NULL,
  `po_note` text NOT NULL,
  `status` varchar(10) NOT NULL,
  `balance` double NOT NULL,
  `paid` double NOT NULL,
  `payment_due_date` varchar(10) NOT NULL,
  `supplier_id_fk` int(11) NOT NULL,
  `date` date NOT NULL,
  `note` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformaccounting_po_total`
--

LOCK TABLES `xformaccounting_po_total` WRITE;
/*!40000 ALTER TABLE `xformaccounting_po_total` DISABLE KEYS */;
/*!40000 ALTER TABLE `xformaccounting_po_total` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformaccounting_product_master`
--

DROP TABLE IF EXISTS `xformaccounting_product_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformaccounting_product_master` (
  `product_master_id` int(11) NOT NULL AUTO_INCREMENT,
  `product_master_name` varchar(50) NOT NULL,
  `category_id_fk` int(11) NOT NULL,
  PRIMARY KEY (`product_master_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformaccounting_product_master`
--

LOCK TABLES `xformaccounting_product_master` WRITE;
/*!40000 ALTER TABLE `xformaccounting_product_master` DISABLE KEYS */;
/*!40000 ALTER TABLE `xformaccounting_product_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformaccounting_proforma_invoice`
--

DROP TABLE IF EXISTS `xformaccounting_proforma_invoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformaccounting_proforma_invoice` (
  `invoice_id` int(11) NOT NULL AUTO_INCREMENT,
  `invoice_number` varchar(100) NOT NULL,
  `invoice_date` date NOT NULL,
  `customer_id` int(11) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `quantity` double NOT NULL,
  `unit` varchar(100) NOT NULL,
  `hsn_code` varchar(20) NOT NULL,
  `gst` varchar(20) NOT NULL,
  `sgst` double NOT NULL,
  `cgst` double NOT NULL,
  `igst` double NOT NULL,
  `gst_type` varchar(2) NOT NULL,
  `price` double NOT NULL,
  `amount` double NOT NULL,
  `description` text NOT NULL,
  `uid` int(11) NOT NULL,
  `barcode` varchar(50) NOT NULL,
  `discount` double NOT NULL,
  PRIMARY KEY (`invoice_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformaccounting_proforma_invoice`
--

LOCK TABLES `xformaccounting_proforma_invoice` WRITE;
/*!40000 ALTER TABLE `xformaccounting_proforma_invoice` DISABLE KEYS */;
/*!40000 ALTER TABLE `xformaccounting_proforma_invoice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformaccounting_proforma_invoice_payment_gst`
--

DROP TABLE IF EXISTS `xformaccounting_proforma_invoice_payment_gst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformaccounting_proforma_invoice_payment_gst` (
  `invocie_pay_id` int(11) NOT NULL AUTO_INCREMENT,
  `invoice_number_fk` varchar(100) NOT NULL,
  `invocie_pay_method` tinyint(4) NOT NULL,
  `invoice_pay_date` varchar(10) NOT NULL,
  `invocie_pay_amount` double NOT NULL,
  `invoice_pay_remark` varchar(200) NOT NULL,
  `payment_type` varchar(20) NOT NULL,
  `uid` int(11) NOT NULL,
  `customer_id_fk` int(11) NOT NULL,
  PRIMARY KEY (`invocie_pay_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformaccounting_proforma_invoice_payment_gst`
--

LOCK TABLES `xformaccounting_proforma_invoice_payment_gst` WRITE;
/*!40000 ALTER TABLE `xformaccounting_proforma_invoice_payment_gst` DISABLE KEYS */;
/*!40000 ALTER TABLE `xformaccounting_proforma_invoice_payment_gst` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformaccounting_proforma_invoice_total`
--

DROP TABLE IF EXISTS `xformaccounting_proforma_invoice_total`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformaccounting_proforma_invoice_total` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number_fk` varchar(100) NOT NULL,
  `date` varchar(10) NOT NULL,
  `total` double NOT NULL,
  `paid` double NOT NULL,
  `balance` double NOT NULL,
  `customer_id_fk` int(11) NOT NULL,
  `payment_method` tinyint(4) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `note` text NOT NULL,
  `despatch_through` varchar(100) NOT NULL,
  `vehicle_no` varchar(100) NOT NULL,
  `delivery_date` varchar(20) NOT NULL,
  `delivery_note_no` varchar(50) NOT NULL,
  `payment_due_date` varchar(10) NOT NULL,
  `invoice_subheading` text NOT NULL,
  `invoice_footer` text NOT NULL,
  `invoice_memo` text NOT NULL,
  `customer_po` varchar(30) NOT NULL,
  `po_date` varchar(10) NOT NULL,
  `uid` int(11) NOT NULL,
  `shipping_address` text NOT NULL,
  `sales_person` varchar(50) DEFAULT NULL,
  `supplier_code` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformaccounting_proforma_invoice_total`
--

LOCK TABLES `xformaccounting_proforma_invoice_total` WRITE;
/*!40000 ALTER TABLE `xformaccounting_proforma_invoice_total` DISABLE KEYS */;
/*!40000 ALTER TABLE `xformaccounting_proforma_invoice_total` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformaccounting_proforma_payment_gst`
--

DROP TABLE IF EXISTS `xformaccounting_proforma_payment_gst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformaccounting_proforma_payment_gst` (
  `invocie_pay_id` int(11) NOT NULL AUTO_INCREMENT,
  `invoice_number_fk` varchar(100) NOT NULL,
  `invocie_pay_method` tinyint(4) NOT NULL,
  `invoice_pay_date` varchar(10) NOT NULL,
  `invocie_pay_amount` double NOT NULL,
  `rem_balance` int(11) NOT NULL,
  `invoice_pay_remark` varchar(200) NOT NULL,
  `payment_type` varchar(20) NOT NULL,
  `bank_name` varchar(50) NOT NULL,
  `uid` int(11) NOT NULL,
  `customer_id_fk` int(11) NOT NULL,
  PRIMARY KEY (`invocie_pay_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformaccounting_proforma_payment_gst`
--

LOCK TABLES `xformaccounting_proforma_payment_gst` WRITE;
/*!40000 ALTER TABLE `xformaccounting_proforma_payment_gst` DISABLE KEYS */;
/*!40000 ALTER TABLE `xformaccounting_proforma_payment_gst` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformaccounting_purchase_bill`
--

DROP TABLE IF EXISTS `xformaccounting_purchase_bill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformaccounting_purchase_bill` (
  `po_bill_id` int(11) NOT NULL AUTO_INCREMENT,
  `number` varchar(25) NOT NULL,
  `date` date NOT NULL,
  `supplier_id_fk` int(11) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `quantity` double NOT NULL,
  `unit` varchar(10) NOT NULL,
  `hsn_code` varchar(20) NOT NULL,
  `gst` varchar(20) NOT NULL,
  `sgst` double NOT NULL,
  `cgst` double NOT NULL,
  `igst` double NOT NULL,
  `gst_type` varchar(2) NOT NULL,
  `price` double NOT NULL,
  `amount` double NOT NULL,
  `description` text NOT NULL,
  `uid` int(11) NOT NULL,
  `discount` double NOT NULL,
  PRIMARY KEY (`po_bill_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformaccounting_purchase_bill`
--

LOCK TABLES `xformaccounting_purchase_bill` WRITE;
/*!40000 ALTER TABLE `xformaccounting_purchase_bill` DISABLE KEYS */;
/*!40000 ALTER TABLE `xformaccounting_purchase_bill` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformaccounting_purchase_bill_payment_gst`
--

DROP TABLE IF EXISTS `xformaccounting_purchase_bill_payment_gst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformaccounting_purchase_bill_payment_gst` (
  `purchase_pay_id` int(11) NOT NULL AUTO_INCREMENT,
  `purchase_number_fk` varchar(100) NOT NULL,
  `purchase_pay_method` tinyint(4) NOT NULL,
  `purchase_pay_date` varchar(10) NOT NULL,
  `purchase_pay_amount` double NOT NULL,
  `purchase_pay_remark` varchar(200) NOT NULL,
  `payment_type` varchar(20) NOT NULL,
  `uid` int(11) NOT NULL,
  `supplier_id_fk` int(11) NOT NULL,
  PRIMARY KEY (`purchase_pay_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformaccounting_purchase_bill_payment_gst`
--

LOCK TABLES `xformaccounting_purchase_bill_payment_gst` WRITE;
/*!40000 ALTER TABLE `xformaccounting_purchase_bill_payment_gst` DISABLE KEYS */;
/*!40000 ALTER TABLE `xformaccounting_purchase_bill_payment_gst` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformaccounting_purchase_bill_total`
--

DROP TABLE IF EXISTS `xformaccounting_purchase_bill_total`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformaccounting_purchase_bill_total` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number_fk` varchar(100) NOT NULL,
  `total` double NOT NULL,
  `paid` double NOT NULL,
  `balance` double NOT NULL,
  `supplier_id_fk` int(11) NOT NULL,
  `payment_method` tinyint(4) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `note` text NOT NULL,
  `despatch_through` varchar(100) NOT NULL,
  `vehicle_no` varchar(100) NOT NULL,
  `delivery_date` varchar(20) NOT NULL,
  `delivery_note_no` varchar(50) NOT NULL,
  `payment_due_date` varchar(10) NOT NULL,
  `subheading` text NOT NULL,
  `footer` text NOT NULL,
  `memo` text NOT NULL,
  `customer_po` varchar(30) NOT NULL,
  `po_date` varchar(10) NOT NULL,
  `uid` int(11) NOT NULL,
  `shipping_address` text NOT NULL,
  `sales_person` varchar(50) NOT NULL,
  `invoice_no` varchar(100) NOT NULL,
  `expenditure_type` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformaccounting_purchase_bill_total`
--

LOCK TABLES `xformaccounting_purchase_bill_total` WRITE;
/*!40000 ALTER TABLE `xformaccounting_purchase_bill_total` DISABLE KEYS */;
/*!40000 ALTER TABLE `xformaccounting_purchase_bill_total` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformaccounting_purchase_booked`
--

DROP TABLE IF EXISTS `xformaccounting_purchase_booked`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformaccounting_purchase_booked` (
  `purchase_booked_id` int(11) NOT NULL AUTO_INCREMENT,
  `purchase_order_number` varchar(200) NOT NULL,
  PRIMARY KEY (`purchase_booked_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformaccounting_purchase_booked`
--

LOCK TABLES `xformaccounting_purchase_booked` WRITE;
/*!40000 ALTER TABLE `xformaccounting_purchase_booked` DISABLE KEYS */;
/*!40000 ALTER TABLE `xformaccounting_purchase_booked` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformaccounting_purchase_payment_gst`
--

DROP TABLE IF EXISTS `xformaccounting_purchase_payment_gst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformaccounting_purchase_payment_gst` (
  `purchase_pay_id` int(11) NOT NULL AUTO_INCREMENT,
  `purchase_number_fk` varchar(100) NOT NULL,
  `purchase_pay_method` tinyint(4) NOT NULL,
  `purchase_pay_date` varchar(10) NOT NULL,
  `purchase_pay_amount` double NOT NULL,
  `purchase_pay_remark` varchar(200) NOT NULL,
  `payment_type` varchar(20) NOT NULL,
  `uid` int(11) NOT NULL,
  `supplier_id_fk` int(11) NOT NULL,
  PRIMARY KEY (`purchase_pay_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformaccounting_purchase_payment_gst`
--

LOCK TABLES `xformaccounting_purchase_payment_gst` WRITE;
/*!40000 ALTER TABLE `xformaccounting_purchase_payment_gst` DISABLE KEYS */;
/*!40000 ALTER TABLE `xformaccounting_purchase_payment_gst` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformaccounting_purchase_payment_history`
--

DROP TABLE IF EXISTS `xformaccounting_purchase_payment_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformaccounting_purchase_payment_history` (
  `purchase_payment_id` int(11) NOT NULL AUTO_INCREMENT,
  `amount` varchar(30) NOT NULL,
  `payment_type` varchar(100) NOT NULL,
  `note` varchar(100) NOT NULL,
  `payment_date` date NOT NULL,
  `supplier_id_fk` int(11) NOT NULL,
  PRIMARY KEY (`purchase_payment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformaccounting_purchase_payment_history`
--

LOCK TABLES `xformaccounting_purchase_payment_history` WRITE;
/*!40000 ALTER TABLE `xformaccounting_purchase_payment_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `xformaccounting_purchase_payment_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformaccounting_purchase_return`
--

DROP TABLE IF EXISTS `xformaccounting_purchase_return`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformaccounting_purchase_return` (
  `po_return_id` int(11) NOT NULL AUTO_INCREMENT,
  `number` varchar(25) NOT NULL,
  `date` date NOT NULL,
  `supplier_id_fk` int(11) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `quantity` double NOT NULL,
  `unit` varchar(100) NOT NULL,
  `hsn_code` varchar(20) NOT NULL,
  `gst` varchar(20) NOT NULL,
  `sgst` double NOT NULL,
  `cgst` double NOT NULL,
  `igst` double NOT NULL,
  `gst_type` varchar(2) NOT NULL,
  `price` double NOT NULL,
  `amount` double NOT NULL,
  `description` text NOT NULL,
  `uid` int(11) NOT NULL,
  `discount` double NOT NULL,
  PRIMARY KEY (`po_return_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformaccounting_purchase_return`
--

LOCK TABLES `xformaccounting_purchase_return` WRITE;
/*!40000 ALTER TABLE `xformaccounting_purchase_return` DISABLE KEYS */;
/*!40000 ALTER TABLE `xformaccounting_purchase_return` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformaccounting_purchase_return_total`
--

DROP TABLE IF EXISTS `xformaccounting_purchase_return_total`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformaccounting_purchase_return_total` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number_fk` varchar(100) NOT NULL,
  `total` double NOT NULL,
  `paid` double NOT NULL,
  `balance` double NOT NULL,
  `supplier_id_fk` int(11) NOT NULL,
  `payment_method` tinyint(4) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `note` text NOT NULL,
  `despatch_through` varchar(100) NOT NULL,
  `vehicle_no` varchar(100) NOT NULL,
  `delivery_date` varchar(20) NOT NULL,
  `delivery_note_no` varchar(50) NOT NULL,
  `payment_due_date` varchar(10) NOT NULL,
  `subheading` text NOT NULL,
  `footer` text NOT NULL,
  `memo` text NOT NULL,
  `customer_po` varchar(30) NOT NULL,
  `po_date` varchar(10) NOT NULL,
  `uid` int(11) NOT NULL,
  `shipping_address` text NOT NULL,
  `sales_person` varchar(50) NOT NULL,
  `ref_no` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformaccounting_purchase_return_total`
--

LOCK TABLES `xformaccounting_purchase_return_total` WRITE;
/*!40000 ALTER TABLE `xformaccounting_purchase_return_total` DISABLE KEYS */;
/*!40000 ALTER TABLE `xformaccounting_purchase_return_total` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformaccounting_purchase_stock`
--

DROP TABLE IF EXISTS `xformaccounting_purchase_stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformaccounting_purchase_stock` (
  `purchase_stock_id` int(11) NOT NULL AUTO_INCREMENT,
  `inventory_id_fk` int(11) NOT NULL,
  `oldstock` int(11) NOT NULL,
  `instock` int(11) NOT NULL,
  `supplier_id_fk` int(11) NOT NULL,
  `purchase_date` date NOT NULL,
  `paid_amount` varchar(25) NOT NULL,
  `rate_on_item` varchar(20) NOT NULL,
  `uid` int(11) NOT NULL,
  `purchase_unit` varchar(5) NOT NULL,
  PRIMARY KEY (`purchase_stock_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformaccounting_purchase_stock`
--

LOCK TABLES `xformaccounting_purchase_stock` WRITE;
/*!40000 ALTER TABLE `xformaccounting_purchase_stock` DISABLE KEYS */;
/*!40000 ALTER TABLE `xformaccounting_purchase_stock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformaccounting_purchse_order`
--

DROP TABLE IF EXISTS `xformaccounting_purchse_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformaccounting_purchse_order` (
  `po_id` int(11) NOT NULL AUTO_INCREMENT,
  `number` varchar(25) NOT NULL,
  `supplier_id` int(11) NOT NULL,
  `purchase_date` date NOT NULL,
  `delivery_date` varchar(12) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `quantity` float NOT NULL,
  `discount` varchar(100) NOT NULL,
  `unit` varchar(10) NOT NULL,
  `hsn_code` varchar(20) NOT NULL,
  `gst` varchar(20) NOT NULL,
  `sgst` double NOT NULL,
  `cgst` double NOT NULL,
  `igst` double NOT NULL,
  `gst_type` varchar(2) NOT NULL,
  `price` double NOT NULL,
  `amount` double NOT NULL,
  `amount_due` double NOT NULL,
  `subheading` varchar(50) NOT NULL,
  `footer` text NOT NULL,
  `memo` text NOT NULL,
  `po_upload` varchar(200) NOT NULL,
  `reasons` text DEFAULT NULL,
  `description` text NOT NULL,
  `po_pending_quantity` varchar(50) NOT NULL,
  `uid` int(11) NOT NULL,
  PRIMARY KEY (`po_id`)
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformaccounting_purchse_order`
--

LOCK TABLES `xformaccounting_purchse_order` WRITE;
/*!40000 ALTER TABLE `xformaccounting_purchse_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `xformaccounting_purchse_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformaccounting_quotation`
--

DROP TABLE IF EXISTS `xformaccounting_quotation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformaccounting_quotation` (
  `quotation_id` int(11) NOT NULL AUTO_INCREMENT,
  `number` varchar(25) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `date` varchar(10) NOT NULL,
  `exp_date` varchar(10) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `quantity` int(11) NOT NULL,
  `unit` varchar(100) NOT NULL,
  `hsn_code` varchar(20) NOT NULL,
  `gst` varchar(20) NOT NULL,
  `sgst` double NOT NULL,
  `cgst` double NOT NULL,
  `igst` double NOT NULL,
  `gst_type` varchar(2) NOT NULL,
  `price` double NOT NULL,
  `amount` double NOT NULL,
  `discount` double NOT NULL,
  `description` text NOT NULL,
  `uid` int(11) NOT NULL,
  `sez` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`quotation_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformaccounting_quotation`
--

LOCK TABLES `xformaccounting_quotation` WRITE;
/*!40000 ALTER TABLE `xformaccounting_quotation` DISABLE KEYS */;
/*!40000 ALTER TABLE `xformaccounting_quotation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformaccounting_quotation_total`
--

DROP TABLE IF EXISTS `xformaccounting_quotation_total`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformaccounting_quotation_total` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number_fk` varchar(100) NOT NULL,
  `basic_total` double NOT NULL,
  `total` double NOT NULL,
  `customer_id_fk` int(11) NOT NULL,
  `payment_method` tinyint(4) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `enquiry` tinyint(4) NOT NULL,
  `uid` int(11) NOT NULL,
  `terms_and_conditions` text NOT NULL,
  `payment_terms` text NOT NULL,
  `process_schedule` text NOT NULL,
  `taxes` text NOT NULL,
  `exclusions` text NOT NULL,
  `quotation_subheading` varchar(50) NOT NULL,
  `quotation_footer` text NOT NULL,
  `quotation_memo` text NOT NULL,
  `approved_by` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformaccounting_quotation_total`
--

LOCK TABLES `xformaccounting_quotation_total` WRITE;
/*!40000 ALTER TABLE `xformaccounting_quotation_total` DISABLE KEYS */;
/*!40000 ALTER TABLE `xformaccounting_quotation_total` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformaccounting_raw_items_delivery`
--

DROP TABLE IF EXISTS `xformaccounting_raw_items_delivery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformaccounting_raw_items_delivery` (
  `raw_item_delivery_id` int(11) NOT NULL AUTO_INCREMENT,
  `raw_item_name` varchar(50) NOT NULL,
  `raw_item_qty` int(11) NOT NULL,
  `raw_item_unit` varchar(10) NOT NULL,
  `raw_item_deliver_date` date NOT NULL,
  `batch` int(11) NOT NULL,
  `batch_status` int(11) NOT NULL,
  `batch_description` varchar(150) NOT NULL,
  PRIMARY KEY (`raw_item_delivery_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformaccounting_raw_items_delivery`
--

LOCK TABLES `xformaccounting_raw_items_delivery` WRITE;
/*!40000 ALTER TABLE `xformaccounting_raw_items_delivery` DISABLE KEYS */;
/*!40000 ALTER TABLE `xformaccounting_raw_items_delivery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformaccounting_raw_items_master`
--

DROP TABLE IF EXISTS `xformaccounting_raw_items_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformaccounting_raw_items_master` (
  `raw_item_master_id` int(11) NOT NULL AUTO_INCREMENT,
  `raw_item_master_name` varchar(40) NOT NULL,
  PRIMARY KEY (`raw_item_master_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformaccounting_raw_items_master`
--

LOCK TABLES `xformaccounting_raw_items_master` WRITE;
/*!40000 ALTER TABLE `xformaccounting_raw_items_master` DISABLE KEYS */;
/*!40000 ALTER TABLE `xformaccounting_raw_items_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformaccounting_raw_items_stock`
--

DROP TABLE IF EXISTS `xformaccounting_raw_items_stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformaccounting_raw_items_stock` (
  `raw_item_stock_id` int(11) NOT NULL AUTO_INCREMENT,
  `raw_item_id_fk` int(11) NOT NULL,
  `raw_item_stock` int(11) NOT NULL,
  PRIMARY KEY (`raw_item_stock_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformaccounting_raw_items_stock`
--

LOCK TABLES `xformaccounting_raw_items_stock` WRITE;
/*!40000 ALTER TABLE `xformaccounting_raw_items_stock` DISABLE KEYS */;
/*!40000 ALTER TABLE `xformaccounting_raw_items_stock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformaccounting_raw_mat_roll_stock`
--

DROP TABLE IF EXISTS `xformaccounting_raw_mat_roll_stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformaccounting_raw_mat_roll_stock` (
  `id` int(11) NOT NULL,
  `code` varchar(20) NOT NULL,
  `roll_weight` varchar(20) NOT NULL,
  `roll_size` varchar(20) NOT NULL,
  `bags_created` varchar(20) NOT NULL,
  `roll_color` varchar(20) NOT NULL,
  `gsm` varchar(10) NOT NULL,
  `bag_type` varchar(100) NOT NULL,
  `bag_size` varchar(10) NOT NULL,
  `created_date` date NOT NULL,
  `uid` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformaccounting_raw_mat_roll_stock`
--

LOCK TABLES `xformaccounting_raw_mat_roll_stock` WRITE;
/*!40000 ALTER TABLE `xformaccounting_raw_mat_roll_stock` DISABLE KEYS */;
/*!40000 ALTER TABLE `xformaccounting_raw_mat_roll_stock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformaccounting_role`
--

DROP TABLE IF EXISTS `xformaccounting_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformaccounting_role` (
  `role_id` int(11) NOT NULL,
  `role_name` varchar(70) NOT NULL,
  PRIMARY KEY (`role_id`),
  UNIQUE KEY `role_name` (`role_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformaccounting_role`
--

LOCK TABLES `xformaccounting_role` WRITE;
/*!40000 ALTER TABLE `xformaccounting_role` DISABLE KEYS */;
/*!40000 ALTER TABLE `xformaccounting_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformaccounting_sales_return`
--

DROP TABLE IF EXISTS `xformaccounting_sales_return`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformaccounting_sales_return` (
  `sr_return_id` int(11) NOT NULL AUTO_INCREMENT,
  `number` varchar(25) NOT NULL,
  `date` date NOT NULL,
  `customer_id_fk` int(11) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `quantity` double NOT NULL,
  `unit` varchar(10) NOT NULL,
  `hsn_code` varchar(20) NOT NULL,
  `gst` varchar(20) NOT NULL,
  `sgst` double NOT NULL,
  `cgst` double NOT NULL,
  `igst` double NOT NULL,
  `gst_type` varchar(2) NOT NULL,
  `price` double NOT NULL,
  `amount` double NOT NULL,
  `description` text NOT NULL,
  `uid` int(11) NOT NULL,
  `discount` double NOT NULL,
  PRIMARY KEY (`sr_return_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformaccounting_sales_return`
--

LOCK TABLES `xformaccounting_sales_return` WRITE;
/*!40000 ALTER TABLE `xformaccounting_sales_return` DISABLE KEYS */;
/*!40000 ALTER TABLE `xformaccounting_sales_return` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformaccounting_sales_return_total`
--

DROP TABLE IF EXISTS `xformaccounting_sales_return_total`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformaccounting_sales_return_total` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number_fk` varchar(100) NOT NULL,
  `total` double NOT NULL,
  `paid` double NOT NULL,
  `balance` double NOT NULL,
  `customer_id_fk` int(11) NOT NULL,
  `payment_method` tinyint(4) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `note` text NOT NULL,
  `despatch_through` varchar(100) NOT NULL,
  `vehicle_no` varchar(100) NOT NULL,
  `delivery_date` varchar(20) NOT NULL,
  `delivery_note_no` varchar(50) NOT NULL,
  `payment_due_date` varchar(10) NOT NULL,
  `subheading` text NOT NULL,
  `footer` text NOT NULL,
  `memo` text NOT NULL,
  `customer_po` varchar(30) NOT NULL,
  `po_date` varchar(10) NOT NULL,
  `uid` int(11) NOT NULL,
  `shipping_address` text NOT NULL,
  `sales_person` varchar(50) NOT NULL,
  `ref_no` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformaccounting_sales_return_total`
--

LOCK TABLES `xformaccounting_sales_return_total` WRITE;
/*!40000 ALTER TABLE `xformaccounting_sales_return_total` DISABLE KEYS */;
/*!40000 ALTER TABLE `xformaccounting_sales_return_total` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformaccounting_salesorder`
--

DROP TABLE IF EXISTS `xformaccounting_salesorder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformaccounting_salesorder` (
  `salesorder_id` int(11) NOT NULL AUTO_INCREMENT,
  `number` varchar(25) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `date` varchar(10) NOT NULL,
  `exp_date` varchar(10) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `quantity` int(11) NOT NULL,
  `hsn_code` varchar(20) NOT NULL,
  `gst` varchar(20) NOT NULL,
  `sgst` double NOT NULL,
  `cgst` double NOT NULL,
  `igst` double NOT NULL,
  `gst_type` varchar(2) NOT NULL,
  `price` double NOT NULL,
  `amount` double NOT NULL,
  `discount` double NOT NULL,
  `description` text NOT NULL,
  `uid` int(11) NOT NULL,
  PRIMARY KEY (`salesorder_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformaccounting_salesorder`
--

LOCK TABLES `xformaccounting_salesorder` WRITE;
/*!40000 ALTER TABLE `xformaccounting_salesorder` DISABLE KEYS */;
/*!40000 ALTER TABLE `xformaccounting_salesorder` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformaccounting_salesorder_total`
--

DROP TABLE IF EXISTS `xformaccounting_salesorder_total`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformaccounting_salesorder_total` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number_fk` varchar(100) NOT NULL,
  `basic_total` double NOT NULL,
  `total` double NOT NULL,
  `customer_id_fk` int(11) NOT NULL,
  `payment_method` tinyint(4) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `enquiry` tinyint(4) NOT NULL,
  `uid` int(11) NOT NULL,
  `terms_and_conditions` text NOT NULL,
  `payment_terms` text NOT NULL,
  `process_schedule` text NOT NULL,
  `taxes` text NOT NULL,
  `exclusions` text NOT NULL,
  `salesorder_subheading` varchar(50) NOT NULL,
  `salesorder_footer` text NOT NULL,
  `salesorder_memo` text NOT NULL,
  `approved_by` int(11) NOT NULL,
  `project_code` varchar(100) NOT NULL,
  `customer_code` varchar(100) NOT NULL,
  `po_number` varchar(100) NOT NULL,
  `transportation` varchar(100) NOT NULL,
  `installation` varchar(100) NOT NULL,
  `pay_terms` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformaccounting_salesorder_total`
--

LOCK TABLES `xformaccounting_salesorder_total` WRITE;
/*!40000 ALTER TABLE `xformaccounting_salesorder_total` DISABLE KEYS */;
/*!40000 ALTER TABLE `xformaccounting_salesorder_total` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformaccounting_settings`
--

DROP TABLE IF EXISTS `xformaccounting_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformaccounting_settings` (
  `setting_id` int(11) NOT NULL,
  `company_logo` varchar(100) NOT NULL,
  `quotation_subheading` varchar(50) NOT NULL,
  `quotation_title` varchar(30) NOT NULL,
  `quotation_footer` varchar(100) NOT NULL,
  `quotation_memo` text NOT NULL,
  `invoice_default_payment_term` varchar(30) NOT NULL,
  `invoice_title` varchar(30) NOT NULL,
  `invoice_subheading` varchar(50) NOT NULL,
  `invoice_footer` varchar(100) NOT NULL,
  `invoice_memo` varchar(255) NOT NULL,
  `invoice_notes` text NOT NULL,
  `address` text NOT NULL,
  `state_code` varchar(10) NOT NULL,
  `company_name` varchar(100) NOT NULL,
  `company_gst` varchar(30) NOT NULL,
  `company_pan` varchar(20) NOT NULL,
  `notes` text NOT NULL,
  `po_title` varchar(50) NOT NULL,
  `po_subheading` varchar(50) NOT NULL,
  `po_footer` varchar(100) NOT NULL,
  `po_memo` varchar(100) NOT NULL,
  `po_note` text NOT NULL,
  `mobile` varchar(30) NOT NULL,
  `email` varchar(50) NOT NULL,
  `uid` int(11) NOT NULL,
  `terms_and_conditions` text NOT NULL,
  `payment_terms` text NOT NULL,
  `process_schedule` text NOT NULL,
  `taxes` text NOT NULL,
  `exclusions` text NOT NULL,
  `po_terms_and_conditions` text NOT NULL,
  `po_payment_terms` text NOT NULL,
  `po_process_schedule` text NOT NULL,
  `po_taxes` text NOT NULL,
  `po_exclusions` text NOT NULL,
  `cin` varchar(100) NOT NULL,
  `company_stamp` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`setting_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformaccounting_settings`
--

LOCK TABLES `xformaccounting_settings` WRITE;
/*!40000 ALTER TABLE `xformaccounting_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `xformaccounting_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformaccounting_sold_stock`
--

DROP TABLE IF EXISTS `xformaccounting_sold_stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformaccounting_sold_stock` (
  `sold_stock_id` int(11) NOT NULL,
  `inventory_id_fk` int(11) NOT NULL,
  `stock` int(11) NOT NULL,
  `outstock` int(11) NOT NULL,
  `customer_id_fk` int(11) NOT NULL,
  `sold_date` varchar(10) NOT NULL,
  `uid` int(11) NOT NULL,
  PRIMARY KEY (`sold_stock_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformaccounting_sold_stock`
--

LOCK TABLES `xformaccounting_sold_stock` WRITE;
/*!40000 ALTER TABLE `xformaccounting_sold_stock` DISABLE KEYS */;
/*!40000 ALTER TABLE `xformaccounting_sold_stock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformaccounting_subasset`
--

DROP TABLE IF EXISTS `xformaccounting_subasset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformaccounting_subasset` (
  `subasset_id` int(11) NOT NULL,
  `asset_id` int(11) NOT NULL,
  `subasset_name` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformaccounting_subasset`
--

LOCK TABLES `xformaccounting_subasset` WRITE;
/*!40000 ALTER TABLE `xformaccounting_subasset` DISABLE KEYS */;
/*!40000 ALTER TABLE `xformaccounting_subasset` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformaccounting_subliabilities`
--

DROP TABLE IF EXISTS `xformaccounting_subliabilities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformaccounting_subliabilities` (
  `subliabilities_id` int(11) NOT NULL AUTO_INCREMENT,
  `liabilities_id` int(11) NOT NULL,
  `subliabilities_name` varchar(255) NOT NULL,
  PRIMARY KEY (`subliabilities_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformaccounting_subliabilities`
--

LOCK TABLES `xformaccounting_subliabilities` WRITE;
/*!40000 ALTER TABLE `xformaccounting_subliabilities` DISABLE KEYS */;
/*!40000 ALTER TABLE `xformaccounting_subliabilities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformaccounting_supplier`
--

DROP TABLE IF EXISTS `xformaccounting_supplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformaccounting_supplier` (
  `supplier_id` int(11) NOT NULL AUTO_INCREMENT,
  `company_name` varchar(100) NOT NULL,
  `fullname` varchar(50) NOT NULL,
  `pancard` varchar(30) NOT NULL,
  `gst` varchar(20) NOT NULL,
  `email` varchar(50) NOT NULL,
  `mobile` varchar(22) NOT NULL,
  `address` varchar(100) NOT NULL,
  `uid` int(11) NOT NULL,
  `state_code` varchar(50) NOT NULL,
  `s_code` varchar(100) NOT NULL,
  PRIMARY KEY (`supplier_id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformaccounting_supplier`
--

LOCK TABLES `xformaccounting_supplier` WRITE;
/*!40000 ALTER TABLE `xformaccounting_supplier` DISABLE KEYS */;
/*!40000 ALTER TABLE `xformaccounting_supplier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformsales_contact`
--

DROP TABLE IF EXISTS `xformsales_contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformsales_contact` (
  `contact_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `contact_address` varchar(255) DEFAULT NULL,
  `contact_city` varchar(255) DEFAULT NULL,
  `contact_country` varchar(255) DEFAULT NULL,
  `contact_email` varchar(255) DEFAULT NULL,
  `contact_mobile_no` varchar(255) DEFAULT NULL,
  `contact_name` varchar(255) DEFAULT NULL,
  `contact_occasion` varchar(255) DEFAULT NULL,
  `contact_occasion_date` date DEFAULT NULL,
  `contact_postal_code` varchar(255) DEFAULT NULL,
  `contact_state` varchar(255) DEFAULT NULL,
  `follow_task_category` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`contact_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformsales_contact`
--

LOCK TABLES `xformsales_contact` WRITE;
/*!40000 ALTER TABLE `xformsales_contact` DISABLE KEYS */;
INSERT INTO `xformsales_contact` VALUES (1,'806 Crown Height Hotel Crown Plaza Sector 10 Rohini New Delhi','Pune','India','komal@xform.in','9686545822','Gaurav Khanna','Birthday','2021-02-18','110085','Maharashtra','Follow Up'),(2,'gfsgssgtsgs','Pune','India','xyz@gmail.com','5067286342','Xyz Test','Anniversary','2022-05-10','411001','Maharashtra','Call'),(3,'42 Andheri East','Mumbai','India','rajesh.kumar@email.in','9711234567','Rajesh Kumar','Birthday','1985-08-15','400069','Maharashtra','Email'),(4,'15 Lajpat Nagar','Delhi','India','sunita.agarwal@email.in','9722345678','Sunita Agarwal','Anniversary','2019-12-25','110024','Delhi','Meeting'),(5,'78 Park Street','Kolkata','India','nikhil.bose@email.in','9733456789','Nikhil Bose','Conference','2023-03-10','700016','West Bengal','Follow Up'),(6,'23 Adyar','Chennai','India','preethi.s@email.in','9744567890','Preethi Suresh','Birthday','1990-07-22','600020','Tamil Nadu','Call'),(7,'11 Marine Drive','Kochi','India','kavya.nair@email.in','9755678901','Kavya Nair','Anniversary','2020-01-14','682031','Kerala','Email'),(8,'34 Hazratganj','Lucknow','India','arjun.mishra@email.in','9766789012','Arjun Mishra','Birthday','1988-11-30','226001','Uttar Pradesh','Meeting'),(9,'6 Sector 17','Chandigarh','India','sonia.chauhan@email.in','9777890123','Sonia Chauhan','Conference','2022-09-05','160017','Punjab','Follow Up'),(10,'89 New Market','Bhopal','India','manish.tiwari@email.in','9788901234','Manish Tiwari','Birthday','1992-04-18','462001','Madhya Pradesh','Call'),(11,'21 Pattom','Trivandrum','India','rekha.pillai@email.in','9799012345','Rekha Pillai','Anniversary','2018-06-20','695004','Kerala','Email'),(12,'56 HITECH City','Hyderabad','India','suresh.babu@email.in','9810123456','Suresh Babu','Birthday','1987-02-14','500081','Telangana','Meeting');
/*!40000 ALTER TABLE `xformsales_contact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformsales_create_team`
--

DROP TABLE IF EXISTS `xformsales_create_team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformsales_create_team` (
  `create_team_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_id_fk` bigint(20) DEFAULT NULL,
  `team_id_fk` bigint(20) DEFAULT NULL,
  `team_member_id_fk` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`create_team_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformsales_create_team`
--

LOCK TABLES `xformsales_create_team` WRITE;
/*!40000 ALTER TABLE `xformsales_create_team` DISABLE KEYS */;
/*!40000 ALTER TABLE `xformsales_create_team` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformsales_lead`
--

DROP TABLE IF EXISTS `xformsales_lead`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformsales_lead` (
  `lead_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `designation` varchar(255) DEFAULT NULL,
  `inquiry_date` date DEFAULT NULL,
  `lead_address` varchar(255) DEFAULT NULL,
  `lead_city` varchar(255) DEFAULT NULL,
  `lead_country` varchar(255) DEFAULT NULL,
  `lead_created_date` datetime(6) DEFAULT NULL,
  `lead_email` varchar(255) DEFAULT NULL,
  `lead_first_name` varchar(255) DEFAULT NULL,
  `lead_industry` varchar(255) DEFAULT NULL,
  `lead_last_name` varchar(255) DEFAULT NULL,
  `lead_mobile_no` varchar(255) DEFAULT NULL,
  `lead_organisation_name` varchar(255) DEFAULT NULL,
  `lead_phone_no` varchar(255) DEFAULT NULL,
  `lead_reason` varchar(255) DEFAULT NULL,
  `lead_source` varchar(255) DEFAULT NULL,
  `lead_state` varchar(255) DEFAULT NULL,
  `lead_status` varchar(255) DEFAULT NULL,
  `lead_title` varchar(255) DEFAULT NULL,
  `lead_type` varchar(255) DEFAULT NULL,
  `lead_website` varchar(255) DEFAULT NULL,
  `no_of_employee` int(11) DEFAULT NULL,
  `unique_query_id` varchar(255) DEFAULT NULL,
  `upload_document` text DEFAULT NULL,
  `upload_document1` text DEFAULT NULL,
  `upload_document2` text DEFAULT NULL,
  `upload_document3` text DEFAULT NULL,
  `user_id_fk` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`lead_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1001 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformsales_lead`
--

LOCK TABLES `xformsales_lead` WRITE;
/*!40000 ALTER TABLE `xformsales_lead` DISABLE KEYS */;
INSERT INTO `xformsales_lead` VALUES (501,NULL,'2024-02-02','1 Main Road','Delhi','India','2024-02-02 09:00:00.000000','priya1@email.in','Priya','Manufacturing','Sharma','9800007891','Xform Technologies',NULL,NULL,'Website','Delhi','New Lead','Sales Lead','B2B',NULL,6,NULL,NULL,NULL,NULL,NULL,1),(502,NULL,'2025-03-03','2 Main Road','Pune','India','2025-03-03 09:00:00.000000','amit2@email.in','Amit','Healthcare','Patel','9800015782','BuildRight Infra',NULL,NULL,'Referral','Karnataka','NotContacted','Sales Lead','B2B',NULL,7,NULL,NULL,NULL,NULL,NULL,1),(503,NULL,'2023-04-04','3 Main Road','Bangalore','India','2023-04-04 09:00:00.000000','sneha3@email.in','Sneha','Retail','Singh','9800023673','MedPlus Healthcare',NULL,NULL,'Direct','Telangana','NotContacted','Sales Lead','B2B',NULL,8,NULL,NULL,NULL,NULL,NULL,1),(504,NULL,'2024-05-05','4 Main Road','Hyderabad','India','2024-05-05 09:00:00.000000','vikas4@email.in','Vikas','Education','Verma','9800031564','GreenField Agro',NULL,NULL,'Email','Tamil Nadu','NotContacted','Sales Lead','B2B',NULL,9,NULL,NULL,NULL,NULL,NULL,1),(505,NULL,'2025-06-06','5 Main Road','Chennai','India','2025-06-06 09:00:00.000000','neha5@email.in','Neha','Finance','Joshi','9800039455','FinanceFirst Pvt Ltd',NULL,NULL,'Social Media','West Bengal','NotContacted','Sales Lead','B2B',NULL,10,NULL,NULL,NULL,NULL,NULL,1),(506,NULL,'2023-07-07','6 Main Road','Kolkata','India','2023-07-07 09:00:00.000000','sanjay6@email.in','Sanjay','Real Estate','Mehta','9800047346','AutoDrive Motors',NULL,NULL,'Other','Rajasthan','NotContacted','Sales Lead','B2B',NULL,11,NULL,NULL,NULL,NULL,NULL,1),(507,NULL,'2024-08-08','7 Main Road','Jaipur','India','2024-08-08 09:00:00.000000','kavita7@email.in','Kavita','Automotive','Desai','9800055237','EduSmart Institute',NULL,NULL,'Indiamart','Gujarat','NotContacted','Sales Lead','B2B',NULL,12,NULL,NULL,NULL,NULL,NULL,1),(508,NULL,'2025-09-09','8 Main Road','Ahmedabad','India','2025-09-09 09:00:00.000000','rahul8@email.in','Rahul','IT','Gupta','9800063128','Reliance Industries',NULL,NULL,'Website','Maharashtra','NotContacted','Sales Lead','B2B',NULL,13,NULL,NULL,NULL,NULL,NULL,1),(509,NULL,'2023-10-10','9 Main Road','Surat','India','2023-10-10 09:00:00.000000','anita9@email.in','Anita','Manufacturing','Nair','9800071019','Tata Consultancy',NULL,NULL,'Referral','Delhi','NotContacted','Sales Lead','B2B',NULL,14,NULL,NULL,NULL,NULL,NULL,1),(510,NULL,'2024-11-11','10 Main Road','Mumbai','India','2024-11-11 09:00:00.000000','deepak10@email.in','Deepak','Healthcare','Reddy','9800078910','Infosys Ltd',NULL,NULL,'Direct','Karnataka','NotContacted','Sales Lead','B2B',NULL,15,NULL,NULL,NULL,NULL,NULL,1),(511,NULL,'2025-12-12','11 Main Road','Delhi','India','2025-12-12 09:00:00.000000','sunita11@email.in','Sunita','Retail','Shah','9800086801','Wipro Technologies',NULL,NULL,'Email','Telangana','NotContacted','Sales Lead','B2B',NULL,16,NULL,NULL,NULL,NULL,NULL,1),(512,NULL,'2023-01-13','12 Main Road','Pune','India','2023-01-13 09:00:00.000000','vikram12@email.in','Vikram','Education','Mishra','9800094692','HCL Technologies',NULL,NULL,'Social Media','Tamil Nadu','NotContacted','Sales Lead','B2B',NULL,17,NULL,NULL,NULL,NULL,NULL,1),(513,NULL,'2024-02-14','13 Main Road','Bangalore','India','2024-02-14 09:00:00.000000','pooja13@email.in','Pooja','Finance','Tiwari','9800102583','Mahindra Group',NULL,NULL,'Other','West Bengal','NotContacted','Sales Lead','B2B',NULL,18,NULL,NULL,NULL,NULL,NULL,1),(514,NULL,'2025-03-15','14 Main Road','Hyderabad','India','2025-03-15 09:00:00.000000','mahesh14@email.in','Mahesh','Real Estate','Agarwal','9800110474','TechCorp Solutions',NULL,NULL,'Indiamart','Rajasthan','NotContacted','Sales Lead','B2B',NULL,19,NULL,NULL,NULL,NULL,NULL,1),(515,NULL,'2023-04-16','15 Main Road','Chennai','India','2023-04-16 09:00:00.000000','rekha15@email.in','Rekha','Automotive','Bose','9800118365','Xform Technologies',NULL,NULL,'Website','Gujarat','NotContacted','Sales Lead','B2B',NULL,20,NULL,NULL,NULL,NULL,NULL,1),(516,NULL,'2024-05-17','16 Main Road','Kolkata','India','2024-05-17 09:00:00.000000','suresh16@email.in','Suresh','IT','Pillai','9800126256','BuildRight Infra',NULL,NULL,'Referral','Maharashtra','NotContacted','Sales Lead','B2B',NULL,21,NULL,NULL,NULL,NULL,NULL,1),(517,NULL,'2025-06-18','17 Main Road','Jaipur','India','2025-06-18 09:00:00.000000','meena17@email.in','Meena','Manufacturing','Chauhan','9800134147','MedPlus Healthcare',NULL,NULL,'Direct','Delhi','NotContacted','Sales Lead','B2B',NULL,22,NULL,NULL,NULL,NULL,NULL,1),(518,NULL,'2023-07-19','18 Main Road','Ahmedabad','India','2023-07-19 09:00:00.000000','anil18@email.in','Anil','Healthcare','Rao','9800142038','GreenField Agro',NULL,NULL,'Email','Karnataka','NotContacted','Sales Lead','B2B',NULL,23,NULL,NULL,NULL,NULL,NULL,1),(519,NULL,'2024-08-20','19 Main Road','Surat','India','2024-08-20 09:00:00.000000','komal19@email.in','Komal','Retail','Pandey','9800149929','FinanceFirst Pvt Ltd',NULL,NULL,'Social Media','Telangana','NotContacted','Sales Lead','B2B',NULL,24,NULL,NULL,NULL,NULL,NULL,1),(520,NULL,'2025-09-21','20 Main Road','Mumbai','India','2025-09-21 09:00:00.000000','ravi20@email.in','Ravi','Education','Kumar','9800157820','AutoDrive Motors',NULL,NULL,'Other','Tamil Nadu','NotContacted','Sales Lead','B2B',NULL,25,NULL,NULL,NULL,NULL,NULL,1),(521,NULL,'2023-10-22','21 Main Road','Delhi','India','2023-10-22 09:00:00.000000','shweta21@email.in','Shweta','Finance','Sharma','9800165711','EduSmart Institute',NULL,NULL,'Indiamart','West Bengal','NotContacted','Sales Lead','B2B',NULL,26,NULL,NULL,NULL,NULL,NULL,1),(522,NULL,'2024-11-23','22 Main Road','Pune','India','2024-11-23 09:00:00.000000','girish22@email.in','Girish','Real Estate','Patel','9800173602','Reliance Industries',NULL,NULL,'Website','Rajasthan','NotContacted','Sales Lead','B2B',NULL,27,NULL,NULL,NULL,NULL,NULL,1),(523,NULL,'2025-12-24','23 Main Road','Bangalore','India','2025-12-24 09:00:00.000000','pallavi23@email.in','Pallavi','Automotive','Singh','9800181493','Tata Consultancy',NULL,NULL,'Referral','Gujarat','NotContacted','Sales Lead','B2B',NULL,28,NULL,NULL,NULL,NULL,NULL,1),(524,NULL,'2023-01-25','24 Main Road','Hyderabad','India','2023-01-25 09:00:00.000000','rajesh24@email.in','Rajesh','IT','Verma','9800189384','Infosys Ltd',NULL,NULL,'Direct','Maharashtra','NotContacted','Sales Lead','B2B',NULL,29,NULL,NULL,NULL,NULL,NULL,1),(525,NULL,'2024-02-26','25 Main Road','Chennai','India','2024-02-26 09:00:00.000000','priya25@email.in','Priya','Manufacturing','Joshi','9800197275','Wipro Technologies',NULL,NULL,'Email','Delhi','NotContacted','Sales Lead','B2B',NULL,30,NULL,NULL,NULL,NULL,NULL,1),(526,NULL,'2025-03-27','26 Main Road','Kolkata','India','2025-03-27 09:00:00.000000','amit26@email.in','Amit','Healthcare','Mehta','9800205166','HCL Technologies',NULL,NULL,'Social Media','Karnataka','NotContacted','Sales Lead','B2B',NULL,31,NULL,NULL,NULL,NULL,NULL,1),(527,NULL,'2023-04-28','27 Main Road','Jaipur','India','2023-04-28 09:00:00.000000','sneha27@email.in','Sneha','Retail','Desai','9800213057','Mahindra Group',NULL,NULL,'Other','Telangana','NotContacted','Sales Lead','B2B',NULL,32,NULL,NULL,NULL,NULL,NULL,1),(528,NULL,'2024-05-01','28 Main Road','Ahmedabad','India','2024-05-01 09:00:00.000000','vikas28@email.in','Vikas','Education','Gupta','9800220948','TechCorp Solutions',NULL,NULL,'Indiamart','Tamil Nadu','NotContacted','Sales Lead','B2B',NULL,33,NULL,NULL,NULL,NULL,NULL,1),(529,NULL,'2025-06-02','29 Main Road','Surat','India','2025-06-02 09:00:00.000000','neha29@email.in','Neha','Finance','Nair','9800228839','Xform Technologies',NULL,NULL,'Website','West Bengal','NotContacted','Sales Lead','B2B',NULL,34,NULL,NULL,NULL,NULL,NULL,1),(530,NULL,'2023-07-03','30 Main Road','Mumbai','India','2023-07-03 09:00:00.000000','sanjay30@email.in','Sanjay','Real Estate','Reddy','9800236730','BuildRight Infra',NULL,NULL,'Referral','Rajasthan','NotContacted','Sales Lead','B2B',NULL,35,NULL,NULL,NULL,NULL,NULL,1),(531,NULL,'2024-08-04','31 Main Road','Delhi','India','2024-08-04 09:00:00.000000','kavita31@email.in','Kavita','Automotive','Shah','9800244621','MedPlus Healthcare',NULL,NULL,'Direct','Gujarat','NotContacted','Sales Lead','B2B',NULL,36,NULL,NULL,NULL,NULL,NULL,1),(532,NULL,'2025-09-05','32 Main Road','Pune','India','2025-09-05 09:00:00.000000','rahul32@email.in','Rahul','IT','Mishra','9800252512','GreenField Agro',NULL,NULL,'Email','Maharashtra','NotContacted','Sales Lead','B2B',NULL,37,NULL,NULL,NULL,NULL,NULL,1),(533,NULL,'2023-10-06','33 Main Road','Bangalore','India','2023-10-06 09:00:00.000000','anita33@email.in','Anita','Manufacturing','Tiwari','9800260403','FinanceFirst Pvt Ltd',NULL,NULL,'Social Media','Delhi','NotContacted','Sales Lead','B2B',NULL,38,NULL,NULL,NULL,NULL,NULL,1),(534,NULL,'2024-11-07','34 Main Road','Hyderabad','India','2024-11-07 09:00:00.000000','deepak34@email.in','Deepak','Healthcare','Agarwal','9800268294','AutoDrive Motors',NULL,NULL,'Other','Karnataka','NotContacted','Sales Lead','B2B',NULL,39,NULL,NULL,NULL,NULL,NULL,1),(535,NULL,'2025-12-08','35 Main Road','Chennai','India','2025-12-08 09:00:00.000000','sunita35@email.in','Sunita','Retail','Bose','9800276185','EduSmart Institute',NULL,NULL,'Indiamart','Telangana','NotContacted','Sales Lead','B2B',NULL,40,NULL,NULL,NULL,NULL,NULL,1),(536,NULL,'2023-01-09','36 Main Road','Kolkata','India','2023-01-09 09:00:00.000000','vikram36@email.in','Vikram','Education','Pillai','9800284076','Reliance Industries',NULL,NULL,'Website','Tamil Nadu','NotContacted','Sales Lead','B2B',NULL,41,NULL,NULL,NULL,NULL,NULL,1),(537,NULL,'2024-02-10','37 Main Road','Jaipur','India','2024-02-10 09:00:00.000000','pooja37@email.in','Pooja','Finance','Chauhan','9800291967','Tata Consultancy',NULL,NULL,'Referral','West Bengal','NotContacted','Sales Lead','B2B',NULL,42,NULL,NULL,NULL,NULL,NULL,1),(538,NULL,'2025-03-11','38 Main Road','Ahmedabad','India','2025-03-11 09:00:00.000000','mahesh38@email.in','Mahesh','Real Estate','Rao','9800299858','Infosys Ltd',NULL,NULL,'Direct','Rajasthan','NotContacted','Sales Lead','B2B',NULL,43,NULL,NULL,NULL,NULL,NULL,1),(539,NULL,'2023-04-12','39 Main Road','Surat','India','2023-04-12 09:00:00.000000','rekha39@email.in','Rekha','Automotive','Pandey','9800307749','Wipro Technologies',NULL,NULL,'Email','Gujarat','NotContacted','Sales Lead','B2B',NULL,44,NULL,NULL,NULL,NULL,NULL,1),(540,NULL,'2024-05-13','40 Main Road','Mumbai','India','2024-05-13 09:00:00.000000','suresh40@email.in','Suresh','IT','Kumar','9800315640','HCL Technologies',NULL,NULL,'Social Media','Maharashtra','NotContacted','Sales Lead','B2B',NULL,45,NULL,NULL,NULL,NULL,NULL,1),(541,NULL,'2025-06-14','41 Main Road','Delhi','India','2025-06-14 09:00:00.000000','meena41@email.in','Meena','Manufacturing','Sharma','9800323531','Mahindra Group',NULL,NULL,'Other','Delhi','NotContacted','Sales Lead','B2B',NULL,46,NULL,NULL,NULL,NULL,NULL,1),(542,NULL,'2023-07-15','42 Main Road','Pune','India','2023-07-15 09:00:00.000000','anil42@email.in','Anil','Healthcare','Patel','9800331422','TechCorp Solutions',NULL,NULL,'Indiamart','Karnataka','NotContacted','Sales Lead','B2B',NULL,47,NULL,NULL,NULL,NULL,NULL,1),(543,NULL,'2024-08-16','43 Main Road','Bangalore','India','2024-08-16 09:00:00.000000','komal43@email.in','Komal','Retail','Singh','9800339313','Xform Technologies',NULL,NULL,'Website','Telangana','NotContacted','Sales Lead','B2B',NULL,48,NULL,NULL,NULL,NULL,NULL,1),(544,NULL,'2025-09-17','44 Main Road','Hyderabad','India','2025-09-17 09:00:00.000000','ravi44@email.in','Ravi','Education','Verma','9800347204','BuildRight Infra',NULL,NULL,'Referral','Tamil Nadu','NotContacted','Sales Lead','B2B',NULL,49,NULL,NULL,NULL,NULL,NULL,1),(545,NULL,'2023-10-18','45 Main Road','Chennai','India','2023-10-18 09:00:00.000000','shweta45@email.in','Shweta','Finance','Joshi','9800355095','MedPlus Healthcare',NULL,NULL,'Direct','West Bengal','NotContacted','Sales Lead','B2B',NULL,50,NULL,NULL,NULL,NULL,NULL,1),(546,NULL,'2024-11-19','46 Main Road','Kolkata','India','2024-11-19 09:00:00.000000','girish46@email.in','Girish','Real Estate','Mehta','9800362986','GreenField Agro',NULL,NULL,'Email','Rajasthan','NotContacted','Sales Lead','B2B',NULL,51,NULL,NULL,NULL,NULL,NULL,1),(547,NULL,'2025-12-20','47 Main Road','Jaipur','India','2025-12-20 09:00:00.000000','pallavi47@email.in','Pallavi','Automotive','Desai','9800370877','FinanceFirst Pvt Ltd',NULL,NULL,'Social Media','Gujarat','NotContacted','Sales Lead','B2B',NULL,52,NULL,NULL,NULL,NULL,NULL,1),(548,NULL,'2023-01-21','48 Main Road','Ahmedabad','India','2023-01-21 09:00:00.000000','rajesh48@email.in','Rajesh','IT','Gupta','9800378768','AutoDrive Motors',NULL,NULL,'Other','Maharashtra','NotContacted','Sales Lead','B2B',NULL,53,NULL,NULL,NULL,NULL,NULL,1),(549,NULL,'2024-02-22','49 Main Road','Surat','India','2024-02-22 09:00:00.000000','priya49@email.in','Priya','Manufacturing','Nair','9800386659','EduSmart Institute',NULL,NULL,'Indiamart','Delhi','NotContacted','Sales Lead','B2B',NULL,54,NULL,NULL,NULL,NULL,NULL,1),(550,NULL,'2025-03-23','50 Main Road','Mumbai','India','2025-03-23 09:00:00.000000','amit50@email.in','Amit','Healthcare','Reddy','9800394550','Reliance Industries',NULL,NULL,'Website','Karnataka','NotContacted','Sales Lead','B2B',NULL,55,NULL,NULL,NULL,NULL,NULL,1),(551,NULL,'2023-04-24','51 Main Road','Delhi','India','2023-04-24 09:00:00.000000','sneha51@email.in','Sneha','Retail','Shah','9800402441','Tata Consultancy',NULL,NULL,'Referral','Telangana','NotContacted','Sales Lead','B2B',NULL,56,NULL,NULL,NULL,NULL,NULL,1),(552,NULL,'2024-05-25','52 Main Road','Pune','India','2024-05-25 09:00:00.000000','vikas52@email.in','Vikas','Education','Mishra','9800410332','Infosys Ltd',NULL,NULL,'Direct','Tamil Nadu','NotContacted','Sales Lead','B2B',NULL,57,NULL,NULL,NULL,NULL,NULL,1),(553,NULL,'2025-06-26','53 Main Road','Bangalore','India','2025-06-26 09:00:00.000000','neha53@email.in','Neha','Finance','Tiwari','9800418223','Wipro Technologies',NULL,NULL,'Email','West Bengal','NotContacted','Sales Lead','B2B',NULL,58,NULL,NULL,NULL,NULL,NULL,1),(554,NULL,'2023-07-27','54 Main Road','Hyderabad','India','2023-07-27 09:00:00.000000','sanjay54@email.in','Sanjay','Real Estate','Agarwal','9800426114','HCL Technologies',NULL,NULL,'Social Media','Rajasthan','NotContacted','Sales Lead','B2B',NULL,59,NULL,NULL,NULL,NULL,NULL,1),(555,NULL,'2024-08-28','55 Main Road','Chennai','India','2024-08-28 09:00:00.000000','kavita55@email.in','Kavita','Automotive','Bose','9800434005','Mahindra Group',NULL,NULL,'Other','Gujarat','NotContacted','Sales Lead','B2B',NULL,60,NULL,NULL,NULL,NULL,NULL,1),(556,NULL,'2025-09-01','56 Main Road','Kolkata','India','2025-09-01 09:00:00.000000','rahul56@email.in','Rahul','IT','Pillai','9800441896','TechCorp Solutions',NULL,NULL,'Indiamart','Maharashtra','Contacted','Sales Lead','B2B',NULL,61,NULL,NULL,NULL,NULL,NULL,1),(557,NULL,'2023-10-02','57 Main Road','Jaipur','India','2023-10-02 09:00:00.000000','anita57@email.in','Anita','Manufacturing','Chauhan','9800449787','Xform Technologies',NULL,NULL,'Website','Delhi','Contacted','Sales Lead','B2B',NULL,62,NULL,NULL,NULL,NULL,NULL,1),(558,NULL,'2024-11-03','58 Main Road','Ahmedabad','India','2024-11-03 09:00:00.000000','deepak58@email.in','Deepak','Healthcare','Rao','9800457678','BuildRight Infra',NULL,NULL,'Referral','Karnataka','Contacted','Sales Lead','B2B',NULL,63,NULL,NULL,NULL,NULL,NULL,1),(559,NULL,'2025-12-04','59 Main Road','Surat','India','2025-12-04 09:00:00.000000','sunita59@email.in','Sunita','Retail','Pandey','9800465569','MedPlus Healthcare',NULL,NULL,'Direct','Telangana','Contacted','Sales Lead','B2B',NULL,64,NULL,NULL,NULL,NULL,NULL,1),(560,NULL,'2023-01-05','60 Main Road','Mumbai','India','2023-01-05 09:00:00.000000','vikram60@email.in','Vikram','Education','Kumar','9800473460','GreenField Agro',NULL,NULL,'Email','Tamil Nadu','Contacted','Sales Lead','B2B',NULL,65,NULL,NULL,NULL,NULL,NULL,1),(561,NULL,'2024-02-06','61 Main Road','Delhi','India','2024-02-06 09:00:00.000000','pooja61@email.in','Pooja','Finance','Sharma','9800481351','FinanceFirst Pvt Ltd',NULL,NULL,'Social Media','West Bengal','Contacted','Sales Lead','B2B',NULL,66,NULL,NULL,NULL,NULL,NULL,1),(562,NULL,'2025-03-07','62 Main Road','Pune','India','2025-03-07 09:00:00.000000','mahesh62@email.in','Mahesh','Real Estate','Patel','9800489242','AutoDrive Motors',NULL,NULL,'Other','Rajasthan','Contacted','Sales Lead','B2B',NULL,67,NULL,NULL,NULL,NULL,NULL,1),(563,NULL,'2023-04-08','63 Main Road','Bangalore','India','2023-04-08 09:00:00.000000','rekha63@email.in','Rekha','Automotive','Singh','9800497133','EduSmart Institute',NULL,NULL,'Indiamart','Gujarat','Contacted','Sales Lead','B2B',NULL,68,NULL,NULL,NULL,NULL,NULL,1),(564,NULL,'2024-05-09','64 Main Road','Hyderabad','India','2024-05-09 09:00:00.000000','suresh64@email.in','Suresh','IT','Verma','9800505024','Reliance Industries',NULL,NULL,'Website','Maharashtra','Contacted','Sales Lead','B2B',NULL,69,NULL,NULL,NULL,NULL,NULL,1),(565,NULL,'2025-06-10','65 Main Road','Chennai','India','2025-06-10 09:00:00.000000','meena65@email.in','Meena','Manufacturing','Joshi','9800512915','Tata Consultancy',NULL,NULL,'Referral','Delhi','Contacted','Sales Lead','B2B',NULL,70,NULL,NULL,NULL,NULL,NULL,1),(566,NULL,'2023-07-11','66 Main Road','Kolkata','India','2023-07-11 09:00:00.000000','anil66@email.in','Anil','Healthcare','Mehta','9800520806','Infosys Ltd',NULL,NULL,'Direct','Karnataka','Contacted','Sales Lead','B2B',NULL,71,NULL,NULL,NULL,NULL,NULL,1),(567,NULL,'2024-08-12','67 Main Road','Jaipur','India','2024-08-12 09:00:00.000000','komal67@email.in','Komal','Retail','Desai','9800528697','Wipro Technologies',NULL,NULL,'Email','Telangana','Contacted','Sales Lead','B2B',NULL,72,NULL,NULL,NULL,NULL,NULL,1),(568,NULL,'2025-09-13','68 Main Road','Ahmedabad','India','2025-09-13 09:00:00.000000','ravi68@email.in','Ravi','Education','Gupta','9800536588','HCL Technologies',NULL,NULL,'Social Media','Tamil Nadu','Contacted','Sales Lead','B2B',NULL,73,NULL,NULL,NULL,NULL,NULL,1),(569,NULL,'2023-10-14','69 Main Road','Surat','India','2023-10-14 09:00:00.000000','shweta69@email.in','Shweta','Finance','Nair','9800544479','Mahindra Group',NULL,NULL,'Other','West Bengal','Contacted','Sales Lead','B2B',NULL,74,NULL,NULL,NULL,NULL,NULL,1),(570,NULL,'2024-11-15','70 Main Road','Mumbai','India','2024-11-15 09:00:00.000000','girish70@email.in','Girish','Real Estate','Reddy','9800552370','TechCorp Solutions',NULL,NULL,'Indiamart','Rajasthan','Contacted','Sales Lead','B2B',NULL,75,NULL,NULL,NULL,NULL,NULL,1),(571,NULL,'2025-12-16','71 Main Road','Delhi','India','2025-12-16 09:00:00.000000','pallavi71@email.in','Pallavi','Automotive','Shah','9800560261','Xform Technologies',NULL,NULL,'Website','Gujarat','Contacted','Sales Lead','B2B',NULL,76,NULL,NULL,NULL,NULL,NULL,1),(572,NULL,'2023-01-17','72 Main Road','Pune','India','2023-01-17 09:00:00.000000','rajesh72@email.in','Rajesh','IT','Mishra','9800568152','BuildRight Infra',NULL,NULL,'Referral','Maharashtra','Contacted','Sales Lead','B2B',NULL,77,NULL,NULL,NULL,NULL,NULL,1),(573,NULL,'2024-02-18','73 Main Road','Bangalore','India','2024-02-18 09:00:00.000000','priya73@email.in','Priya','Manufacturing','Tiwari','9800576043','MedPlus Healthcare',NULL,NULL,'Direct','Delhi','Contacted','Sales Lead','B2B',NULL,78,NULL,NULL,NULL,NULL,NULL,1),(574,NULL,'2025-03-19','74 Main Road','Hyderabad','India','2025-03-19 09:00:00.000000','amit74@email.in','Amit','Healthcare','Agarwal','9800583934','GreenField Agro',NULL,NULL,'Email','Karnataka','Contacted','Sales Lead','B2B',NULL,79,NULL,NULL,NULL,NULL,NULL,1),(575,NULL,'2023-04-20','75 Main Road','Chennai','India','2023-04-20 09:00:00.000000','sneha75@email.in','Sneha','Retail','Bose','9800591825','FinanceFirst Pvt Ltd',NULL,NULL,'Social Media','Telangana','Contacted','Sales Lead','B2B',NULL,80,NULL,NULL,NULL,NULL,NULL,1),(576,NULL,'2024-05-21','76 Main Road','Kolkata','India','2024-05-21 09:00:00.000000','vikas76@email.in','Vikas','Education','Pillai','9800599716','AutoDrive Motors',NULL,NULL,'Other','Tamil Nadu','Contacted','Sales Lead','B2B',NULL,81,NULL,NULL,NULL,NULL,NULL,1),(577,NULL,'2025-06-22','77 Main Road','Jaipur','India','2025-06-22 09:00:00.000000','neha77@email.in','Neha','Finance','Chauhan','9800607607','EduSmart Institute',NULL,NULL,'Indiamart','West Bengal','Contacted','Sales Lead','B2B',NULL,82,NULL,NULL,NULL,NULL,NULL,1),(578,NULL,'2023-07-23','78 Main Road','Ahmedabad','India','2023-07-23 09:00:00.000000','sanjay78@email.in','Sanjay','Real Estate','Rao','9800615498','Reliance Industries',NULL,NULL,'Website','Rajasthan','Contacted','Sales Lead','B2B',NULL,83,NULL,NULL,NULL,NULL,NULL,1),(579,NULL,'2024-08-24','79 Main Road','Surat','India','2024-08-24 09:00:00.000000','kavita79@email.in','Kavita','Automotive','Pandey','9800623389','Tata Consultancy',NULL,NULL,'Referral','Gujarat','Contacted','Sales Lead','B2B',NULL,84,NULL,NULL,NULL,NULL,NULL,1),(580,NULL,'2025-09-25','80 Main Road','Mumbai','India','2025-09-25 09:00:00.000000','rahul80@email.in','Rahul','IT','Kumar','9800631280','Infosys Ltd',NULL,NULL,'Direct','Maharashtra','Contacted','Sales Lead','B2B',NULL,85,NULL,NULL,NULL,NULL,NULL,1),(581,NULL,'2023-10-26','81 Main Road','Delhi','India','2023-10-26 09:00:00.000000','anita81@email.in','Anita','Manufacturing','Sharma','9800639171','Wipro Technologies',NULL,NULL,'Email','Delhi','Contacted','Sales Lead','B2B',NULL,86,NULL,NULL,NULL,NULL,NULL,1),(582,NULL,'2024-11-27','82 Main Road','Pune','India','2024-11-27 09:00:00.000000','deepak82@email.in','Deepak','Healthcare','Patel','9800647062','HCL Technologies',NULL,NULL,'Social Media','Karnataka','Contacted','Sales Lead','B2B',NULL,87,NULL,NULL,NULL,NULL,NULL,1),(583,NULL,'2025-12-28','83 Main Road','Bangalore','India','2025-12-28 09:00:00.000000','sunita83@email.in','Sunita','Retail','Singh','9800654953','Mahindra Group',NULL,NULL,'Other','Telangana','Contacted','Sales Lead','B2B',NULL,88,NULL,NULL,NULL,NULL,NULL,1),(584,NULL,'2023-01-01','84 Main Road','Hyderabad','India','2023-01-01 09:00:00.000000','vikram84@email.in','Vikram','Education','Verma','9800662844','TechCorp Solutions',NULL,NULL,'Indiamart','Tamil Nadu','Contacted','Sales Lead','B2B',NULL,89,NULL,NULL,NULL,NULL,NULL,1),(585,NULL,'2024-02-02','85 Main Road','Chennai','India','2024-02-02 09:00:00.000000','pooja85@email.in','Pooja','Finance','Joshi','9800670735','Xform Technologies',NULL,NULL,'Website','West Bengal','Contacted','Sales Lead','B2B',NULL,90,NULL,NULL,NULL,NULL,NULL,1),(586,NULL,'2025-03-03','86 Main Road','Kolkata','India','2025-03-03 09:00:00.000000','mahesh86@email.in','Mahesh','Real Estate','Mehta','9800678626','BuildRight Infra',NULL,NULL,'Referral','Rajasthan','Contacted','Sales Lead','B2B',NULL,91,NULL,NULL,NULL,NULL,NULL,1),(587,NULL,'2023-04-04','87 Main Road','Jaipur','India','2023-04-04 09:00:00.000000','rekha87@email.in','Rekha','Automotive','Desai','9800686517','MedPlus Healthcare',NULL,NULL,'Direct','Gujarat','Contacted','Sales Lead','B2B',NULL,92,NULL,NULL,NULL,NULL,NULL,1),(588,NULL,'2024-05-05','88 Main Road','Ahmedabad','India','2024-05-05 09:00:00.000000','suresh88@email.in','Suresh','IT','Gupta','9800694408','GreenField Agro',NULL,NULL,'Email','Maharashtra','Contacted','Sales Lead','B2B',NULL,93,NULL,NULL,NULL,NULL,NULL,1),(589,NULL,'2025-06-06','89 Main Road','Surat','India','2025-06-06 09:00:00.000000','meena89@email.in','Meena','Manufacturing','Nair','9800702299','FinanceFirst Pvt Ltd',NULL,NULL,'Social Media','Delhi','Contacted','Sales Lead','B2B',NULL,94,NULL,NULL,NULL,NULL,NULL,1),(590,NULL,'2023-07-07','90 Main Road','Mumbai','India','2023-07-07 09:00:00.000000','anil90@email.in','Anil','Healthcare','Reddy','9800710190','AutoDrive Motors',NULL,NULL,'Other','Karnataka','Contacted','Sales Lead','B2B',NULL,95,NULL,NULL,NULL,NULL,NULL,1),(591,NULL,'2024-08-08','91 Main Road','Delhi','India','2024-08-08 09:00:00.000000','komal91@email.in','Komal','Retail','Shah','9800718081','EduSmart Institute',NULL,NULL,'Indiamart','Telangana','Contacted','Sales Lead','B2B',NULL,96,NULL,NULL,NULL,NULL,NULL,1),(592,NULL,'2025-09-09','92 Main Road','Pune','India','2025-09-09 09:00:00.000000','ravi92@email.in','Ravi','Education','Mishra','9800725972','Reliance Industries',NULL,NULL,'Website','Tamil Nadu','Contacted','Sales Lead','B2B',NULL,97,NULL,NULL,NULL,NULL,NULL,1),(593,NULL,'2023-10-10','93 Main Road','Bangalore','India','2023-10-10 09:00:00.000000','shweta93@email.in','Shweta','Finance','Tiwari','9800733863','Tata Consultancy',NULL,NULL,'Referral','West Bengal','Contacted','Sales Lead','B2B',NULL,98,NULL,NULL,NULL,NULL,NULL,1),(594,NULL,'2024-11-11','94 Main Road','Hyderabad','India','2024-11-11 09:00:00.000000','girish94@email.in','Girish','Real Estate','Agarwal','9800741754','Infosys Ltd',NULL,NULL,'Direct','Rajasthan','Contacted','Sales Lead','B2B',NULL,99,NULL,NULL,NULL,NULL,NULL,1),(595,NULL,'2025-12-12','95 Main Road','Chennai','India','2025-12-12 09:00:00.000000','pallavi95@email.in','Pallavi','Automotive','Bose','9800749645','Wipro Technologies',NULL,NULL,'Email','Gujarat','Contacted','Sales Lead','B2B',NULL,100,NULL,NULL,NULL,NULL,NULL,1),(596,NULL,'2023-01-13','96 Main Road','Kolkata','India','2023-01-13 09:00:00.000000','rajesh96@email.in','Rajesh','IT','Pillai','9800757536','HCL Technologies',NULL,NULL,'Social Media','Maharashtra','Contacted','Sales Lead','B2B',NULL,101,NULL,NULL,NULL,NULL,NULL,1),(597,NULL,'2024-02-14','97 Main Road','Jaipur','India','2024-02-14 09:00:00.000000','priya97@email.in','Priya','Manufacturing','Chauhan','9800765427','Mahindra Group',NULL,NULL,'Other','Delhi','Contacted','Sales Lead','B2B',NULL,102,NULL,NULL,NULL,NULL,NULL,1),(598,NULL,'2025-03-15','98 Main Road','Ahmedabad','India','2025-03-15 09:00:00.000000','amit98@email.in','Amit','Healthcare','Rao','9800773318','TechCorp Solutions',NULL,NULL,'Indiamart','Karnataka','Contacted','Sales Lead','B2B',NULL,103,NULL,NULL,NULL,NULL,NULL,1),(599,NULL,'2023-04-16','99 Main Road','Surat','India','2023-04-16 09:00:00.000000','sneha99@email.in','Sneha','Retail','Pandey','9800781209','Xform Technologies',NULL,NULL,'Website','Telangana','Contacted','Sales Lead','B2B',NULL,104,NULL,NULL,NULL,NULL,NULL,1),(600,NULL,'2024-05-17','100 Main Road','Mumbai','India','2024-05-17 09:00:00.000000','vikas100@email.in','Vikas','Education','Kumar','9800789100','BuildRight Infra',NULL,NULL,'Referral','Tamil Nadu','Contacted','Sales Lead','B2B',NULL,105,NULL,NULL,NULL,NULL,NULL,1),(601,NULL,'2025-06-18','101 Main Road','Delhi','India','2025-06-18 09:00:00.000000','neha101@email.in','Neha','Finance','Sharma','9800796991','MedPlus Healthcare',NULL,NULL,'Direct','West Bengal','Contacted','Sales Lead','B2B',NULL,106,NULL,NULL,NULL,NULL,NULL,1),(602,NULL,'2023-07-19','102 Main Road','Pune','India','2023-07-19 09:00:00.000000','sanjay102@email.in','Sanjay','Real Estate','Patel','9800804882','GreenField Agro',NULL,NULL,'Email','Rajasthan','Qualified Lead','Sales Lead','B2B',NULL,107,NULL,NULL,NULL,NULL,NULL,1),(603,NULL,'2024-08-20','103 Main Road','Bangalore','India','2024-08-20 09:00:00.000000','kavita103@email.in','Kavita','Automotive','Singh','9800812773','FinanceFirst Pvt Ltd',NULL,NULL,'Social Media','Gujarat','Qualified Lead','Sales Lead','B2B',NULL,108,NULL,NULL,NULL,NULL,NULL,1),(604,NULL,'2025-09-21','104 Main Road','Hyderabad','India','2025-09-21 09:00:00.000000','rahul104@email.in','Rahul','IT','Verma','9800820664','AutoDrive Motors',NULL,NULL,'Other','Maharashtra','Qualified Lead','Sales Lead','B2B',NULL,109,NULL,NULL,NULL,NULL,NULL,1),(605,NULL,'2023-10-22','105 Main Road','Chennai','India','2023-10-22 09:00:00.000000','anita105@email.in','Anita','Manufacturing','Joshi','9800828555','EduSmart Institute',NULL,NULL,'Indiamart','Delhi','Qualified Lead','Sales Lead','B2B',NULL,110,NULL,NULL,NULL,NULL,NULL,1),(606,NULL,'2024-11-23','106 Main Road','Kolkata','India','2024-11-23 09:00:00.000000','deepak106@email.in','Deepak','Healthcare','Mehta','9800836446','Reliance Industries',NULL,NULL,'Website','Karnataka','Qualified Lead','Sales Lead','B2B',NULL,111,NULL,NULL,NULL,NULL,NULL,1),(607,NULL,'2025-12-24','107 Main Road','Jaipur','India','2025-12-24 09:00:00.000000','sunita107@email.in','Sunita','Retail','Desai','9800844337','Tata Consultancy',NULL,NULL,'Referral','Telangana','Qualified Lead','Sales Lead','B2B',NULL,112,NULL,NULL,NULL,NULL,NULL,1),(608,NULL,'2023-01-25','108 Main Road','Ahmedabad','India','2023-01-25 09:00:00.000000','vikram108@email.in','Vikram','Education','Gupta','9800852228','Infosys Ltd',NULL,NULL,'Direct','Tamil Nadu','Qualified Lead','Sales Lead','B2B',NULL,113,NULL,NULL,NULL,NULL,NULL,1),(609,NULL,'2024-02-26','109 Main Road','Surat','India','2024-02-26 09:00:00.000000','pooja109@email.in','Pooja','Finance','Nair','9800860119','Wipro Technologies',NULL,NULL,'Email','West Bengal','Qualified Lead','Sales Lead','B2B',NULL,114,NULL,NULL,NULL,NULL,NULL,1),(610,NULL,'2025-03-27','110 Main Road','Mumbai','India','2025-03-27 09:00:00.000000','mahesh110@email.in','Mahesh','Real Estate','Reddy','9800868010','HCL Technologies',NULL,NULL,'Social Media','Rajasthan','Qualified Lead','Sales Lead','B2B',NULL,115,NULL,NULL,NULL,NULL,NULL,1),(611,NULL,'2023-04-28','111 Main Road','Delhi','India','2023-04-28 09:00:00.000000','rekha111@email.in','Rekha','Automotive','Shah','9800875901','Mahindra Group',NULL,NULL,'Other','Gujarat','Qualified Lead','Sales Lead','B2B',NULL,116,NULL,NULL,NULL,NULL,NULL,1),(612,NULL,'2024-05-01','112 Main Road','Pune','India','2024-05-01 09:00:00.000000','suresh112@email.in','Suresh','IT','Mishra','9800883792','TechCorp Solutions',NULL,NULL,'Indiamart','Maharashtra','Qualified Lead','Sales Lead','B2B',NULL,117,NULL,NULL,NULL,NULL,NULL,1),(613,NULL,'2025-06-02','113 Main Road','Bangalore','India','2025-06-02 09:00:00.000000','meena113@email.in','Meena','Manufacturing','Tiwari','9800891683','Xform Technologies',NULL,NULL,'Website','Delhi','Qualified Lead','Sales Lead','B2B',NULL,118,NULL,NULL,NULL,NULL,NULL,1),(614,NULL,'2023-07-03','114 Main Road','Hyderabad','India','2023-07-03 09:00:00.000000','anil114@email.in','Anil','Healthcare','Agarwal','9800899574','BuildRight Infra',NULL,NULL,'Referral','Karnataka','Qualified Lead','Sales Lead','B2B',NULL,119,NULL,NULL,NULL,NULL,NULL,1),(615,NULL,'2024-08-04','115 Main Road','Chennai','India','2024-08-04 09:00:00.000000','komal115@email.in','Komal','Retail','Bose','9800907465','MedPlus Healthcare',NULL,NULL,'Direct','Telangana','Qualified Lead','Sales Lead','B2B',NULL,120,NULL,NULL,NULL,NULL,NULL,1),(616,NULL,'2025-09-05','116 Main Road','Kolkata','India','2025-09-05 09:00:00.000000','ravi116@email.in','Ravi','Education','Pillai','9800915356','GreenField Agro',NULL,NULL,'Email','Tamil Nadu','Qualified Lead','Sales Lead','B2B',NULL,121,NULL,NULL,NULL,NULL,NULL,1),(617,NULL,'2023-10-06','117 Main Road','Jaipur','India','2023-10-06 09:00:00.000000','shweta117@email.in','Shweta','Finance','Chauhan','9800923247','FinanceFirst Pvt Ltd',NULL,NULL,'Social Media','West Bengal','Qualified Lead','Sales Lead','B2B',NULL,122,NULL,NULL,NULL,NULL,NULL,1),(618,NULL,'2024-11-07','118 Main Road','Ahmedabad','India','2024-11-07 09:00:00.000000','girish118@email.in','Girish','Real Estate','Rao','9800931138','AutoDrive Motors',NULL,NULL,'Other','Rajasthan','Qualified Lead','Sales Lead','B2B',NULL,123,NULL,NULL,NULL,NULL,NULL,1),(619,NULL,'2025-12-08','119 Main Road','Surat','India','2025-12-08 09:00:00.000000','pallavi119@email.in','Pallavi','Automotive','Pandey','9800939029','EduSmart Institute',NULL,NULL,'Indiamart','Gujarat','Qualified Lead','Sales Lead','B2B',NULL,124,NULL,NULL,NULL,NULL,NULL,1),(620,NULL,'2023-01-09','120 Main Road','Mumbai','India','2023-01-09 09:00:00.000000','rajesh120@email.in','Rajesh','IT','Kumar','9800946920','Reliance Industries',NULL,NULL,'Website','Maharashtra','Qualified Lead','Sales Lead','B2B',NULL,125,NULL,NULL,NULL,NULL,NULL,1),(621,NULL,'2024-02-10','121 Main Road','Delhi','India','2024-02-10 09:00:00.000000','priya121@email.in','Priya','Manufacturing','Sharma','9800954811','Tata Consultancy',NULL,NULL,'Referral','Delhi','Qualified Lead','Sales Lead','B2B',NULL,126,NULL,NULL,NULL,NULL,NULL,1),(622,NULL,'2025-03-11','122 Main Road','Pune','India','2025-03-11 09:00:00.000000','amit122@email.in','Amit','Healthcare','Patel','9800962702','Infosys Ltd',NULL,NULL,'Direct','Karnataka','Qualified Lead','Sales Lead','B2B',NULL,127,NULL,NULL,NULL,NULL,NULL,1),(623,NULL,'2023-04-12','123 Main Road','Bangalore','India','2023-04-12 09:00:00.000000','sneha123@email.in','Sneha','Retail','Singh','9800970593','Wipro Technologies',NULL,NULL,'Email','Telangana','Qualified Lead','Sales Lead','B2B',NULL,128,NULL,NULL,NULL,NULL,NULL,1),(624,NULL,'2024-05-13','124 Main Road','Hyderabad','India','2024-05-13 09:00:00.000000','vikas124@email.in','Vikas','Education','Verma','9800978484','HCL Technologies',NULL,NULL,'Social Media','Tamil Nadu','Qualified Lead','Sales Lead','B2B',NULL,129,NULL,NULL,NULL,NULL,NULL,1),(625,NULL,'2025-06-14','125 Main Road','Chennai','India','2025-06-14 09:00:00.000000','neha125@email.in','Neha','Finance','Joshi','9800986375','Mahindra Group',NULL,NULL,'Other','West Bengal','Qualified Lead','Sales Lead','B2B',NULL,130,NULL,NULL,NULL,NULL,NULL,1),(626,NULL,'2023-07-15','126 Main Road','Kolkata','India','2023-07-15 09:00:00.000000','sanjay126@email.in','Sanjay','Real Estate','Mehta','9800994266','TechCorp Solutions',NULL,NULL,'Indiamart','Rajasthan','Qualified Lead','Sales Lead','B2B',NULL,131,NULL,NULL,NULL,NULL,NULL,1),(627,NULL,'2024-08-16','127 Main Road','Jaipur','India','2024-08-16 09:00:00.000000','kavita127@email.in','Kavita','Automotive','Desai','9801002157','Xform Technologies',NULL,NULL,'Website','Gujarat','Qualified Lead','Sales Lead','B2B',NULL,132,NULL,NULL,NULL,NULL,NULL,1),(628,NULL,'2025-09-17','128 Main Road','Ahmedabad','India','2025-09-17 09:00:00.000000','rahul128@email.in','Rahul','IT','Gupta','9801010048','BuildRight Infra',NULL,NULL,'Referral','Maharashtra','Qualified Lead','Sales Lead','B2B',NULL,133,NULL,NULL,NULL,NULL,NULL,1),(629,NULL,'2023-10-18','129 Main Road','Surat','India','2023-10-18 09:00:00.000000','anita129@email.in','Anita','Manufacturing','Nair','9801017939','MedPlus Healthcare',NULL,NULL,'Direct','Delhi','Qualified Lead','Sales Lead','B2B',NULL,134,NULL,NULL,NULL,NULL,NULL,1),(630,NULL,'2024-11-19','130 Main Road','Mumbai','India','2024-11-19 09:00:00.000000','deepak130@email.in','Deepak','Healthcare','Reddy','9801025830','GreenField Agro',NULL,NULL,'Email','Karnataka','Qualified Lead','Sales Lead','B2B',NULL,135,NULL,NULL,NULL,NULL,NULL,1),(631,NULL,'2025-12-20','131 Main Road','Delhi','India','2025-12-20 09:00:00.000000','sunita131@email.in','Sunita','Retail','Shah','9801033721','FinanceFirst Pvt Ltd',NULL,NULL,'Social Media','Telangana','Qualified Lead','Sales Lead','B2B',NULL,136,NULL,NULL,NULL,NULL,NULL,1),(632,NULL,'2023-01-21','132 Main Road','Pune','India','2023-01-21 09:00:00.000000','vikram132@email.in','Vikram','Education','Mishra','9801041612','AutoDrive Motors',NULL,NULL,'Other','Tamil Nadu','Qualified Lead','Sales Lead','B2B',NULL,137,NULL,NULL,NULL,NULL,NULL,1),(633,NULL,'2024-02-22','133 Main Road','Bangalore','India','2024-02-22 09:00:00.000000','pooja133@email.in','Pooja','Finance','Tiwari','9801049503','EduSmart Institute',NULL,NULL,'Indiamart','West Bengal','Qualified Lead','Sales Lead','B2B',NULL,138,NULL,NULL,NULL,NULL,NULL,1),(634,NULL,'2025-03-23','134 Main Road','Hyderabad','India','2025-03-23 09:00:00.000000','mahesh134@email.in','Mahesh','Real Estate','Agarwal','9801057394','Reliance Industries',NULL,NULL,'Website','Rajasthan','Qualified Lead','Sales Lead','B2B',NULL,139,NULL,NULL,NULL,NULL,NULL,1),(635,NULL,'2023-04-24','135 Main Road','Chennai','India','2023-04-24 09:00:00.000000','rekha135@email.in','Rekha','Automotive','Bose','9801065285','Tata Consultancy',NULL,NULL,'Referral','Gujarat','Qualified Lead','Sales Lead','B2B',NULL,140,NULL,NULL,NULL,NULL,NULL,1),(636,NULL,'2024-05-25','136 Main Road','Kolkata','India','2024-05-25 09:00:00.000000','suresh136@email.in','Suresh','IT','Pillai','9801073176','Infosys Ltd',NULL,NULL,'Direct','Maharashtra','Qualified Lead','Sales Lead','B2B',NULL,141,NULL,NULL,NULL,NULL,NULL,1),(637,NULL,'2025-06-26','137 Main Road','Jaipur','India','2025-06-26 09:00:00.000000','meena137@email.in','Meena','Manufacturing','Chauhan','9801081067','Wipro Technologies',NULL,NULL,'Email','Delhi','Qualified Lead','Sales Lead','B2B',NULL,142,NULL,NULL,NULL,NULL,NULL,1),(638,NULL,'2023-07-27','138 Main Road','Ahmedabad','India','2023-07-27 09:00:00.000000','anil138@email.in','Anil','Healthcare','Rao','9801088958','HCL Technologies',NULL,NULL,'Social Media','Karnataka','Qualified Lead','Sales Lead','B2B',NULL,143,NULL,NULL,NULL,NULL,NULL,1),(639,NULL,'2024-08-28','139 Main Road','Surat','India','2024-08-28 09:00:00.000000','komal139@email.in','Komal','Retail','Pandey','9801096849','Mahindra Group',NULL,NULL,'Other','Telangana','Qualified Lead','Sales Lead','B2B',NULL,144,NULL,NULL,NULL,NULL,NULL,1),(640,NULL,'2025-09-01','140 Main Road','Mumbai','India','2025-09-01 09:00:00.000000','ravi140@email.in','Ravi','Education','Kumar','9801104740','TechCorp Solutions',NULL,NULL,'Indiamart','Tamil Nadu','Qualified Lead','Sales Lead','B2B',NULL,145,NULL,NULL,NULL,NULL,NULL,1),(641,NULL,'2023-10-02','141 Main Road','Delhi','India','2023-10-02 09:00:00.000000','shweta141@email.in','Shweta','Finance','Sharma','9801112631','Xform Technologies',NULL,NULL,'Website','West Bengal','Qualified Lead','Sales Lead','B2B',NULL,146,NULL,NULL,NULL,NULL,NULL,1),(642,NULL,'2024-11-03','142 Main Road','Pune','India','2024-11-03 09:00:00.000000','girish142@email.in','Girish','Real Estate','Patel','9801120522','BuildRight Infra',NULL,NULL,'Referral','Rajasthan','Qualified Lead','Sales Lead','B2B',NULL,147,NULL,NULL,NULL,NULL,NULL,1),(643,NULL,'2025-12-04','143 Main Road','Bangalore','India','2025-12-04 09:00:00.000000','pallavi143@email.in','Pallavi','Automotive','Singh','9801128413','MedPlus Healthcare',NULL,NULL,'Direct','Gujarat','Qualified Lead','Sales Lead','B2B',NULL,148,NULL,NULL,NULL,NULL,NULL,1),(644,NULL,'2023-01-05','144 Main Road','Hyderabad','India','2023-01-05 09:00:00.000000','rajesh144@email.in','Rajesh','IT','Verma','9801136304','GreenField Agro',NULL,NULL,'Email','Maharashtra','Qualified Lead','Sales Lead','B2B',NULL,149,NULL,NULL,NULL,NULL,NULL,1),(645,NULL,'2024-02-06','145 Main Road','Chennai','India','2024-02-06 09:00:00.000000','priya145@email.in','Priya','Manufacturing','Joshi','9801144195','FinanceFirst Pvt Ltd',NULL,NULL,'Social Media','Delhi','Qualified Lead','Sales Lead','B2B',NULL,150,NULL,NULL,NULL,NULL,NULL,1),(646,NULL,'2025-03-07','146 Main Road','Kolkata','India','2025-03-07 09:00:00.000000','amit146@email.in','Amit','Healthcare','Mehta','9801152086','AutoDrive Motors',NULL,NULL,'Other','Karnataka','Qualified Lead','Sales Lead','B2B',NULL,151,NULL,NULL,NULL,NULL,NULL,1),(647,NULL,'2023-04-08','147 Main Road','Jaipur','India','2023-04-08 09:00:00.000000','sneha147@email.in','Sneha','Retail','Desai','9801159977','EduSmart Institute',NULL,NULL,'Indiamart','Telangana','Qualified Lead','Sales Lead','B2B',NULL,152,NULL,NULL,NULL,NULL,NULL,1),(648,NULL,'2024-05-09','148 Main Road','Ahmedabad','India','2024-05-09 09:00:00.000000','vikas148@email.in','Vikas','Education','Gupta','9801167868','Reliance Industries',NULL,NULL,'Website','Tamil Nadu','Working','Sales Lead','B2B',NULL,153,NULL,NULL,NULL,NULL,NULL,1),(649,NULL,'2025-06-10','149 Main Road','Surat','India','2025-06-10 09:00:00.000000','neha149@email.in','Neha','Finance','Nair','9801175759','Tata Consultancy',NULL,NULL,'Referral','West Bengal','Working','Sales Lead','B2B',NULL,154,NULL,NULL,NULL,NULL,NULL,1),(650,NULL,'2023-07-11','150 Main Road','Mumbai','India','2023-07-11 09:00:00.000000','sanjay150@email.in','Sanjay','Real Estate','Reddy','9801183650','Infosys Ltd',NULL,NULL,'Direct','Rajasthan','Working','Sales Lead','B2B',NULL,155,NULL,NULL,NULL,NULL,NULL,1),(651,NULL,'2024-08-12','151 Main Road','Delhi','India','2024-08-12 09:00:00.000000','kavita151@email.in','Kavita','Automotive','Shah','9801191541','Wipro Technologies',NULL,NULL,'Email','Gujarat','Working','Sales Lead','B2B',NULL,156,NULL,NULL,NULL,NULL,NULL,1),(652,NULL,'2025-09-13','152 Main Road','Pune','India','2025-09-13 09:00:00.000000','rahul152@email.in','Rahul','IT','Mishra','9801199432','HCL Technologies',NULL,NULL,'Social Media','Maharashtra','Working','Sales Lead','B2B',NULL,157,NULL,NULL,NULL,NULL,NULL,1),(653,NULL,'2023-10-14','153 Main Road','Bangalore','India','2023-10-14 09:00:00.000000','anita153@email.in','Anita','Manufacturing','Tiwari','9801207323','Mahindra Group',NULL,NULL,'Other','Delhi','Working','Sales Lead','B2B',NULL,158,NULL,NULL,NULL,NULL,NULL,1),(654,NULL,'2024-11-15','154 Main Road','Hyderabad','India','2024-11-15 09:00:00.000000','deepak154@email.in','Deepak','Healthcare','Agarwal','9801215214','TechCorp Solutions',NULL,NULL,'Indiamart','Karnataka','Working','Sales Lead','B2B',NULL,159,NULL,NULL,NULL,NULL,NULL,1),(655,NULL,'2025-12-16','155 Main Road','Chennai','India','2025-12-16 09:00:00.000000','sunita155@email.in','Sunita','Retail','Bose','9801223105','Xform Technologies',NULL,NULL,'Website','Telangana','Working','Sales Lead','B2B',NULL,160,NULL,NULL,NULL,NULL,NULL,1),(656,NULL,'2023-01-17','156 Main Road','Kolkata','India','2023-01-17 09:00:00.000000','vikram156@email.in','Vikram','Education','Pillai','9801230996','BuildRight Infra',NULL,NULL,'Referral','Tamil Nadu','Working','Sales Lead','B2B',NULL,161,NULL,NULL,NULL,NULL,NULL,1),(657,NULL,'2024-02-18','157 Main Road','Jaipur','India','2024-02-18 09:00:00.000000','pooja157@email.in','Pooja','Finance','Chauhan','9801238887','MedPlus Healthcare',NULL,NULL,'Direct','West Bengal','Working','Sales Lead','B2B',NULL,162,NULL,NULL,NULL,NULL,NULL,1),(658,NULL,'2025-03-19','158 Main Road','Ahmedabad','India','2025-03-19 09:00:00.000000','mahesh158@email.in','Mahesh','Real Estate','Rao','9801246778','GreenField Agro',NULL,NULL,'Email','Rajasthan','Working','Sales Lead','B2B',NULL,163,NULL,NULL,NULL,NULL,NULL,1),(659,NULL,'2023-04-20','159 Main Road','Surat','India','2023-04-20 09:00:00.000000','rekha159@email.in','Rekha','Automotive','Pandey','9801254669','FinanceFirst Pvt Ltd',NULL,NULL,'Social Media','Gujarat','Working','Sales Lead','B2B',NULL,164,NULL,NULL,NULL,NULL,NULL,1),(660,NULL,'2024-05-21','160 Main Road','Mumbai','India','2024-05-21 09:00:00.000000','suresh160@email.in','Suresh','IT','Kumar','9801262560','AutoDrive Motors',NULL,NULL,'Other','Maharashtra','Working','Sales Lead','B2B',NULL,165,NULL,NULL,NULL,NULL,NULL,1),(661,NULL,'2025-06-22','161 Main Road','Delhi','India','2025-06-22 09:00:00.000000','meena161@email.in','Meena','Manufacturing','Sharma','9801270451','EduSmart Institute',NULL,NULL,'Indiamart','Delhi','Working','Sales Lead','B2B',NULL,166,NULL,NULL,NULL,NULL,NULL,1),(662,NULL,'2023-07-23','162 Main Road','Pune','India','2023-07-23 09:00:00.000000','anil162@email.in','Anil','Healthcare','Patel','9801278342','Reliance Industries',NULL,NULL,'Website','Karnataka','Working','Sales Lead','B2B',NULL,167,NULL,NULL,NULL,NULL,NULL,1),(663,NULL,'2024-08-24','163 Main Road','Bangalore','India','2024-08-24 09:00:00.000000','komal163@email.in','Komal','Retail','Singh','9801286233','Tata Consultancy',NULL,NULL,'Referral','Telangana','Working','Sales Lead','B2B',NULL,168,NULL,NULL,NULL,NULL,NULL,1),(664,NULL,'2025-09-25','164 Main Road','Hyderabad','India','2025-09-25 09:00:00.000000','ravi164@email.in','Ravi','Education','Verma','9801294124','Infosys Ltd',NULL,NULL,'Direct','Tamil Nadu','Working','Sales Lead','B2B',NULL,169,NULL,NULL,NULL,NULL,NULL,1),(665,NULL,'2023-10-26','165 Main Road','Chennai','India','2023-10-26 09:00:00.000000','shweta165@email.in','Shweta','Finance','Joshi','9801302015','Wipro Technologies',NULL,NULL,'Email','West Bengal','Working','Sales Lead','B2B',NULL,170,NULL,NULL,NULL,NULL,NULL,1),(666,NULL,'2024-11-27','166 Main Road','Kolkata','India','2024-11-27 09:00:00.000000','girish166@email.in','Girish','Real Estate','Mehta','9801309906','HCL Technologies',NULL,NULL,'Social Media','Rajasthan','Working','Sales Lead','B2B',NULL,171,NULL,NULL,NULL,NULL,NULL,1),(667,NULL,'2025-12-28','167 Main Road','Jaipur','India','2025-12-28 09:00:00.000000','pallavi167@email.in','Pallavi','Automotive','Desai','9801317797','Mahindra Group',NULL,NULL,'Other','Gujarat','Working','Sales Lead','B2B',NULL,172,NULL,NULL,NULL,NULL,NULL,1),(668,NULL,'2023-01-01','168 Main Road','Ahmedabad','India','2023-01-01 09:00:00.000000','rajesh168@email.in','Rajesh','IT','Gupta','9801325688','TechCorp Solutions',NULL,NULL,'Indiamart','Maharashtra','Working','Sales Lead','B2B',NULL,173,NULL,NULL,NULL,NULL,NULL,1),(669,NULL,'2024-02-02','169 Main Road','Surat','India','2024-02-02 09:00:00.000000','priya169@email.in','Priya','Manufacturing','Nair','9801333579','Xform Technologies',NULL,NULL,'Website','Delhi','Working','Sales Lead','B2B',NULL,174,NULL,NULL,NULL,NULL,NULL,1),(670,NULL,'2025-03-03','170 Main Road','Mumbai','India','2025-03-03 09:00:00.000000','amit170@email.in','Amit','Healthcare','Reddy','9801341470','BuildRight Infra',NULL,NULL,'Referral','Karnataka','Working','Sales Lead','B2B',NULL,175,NULL,NULL,NULL,NULL,NULL,1),(671,NULL,'2023-04-04','171 Main Road','Delhi','India','2023-04-04 09:00:00.000000','sneha171@email.in','Sneha','Retail','Shah','9801349361','MedPlus Healthcare',NULL,NULL,'Direct','Telangana','Working','Sales Lead','B2B',NULL,176,NULL,NULL,NULL,NULL,NULL,1),(672,NULL,'2024-05-05','172 Main Road','Pune','India','2024-05-05 09:00:00.000000','vikas172@email.in','Vikas','Education','Mishra','9801357252','GreenField Agro',NULL,NULL,'Email','Tamil Nadu','Working','Sales Lead','B2B',NULL,177,NULL,NULL,NULL,NULL,NULL,1),(673,NULL,'2025-06-06','173 Main Road','Bangalore','India','2025-06-06 09:00:00.000000','neha173@email.in','Neha','Finance','Tiwari','9801365143','FinanceFirst Pvt Ltd',NULL,NULL,'Social Media','West Bengal','Working','Sales Lead','B2B',NULL,178,NULL,NULL,NULL,NULL,NULL,1),(674,NULL,'2023-07-07','174 Main Road','Hyderabad','India','2023-07-07 09:00:00.000000','sanjay174@email.in','Sanjay','Real Estate','Agarwal','9801373034','AutoDrive Motors',NULL,NULL,'Other','Rajasthan','Working','Sales Lead','B2B',NULL,179,NULL,NULL,NULL,NULL,NULL,1),(675,NULL,'2024-08-08','175 Main Road','Chennai','India','2024-08-08 09:00:00.000000','kavita175@email.in','Kavita','Automotive','Bose','9801380925','EduSmart Institute',NULL,NULL,'Indiamart','Gujarat','Working','Sales Lead','B2B',NULL,180,NULL,NULL,NULL,NULL,NULL,1),(676,NULL,'2025-09-09','176 Main Road','Kolkata','India','2025-09-09 09:00:00.000000','rahul176@email.in','Rahul','IT','Pillai','9801388816','Reliance Industries',NULL,NULL,'Website','Maharashtra','Working','Sales Lead','B2B',NULL,181,NULL,NULL,NULL,NULL,NULL,1),(677,NULL,'2023-10-10','177 Main Road','Jaipur','India','2023-10-10 09:00:00.000000','anita177@email.in','Anita','Manufacturing','Chauhan','9801396707','Tata Consultancy',NULL,NULL,'Referral','Delhi','Working','Sales Lead','B2B',NULL,182,NULL,NULL,NULL,NULL,NULL,1),(678,NULL,'2024-11-11','178 Main Road','Ahmedabad','India','2024-11-11 09:00:00.000000','deepak178@email.in','Deepak','Healthcare','Rao','9801404598','Infosys Ltd',NULL,NULL,'Direct','Karnataka','Working','Sales Lead','B2B',NULL,183,NULL,NULL,NULL,NULL,NULL,1),(679,NULL,'2025-12-12','179 Main Road','Surat','India','2025-12-12 09:00:00.000000','sunita179@email.in','Sunita','Retail','Pandey','9801412489','Wipro Technologies',NULL,NULL,'Email','Telangana','Working','Sales Lead','B2B',NULL,184,NULL,NULL,NULL,NULL,NULL,1),(680,NULL,'2023-01-13','180 Main Road','Mumbai','India','2023-01-13 09:00:00.000000','vikram180@email.in','Vikram','Education','Kumar','9801420380','HCL Technologies',NULL,NULL,'Social Media','Tamil Nadu','Working','Sales Lead','B2B',NULL,185,NULL,NULL,NULL,NULL,NULL,1),(681,NULL,'2024-02-14','181 Main Road','Delhi','India','2024-02-14 09:00:00.000000','pooja181@email.in','Pooja','Finance','Sharma','9801428271','Mahindra Group',NULL,NULL,'Other','West Bengal','Working','Sales Lead','B2B',NULL,186,NULL,NULL,NULL,NULL,NULL,1),(682,NULL,'2025-03-15','182 Main Road','Pune','India','2025-03-15 09:00:00.000000','mahesh182@email.in','Mahesh','Real Estate','Patel','9801436162','TechCorp Solutions',NULL,NULL,'Indiamart','Rajasthan','Working','Sales Lead','B2B',NULL,187,NULL,NULL,NULL,NULL,NULL,1),(683,NULL,'2023-04-16','183 Main Road','Bangalore','India','2023-04-16 09:00:00.000000','rekha183@email.in','Rekha','Automotive','Singh','9801444053','Xform Technologies',NULL,NULL,'Website','Gujarat','Working','Sales Lead','B2B',NULL,188,NULL,NULL,NULL,NULL,NULL,1),(684,NULL,'2024-05-17','184 Main Road','Hyderabad','India','2024-05-17 09:00:00.000000','suresh184@email.in','Suresh','IT','Verma','9801451944','BuildRight Infra',NULL,NULL,'Referral','Maharashtra','Working','Sales Lead','B2B',NULL,189,NULL,NULL,NULL,NULL,NULL,1),(685,NULL,'2025-06-18','185 Main Road','Chennai','India','2025-06-18 09:00:00.000000','meena185@email.in','Meena','Manufacturing','Joshi','9801459835','MedPlus Healthcare',NULL,NULL,'Direct','Delhi','Working','Sales Lead','B2B',NULL,190,NULL,NULL,NULL,NULL,NULL,1),(686,NULL,'2023-07-19','186 Main Road','Kolkata','India','2023-07-19 09:00:00.000000','anil186@email.in','Anil','Healthcare','Mehta','9801467726','GreenField Agro',NULL,NULL,'Email','Karnataka','Working','Sales Lead','B2B',NULL,191,NULL,NULL,NULL,NULL,NULL,1),(687,NULL,'2024-08-20','187 Main Road','Jaipur','India','2024-08-20 09:00:00.000000','komal187@email.in','Komal','Retail','Desai','9801475617','FinanceFirst Pvt Ltd',NULL,NULL,'Social Media','Telangana','Working','Sales Lead','B2B',NULL,192,NULL,NULL,NULL,NULL,NULL,1),(688,NULL,'2025-09-21','188 Main Road','Ahmedabad','India','2025-09-21 09:00:00.000000','ravi188@email.in','Ravi','Education','Gupta','9801483508','AutoDrive Motors',NULL,NULL,'Other','Tamil Nadu','Working','Sales Lead','B2B',NULL,193,NULL,NULL,NULL,NULL,NULL,1),(689,NULL,'2023-10-22','189 Main Road','Surat','India','2023-10-22 09:00:00.000000','shweta189@email.in','Shweta','Finance','Nair','9801491399','EduSmart Institute',NULL,NULL,'Indiamart','West Bengal','Working','Sales Lead','B2B',NULL,194,NULL,NULL,NULL,NULL,NULL,1),(690,NULL,'2024-11-23','190 Main Road','Mumbai','India','2024-11-23 09:00:00.000000','girish190@email.in','Girish','Real Estate','Reddy','9801499290','Reliance Industries',NULL,NULL,'Website','Rajasthan','Working','Sales Lead','B2B',NULL,195,NULL,NULL,NULL,NULL,NULL,1),(691,NULL,'2025-12-24','191 Main Road','Delhi','India','2025-12-24 09:00:00.000000','pallavi191@email.in','Pallavi','Automotive','Shah','9801507181','Tata Consultancy',NULL,NULL,'Referral','Gujarat','Working','Sales Lead','B2B',NULL,196,NULL,NULL,NULL,NULL,NULL,1),(692,NULL,'2023-01-25','192 Main Road','Pune','India','2023-01-25 09:00:00.000000','rajesh192@email.in','Rajesh','IT','Mishra','9801515072','Infosys Ltd',NULL,NULL,'Direct','Maharashtra','Working','Sales Lead','B2B',NULL,197,NULL,NULL,NULL,NULL,NULL,1),(693,NULL,'2024-02-26','193 Main Road','Bangalore','India','2024-02-26 09:00:00.000000','priya193@email.in','Priya','Manufacturing','Tiwari','9801522963','Wipro Technologies',NULL,NULL,'Email','Delhi','QuotationSent','Sales Lead','B2B',NULL,198,NULL,NULL,NULL,NULL,NULL,1),(694,NULL,'2025-03-27','194 Main Road','Hyderabad','India','2025-03-27 09:00:00.000000','amit194@email.in','Amit','Healthcare','Agarwal','9801530854','HCL Technologies',NULL,NULL,'Social Media','Karnataka','QuotationSent','Sales Lead','B2B',NULL,199,NULL,NULL,NULL,NULL,NULL,1),(695,NULL,'2023-04-28','195 Main Road','Chennai','India','2023-04-28 09:00:00.000000','sneha195@email.in','Sneha','Retail','Bose','9801538745','Mahindra Group',NULL,NULL,'Other','Telangana','QuotationSent','Sales Lead','B2B',NULL,200,NULL,NULL,NULL,NULL,NULL,1),(696,NULL,'2024-05-01','196 Main Road','Kolkata','India','2024-05-01 09:00:00.000000','vikas196@email.in','Vikas','Education','Pillai','9801546636','TechCorp Solutions',NULL,NULL,'Indiamart','Tamil Nadu','QuotationSent','Sales Lead','B2B',NULL,201,NULL,NULL,NULL,NULL,NULL,1),(697,NULL,'2025-06-02','197 Main Road','Jaipur','India','2025-06-02 09:00:00.000000','neha197@email.in','Neha','Finance','Chauhan','9801554527','Xform Technologies',NULL,NULL,'Website','West Bengal','QuotationSent','Sales Lead','B2B',NULL,202,NULL,NULL,NULL,NULL,NULL,1),(698,NULL,'2023-07-03','198 Main Road','Ahmedabad','India','2023-07-03 09:00:00.000000','sanjay198@email.in','Sanjay','Real Estate','Rao','9801562418','BuildRight Infra',NULL,NULL,'Referral','Rajasthan','QuotationSent','Sales Lead','B2B',NULL,203,NULL,NULL,NULL,NULL,NULL,1),(699,NULL,'2024-08-04','199 Main Road','Surat','India','2024-08-04 09:00:00.000000','kavita199@email.in','Kavita','Automotive','Pandey','9801570309','MedPlus Healthcare',NULL,NULL,'Direct','Gujarat','QuotationSent','Sales Lead','B2B',NULL,204,NULL,NULL,NULL,NULL,NULL,1),(700,NULL,'2025-09-05','200 Main Road','Mumbai','India','2025-09-05 09:00:00.000000','rahul200@email.in','Rahul','IT','Kumar','9801578200','GreenField Agro',NULL,NULL,'Email','Maharashtra','QuotationSent','Sales Lead','B2B',NULL,205,NULL,NULL,NULL,NULL,NULL,1),(701,NULL,'2023-10-06','201 Main Road','Delhi','India','2023-10-06 09:00:00.000000','anita201@email.in','Anita','Manufacturing','Sharma','9801586091','FinanceFirst Pvt Ltd',NULL,NULL,'Social Media','Delhi','QuotationSent','Sales Lead','B2B',NULL,206,NULL,NULL,NULL,NULL,NULL,1),(702,NULL,'2024-11-07','202 Main Road','Pune','India','2024-11-07 09:00:00.000000','deepak202@email.in','Deepak','Healthcare','Patel','9801593982','AutoDrive Motors',NULL,NULL,'Other','Karnataka','QuotationSent','Sales Lead','B2B',NULL,207,NULL,NULL,NULL,NULL,NULL,1),(703,NULL,'2025-12-08','203 Main Road','Bangalore','India','2025-12-08 09:00:00.000000','sunita203@email.in','Sunita','Retail','Singh','9801601873','EduSmart Institute',NULL,NULL,'Indiamart','Telangana','QuotationSent','Sales Lead','B2B',NULL,208,NULL,NULL,NULL,NULL,NULL,1),(704,NULL,'2023-01-09','204 Main Road','Hyderabad','India','2023-01-09 09:00:00.000000','vikram204@email.in','Vikram','Education','Verma','9801609764','Reliance Industries',NULL,NULL,'Website','Tamil Nadu','QuotationSent','Sales Lead','B2B',NULL,209,NULL,NULL,NULL,NULL,NULL,1),(705,NULL,'2024-02-10','205 Main Road','Chennai','India','2024-02-10 09:00:00.000000','pooja205@email.in','Pooja','Finance','Joshi','9801617655','Tata Consultancy',NULL,NULL,'Referral','West Bengal','QuotationSent','Sales Lead','B2B',NULL,210,NULL,NULL,NULL,NULL,NULL,1),(706,NULL,'2025-03-11','206 Main Road','Kolkata','India','2025-03-11 09:00:00.000000','mahesh206@email.in','Mahesh','Real Estate','Mehta','9801625546','Infosys Ltd',NULL,NULL,'Direct','Rajasthan','QuotationSent','Sales Lead','B2B',NULL,211,NULL,NULL,NULL,NULL,NULL,1),(707,NULL,'2023-04-12','207 Main Road','Jaipur','India','2023-04-12 09:00:00.000000','rekha207@email.in','Rekha','Automotive','Desai','9801633437','Wipro Technologies',NULL,NULL,'Email','Gujarat','QuotationSent','Sales Lead','B2B',NULL,212,NULL,NULL,NULL,NULL,NULL,1),(708,NULL,'2024-05-13','208 Main Road','Ahmedabad','India','2024-05-13 09:00:00.000000','suresh208@email.in','Suresh','IT','Gupta','9801641328','HCL Technologies',NULL,NULL,'Social Media','Maharashtra','QuotationSent','Sales Lead','B2B',NULL,213,NULL,NULL,NULL,NULL,NULL,1),(709,NULL,'2025-06-14','209 Main Road','Surat','India','2025-06-14 09:00:00.000000','meena209@email.in','Meena','Manufacturing','Nair','9801649219','Mahindra Group',NULL,NULL,'Other','Delhi','QuotationSent','Sales Lead','B2B',NULL,214,NULL,NULL,NULL,NULL,NULL,1),(710,NULL,'2023-07-15','210 Main Road','Mumbai','India','2023-07-15 09:00:00.000000','anil210@email.in','Anil','Healthcare','Reddy','9801657110','TechCorp Solutions',NULL,NULL,'Indiamart','Karnataka','QuotationSent','Sales Lead','B2B',NULL,215,NULL,NULL,NULL,NULL,NULL,1),(711,NULL,'2024-08-16','211 Main Road','Delhi','India','2024-08-16 09:00:00.000000','komal211@email.in','Komal','Retail','Shah','9801665001','Xform Technologies',NULL,NULL,'Website','Telangana','QuotationSent','Sales Lead','B2B',NULL,216,NULL,NULL,NULL,NULL,NULL,1),(712,NULL,'2025-09-17','212 Main Road','Pune','India','2025-09-17 09:00:00.000000','ravi212@email.in','Ravi','Education','Mishra','9801672892','BuildRight Infra',NULL,NULL,'Referral','Tamil Nadu','QuotationSent','Sales Lead','B2B',NULL,217,NULL,NULL,NULL,NULL,NULL,1),(713,NULL,'2023-10-18','213 Main Road','Bangalore','India','2023-10-18 09:00:00.000000','shweta213@email.in','Shweta','Finance','Tiwari','9801680783','MedPlus Healthcare',NULL,NULL,'Direct','West Bengal','QuotationSent','Sales Lead','B2B',NULL,218,NULL,NULL,NULL,NULL,NULL,1),(714,NULL,'2024-11-19','214 Main Road','Hyderabad','India','2024-11-19 09:00:00.000000','girish214@email.in','Girish','Real Estate','Agarwal','9801688674','GreenField Agro',NULL,NULL,'Email','Rajasthan','QuotationSent','Sales Lead','B2B',NULL,219,NULL,NULL,NULL,NULL,NULL,1),(715,NULL,'2025-12-20','215 Main Road','Chennai','India','2025-12-20 09:00:00.000000','pallavi215@email.in','Pallavi','Automotive','Bose','9801696565','FinanceFirst Pvt Ltd',NULL,NULL,'Social Media','Gujarat','QuotationSent','Sales Lead','B2B',NULL,220,NULL,NULL,NULL,NULL,NULL,1),(716,NULL,'2023-01-21','216 Main Road','Kolkata','India','2023-01-21 09:00:00.000000','rajesh216@email.in','Rajesh','IT','Pillai','9801704456','AutoDrive Motors',NULL,NULL,'Other','Maharashtra','QuotationSent','Sales Lead','B2B',NULL,221,NULL,NULL,NULL,NULL,NULL,1),(717,NULL,'2024-02-22','217 Main Road','Jaipur','India','2024-02-22 09:00:00.000000','priya217@email.in','Priya','Manufacturing','Chauhan','9801712347','EduSmart Institute',NULL,NULL,'Indiamart','Delhi','QuotationSent','Sales Lead','B2B',NULL,222,NULL,NULL,NULL,NULL,NULL,1),(718,NULL,'2025-03-23','218 Main Road','Ahmedabad','India','2025-03-23 09:00:00.000000','amit218@email.in','Amit','Healthcare','Rao','9801720238','Reliance Industries',NULL,NULL,'Website','Karnataka','QuotationSent','Sales Lead','B2B',NULL,223,NULL,NULL,NULL,NULL,NULL,1),(719,NULL,'2023-04-24','219 Main Road','Surat','India','2023-04-24 09:00:00.000000','sneha219@email.in','Sneha','Retail','Pandey','9801728129','Tata Consultancy',NULL,NULL,'Referral','Telangana','QuotationSent','Sales Lead','B2B',NULL,224,NULL,NULL,NULL,NULL,NULL,1),(720,NULL,'2024-05-25','220 Main Road','Mumbai','India','2024-05-25 09:00:00.000000','vikas220@email.in','Vikas','Education','Kumar','9801736020','Infosys Ltd',NULL,NULL,'Direct','Tamil Nadu','QuotationSent','Sales Lead','B2B',NULL,225,NULL,NULL,NULL,NULL,NULL,1),(721,NULL,'2025-06-26','221 Main Road','Delhi','India','2025-06-26 09:00:00.000000','neha221@email.in','Neha','Finance','Sharma','9801743911','Wipro Technologies',NULL,NULL,'Email','West Bengal','QuotationSent','Sales Lead','B2B',NULL,226,NULL,NULL,NULL,NULL,NULL,1),(722,NULL,'2023-07-27','222 Main Road','Pune','India','2023-07-27 09:00:00.000000','sanjay222@email.in','Sanjay','Real Estate','Patel','9801751802','HCL Technologies',NULL,NULL,'Social Media','Rajasthan','QuotationSent','Sales Lead','B2B',NULL,227,NULL,NULL,NULL,NULL,NULL,1),(723,NULL,'2024-08-28','223 Main Road','Bangalore','India','2024-08-28 09:00:00.000000','kavita223@email.in','Kavita','Automotive','Singh','9801759693','Mahindra Group',NULL,NULL,'Other','Gujarat','QuotationSent','Sales Lead','B2B',NULL,228,NULL,NULL,NULL,NULL,NULL,1),(724,NULL,'2025-09-01','224 Main Road','Hyderabad','India','2025-09-01 09:00:00.000000','rahul224@email.in','Rahul','IT','Verma','9801767584','TechCorp Solutions',NULL,NULL,'Indiamart','Maharashtra','QuotationSent','Sales Lead','B2B',NULL,229,NULL,NULL,NULL,NULL,NULL,1),(725,NULL,'2023-10-02','225 Main Road','Chennai','India','2023-10-02 09:00:00.000000','anita225@email.in','Anita','Manufacturing','Joshi','9801775475','Xform Technologies',NULL,NULL,'Website','Delhi','QuotationSent','Sales Lead','B2B',NULL,230,NULL,NULL,NULL,NULL,NULL,1),(726,NULL,'2024-11-03','226 Main Road','Kolkata','India','2024-11-03 09:00:00.000000','deepak226@email.in','Deepak','Healthcare','Mehta','9801783366','BuildRight Infra',NULL,NULL,'Referral','Karnataka','QuotationSent','Sales Lead','B2B',NULL,231,NULL,NULL,NULL,NULL,NULL,1),(727,NULL,'2025-12-04','227 Main Road','Jaipur','India','2025-12-04 09:00:00.000000','sunita227@email.in','Sunita','Retail','Desai','9801791257','MedPlus Healthcare',NULL,NULL,'Direct','Telangana','QuotationSent','Sales Lead','B2B',NULL,232,NULL,NULL,NULL,NULL,NULL,1),(728,NULL,'2023-01-05','228 Main Road','Ahmedabad','India','2023-01-05 09:00:00.000000','vikram228@email.in','Vikram','Education','Gupta','9801799148','GreenField Agro',NULL,NULL,'Email','Tamil Nadu','QuotationSent','Sales Lead','B2B',NULL,233,NULL,NULL,NULL,NULL,NULL,1),(729,NULL,'2024-02-06','229 Main Road','Surat','India','2024-02-06 09:00:00.000000','pooja229@email.in','Pooja','Finance','Nair','9801807039','FinanceFirst Pvt Ltd',NULL,NULL,'Social Media','West Bengal','QuotationSent','Sales Lead','B2B',NULL,234,NULL,NULL,NULL,NULL,NULL,1),(730,NULL,'2025-03-07','230 Main Road','Mumbai','India','2025-03-07 09:00:00.000000','mahesh230@email.in','Mahesh','Real Estate','Reddy','9801814930','AutoDrive Motors',NULL,NULL,'Other','Rajasthan','QuotationSent','Sales Lead','B2B',NULL,235,NULL,NULL,NULL,NULL,NULL,1),(731,NULL,'2023-04-08','231 Main Road','Delhi','India','2023-04-08 09:00:00.000000','rekha231@email.in','Rekha','Automotive','Shah','9801822821','EduSmart Institute',NULL,NULL,'Indiamart','Gujarat','QuotationSent','Sales Lead','B2B',NULL,236,NULL,NULL,NULL,NULL,NULL,1),(732,NULL,'2024-05-09','232 Main Road','Pune','India','2024-05-09 09:00:00.000000','suresh232@email.in','Suresh','IT','Mishra','9801830712','Reliance Industries',NULL,NULL,'Website','Maharashtra','QuotationSent','Sales Lead','B2B',NULL,237,NULL,NULL,NULL,NULL,NULL,1),(733,NULL,'2025-06-10','233 Main Road','Bangalore','India','2025-06-10 09:00:00.000000','meena233@email.in','Meena','Manufacturing','Tiwari','9801838603','Tata Consultancy',NULL,NULL,'Referral','Delhi','QuotationSent','Sales Lead','B2B',NULL,238,NULL,NULL,NULL,NULL,NULL,1),(734,NULL,'2023-07-11','234 Main Road','Hyderabad','India','2023-07-11 09:00:00.000000','anil234@email.in','Anil','Healthcare','Agarwal','9801846494','Infosys Ltd',NULL,NULL,'Direct','Karnataka','QuotationSent','Sales Lead','B2B',NULL,239,NULL,NULL,NULL,NULL,NULL,1),(735,NULL,'2024-08-12','235 Main Road','Chennai','India','2024-08-12 09:00:00.000000','komal235@email.in','Komal','Retail','Bose','9801854385','Wipro Technologies',NULL,NULL,'Email','Telangana','QuotationSent','Sales Lead','B2B',NULL,240,NULL,NULL,NULL,NULL,NULL,1),(736,NULL,'2025-09-13','236 Main Road','Kolkata','India','2025-09-13 09:00:00.000000','ravi236@email.in','Ravi','Education','Pillai','9801862276','HCL Technologies',NULL,NULL,'Social Media','Tamil Nadu','QuotationSent','Sales Lead','B2B',NULL,241,NULL,NULL,NULL,NULL,NULL,1),(737,NULL,'2023-10-14','237 Main Road','Jaipur','India','2023-10-14 09:00:00.000000','shweta237@email.in','Shweta','Finance','Chauhan','9801870167','Mahindra Group',NULL,NULL,'Other','West Bengal','QuotationSent','Sales Lead','B2B',NULL,242,NULL,NULL,NULL,NULL,NULL,1),(738,NULL,'2024-11-15','238 Main Road','Ahmedabad','India','2024-11-15 09:00:00.000000','girish238@email.in','Girish','Real Estate','Rao','9801878058','TechCorp Solutions',NULL,NULL,'Indiamart','Rajasthan','Negotiation','Sales Lead','B2B',NULL,243,NULL,NULL,NULL,NULL,NULL,1),(739,NULL,'2025-12-16','239 Main Road','Surat','India','2025-12-16 09:00:00.000000','pallavi239@email.in','Pallavi','Automotive','Pandey','9801885949','Xform Technologies',NULL,NULL,'Website','Gujarat','Negotiation','Sales Lead','B2B',NULL,244,NULL,NULL,NULL,NULL,NULL,1),(740,NULL,'2023-01-17','240 Main Road','Mumbai','India','2023-01-17 09:00:00.000000','rajesh240@email.in','Rajesh','IT','Kumar','9801893840','BuildRight Infra',NULL,NULL,'Referral','Maharashtra','Negotiation','Sales Lead','B2B',NULL,245,NULL,NULL,NULL,NULL,NULL,1),(741,NULL,'2024-02-18','241 Main Road','Delhi','India','2024-02-18 09:00:00.000000','priya241@email.in','Priya','Manufacturing','Sharma','9801901731','MedPlus Healthcare',NULL,NULL,'Direct','Delhi','Negotiation','Sales Lead','B2B',NULL,246,NULL,NULL,NULL,NULL,NULL,1),(742,NULL,'2025-03-19','242 Main Road','Pune','India','2025-03-19 09:00:00.000000','amit242@email.in','Amit','Healthcare','Patel','9801909622','GreenField Agro',NULL,NULL,'Email','Karnataka','Negotiation','Sales Lead','B2B',NULL,247,NULL,NULL,NULL,NULL,NULL,1),(743,NULL,'2023-04-20','243 Main Road','Bangalore','India','2023-04-20 09:00:00.000000','sneha243@email.in','Sneha','Retail','Singh','9801917513','FinanceFirst Pvt Ltd',NULL,NULL,'Social Media','Telangana','Negotiation','Sales Lead','B2B',NULL,248,NULL,NULL,NULL,NULL,NULL,1),(744,NULL,'2024-05-21','244 Main Road','Hyderabad','India','2024-05-21 09:00:00.000000','vikas244@email.in','Vikas','Education','Verma','9801925404','AutoDrive Motors',NULL,NULL,'Other','Tamil Nadu','Negotiation','Sales Lead','B2B',NULL,249,NULL,NULL,NULL,NULL,NULL,1),(745,NULL,'2025-06-22','245 Main Road','Chennai','India','2025-06-22 09:00:00.000000','neha245@email.in','Neha','Finance','Joshi','9801933295','EduSmart Institute',NULL,NULL,'Indiamart','West Bengal','Negotiation','Sales Lead','B2B',NULL,250,NULL,NULL,NULL,NULL,NULL,1),(746,NULL,'2023-07-23','246 Main Road','Kolkata','India','2023-07-23 09:00:00.000000','sanjay246@email.in','Sanjay','Real Estate','Mehta','9801941186','Reliance Industries',NULL,NULL,'Website','Rajasthan','Negotiation','Sales Lead','B2B',NULL,251,NULL,NULL,NULL,NULL,NULL,1),(747,NULL,'2024-08-24','247 Main Road','Jaipur','India','2024-08-24 09:00:00.000000','kavita247@email.in','Kavita','Automotive','Desai','9801949077','Tata Consultancy',NULL,NULL,'Referral','Gujarat','Negotiation','Sales Lead','B2B',NULL,252,NULL,NULL,NULL,NULL,NULL,1),(748,NULL,'2025-09-25','248 Main Road','Ahmedabad','India','2025-09-25 09:00:00.000000','rahul248@email.in','Rahul','IT','Gupta','9801956968','Infosys Ltd',NULL,NULL,'Direct','Maharashtra','Negotiation','Sales Lead','B2B',NULL,253,NULL,NULL,NULL,NULL,NULL,1),(749,NULL,'2023-10-26','249 Main Road','Surat','India','2023-10-26 09:00:00.000000','anita249@email.in','Anita','Manufacturing','Nair','9801964859','Wipro Technologies',NULL,NULL,'Email','Delhi','Negotiation','Sales Lead','B2B',NULL,254,NULL,NULL,NULL,NULL,NULL,1),(750,NULL,'2024-11-27','250 Main Road','Mumbai','India','2024-11-27 09:00:00.000000','deepak250@email.in','Deepak','Healthcare','Reddy','9801972750','HCL Technologies',NULL,NULL,'Social Media','Karnataka','Negotiation','Sales Lead','B2B',NULL,255,NULL,NULL,NULL,NULL,NULL,1),(751,NULL,'2025-12-28','251 Main Road','Delhi','India','2025-12-28 09:00:00.000000','sunita251@email.in','Sunita','Retail','Shah','9801980641','Mahindra Group',NULL,NULL,'Other','Telangana','Negotiation','Sales Lead','B2B',NULL,256,NULL,NULL,NULL,NULL,NULL,1),(752,NULL,'2023-01-01','252 Main Road','Pune','India','2023-01-01 09:00:00.000000','vikram252@email.in','Vikram','Education','Mishra','9801988532','TechCorp Solutions',NULL,NULL,'Indiamart','Tamil Nadu','Negotiation','Sales Lead','B2B',NULL,257,NULL,NULL,NULL,NULL,NULL,1),(753,NULL,'2024-02-02','253 Main Road','Bangalore','India','2024-02-02 09:00:00.000000','pooja253@email.in','Pooja','Finance','Tiwari','9801996423','Xform Technologies',NULL,NULL,'Website','West Bengal','Negotiation','Sales Lead','B2B',NULL,258,NULL,NULL,NULL,NULL,NULL,1),(754,NULL,'2025-03-03','254 Main Road','Hyderabad','India','2025-03-03 09:00:00.000000','mahesh254@email.in','Mahesh','Real Estate','Agarwal','9802004314','BuildRight Infra',NULL,NULL,'Referral','Rajasthan','Negotiation','Sales Lead','B2B',NULL,259,NULL,NULL,NULL,NULL,NULL,1),(755,NULL,'2023-04-04','255 Main Road','Chennai','India','2023-04-04 09:00:00.000000','rekha255@email.in','Rekha','Automotive','Bose','9802012205','MedPlus Healthcare',NULL,NULL,'Direct','Gujarat','Negotiation','Sales Lead','B2B',NULL,260,NULL,NULL,NULL,NULL,NULL,1),(756,NULL,'2024-05-05','256 Main Road','Kolkata','India','2024-05-05 09:00:00.000000','suresh256@email.in','Suresh','IT','Pillai','9802020096','GreenField Agro',NULL,NULL,'Email','Maharashtra','Negotiation','Sales Lead','B2B',NULL,261,NULL,NULL,NULL,NULL,NULL,1),(757,NULL,'2025-06-06','257 Main Road','Jaipur','India','2025-06-06 09:00:00.000000','meena257@email.in','Meena','Manufacturing','Chauhan','9802027987','FinanceFirst Pvt Ltd',NULL,NULL,'Social Media','Delhi','Negotiation','Sales Lead','B2B',NULL,262,NULL,NULL,NULL,NULL,NULL,1),(758,NULL,'2023-07-07','258 Main Road','Ahmedabad','India','2023-07-07 09:00:00.000000','anil258@email.in','Anil','Healthcare','Rao','9802035878','AutoDrive Motors',NULL,NULL,'Other','Karnataka','Negotiation','Sales Lead','B2B',NULL,263,NULL,NULL,NULL,NULL,NULL,1),(759,NULL,'2024-08-08','259 Main Road','Surat','India','2024-08-08 09:00:00.000000','komal259@email.in','Komal','Retail','Pandey','9802043769','EduSmart Institute',NULL,NULL,'Indiamart','Telangana','Negotiation','Sales Lead','B2B',NULL,264,NULL,NULL,NULL,NULL,NULL,1),(760,NULL,'2025-09-09','260 Main Road','Mumbai','India','2025-09-09 09:00:00.000000','ravi260@email.in','Ravi','Education','Kumar','9802051660','Reliance Industries',NULL,NULL,'Website','Tamil Nadu','Negotiation','Sales Lead','B2B',NULL,265,NULL,NULL,NULL,NULL,NULL,1),(761,NULL,'2023-10-10','261 Main Road','Delhi','India','2023-10-10 09:00:00.000000','shweta261@email.in','Shweta','Finance','Sharma','9802059551','Tata Consultancy',NULL,NULL,'Referral','West Bengal','Negotiation','Sales Lead','B2B',NULL,266,NULL,NULL,NULL,NULL,NULL,1),(762,NULL,'2024-11-11','262 Main Road','Pune','India','2024-11-11 09:00:00.000000','girish262@email.in','Girish','Real Estate','Patel','9802067442','Infosys Ltd',NULL,NULL,'Direct','Rajasthan','Negotiation','Sales Lead','B2B',NULL,267,NULL,NULL,NULL,NULL,NULL,1),(763,NULL,'2025-12-12','263 Main Road','Bangalore','India','2025-12-12 09:00:00.000000','pallavi263@email.in','Pallavi','Automotive','Singh','9802075333','Wipro Technologies',NULL,NULL,'Email','Gujarat','Negotiation','Sales Lead','B2B',NULL,268,NULL,NULL,NULL,NULL,NULL,1),(764,NULL,'2023-01-13','264 Main Road','Hyderabad','India','2023-01-13 09:00:00.000000','rajesh264@email.in','Rajesh','IT','Verma','9802083224','HCL Technologies',NULL,NULL,'Social Media','Maharashtra','Negotiation','Sales Lead','B2B',NULL,269,NULL,NULL,NULL,NULL,NULL,1),(765,NULL,'2024-02-14','265 Main Road','Chennai','India','2024-02-14 09:00:00.000000','priya265@email.in','Priya','Manufacturing','Joshi','9802091115','Mahindra Group',NULL,NULL,'Other','Delhi','Negotiation','Sales Lead','B2B',NULL,270,NULL,NULL,NULL,NULL,NULL,1),(766,NULL,'2025-03-15','266 Main Road','Kolkata','India','2025-03-15 09:00:00.000000','amit266@email.in','Amit','Healthcare','Mehta','9802099006','TechCorp Solutions',NULL,NULL,'Indiamart','Karnataka','Negotiation','Sales Lead','B2B',NULL,271,NULL,NULL,NULL,NULL,NULL,1),(767,NULL,'2023-04-16','267 Main Road','Jaipur','India','2023-04-16 09:00:00.000000','sneha267@email.in','Sneha','Retail','Desai','9802106897','Xform Technologies',NULL,NULL,'Website','Telangana','Negotiation','Sales Lead','B2B',NULL,272,NULL,NULL,NULL,NULL,NULL,1),(768,NULL,'2024-05-17','268 Main Road','Ahmedabad','India','2024-05-17 09:00:00.000000','vikas268@email.in','Vikas','Education','Gupta','9802114788','BuildRight Infra',NULL,NULL,'Referral','Tamil Nadu','Negotiation','Sales Lead','B2B',NULL,273,NULL,NULL,NULL,NULL,NULL,1),(769,NULL,'2025-06-18','269 Main Road','Surat','India','2025-06-18 09:00:00.000000','neha269@email.in','Neha','Finance','Nair','9802122679','MedPlus Healthcare',NULL,NULL,'Direct','West Bengal','Negotiation','Sales Lead','B2B',NULL,274,NULL,NULL,NULL,NULL,NULL,1),(770,NULL,'2023-07-19','270 Main Road','Mumbai','India','2023-07-19 09:00:00.000000','sanjay270@email.in','Sanjay','Real Estate','Reddy','9802130570','GreenField Agro',NULL,NULL,'Email','Rajasthan','Negotiation','Sales Lead','B2B',NULL,275,NULL,NULL,NULL,NULL,NULL,1),(771,NULL,'2024-08-20','271 Main Road','Delhi','India','2024-08-20 09:00:00.000000','kavita271@email.in','Kavita','Automotive','Shah','9802138461','FinanceFirst Pvt Ltd',NULL,NULL,'Social Media','Gujarat','Negotiation','Sales Lead','B2B',NULL,276,NULL,NULL,NULL,NULL,NULL,1),(772,NULL,'2025-09-21','272 Main Road','Pune','India','2025-09-21 09:00:00.000000','rahul272@email.in','Rahul','IT','Mishra','9802146352','AutoDrive Motors',NULL,NULL,'Other','Maharashtra','Negotiation','Sales Lead','B2B',NULL,277,NULL,NULL,NULL,NULL,NULL,1),(773,NULL,'2023-10-22','273 Main Road','Bangalore','India','2023-10-22 09:00:00.000000','anita273@email.in','Anita','Manufacturing','Tiwari','9802154243','EduSmart Institute',NULL,NULL,'Indiamart','Delhi','Negotiation','Sales Lead','B2B',NULL,278,NULL,NULL,NULL,NULL,NULL,1),(774,NULL,'2024-11-23','274 Main Road','Hyderabad','India','2024-11-23 09:00:00.000000','deepak274@email.in','Deepak','Healthcare','Agarwal','9802162134','Reliance Industries',NULL,NULL,'Website','Karnataka','Negotiation','Sales Lead','B2B',NULL,279,NULL,NULL,NULL,NULL,NULL,1),(775,NULL,'2025-12-24','275 Main Road','Chennai','India','2025-12-24 09:00:00.000000','sunita275@email.in','Sunita','Retail','Bose','9802170025','Tata Consultancy',NULL,NULL,'Referral','Telangana','Negotiation','Sales Lead','B2B',NULL,280,NULL,NULL,NULL,NULL,NULL,1),(776,NULL,'2023-01-25','276 Main Road','Kolkata','India','2023-01-25 09:00:00.000000','vikram276@email.in','Vikram','Education','Pillai','9802177916','Infosys Ltd',NULL,NULL,'Direct','Tamil Nadu','Negotiation','Sales Lead','B2B',NULL,281,NULL,NULL,NULL,NULL,NULL,1),(777,NULL,'2024-02-26','277 Main Road','Jaipur','India','2024-02-26 09:00:00.000000','pooja277@email.in','Pooja','Finance','Chauhan','9802185807','Wipro Technologies',NULL,NULL,'Email','West Bengal','Negotiation','Sales Lead','B2B',NULL,282,NULL,NULL,NULL,NULL,NULL,1),(778,NULL,'2025-03-27','278 Main Road','Ahmedabad','India','2025-03-27 09:00:00.000000','mahesh278@email.in','Mahesh','Real Estate','Rao','9802193698','HCL Technologies',NULL,NULL,'Social Media','Rajasthan','Negotiation','Sales Lead','B2B',NULL,283,NULL,NULL,NULL,NULL,NULL,1),(779,NULL,'2023-04-28','279 Main Road','Surat','India','2023-04-28 09:00:00.000000','rekha279@email.in','Rekha','Automotive','Pandey','9802201589','Mahindra Group',NULL,NULL,'Other','Gujarat','Negotiation','Sales Lead','B2B',NULL,284,NULL,NULL,NULL,NULL,NULL,1),(780,NULL,'2024-05-01','280 Main Road','Mumbai','India','2024-05-01 09:00:00.000000','suresh280@email.in','Suresh','IT','Kumar','9802209480','TechCorp Solutions',NULL,NULL,'Indiamart','Maharashtra','Negotiation','Sales Lead','B2B',NULL,285,NULL,NULL,NULL,NULL,NULL,1),(781,NULL,'2025-06-02','281 Main Road','Delhi','India','2025-06-02 09:00:00.000000','meena281@email.in','Meena','Manufacturing','Sharma','9802217371','Xform Technologies',NULL,NULL,'Website','Delhi','Negotiation','Sales Lead','B2B',NULL,286,NULL,NULL,NULL,NULL,NULL,1),(782,NULL,'2023-07-03','282 Main Road','Pune','India','2023-07-03 09:00:00.000000','anil282@email.in','Anil','Healthcare','Patel','9802225262','BuildRight Infra',NULL,NULL,'Referral','Karnataka','Negotiation','Sales Lead','B2B',NULL,287,NULL,NULL,NULL,NULL,NULL,1),(783,NULL,'2024-08-04','283 Main Road','Bangalore','India','2024-08-04 09:00:00.000000','komal283@email.in','Komal','Retail','Singh','9802233153','MedPlus Healthcare',NULL,NULL,'Direct','Telangana','Converted','Sales Lead','B2B',NULL,288,NULL,NULL,NULL,NULL,NULL,1),(784,NULL,'2025-09-05','284 Main Road','Hyderabad','India','2025-09-05 09:00:00.000000','ravi284@email.in','Ravi','Education','Verma','9802241044','GreenField Agro',NULL,NULL,'Email','Tamil Nadu','Converted','Sales Lead','B2B',NULL,289,NULL,NULL,NULL,NULL,NULL,1),(785,NULL,'2023-10-06','285 Main Road','Chennai','India','2023-10-06 09:00:00.000000','shweta285@email.in','Shweta','Finance','Joshi','9802248935','FinanceFirst Pvt Ltd',NULL,NULL,'Social Media','West Bengal','Converted','Sales Lead','B2B',NULL,290,NULL,NULL,NULL,NULL,NULL,1),(786,NULL,'2024-11-07','286 Main Road','Kolkata','India','2024-11-07 09:00:00.000000','girish286@email.in','Girish','Real Estate','Mehta','9802256826','AutoDrive Motors',NULL,NULL,'Other','Rajasthan','Converted','Sales Lead','B2B',NULL,291,NULL,NULL,NULL,NULL,NULL,1),(787,NULL,'2025-12-08','287 Main Road','Jaipur','India','2025-12-08 09:00:00.000000','pallavi287@email.in','Pallavi','Automotive','Desai','9802264717','EduSmart Institute',NULL,NULL,'Indiamart','Gujarat','Converted','Sales Lead','B2B',NULL,292,NULL,NULL,NULL,NULL,NULL,1),(788,NULL,'2023-01-09','288 Main Road','Ahmedabad','India','2023-01-09 09:00:00.000000','rajesh288@email.in','Rajesh','IT','Gupta','9802272608','Reliance Industries',NULL,NULL,'Website','Maharashtra','Converted','Sales Lead','B2B',NULL,293,NULL,NULL,NULL,NULL,NULL,1),(789,NULL,'2024-02-10','289 Main Road','Surat','India','2024-02-10 09:00:00.000000','priya289@email.in','Priya','Manufacturing','Nair','9802280499','Tata Consultancy',NULL,NULL,'Referral','Delhi','Converted','Sales Lead','B2B',NULL,294,NULL,NULL,NULL,NULL,NULL,1),(790,NULL,'2025-03-11','290 Main Road','Mumbai','India','2025-03-11 09:00:00.000000','amit290@email.in','Amit','Healthcare','Reddy','9802288390','Infosys Ltd',NULL,NULL,'Direct','Karnataka','Converted','Sales Lead','B2B',NULL,295,NULL,NULL,NULL,NULL,NULL,1),(791,NULL,'2023-04-12','291 Main Road','Delhi','India','2023-04-12 09:00:00.000000','sneha291@email.in','Sneha','Retail','Shah','9802296281','Wipro Technologies',NULL,NULL,'Email','Telangana','Converted','Sales Lead','B2B',NULL,296,NULL,NULL,NULL,NULL,NULL,1),(792,NULL,'2024-05-13','292 Main Road','Pune','India','2024-05-13 09:00:00.000000','vikas292@email.in','Vikas','Education','Mishra','9802304172','HCL Technologies',NULL,NULL,'Social Media','Tamil Nadu','Converted','Sales Lead','B2B',NULL,297,NULL,NULL,NULL,NULL,NULL,1),(793,NULL,'2025-06-14','293 Main Road','Bangalore','India','2025-06-14 09:00:00.000000','neha293@email.in','Neha','Finance','Tiwari','9802312063','Mahindra Group',NULL,NULL,'Other','West Bengal','Converted','Sales Lead','B2B',NULL,298,NULL,NULL,NULL,NULL,NULL,1),(794,NULL,'2023-07-15','294 Main Road','Hyderabad','India','2023-07-15 09:00:00.000000','sanjay294@email.in','Sanjay','Real Estate','Agarwal','9802319954','TechCorp Solutions',NULL,NULL,'Indiamart','Rajasthan','Converted','Sales Lead','B2B',NULL,299,NULL,NULL,NULL,NULL,NULL,1),(795,NULL,'2024-08-16','295 Main Road','Chennai','India','2024-08-16 09:00:00.000000','kavita295@email.in','Kavita','Automotive','Bose','9802327845','Xform Technologies',NULL,NULL,'Website','Gujarat','Converted','Sales Lead','B2B',NULL,300,NULL,NULL,NULL,NULL,NULL,1),(796,NULL,'2025-09-17','296 Main Road','Kolkata','India','2025-09-17 09:00:00.000000','rahul296@email.in','Rahul','IT','Pillai','9802335736','BuildRight Infra',NULL,NULL,'Referral','Maharashtra','Converted','Sales Lead','B2B',NULL,301,NULL,NULL,NULL,NULL,NULL,1),(797,NULL,'2023-10-18','297 Main Road','Jaipur','India','2023-10-18 09:00:00.000000','anita297@email.in','Anita','Manufacturing','Chauhan','9802343627','MedPlus Healthcare',NULL,NULL,'Direct','Delhi','Converted','Sales Lead','B2B',NULL,302,NULL,NULL,NULL,NULL,NULL,1),(798,NULL,'2024-11-19','298 Main Road','Ahmedabad','India','2024-11-19 09:00:00.000000','deepak298@email.in','Deepak','Healthcare','Rao','9802351518','GreenField Agro',NULL,NULL,'Email','Karnataka','Converted','Sales Lead','B2B',NULL,303,NULL,NULL,NULL,NULL,NULL,1),(799,NULL,'2025-12-20','299 Main Road','Surat','India','2025-12-20 09:00:00.000000','sunita299@email.in','Sunita','Retail','Pandey','9802359409','FinanceFirst Pvt Ltd',NULL,NULL,'Social Media','Telangana','Converted','Sales Lead','B2B',NULL,304,NULL,NULL,NULL,NULL,NULL,1),(800,NULL,'2023-01-21','300 Main Road','Mumbai','India','2023-01-21 09:00:00.000000','vikram300@email.in','Vikram','Education','Kumar','9802367300','AutoDrive Motors',NULL,NULL,'Other','Tamil Nadu','Converted','Sales Lead','B2B',NULL,305,NULL,NULL,NULL,NULL,NULL,1),(801,NULL,'2024-02-22','301 Main Road','Delhi','India','2024-02-22 09:00:00.000000','pooja301@email.in','Pooja','Finance','Sharma','9802375191','EduSmart Institute',NULL,NULL,'Indiamart','West Bengal','Converted','Sales Lead','B2B',NULL,306,NULL,NULL,NULL,NULL,NULL,1),(802,NULL,'2025-03-23','302 Main Road','Pune','India','2025-03-23 09:00:00.000000','mahesh302@email.in','Mahesh','Real Estate','Patel','9802383082','Reliance Industries',NULL,NULL,'Website','Rajasthan','Converted','Sales Lead','B2B',NULL,307,NULL,NULL,NULL,NULL,NULL,1),(803,NULL,'2023-04-24','303 Main Road','Bangalore','India','2023-04-24 09:00:00.000000','rekha303@email.in','Rekha','Automotive','Singh','9802390973','Tata Consultancy',NULL,NULL,'Referral','Gujarat','Converted','Sales Lead','B2B',NULL,308,NULL,NULL,NULL,NULL,NULL,1),(804,NULL,'2024-05-25','304 Main Road','Hyderabad','India','2024-05-25 09:00:00.000000','suresh304@email.in','Suresh','IT','Verma','9802398864','Infosys Ltd',NULL,NULL,'Direct','Maharashtra','Converted','Sales Lead','B2B',NULL,309,NULL,NULL,NULL,NULL,NULL,1),(805,NULL,'2025-06-26','305 Main Road','Chennai','India','2025-06-26 09:00:00.000000','meena305@email.in','Meena','Manufacturing','Joshi','9802406755','Wipro Technologies',NULL,NULL,'Email','Delhi','Converted','Sales Lead','B2B',NULL,310,NULL,NULL,NULL,NULL,NULL,1),(806,NULL,'2023-07-27','306 Main Road','Kolkata','India','2023-07-27 09:00:00.000000','anil306@email.in','Anil','Healthcare','Mehta','9802414646','HCL Technologies',NULL,NULL,'Social Media','Karnataka','Converted','Sales Lead','B2B',NULL,311,NULL,NULL,NULL,NULL,NULL,1),(807,NULL,'2024-08-28','307 Main Road','Jaipur','India','2024-08-28 09:00:00.000000','komal307@email.in','Komal','Retail','Desai','9802422537','Mahindra Group',NULL,NULL,'Other','Telangana','Converted','Sales Lead','B2B',NULL,312,NULL,NULL,NULL,NULL,NULL,1),(808,NULL,'2025-09-01','308 Main Road','Ahmedabad','India','2025-09-01 09:00:00.000000','ravi308@email.in','Ravi','Education','Gupta','9802430428','TechCorp Solutions',NULL,NULL,'Indiamart','Tamil Nadu','Converted','Sales Lead','B2B',NULL,313,NULL,NULL,NULL,NULL,NULL,1),(809,NULL,'2023-10-02','309 Main Road','Surat','India','2023-10-02 09:00:00.000000','shweta309@email.in','Shweta','Finance','Nair','9802438319','Xform Technologies',NULL,NULL,'Website','West Bengal','Converted','Sales Lead','B2B',NULL,314,NULL,NULL,NULL,NULL,NULL,1),(810,NULL,'2024-11-03','310 Main Road','Mumbai','India','2024-11-03 09:00:00.000000','girish310@email.in','Girish','Real Estate','Reddy','9802446210','BuildRight Infra',NULL,NULL,'Referral','Rajasthan','Converted','Sales Lead','B2B',NULL,315,NULL,NULL,NULL,NULL,NULL,1),(811,NULL,'2025-12-04','311 Main Road','Delhi','India','2025-12-04 09:00:00.000000','pallavi311@email.in','Pallavi','Automotive','Shah','9802454101','MedPlus Healthcare',NULL,NULL,'Direct','Gujarat','Converted','Sales Lead','B2B',NULL,316,NULL,NULL,NULL,NULL,NULL,1),(812,NULL,'2023-01-05','312 Main Road','Pune','India','2023-01-05 09:00:00.000000','rajesh312@email.in','Rajesh','IT','Mishra','9802461992','GreenField Agro',NULL,NULL,'Email','Maharashtra','Converted','Sales Lead','B2B',NULL,317,NULL,NULL,NULL,NULL,NULL,1),(813,NULL,'2024-02-06','313 Main Road','Bangalore','India','2024-02-06 09:00:00.000000','priya313@email.in','Priya','Manufacturing','Tiwari','9802469883','FinanceFirst Pvt Ltd',NULL,NULL,'Social Media','Delhi','Converted','Sales Lead','B2B',NULL,318,NULL,NULL,NULL,NULL,NULL,1),(814,NULL,'2025-03-07','314 Main Road','Hyderabad','India','2025-03-07 09:00:00.000000','amit314@email.in','Amit','Healthcare','Agarwal','9802477774','AutoDrive Motors',NULL,NULL,'Other','Karnataka','Converted','Sales Lead','B2B',NULL,319,NULL,NULL,NULL,NULL,NULL,1),(815,NULL,'2023-04-08','315 Main Road','Chennai','India','2023-04-08 09:00:00.000000','sneha315@email.in','Sneha','Retail','Bose','9802485665','EduSmart Institute',NULL,NULL,'Indiamart','Telangana','Converted','Sales Lead','B2B',NULL,320,NULL,NULL,NULL,NULL,NULL,1),(816,NULL,'2024-05-09','316 Main Road','Kolkata','India','2024-05-09 09:00:00.000000','vikas316@email.in','Vikas','Education','Pillai','9802493556','Reliance Industries',NULL,NULL,'Website','Tamil Nadu','Converted','Sales Lead','B2B',NULL,321,NULL,NULL,NULL,NULL,NULL,1),(817,NULL,'2025-06-10','317 Main Road','Jaipur','India','2025-06-10 09:00:00.000000','neha317@email.in','Neha','Finance','Chauhan','9802501447','Tata Consultancy',NULL,NULL,'Referral','West Bengal','Converted','Sales Lead','B2B',NULL,322,NULL,NULL,NULL,NULL,NULL,1),(818,NULL,'2023-07-11','318 Main Road','Ahmedabad','India','2023-07-11 09:00:00.000000','sanjay318@email.in','Sanjay','Real Estate','Rao','9802509338','Infosys Ltd',NULL,NULL,'Direct','Rajasthan','Converted','Sales Lead','B2B',NULL,323,NULL,NULL,NULL,NULL,NULL,1),(819,NULL,'2024-08-12','319 Main Road','Surat','India','2024-08-12 09:00:00.000000','kavita319@email.in','Kavita','Automotive','Pandey','9802517229','Wipro Technologies',NULL,NULL,'Email','Gujarat','Converted','Sales Lead','B2B',NULL,324,NULL,NULL,NULL,NULL,NULL,1),(820,NULL,'2025-09-13','320 Main Road','Mumbai','India','2025-09-13 09:00:00.000000','rahul320@email.in','Rahul','IT','Kumar','9802525120','HCL Technologies',NULL,NULL,'Social Media','Maharashtra','Converted','Sales Lead','B2B',NULL,325,NULL,NULL,NULL,NULL,NULL,1),(821,NULL,'2023-10-14','321 Main Road','Delhi','India','2023-10-14 09:00:00.000000','anita321@email.in','Anita','Manufacturing','Sharma','9802533011','Mahindra Group',NULL,NULL,'Other','Delhi','Converted','Sales Lead','B2B',NULL,326,NULL,NULL,NULL,NULL,NULL,1),(822,NULL,'2024-11-15','322 Main Road','Pune','India','2024-11-15 09:00:00.000000','deepak322@email.in','Deepak','Healthcare','Patel','9802540902','TechCorp Solutions',NULL,NULL,'Indiamart','Karnataka','Converted','Sales Lead','B2B',NULL,327,NULL,NULL,NULL,NULL,NULL,1),(823,NULL,'2025-12-16','323 Main Road','Bangalore','India','2025-12-16 09:00:00.000000','sunita323@email.in','Sunita','Retail','Singh','9802548793','Xform Technologies',NULL,NULL,'Website','Telangana','Converted','Sales Lead','B2B',NULL,328,NULL,NULL,NULL,NULL,NULL,1),(824,NULL,'2023-01-17','324 Main Road','Hyderabad','India','2023-01-17 09:00:00.000000','vikram324@email.in','Vikram','Education','Verma','9802556684','BuildRight Infra',NULL,NULL,'Referral','Tamil Nadu','Converted','Sales Lead','B2B',NULL,329,NULL,NULL,NULL,NULL,NULL,1),(825,NULL,'2024-02-18','325 Main Road','Chennai','India','2024-02-18 09:00:00.000000','pooja325@email.in','Pooja','Finance','Joshi','9802564575','MedPlus Healthcare',NULL,NULL,'Direct','West Bengal','Converted','Sales Lead','B2B',NULL,330,NULL,NULL,NULL,NULL,NULL,1),(826,NULL,'2025-03-19','326 Main Road','Kolkata','India','2025-03-19 09:00:00.000000','mahesh326@email.in','Mahesh','Real Estate','Mehta','9802572466','GreenField Agro',NULL,NULL,'Email','Rajasthan','Converted','Sales Lead','B2B',NULL,331,NULL,NULL,NULL,NULL,NULL,1),(827,NULL,'2023-04-20','327 Main Road','Jaipur','India','2023-04-20 09:00:00.000000','rekha327@email.in','Rekha','Automotive','Desai','9802580357','FinanceFirst Pvt Ltd',NULL,NULL,'Social Media','Gujarat','Converted','Sales Lead','B2B',NULL,332,NULL,NULL,NULL,NULL,NULL,1),(828,NULL,'2024-05-21','328 Main Road','Ahmedabad','India','2024-05-21 09:00:00.000000','suresh328@email.in','Suresh','IT','Gupta','9802588248','AutoDrive Motors',NULL,NULL,'Other','Maharashtra','Won','Sales Lead','B2B',NULL,333,NULL,NULL,NULL,NULL,NULL,1),(829,NULL,'2025-06-22','329 Main Road','Surat','India','2025-06-22 09:00:00.000000','meena329@email.in','Meena','Manufacturing','Nair','9802596139','EduSmart Institute',NULL,NULL,'Indiamart','Delhi','Won','Sales Lead','B2B',NULL,334,NULL,NULL,NULL,NULL,NULL,1),(830,NULL,'2023-07-23','330 Main Road','Mumbai','India','2023-07-23 09:00:00.000000','anil330@email.in','Anil','Healthcare','Reddy','9802604030','Reliance Industries',NULL,NULL,'Website','Karnataka','Won','Sales Lead','B2B',NULL,335,NULL,NULL,NULL,NULL,NULL,1),(831,NULL,'2024-08-24','331 Main Road','Delhi','India','2024-08-24 09:00:00.000000','komal331@email.in','Komal','Retail','Shah','9802611921','Tata Consultancy',NULL,NULL,'Referral','Telangana','Won','Sales Lead','B2B',NULL,336,NULL,NULL,NULL,NULL,NULL,1),(832,NULL,'2025-09-25','332 Main Road','Pune','India','2025-09-25 09:00:00.000000','ravi332@email.in','Ravi','Education','Mishra','9802619812','Infosys Ltd',NULL,NULL,'Direct','Tamil Nadu','Won','Sales Lead','B2B',NULL,337,NULL,NULL,NULL,NULL,NULL,1),(833,NULL,'2023-10-26','333 Main Road','Bangalore','India','2023-10-26 09:00:00.000000','shweta333@email.in','Shweta','Finance','Tiwari','9802627703','Wipro Technologies',NULL,NULL,'Email','West Bengal','Won','Sales Lead','B2B',NULL,338,NULL,NULL,NULL,NULL,NULL,1),(834,NULL,'2024-11-27','334 Main Road','Hyderabad','India','2024-11-27 09:00:00.000000','girish334@email.in','Girish','Real Estate','Agarwal','9802635594','HCL Technologies',NULL,NULL,'Social Media','Rajasthan','Won','Sales Lead','B2B',NULL,339,NULL,NULL,NULL,NULL,NULL,1),(835,NULL,'2025-12-28','335 Main Road','Chennai','India','2025-12-28 09:00:00.000000','pallavi335@email.in','Pallavi','Automotive','Bose','9802643485','Mahindra Group',NULL,NULL,'Other','Gujarat','Won','Sales Lead','B2B',NULL,340,NULL,NULL,NULL,NULL,NULL,1),(836,NULL,'2023-01-01','336 Main Road','Kolkata','India','2023-01-01 09:00:00.000000','rajesh336@email.in','Rajesh','IT','Pillai','9802651376','TechCorp Solutions',NULL,NULL,'Indiamart','Maharashtra','Won','Sales Lead','B2B',NULL,341,NULL,NULL,NULL,NULL,NULL,1),(837,NULL,'2024-02-02','337 Main Road','Jaipur','India','2024-02-02 09:00:00.000000','priya337@email.in','Priya','Manufacturing','Chauhan','9802659267','Xform Technologies',NULL,NULL,'Website','Delhi','Won','Sales Lead','B2B',NULL,342,NULL,NULL,NULL,NULL,NULL,1),(838,NULL,'2025-03-03','338 Main Road','Ahmedabad','India','2025-03-03 09:00:00.000000','amit338@email.in','Amit','Healthcare','Rao','9802667158','BuildRight Infra',NULL,NULL,'Referral','Karnataka','Won','Sales Lead','B2B',NULL,343,NULL,NULL,NULL,NULL,NULL,1),(839,NULL,'2023-04-04','339 Main Road','Surat','India','2023-04-04 09:00:00.000000','sneha339@email.in','Sneha','Retail','Pandey','9802675049','MedPlus Healthcare',NULL,NULL,'Direct','Telangana','Won','Sales Lead','B2B',NULL,344,NULL,NULL,NULL,NULL,NULL,1),(840,NULL,'2024-05-05','340 Main Road','Mumbai','India','2024-05-05 09:00:00.000000','vikas340@email.in','Vikas','Education','Kumar','9802682940','GreenField Agro',NULL,NULL,'Email','Tamil Nadu','Won','Sales Lead','B2B',NULL,345,NULL,NULL,NULL,NULL,NULL,1),(841,NULL,'2025-06-06','341 Main Road','Delhi','India','2025-06-06 09:00:00.000000','neha341@email.in','Neha','Finance','Sharma','9802690831','FinanceFirst Pvt Ltd',NULL,NULL,'Social Media','West Bengal','Won','Sales Lead','B2B',NULL,346,NULL,NULL,NULL,NULL,NULL,1),(842,NULL,'2023-07-07','342 Main Road','Pune','India','2023-07-07 09:00:00.000000','sanjay342@email.in','Sanjay','Real Estate','Patel','9802698722','AutoDrive Motors',NULL,NULL,'Other','Rajasthan','Won','Sales Lead','B2B',NULL,347,NULL,NULL,NULL,NULL,NULL,1),(843,NULL,'2024-08-08','343 Main Road','Bangalore','India','2024-08-08 09:00:00.000000','kavita343@email.in','Kavita','Automotive','Singh','9802706613','EduSmart Institute',NULL,NULL,'Indiamart','Gujarat','Won','Sales Lead','B2B',NULL,348,NULL,NULL,NULL,NULL,NULL,1),(844,NULL,'2025-09-09','344 Main Road','Hyderabad','India','2025-09-09 09:00:00.000000','rahul344@email.in','Rahul','IT','Verma','9802714504','Reliance Industries',NULL,NULL,'Website','Maharashtra','Won','Sales Lead','B2B',NULL,349,NULL,NULL,NULL,NULL,NULL,1),(845,NULL,'2023-10-10','345 Main Road','Chennai','India','2023-10-10 09:00:00.000000','anita345@email.in','Anita','Manufacturing','Joshi','9802722395','Tata Consultancy',NULL,NULL,'Referral','Delhi','Won','Sales Lead','B2B',NULL,350,NULL,NULL,NULL,NULL,NULL,1),(846,NULL,'2024-11-11','346 Main Road','Kolkata','India','2024-11-11 09:00:00.000000','deepak346@email.in','Deepak','Healthcare','Mehta','9802730286','Infosys Ltd',NULL,NULL,'Direct','Karnataka','Won','Sales Lead','B2B',NULL,351,NULL,NULL,NULL,NULL,NULL,1),(847,NULL,'2025-12-12','347 Main Road','Jaipur','India','2025-12-12 09:00:00.000000','sunita347@email.in','Sunita','Retail','Desai','9802738177','Wipro Technologies',NULL,NULL,'Email','Telangana','Won','Sales Lead','B2B',NULL,352,NULL,NULL,NULL,NULL,NULL,1),(848,NULL,'2023-01-13','348 Main Road','Ahmedabad','India','2023-01-13 09:00:00.000000','vikram348@email.in','Vikram','Education','Gupta','9802746068','HCL Technologies',NULL,NULL,'Social Media','Tamil Nadu','Won','Sales Lead','B2B',NULL,353,NULL,NULL,NULL,NULL,NULL,1),(849,NULL,'2024-02-14','349 Main Road','Surat','India','2024-02-14 09:00:00.000000','pooja349@email.in','Pooja','Finance','Nair','9802753959','Mahindra Group',NULL,NULL,'Other','West Bengal','Won','Sales Lead','B2B',NULL,354,NULL,NULL,NULL,NULL,NULL,1),(850,NULL,'2025-03-15','350 Main Road','Mumbai','India','2025-03-15 09:00:00.000000','mahesh350@email.in','Mahesh','Real Estate','Reddy','9802761850','TechCorp Solutions',NULL,NULL,'Indiamart','Rajasthan','Won','Sales Lead','B2B',NULL,355,NULL,NULL,NULL,NULL,NULL,1),(851,NULL,'2023-04-16','351 Main Road','Delhi','India','2023-04-16 09:00:00.000000','rekha351@email.in','Rekha','Automotive','Shah','9802769741','Xform Technologies',NULL,NULL,'Website','Gujarat','Won','Sales Lead','B2B',NULL,356,NULL,NULL,NULL,NULL,NULL,1),(852,NULL,'2024-05-17','352 Main Road','Pune','India','2024-05-17 09:00:00.000000','suresh352@email.in','Suresh','IT','Mishra','9802777632','BuildRight Infra',NULL,NULL,'Referral','Maharashtra','Won','Sales Lead','B2B',NULL,357,NULL,NULL,NULL,NULL,NULL,1),(853,NULL,'2025-06-18','353 Main Road','Bangalore','India','2025-06-18 09:00:00.000000','meena353@email.in','Meena','Manufacturing','Tiwari','9802785523','MedPlus Healthcare',NULL,NULL,'Direct','Delhi','Won','Sales Lead','B2B',NULL,358,NULL,NULL,NULL,NULL,NULL,1),(854,NULL,'2023-07-19','354 Main Road','Hyderabad','India','2023-07-19 09:00:00.000000','anil354@email.in','Anil','Healthcare','Agarwal','9802793414','GreenField Agro',NULL,NULL,'Email','Karnataka','Won','Sales Lead','B2B',NULL,359,NULL,NULL,NULL,NULL,NULL,1),(855,NULL,'2024-08-20','355 Main Road','Chennai','India','2024-08-20 09:00:00.000000','komal355@email.in','Komal','Retail','Bose','9802801305','FinanceFirst Pvt Ltd',NULL,NULL,'Social Media','Telangana','Won','Sales Lead','B2B',NULL,360,NULL,NULL,NULL,NULL,NULL,1),(856,NULL,'2025-09-21','356 Main Road','Kolkata','India','2025-09-21 09:00:00.000000','ravi356@email.in','Ravi','Education','Pillai','9802809196','AutoDrive Motors',NULL,NULL,'Other','Tamil Nadu','Won','Sales Lead','B2B',NULL,361,NULL,NULL,NULL,NULL,NULL,1),(857,NULL,'2023-10-22','357 Main Road','Jaipur','India','2023-10-22 09:00:00.000000','shweta357@email.in','Shweta','Finance','Chauhan','9802817087','EduSmart Institute',NULL,NULL,'Indiamart','West Bengal','Won','Sales Lead','B2B',NULL,362,NULL,NULL,NULL,NULL,NULL,1),(858,NULL,'2024-11-23','358 Main Road','Ahmedabad','India','2024-11-23 09:00:00.000000','girish358@email.in','Girish','Real Estate','Rao','9802824978','Reliance Industries',NULL,NULL,'Website','Rajasthan','Won','Sales Lead','B2B',NULL,363,NULL,NULL,NULL,NULL,NULL,1),(859,NULL,'2025-12-24','359 Main Road','Surat','India','2025-12-24 09:00:00.000000','pallavi359@email.in','Pallavi','Automotive','Pandey','9802832869','Tata Consultancy',NULL,NULL,'Referral','Gujarat','Won','Sales Lead','B2B',NULL,364,NULL,NULL,NULL,NULL,NULL,1),(860,NULL,'2023-01-25','360 Main Road','Mumbai','India','2023-01-25 09:00:00.000000','rajesh360@email.in','Rajesh','IT','Kumar','9802840760','Infosys Ltd',NULL,NULL,'Direct','Maharashtra','Won','Sales Lead','B2B',NULL,365,NULL,NULL,NULL,NULL,NULL,1),(861,NULL,'2024-02-26','361 Main Road','Delhi','India','2024-02-26 09:00:00.000000','priya361@email.in','Priya','Manufacturing','Sharma','9802848651','Wipro Technologies',NULL,NULL,'Email','Delhi','Won','Sales Lead','B2B',NULL,366,NULL,NULL,NULL,NULL,NULL,1),(862,NULL,'2025-03-27','362 Main Road','Pune','India','2025-03-27 09:00:00.000000','amit362@email.in','Amit','Healthcare','Patel','9802856542','HCL Technologies',NULL,NULL,'Social Media','Karnataka','Won','Sales Lead','B2B',NULL,367,NULL,NULL,NULL,NULL,NULL,1),(863,NULL,'2023-04-28','363 Main Road','Bangalore','India','2023-04-28 09:00:00.000000','sneha363@email.in','Sneha','Retail','Singh','9802864433','Mahindra Group',NULL,NULL,'Other','Telangana','Won','Sales Lead','B2B',NULL,368,NULL,NULL,NULL,NULL,NULL,1),(864,NULL,'2024-05-01','364 Main Road','Hyderabad','India','2024-05-01 09:00:00.000000','vikas364@email.in','Vikas','Education','Verma','9802872324','TechCorp Solutions',NULL,NULL,'Indiamart','Tamil Nadu','Won','Sales Lead','B2B',NULL,369,NULL,NULL,NULL,NULL,NULL,1),(865,NULL,'2025-06-02','365 Main Road','Chennai','India','2025-06-02 09:00:00.000000','neha365@email.in','Neha','Finance','Joshi','9802880215','Xform Technologies',NULL,NULL,'Website','West Bengal','Won','Sales Lead','B2B',NULL,370,NULL,NULL,NULL,NULL,NULL,1),(866,NULL,'2023-07-03','366 Main Road','Kolkata','India','2023-07-03 09:00:00.000000','sanjay366@email.in','Sanjay','Real Estate','Mehta','9802888106','BuildRight Infra',NULL,NULL,'Referral','Rajasthan','Won','Sales Lead','B2B',NULL,371,NULL,NULL,NULL,NULL,NULL,1),(867,NULL,'2024-08-04','367 Main Road','Jaipur','India','2024-08-04 09:00:00.000000','kavita367@email.in','Kavita','Automotive','Desai','9802895997','MedPlus Healthcare',NULL,NULL,'Direct','Gujarat','Won','Sales Lead','B2B',NULL,372,NULL,NULL,NULL,NULL,NULL,1),(868,NULL,'2025-09-05','368 Main Road','Ahmedabad','India','2025-09-05 09:00:00.000000','rahul368@email.in','Rahul','IT','Gupta','9802903888','GreenField Agro',NULL,NULL,'Email','Maharashtra','Won','Sales Lead','B2B',NULL,373,NULL,NULL,NULL,NULL,NULL,1),(869,NULL,'2023-10-06','369 Main Road','Surat','India','2023-10-06 09:00:00.000000','anita369@email.in','Anita','Manufacturing','Nair','9802911779','FinanceFirst Pvt Ltd',NULL,NULL,'Social Media','Delhi','Won','Sales Lead','B2B',NULL,374,NULL,NULL,NULL,NULL,NULL,1),(870,NULL,'2024-11-07','370 Main Road','Mumbai','India','2024-11-07 09:00:00.000000','deepak370@email.in','Deepak','Healthcare','Reddy','9802919670','AutoDrive Motors',NULL,NULL,'Other','Karnataka','Won','Sales Lead','B2B',NULL,375,NULL,NULL,NULL,NULL,NULL,1),(871,NULL,'2025-12-08','371 Main Road','Delhi','India','2025-12-08 09:00:00.000000','sunita371@email.in','Sunita','Retail','Shah','9802927561','EduSmart Institute',NULL,NULL,'Indiamart','Telangana','Won','Sales Lead','B2B',NULL,376,NULL,NULL,NULL,NULL,NULL,1),(872,NULL,'2023-01-09','372 Main Road','Pune','India','2023-01-09 09:00:00.000000','vikram372@email.in','Vikram','Education','Mishra','9802935452','Reliance Industries',NULL,NULL,'Website','Tamil Nadu','Won','Sales Lead','B2B',NULL,377,NULL,NULL,NULL,NULL,NULL,1),(873,NULL,'2024-02-10','373 Main Road','Bangalore','India','2024-02-10 09:00:00.000000','pooja373@email.in','Pooja','Finance','Tiwari','9802943343','Tata Consultancy',NULL,NULL,'Referral','West Bengal','Lost','Sales Lead','B2B',NULL,378,NULL,NULL,NULL,NULL,NULL,1),(874,NULL,'2025-03-11','374 Main Road','Hyderabad','India','2025-03-11 09:00:00.000000','mahesh374@email.in','Mahesh','Real Estate','Agarwal','9802951234','Infosys Ltd',NULL,NULL,'Direct','Rajasthan','Lost','Sales Lead','B2B',NULL,379,NULL,NULL,NULL,NULL,NULL,1),(875,NULL,'2023-04-12','375 Main Road','Chennai','India','2023-04-12 09:00:00.000000','rekha375@email.in','Rekha','Automotive','Bose','9802959125','Wipro Technologies',NULL,NULL,'Email','Gujarat','Lost','Sales Lead','B2B',NULL,380,NULL,NULL,NULL,NULL,NULL,1),(876,NULL,'2024-05-13','376 Main Road','Kolkata','India','2024-05-13 09:00:00.000000','suresh376@email.in','Suresh','IT','Pillai','9802967016','HCL Technologies',NULL,NULL,'Social Media','Maharashtra','Lost','Sales Lead','B2B',NULL,381,NULL,NULL,NULL,NULL,NULL,1),(877,NULL,'2025-06-14','377 Main Road','Jaipur','India','2025-06-14 09:00:00.000000','meena377@email.in','Meena','Manufacturing','Chauhan','9802974907','Mahindra Group',NULL,NULL,'Other','Delhi','Lost','Sales Lead','B2B',NULL,382,NULL,NULL,NULL,NULL,NULL,1),(878,NULL,'2023-07-15','378 Main Road','Ahmedabad','India','2023-07-15 09:00:00.000000','anil378@email.in','Anil','Healthcare','Rao','9802982798','TechCorp Solutions',NULL,NULL,'Indiamart','Karnataka','Lost','Sales Lead','B2B',NULL,383,NULL,NULL,NULL,NULL,NULL,1),(879,NULL,'2024-08-16','379 Main Road','Surat','India','2024-08-16 09:00:00.000000','komal379@email.in','Komal','Retail','Pandey','9802990689','Xform Technologies',NULL,NULL,'Website','Telangana','Lost','Sales Lead','B2B',NULL,384,NULL,NULL,NULL,NULL,NULL,1),(880,NULL,'2025-09-17','380 Main Road','Mumbai','India','2025-09-17 09:00:00.000000','ravi380@email.in','Ravi','Education','Kumar','9802998580','BuildRight Infra',NULL,NULL,'Referral','Tamil Nadu','Lost','Sales Lead','B2B',NULL,385,NULL,NULL,NULL,NULL,NULL,1),(881,NULL,'2023-10-18','381 Main Road','Delhi','India','2023-10-18 09:00:00.000000','shweta381@email.in','Shweta','Finance','Sharma','9803006471','MedPlus Healthcare',NULL,NULL,'Direct','West Bengal','Lost','Sales Lead','B2B',NULL,386,NULL,NULL,NULL,NULL,NULL,1),(882,NULL,'2024-11-19','382 Main Road','Pune','India','2024-11-19 09:00:00.000000','girish382@email.in','Girish','Real Estate','Patel','9803014362','GreenField Agro',NULL,NULL,'Email','Rajasthan','Lost','Sales Lead','B2B',NULL,387,NULL,NULL,NULL,NULL,NULL,1),(883,NULL,'2025-12-20','383 Main Road','Bangalore','India','2025-12-20 09:00:00.000000','pallavi383@email.in','Pallavi','Automotive','Singh','9803022253','FinanceFirst Pvt Ltd',NULL,NULL,'Social Media','Gujarat','Lost','Sales Lead','B2B',NULL,388,NULL,NULL,NULL,NULL,NULL,1),(884,NULL,'2023-01-21','384 Main Road','Hyderabad','India','2023-01-21 09:00:00.000000','rajesh384@email.in','Rajesh','IT','Verma','9803030144','AutoDrive Motors',NULL,NULL,'Other','Maharashtra','Lost','Sales Lead','B2B',NULL,389,NULL,NULL,NULL,NULL,NULL,1),(885,NULL,'2024-02-22','385 Main Road','Chennai','India','2024-02-22 09:00:00.000000','priya385@email.in','Priya','Manufacturing','Joshi','9803038035','EduSmart Institute',NULL,NULL,'Indiamart','Delhi','Lost','Sales Lead','B2B',NULL,390,NULL,NULL,NULL,NULL,NULL,1),(886,NULL,'2025-03-23','386 Main Road','Kolkata','India','2025-03-23 09:00:00.000000','amit386@email.in','Amit','Healthcare','Mehta','9803045926','Reliance Industries',NULL,NULL,'Website','Karnataka','Lost','Sales Lead','B2B',NULL,391,NULL,NULL,NULL,NULL,NULL,1),(887,NULL,'2023-04-24','387 Main Road','Jaipur','India','2023-04-24 09:00:00.000000','sneha387@email.in','Sneha','Retail','Desai','9803053817','Tata Consultancy',NULL,NULL,'Referral','Telangana','Lost','Sales Lead','B2B',NULL,392,NULL,NULL,NULL,NULL,NULL,1),(888,NULL,'2024-05-25','388 Main Road','Ahmedabad','India','2024-05-25 09:00:00.000000','vikas388@email.in','Vikas','Education','Gupta','9803061708','Infosys Ltd',NULL,NULL,'Direct','Tamil Nadu','Lost','Sales Lead','B2B',NULL,393,NULL,NULL,NULL,NULL,NULL,1),(889,NULL,'2025-06-26','389 Main Road','Surat','India','2025-06-26 09:00:00.000000','neha389@email.in','Neha','Finance','Nair','9803069599','Wipro Technologies',NULL,NULL,'Email','West Bengal','Lost','Sales Lead','B2B',NULL,394,NULL,NULL,NULL,NULL,NULL,1),(890,NULL,'2023-07-27','390 Main Road','Mumbai','India','2023-07-27 09:00:00.000000','sanjay390@email.in','Sanjay','Real Estate','Reddy','9803077490','HCL Technologies',NULL,NULL,'Social Media','Rajasthan','Lost','Sales Lead','B2B',NULL,395,NULL,NULL,NULL,NULL,NULL,1),(891,NULL,'2024-08-28','391 Main Road','Delhi','India','2024-08-28 09:00:00.000000','kavita391@email.in','Kavita','Automotive','Shah','9803085381','Mahindra Group',NULL,NULL,'Other','Gujarat','Lost','Sales Lead','B2B',NULL,396,NULL,NULL,NULL,NULL,NULL,1),(892,NULL,'2025-09-01','392 Main Road','Pune','India','2025-09-01 09:00:00.000000','rahul392@email.in','Rahul','IT','Mishra','9803093272','TechCorp Solutions',NULL,NULL,'Indiamart','Maharashtra','Lost','Sales Lead','B2B',NULL,397,NULL,NULL,NULL,NULL,NULL,1),(893,NULL,'2023-10-02','393 Main Road','Bangalore','India','2023-10-02 09:00:00.000000','anita393@email.in','Anita','Manufacturing','Tiwari','9803101163','Xform Technologies',NULL,NULL,'Website','Delhi','Lost','Sales Lead','B2B',NULL,398,NULL,NULL,NULL,NULL,NULL,1),(894,NULL,'2024-11-03','394 Main Road','Hyderabad','India','2024-11-03 09:00:00.000000','deepak394@email.in','Deepak','Healthcare','Agarwal','9803109054','BuildRight Infra',NULL,NULL,'Referral','Karnataka','Lost','Sales Lead','B2B',NULL,399,NULL,NULL,NULL,NULL,NULL,1),(895,NULL,'2025-12-04','395 Main Road','Chennai','India','2025-12-04 09:00:00.000000','sunita395@email.in','Sunita','Retail','Bose','9803116945','MedPlus Healthcare',NULL,NULL,'Direct','Telangana','Lost','Sales Lead','B2B',NULL,400,NULL,NULL,NULL,NULL,NULL,1),(896,NULL,'2023-01-05','396 Main Road','Kolkata','India','2023-01-05 09:00:00.000000','vikram396@email.in','Vikram','Education','Pillai','9803124836','GreenField Agro',NULL,NULL,'Email','Tamil Nadu','Lost','Sales Lead','B2B',NULL,401,NULL,NULL,NULL,NULL,NULL,1),(897,NULL,'2024-02-06','397 Main Road','Jaipur','India','2024-02-06 09:00:00.000000','pooja397@email.in','Pooja','Finance','Chauhan','9803132727','FinanceFirst Pvt Ltd',NULL,NULL,'Social Media','West Bengal','Lost','Sales Lead','B2B',NULL,402,NULL,NULL,NULL,NULL,NULL,1),(898,NULL,'2025-03-07','398 Main Road','Ahmedabad','India','2025-03-07 09:00:00.000000','mahesh398@email.in','Mahesh','Real Estate','Rao','9803140618','AutoDrive Motors',NULL,NULL,'Other','Rajasthan','Lost','Sales Lead','B2B',NULL,403,NULL,NULL,NULL,NULL,NULL,1),(899,NULL,'2023-04-08','399 Main Road','Surat','India','2023-04-08 09:00:00.000000','rekha399@email.in','Rekha','Automotive','Pandey','9803148509','EduSmart Institute',NULL,NULL,'Indiamart','Gujarat','Lost','Sales Lead','B2B',NULL,404,NULL,NULL,NULL,NULL,NULL,1),(900,NULL,'2024-05-09','400 Main Road','Mumbai','India','2024-05-09 09:00:00.000000','suresh400@email.in','Suresh','IT','Kumar','9803156400','Reliance Industries',NULL,NULL,'Website','Maharashtra','Lost','Sales Lead','B2B',NULL,405,NULL,NULL,NULL,NULL,NULL,1),(901,NULL,'2025-06-10','401 Main Road','Delhi','India','2025-06-10 09:00:00.000000','meena401@email.in','Meena','Manufacturing','Sharma','9803164291','Tata Consultancy',NULL,NULL,'Referral','Delhi','Lost','Sales Lead','B2B',NULL,406,NULL,NULL,NULL,NULL,NULL,1),(902,NULL,'2023-07-11','402 Main Road','Pune','India','2023-07-11 09:00:00.000000','anil402@email.in','Anil','Healthcare','Patel','9803172182','Infosys Ltd',NULL,NULL,'Direct','Karnataka','Lost','Sales Lead','B2B',NULL,407,NULL,NULL,NULL,NULL,NULL,1),(903,NULL,'2024-08-12','403 Main Road','Bangalore','India','2024-08-12 09:00:00.000000','komal403@email.in','Komal','Retail','Singh','9803180073','Wipro Technologies',NULL,NULL,'Email','Telangana','Lost','Sales Lead','B2B',NULL,408,NULL,NULL,NULL,NULL,NULL,1),(904,NULL,'2025-09-13','404 Main Road','Hyderabad','India','2025-09-13 09:00:00.000000','ravi404@email.in','Ravi','Education','Verma','9803187964','HCL Technologies',NULL,NULL,'Social Media','Tamil Nadu','Lost','Sales Lead','B2B',NULL,409,NULL,NULL,NULL,NULL,NULL,1),(905,NULL,'2023-10-14','405 Main Road','Chennai','India','2023-10-14 09:00:00.000000','shweta405@email.in','Shweta','Finance','Joshi','9803195855','Mahindra Group',NULL,NULL,'Other','West Bengal','Lost','Sales Lead','B2B',NULL,410,NULL,NULL,NULL,NULL,NULL,1),(906,NULL,'2024-11-15','406 Main Road','Kolkata','India','2024-11-15 09:00:00.000000','girish406@email.in','Girish','Real Estate','Mehta','9803203746','TechCorp Solutions',NULL,NULL,'Indiamart','Rajasthan','Lost','Sales Lead','B2B',NULL,411,NULL,NULL,NULL,NULL,NULL,1),(907,NULL,'2025-12-16','407 Main Road','Jaipur','India','2025-12-16 09:00:00.000000','pallavi407@email.in','Pallavi','Automotive','Desai','9803211637','Xform Technologies',NULL,NULL,'Website','Gujarat','Lost','Sales Lead','B2B',NULL,412,NULL,NULL,NULL,NULL,NULL,1),(908,NULL,'2023-01-17','408 Main Road','Ahmedabad','India','2023-01-17 09:00:00.000000','rajesh408@email.in','Rajesh','IT','Gupta','9803219528','BuildRight Infra',NULL,NULL,'Referral','Maharashtra','Lost','Sales Lead','B2B',NULL,413,NULL,NULL,NULL,NULL,NULL,1),(909,NULL,'2024-02-18','409 Main Road','Surat','India','2024-02-18 09:00:00.000000','priya409@email.in','Priya','Manufacturing','Nair','9803227419','MedPlus Healthcare',NULL,NULL,'Direct','Delhi','Lost','Sales Lead','B2B',NULL,414,NULL,NULL,NULL,NULL,NULL,1),(910,NULL,'2025-03-19','410 Main Road','Mumbai','India','2025-03-19 09:00:00.000000','amit410@email.in','Amit','Healthcare','Reddy','9803235310','GreenField Agro',NULL,NULL,'Email','Karnataka','Lost','Sales Lead','B2B',NULL,415,NULL,NULL,NULL,NULL,NULL,1),(911,NULL,'2023-04-20','411 Main Road','Delhi','India','2023-04-20 09:00:00.000000','sneha411@email.in','Sneha','Retail','Shah','9803243201','FinanceFirst Pvt Ltd',NULL,NULL,'Social Media','Telangana','Lost','Sales Lead','B2B',NULL,416,NULL,NULL,NULL,NULL,NULL,1),(912,NULL,'2024-05-21','412 Main Road','Pune','India','2024-05-21 09:00:00.000000','vikas412@email.in','Vikas','Education','Mishra','9803251092','AutoDrive Motors',NULL,NULL,'Other','Tamil Nadu','Lost','Sales Lead','B2B',NULL,417,NULL,NULL,NULL,NULL,NULL,1),(913,NULL,'2025-06-22','413 Main Road','Bangalore','India','2025-06-22 09:00:00.000000','neha413@email.in','Neha','Finance','Tiwari','9803258983','EduSmart Institute',NULL,NULL,'Indiamart','West Bengal','Lost','Sales Lead','B2B',NULL,418,NULL,NULL,NULL,NULL,NULL,1),(914,NULL,'2023-07-23','414 Main Road','Hyderabad','India','2023-07-23 09:00:00.000000','sanjay414@email.in','Sanjay','Real Estate','Agarwal','9803266874','Reliance Industries',NULL,NULL,'Website','Rajasthan','Lost','Sales Lead','B2B',NULL,419,NULL,NULL,NULL,NULL,NULL,1),(915,NULL,'2024-08-24','415 Main Road','Chennai','India','2024-08-24 09:00:00.000000','kavita415@email.in','Kavita','Automotive','Bose','9803274765','Tata Consultancy',NULL,NULL,'Referral','Gujarat','Lost','Sales Lead','B2B',NULL,420,NULL,NULL,NULL,NULL,NULL,1),(916,NULL,'2025-09-25','416 Main Road','Kolkata','India','2025-09-25 09:00:00.000000','rahul416@email.in','Rahul','IT','Pillai','9803282656','Infosys Ltd',NULL,NULL,'Direct','Maharashtra','Lost','Sales Lead','B2B',NULL,421,NULL,NULL,NULL,NULL,NULL,1),(917,NULL,'2023-10-26','417 Main Road','Jaipur','India','2023-10-26 09:00:00.000000','anita417@email.in','Anita','Manufacturing','Chauhan','9803290547','Wipro Technologies',NULL,NULL,'Email','Delhi','Lost','Sales Lead','B2B',NULL,422,NULL,NULL,NULL,NULL,NULL,1),(918,NULL,'2024-11-27','418 Main Road','Ahmedabad','India','2024-11-27 09:00:00.000000','deepak418@email.in','Deepak','Healthcare','Rao','9803298438','HCL Technologies',NULL,NULL,'Social Media','Karnataka','Open','Sales Lead','B2B',NULL,423,NULL,NULL,NULL,NULL,NULL,1),(919,NULL,'2025-12-28','419 Main Road','Surat','India','2025-12-28 09:00:00.000000','sunita419@email.in','Sunita','Retail','Pandey','9803306329','Mahindra Group',NULL,NULL,'Other','Telangana','Open','Sales Lead','B2B',NULL,424,NULL,NULL,NULL,NULL,NULL,1),(920,NULL,'2023-01-01','420 Main Road','Mumbai','India','2023-01-01 09:00:00.000000','vikram420@email.in','Vikram','Education','Kumar','9803314220','TechCorp Solutions',NULL,NULL,'Indiamart','Tamil Nadu','Open','Sales Lead','B2B',NULL,425,NULL,NULL,NULL,NULL,NULL,1),(921,NULL,'2024-02-02','421 Main Road','Delhi','India','2024-02-02 09:00:00.000000','pooja421@email.in','Pooja','Finance','Sharma','9803322111','Xform Technologies',NULL,NULL,'Website','West Bengal','Open','Sales Lead','B2B',NULL,426,NULL,NULL,NULL,NULL,NULL,1),(922,NULL,'2025-03-03','422 Main Road','Pune','India','2025-03-03 09:00:00.000000','mahesh422@email.in','Mahesh','Real Estate','Patel','9803330002','BuildRight Infra',NULL,NULL,'Referral','Rajasthan','Open','Sales Lead','B2B',NULL,427,NULL,NULL,NULL,NULL,NULL,1),(923,NULL,'2023-04-04','423 Main Road','Bangalore','India','2023-04-04 09:00:00.000000','rekha423@email.in','Rekha','Automotive','Singh','9803337893','MedPlus Healthcare',NULL,NULL,'Direct','Gujarat','Open','Sales Lead','B2B',NULL,428,NULL,NULL,NULL,NULL,NULL,1),(924,NULL,'2024-05-05','424 Main Road','Hyderabad','India','2024-05-05 09:00:00.000000','suresh424@email.in','Suresh','IT','Verma','9803345784','GreenField Agro',NULL,NULL,'Email','Maharashtra','Open','Sales Lead','B2B',NULL,429,NULL,NULL,NULL,NULL,NULL,1),(925,NULL,'2025-06-06','425 Main Road','Chennai','India','2025-06-06 09:00:00.000000','meena425@email.in','Meena','Manufacturing','Joshi','9803353675','FinanceFirst Pvt Ltd',NULL,NULL,'Social Media','Delhi','Open','Sales Lead','B2B',NULL,430,NULL,NULL,NULL,NULL,NULL,1),(926,NULL,'2023-07-07','426 Main Road','Kolkata','India','2023-07-07 09:00:00.000000','anil426@email.in','Anil','Healthcare','Mehta','9803361566','AutoDrive Motors',NULL,NULL,'Other','Karnataka','Open','Sales Lead','B2B',NULL,431,NULL,NULL,NULL,NULL,NULL,1),(927,NULL,'2024-08-08','427 Main Road','Jaipur','India','2024-08-08 09:00:00.000000','komal427@email.in','Komal','Retail','Desai','9803369457','EduSmart Institute',NULL,NULL,'Indiamart','Telangana','Open','Sales Lead','B2B',NULL,432,NULL,NULL,NULL,NULL,NULL,1),(928,NULL,'2025-09-09','428 Main Road','Ahmedabad','India','2025-09-09 09:00:00.000000','ravi428@email.in','Ravi','Education','Gupta','9803377348','Reliance Industries',NULL,NULL,'Website','Tamil Nadu','Open','Sales Lead','B2B',NULL,433,NULL,NULL,NULL,NULL,NULL,1),(929,NULL,'2023-10-10','429 Main Road','Surat','India','2023-10-10 09:00:00.000000','shweta429@email.in','Shweta','Finance','Nair','9803385239','Tata Consultancy',NULL,NULL,'Referral','West Bengal','Open','Sales Lead','B2B',NULL,434,NULL,NULL,NULL,NULL,NULL,1),(930,NULL,'2024-11-11','430 Main Road','Mumbai','India','2024-11-11 09:00:00.000000','girish430@email.in','Girish','Real Estate','Reddy','9803393130','Infosys Ltd',NULL,NULL,'Direct','Rajasthan','Open','Sales Lead','B2B',NULL,435,NULL,NULL,NULL,NULL,NULL,1),(931,NULL,'2025-12-12','431 Main Road','Delhi','India','2025-12-12 09:00:00.000000','pallavi431@email.in','Pallavi','Automotive','Shah','9803401021','Wipro Technologies',NULL,NULL,'Email','Gujarat','Open','Sales Lead','B2B',NULL,436,NULL,NULL,NULL,NULL,NULL,1),(932,NULL,'2023-01-13','432 Main Road','Pune','India','2023-01-13 09:00:00.000000','rajesh432@email.in','Rajesh','IT','Mishra','9803408912','HCL Technologies',NULL,NULL,'Social Media','Maharashtra','Open','Sales Lead','B2B',NULL,437,NULL,NULL,NULL,NULL,NULL,1),(933,NULL,'2024-02-14','433 Main Road','Bangalore','India','2024-02-14 09:00:00.000000','priya433@email.in','Priya','Manufacturing','Tiwari','9803416803','Mahindra Group',NULL,NULL,'Other','Delhi','Open','Sales Lead','B2B',NULL,438,NULL,NULL,NULL,NULL,NULL,1),(934,NULL,'2025-03-15','434 Main Road','Hyderabad','India','2025-03-15 09:00:00.000000','amit434@email.in','Amit','Healthcare','Agarwal','9803424694','TechCorp Solutions',NULL,NULL,'Indiamart','Karnataka','Open','Sales Lead','B2B',NULL,439,NULL,NULL,NULL,NULL,NULL,1),(935,NULL,'2023-04-16','435 Main Road','Chennai','India','2023-04-16 09:00:00.000000','sneha435@email.in','Sneha','Retail','Bose','9803432585','Xform Technologies',NULL,NULL,'Website','Telangana','Open','Sales Lead','B2B',NULL,440,NULL,NULL,NULL,NULL,NULL,1),(936,NULL,'2024-05-17','436 Main Road','Kolkata','India','2024-05-17 09:00:00.000000','vikas436@email.in','Vikas','Education','Pillai','9803440476','BuildRight Infra',NULL,NULL,'Referral','Tamil Nadu','Open','Sales Lead','B2B',NULL,441,NULL,NULL,NULL,NULL,NULL,1),(937,NULL,'2025-06-18','437 Main Road','Jaipur','India','2025-06-18 09:00:00.000000','neha437@email.in','Neha','Finance','Chauhan','9803448367','MedPlus Healthcare',NULL,NULL,'Direct','West Bengal','Open','Sales Lead','B2B',NULL,442,NULL,NULL,NULL,NULL,NULL,1),(938,NULL,'2023-07-19','438 Main Road','Ahmedabad','India','2023-07-19 09:00:00.000000','sanjay438@email.in','Sanjay','Real Estate','Rao','9803456258','GreenField Agro',NULL,NULL,'Email','Rajasthan','Open','Sales Lead','B2B',NULL,443,NULL,NULL,NULL,NULL,NULL,1),(939,NULL,'2024-08-20','439 Main Road','Surat','India','2024-08-20 09:00:00.000000','kavita439@email.in','Kavita','Automotive','Pandey','9803464149','FinanceFirst Pvt Ltd',NULL,NULL,'Social Media','Gujarat','Open','Sales Lead','B2B',NULL,444,NULL,NULL,NULL,NULL,NULL,1),(940,NULL,'2025-09-21','440 Main Road','Mumbai','India','2025-09-21 09:00:00.000000','rahul440@email.in','Rahul','IT','Kumar','9803472040','AutoDrive Motors',NULL,NULL,'Other','Maharashtra','Open','Sales Lead','B2B',NULL,445,NULL,NULL,NULL,NULL,NULL,1),(941,NULL,'2023-10-22','441 Main Road','Delhi','India','2023-10-22 09:00:00.000000','anita441@email.in','Anita','Manufacturing','Sharma','9803479931','EduSmart Institute',NULL,NULL,'Indiamart','Delhi','Open','Sales Lead','B2B',NULL,446,NULL,NULL,NULL,NULL,NULL,1),(942,NULL,'2024-11-23','442 Main Road','Pune','India','2024-11-23 09:00:00.000000','deepak442@email.in','Deepak','Healthcare','Patel','9803487822','Reliance Industries',NULL,NULL,'Website','Karnataka','Open','Sales Lead','B2B',NULL,447,NULL,NULL,NULL,NULL,NULL,1),(943,NULL,'2025-12-24','443 Main Road','Bangalore','India','2025-12-24 09:00:00.000000','sunita443@email.in','Sunita','Retail','Singh','9803495713','Tata Consultancy',NULL,NULL,'Referral','Telangana','Open','Sales Lead','B2B',NULL,448,NULL,NULL,NULL,NULL,NULL,1),(944,NULL,'2023-01-25','444 Main Road','Hyderabad','India','2023-01-25 09:00:00.000000','vikram444@email.in','Vikram','Education','Verma','9803503604','Infosys Ltd',NULL,NULL,'Direct','Tamil Nadu','Open','Sales Lead','B2B',NULL,449,NULL,NULL,NULL,NULL,NULL,1),(945,NULL,'2024-02-26','445 Main Road','Chennai','India','2024-02-26 09:00:00.000000','pooja445@email.in','Pooja','Finance','Joshi','9803511495','Wipro Technologies',NULL,NULL,'Email','West Bengal','Open','Sales Lead','B2B',NULL,450,NULL,NULL,NULL,NULL,NULL,1),(946,NULL,'2025-03-27','446 Main Road','Kolkata','India','2025-03-27 09:00:00.000000','mahesh446@email.in','Mahesh','Real Estate','Mehta','9803519386','HCL Technologies',NULL,NULL,'Social Media','Rajasthan','Open','Sales Lead','B2B',NULL,451,NULL,NULL,NULL,NULL,NULL,1),(947,NULL,'2023-04-28','447 Main Road','Jaipur','India','2023-04-28 09:00:00.000000','rekha447@email.in','Rekha','Automotive','Desai','9803527277','Mahindra Group',NULL,NULL,'Other','Gujarat','Open','Sales Lead','B2B',NULL,452,NULL,NULL,NULL,NULL,NULL,1),(948,NULL,'2024-05-01','448 Main Road','Ahmedabad','India','2024-05-01 09:00:00.000000','suresh448@email.in','Suresh','IT','Gupta','9803535168','TechCorp Solutions',NULL,NULL,'Indiamart','Maharashtra','Open','Sales Lead','B2B',NULL,453,NULL,NULL,NULL,NULL,NULL,1),(949,NULL,'2025-06-02','449 Main Road','Surat','India','2025-06-02 09:00:00.000000','meena449@email.in','Meena','Manufacturing','Nair','9803543059','Xform Technologies',NULL,NULL,'Website','Delhi','Open','Sales Lead','B2B',NULL,454,NULL,NULL,NULL,NULL,NULL,1),(950,NULL,'2023-07-03','450 Main Road','Mumbai','India','2023-07-03 09:00:00.000000','anil450@email.in','Anil','Healthcare','Reddy','9803550950','BuildRight Infra',NULL,NULL,'Referral','Karnataka','Open','Sales Lead','B2B',NULL,455,NULL,NULL,NULL,NULL,NULL,1),(951,NULL,'2024-08-04','451 Main Road','Delhi','India','2024-08-04 09:00:00.000000','komal451@email.in','Komal','Retail','Shah','9803558841','MedPlus Healthcare',NULL,NULL,'Direct','Telangana','Open','Sales Lead','B2B',NULL,456,NULL,NULL,NULL,NULL,NULL,1),(952,NULL,'2025-09-05','452 Main Road','Pune','India','2025-09-05 09:00:00.000000','ravi452@email.in','Ravi','Education','Mishra','9803566732','GreenField Agro',NULL,NULL,'Email','Tamil Nadu','Open','Sales Lead','B2B',NULL,457,NULL,NULL,NULL,NULL,NULL,1),(953,NULL,'2023-10-06','453 Main Road','Bangalore','India','2023-10-06 09:00:00.000000','shweta453@email.in','Shweta','Finance','Tiwari','9803574623','FinanceFirst Pvt Ltd',NULL,NULL,'Social Media','West Bengal','Open','Sales Lead','B2B',NULL,458,NULL,NULL,NULL,NULL,NULL,1),(954,NULL,'2024-11-07','454 Main Road','Hyderabad','India','2024-11-07 09:00:00.000000','girish454@email.in','Girish','Real Estate','Agarwal','9803582514','AutoDrive Motors',NULL,NULL,'Other','Rajasthan','Open','Sales Lead','B2B',NULL,459,NULL,NULL,NULL,NULL,NULL,1),(955,NULL,'2025-12-08','455 Main Road','Chennai','India','2025-12-08 09:00:00.000000','pallavi455@email.in','Pallavi','Automotive','Bose','9803590405','EduSmart Institute',NULL,NULL,'Indiamart','Gujarat','Open','Sales Lead','B2B',NULL,460,NULL,NULL,NULL,NULL,NULL,1),(956,NULL,'2023-01-09','456 Main Road','Kolkata','India','2023-01-09 09:00:00.000000','rajesh456@email.in','Rajesh','IT','Pillai','9803598296','Reliance Industries',NULL,NULL,'Website','Maharashtra','Open','Sales Lead','B2B',NULL,461,NULL,NULL,NULL,NULL,NULL,1),(957,NULL,'2024-02-10','457 Main Road','Jaipur','India','2024-02-10 09:00:00.000000','priya457@email.in','Priya','Manufacturing','Chauhan','9803606187','Tata Consultancy',NULL,NULL,'Referral','Delhi','Open','Sales Lead','B2B',NULL,462,NULL,NULL,NULL,NULL,NULL,1),(958,NULL,'2025-03-11','458 Main Road','Ahmedabad','India','2025-03-11 09:00:00.000000','amit458@email.in','Amit','Healthcare','Rao','9803614078','Infosys Ltd',NULL,NULL,'Direct','Karnataka','Open','Sales Lead','B2B',NULL,463,NULL,NULL,NULL,NULL,NULL,1),(959,NULL,'2023-04-12','459 Main Road','Surat','India','2023-04-12 09:00:00.000000','sneha459@email.in','Sneha','Retail','Pandey','9803621969','Wipro Technologies',NULL,NULL,'Email','Telangana','Open','Sales Lead','B2B',NULL,464,NULL,NULL,NULL,NULL,NULL,1),(960,NULL,'2024-05-13','460 Main Road','Mumbai','India','2024-05-13 09:00:00.000000','vikas460@email.in','Vikas','Education','Kumar','9803629860','HCL Technologies',NULL,NULL,'Social Media','Tamil Nadu','Open','Sales Lead','B2B',NULL,465,NULL,NULL,NULL,NULL,NULL,1),(961,NULL,'2025-06-14','461 Main Road','Delhi','India','2025-06-14 09:00:00.000000','neha461@email.in','Neha','Finance','Sharma','9803637751','Mahindra Group',NULL,NULL,'Other','West Bengal','Open','Sales Lead','B2B',NULL,466,NULL,NULL,NULL,NULL,NULL,1),(962,NULL,'2023-07-15','462 Main Road','Pune','India','2023-07-15 09:00:00.000000','sanjay462@email.in','Sanjay','Real Estate','Patel','9803645642','TechCorp Solutions',NULL,NULL,'Indiamart','Rajasthan','Open','Sales Lead','B2B',NULL,467,NULL,NULL,NULL,NULL,NULL,1),(963,NULL,'2024-08-16','463 Main Road','Bangalore','India','2024-08-16 09:00:00.000000','kavita463@email.in','Kavita','Automotive','Singh','9803653533','Xform Technologies',NULL,NULL,'Website','Gujarat','Open','Sales Lead','B2B',NULL,468,NULL,NULL,NULL,NULL,NULL,1),(964,NULL,'2025-09-17','464 Main Road','Hyderabad','India','2025-09-17 09:00:00.000000','rahul464@email.in','Rahul','IT','Verma','9803661424','BuildRight Infra',NULL,NULL,'Referral','Maharashtra','New Lead','Sales Lead','B2B',NULL,469,NULL,NULL,NULL,NULL,NULL,1),(965,NULL,'2023-10-18','465 Main Road','Chennai','India','2023-10-18 09:00:00.000000','anita465@email.in','Anita','Manufacturing','Joshi','9803669315','MedPlus Healthcare',NULL,NULL,'Direct','Delhi','New Lead','Sales Lead','B2B',NULL,470,NULL,NULL,NULL,NULL,NULL,1),(966,NULL,'2024-11-19','466 Main Road','Kolkata','India','2024-11-19 09:00:00.000000','deepak466@email.in','Deepak','Healthcare','Mehta','9803677206','GreenField Agro',NULL,NULL,'Email','Karnataka','New Lead','Sales Lead','B2B',NULL,471,NULL,NULL,NULL,NULL,NULL,1),(967,NULL,'2025-12-20','467 Main Road','Jaipur','India','2025-12-20 09:00:00.000000','sunita467@email.in','Sunita','Retail','Desai','9803685097','FinanceFirst Pvt Ltd',NULL,NULL,'Social Media','Telangana','New Lead','Sales Lead','B2B',NULL,472,NULL,NULL,NULL,NULL,NULL,1),(968,NULL,'2023-01-21','468 Main Road','Ahmedabad','India','2023-01-21 09:00:00.000000','vikram468@email.in','Vikram','Education','Gupta','9803692988','AutoDrive Motors',NULL,NULL,'Other','Tamil Nadu','New Lead','Sales Lead','B2B',NULL,473,NULL,NULL,NULL,NULL,NULL,1),(969,NULL,'2024-02-22','469 Main Road','Surat','India','2024-02-22 09:00:00.000000','pooja469@email.in','Pooja','Finance','Nair','9803700879','EduSmart Institute',NULL,NULL,'Indiamart','West Bengal','New Lead','Sales Lead','B2B',NULL,474,NULL,NULL,NULL,NULL,NULL,1),(970,NULL,'2025-03-23','470 Main Road','Mumbai','India','2025-03-23 09:00:00.000000','mahesh470@email.in','Mahesh','Real Estate','Reddy','9803708770','Reliance Industries',NULL,NULL,'Website','Rajasthan','New Lead','Sales Lead','B2B',NULL,475,NULL,NULL,NULL,NULL,NULL,1),(971,NULL,'2023-04-24','471 Main Road','Delhi','India','2023-04-24 09:00:00.000000','rekha471@email.in','Rekha','Automotive','Shah','9803716661','Tata Consultancy',NULL,NULL,'Referral','Gujarat','New Lead','Sales Lead','B2B',NULL,476,NULL,NULL,NULL,NULL,NULL,1),(972,NULL,'2024-05-25','472 Main Road','Pune','India','2024-05-25 09:00:00.000000','suresh472@email.in','Suresh','IT','Mishra','9803724552','Infosys Ltd',NULL,NULL,'Direct','Maharashtra','New Lead','Sales Lead','B2B',NULL,477,NULL,NULL,NULL,NULL,NULL,1),(973,NULL,'2025-06-26','473 Main Road','Bangalore','India','2025-06-26 09:00:00.000000','meena473@email.in','Meena','Manufacturing','Tiwari','9803732443','Wipro Technologies',NULL,NULL,'Email','Delhi','New Lead','Sales Lead','B2B',NULL,478,NULL,NULL,NULL,NULL,NULL,1),(974,NULL,'2023-07-27','474 Main Road','Hyderabad','India','2023-07-27 09:00:00.000000','anil474@email.in','Anil','Healthcare','Agarwal','9803740334','HCL Technologies',NULL,NULL,'Social Media','Karnataka','New Lead','Sales Lead','B2B',NULL,479,NULL,NULL,NULL,NULL,NULL,1),(975,NULL,'2024-08-28','475 Main Road','Chennai','India','2024-08-28 09:00:00.000000','komal475@email.in','Komal','Retail','Bose','9803748225','Mahindra Group',NULL,NULL,'Other','Telangana','New Lead','Sales Lead','B2B',NULL,480,NULL,NULL,NULL,NULL,NULL,1),(976,NULL,'2025-09-01','476 Main Road','Kolkata','India','2025-09-01 09:00:00.000000','ravi476@email.in','Ravi','Education','Pillai','9803756116','TechCorp Solutions',NULL,NULL,'Indiamart','Tamil Nadu','New Lead','Sales Lead','B2B',NULL,481,NULL,NULL,NULL,NULL,NULL,1),(977,NULL,'2023-10-02','477 Main Road','Jaipur','India','2023-10-02 09:00:00.000000','shweta477@email.in','Shweta','Finance','Chauhan','9803764007','Xform Technologies',NULL,NULL,'Website','West Bengal','New Lead','Sales Lead','B2B',NULL,482,NULL,NULL,NULL,NULL,NULL,1),(978,NULL,'2024-11-03','478 Main Road','Ahmedabad','India','2024-11-03 09:00:00.000000','girish478@email.in','Girish','Real Estate','Rao','9803771898','BuildRight Infra',NULL,NULL,'Referral','Rajasthan','New Lead','Sales Lead','B2B',NULL,483,NULL,NULL,NULL,NULL,NULL,1),(979,NULL,'2025-12-04','479 Main Road','Surat','India','2025-12-04 09:00:00.000000','pallavi479@email.in','Pallavi','Automotive','Pandey','9803779789','MedPlus Healthcare',NULL,NULL,'Direct','Gujarat','New Lead','Sales Lead','B2B',NULL,484,NULL,NULL,NULL,NULL,NULL,1),(980,NULL,'2023-01-05','480 Main Road','Mumbai','India','2023-01-05 09:00:00.000000','rajesh480@email.in','Rajesh','IT','Kumar','9803787680','GreenField Agro',NULL,NULL,'Email','Maharashtra','New Lead','Sales Lead','B2B',NULL,485,NULL,NULL,NULL,NULL,NULL,1),(981,NULL,'2024-02-06','481 Main Road','Delhi','India','2024-02-06 09:00:00.000000','priya481@email.in','Priya','Manufacturing','Sharma','9803795571','FinanceFirst Pvt Ltd',NULL,NULL,'Social Media','Delhi','New Lead','Sales Lead','B2B',NULL,486,NULL,NULL,NULL,NULL,NULL,1),(982,NULL,'2025-03-07','482 Main Road','Pune','India','2025-03-07 09:00:00.000000','amit482@email.in','Amit','Healthcare','Patel','9803803462','AutoDrive Motors',NULL,NULL,'Other','Karnataka','New Lead','Sales Lead','B2B',NULL,487,NULL,NULL,NULL,NULL,NULL,1),(983,NULL,'2023-04-08','483 Main Road','Bangalore','India','2023-04-08 09:00:00.000000','sneha483@email.in','Sneha','Retail','Singh','9803811353','EduSmart Institute',NULL,NULL,'Indiamart','Telangana','New Lead','Sales Lead','B2B',NULL,488,NULL,NULL,NULL,NULL,NULL,1),(984,NULL,'2024-05-09','484 Main Road','Hyderabad','India','2024-05-09 09:00:00.000000','vikas484@email.in','Vikas','Education','Verma','9803819244','Reliance Industries',NULL,NULL,'Website','Tamil Nadu','New Lead','Sales Lead','B2B',NULL,489,NULL,NULL,NULL,NULL,NULL,1),(985,NULL,'2025-06-10','485 Main Road','Chennai','India','2025-06-10 09:00:00.000000','neha485@email.in','Neha','Finance','Joshi','9803827135','Tata Consultancy',NULL,NULL,'Referral','West Bengal','New Lead','Sales Lead','B2B',NULL,490,NULL,NULL,NULL,NULL,NULL,1),(986,NULL,'2023-07-11','486 Main Road','Kolkata','India','2023-07-11 09:00:00.000000','sanjay486@email.in','Sanjay','Real Estate','Mehta','9803835026','Infosys Ltd',NULL,NULL,'Direct','Rajasthan','New Lead','Sales Lead','B2B',NULL,491,NULL,NULL,NULL,NULL,NULL,1),(987,NULL,'2024-08-12','487 Main Road','Jaipur','India','2024-08-12 09:00:00.000000','kavita487@email.in','Kavita','Automotive','Desai','9803842917','Wipro Technologies',NULL,NULL,'Email','Gujarat','New Lead','Sales Lead','B2B',NULL,492,NULL,NULL,NULL,NULL,NULL,1),(988,NULL,'2025-09-13','488 Main Road','Ahmedabad','India','2025-09-13 09:00:00.000000','rahul488@email.in','Rahul','IT','Gupta','9803850808','HCL Technologies',NULL,NULL,'Social Media','Maharashtra','New Lead','Sales Lead','B2B',NULL,493,NULL,NULL,NULL,NULL,NULL,1),(989,NULL,'2023-10-14','489 Main Road','Surat','India','2023-10-14 09:00:00.000000','anita489@email.in','Anita','Manufacturing','Nair','9803858699','Mahindra Group',NULL,NULL,'Other','Delhi','New Lead','Sales Lead','B2B',NULL,494,NULL,NULL,NULL,NULL,NULL,1),(990,NULL,'2024-11-15','490 Main Road','Mumbai','India','2024-11-15 09:00:00.000000','deepak490@email.in','Deepak','Healthcare','Reddy','9803866590','TechCorp Solutions',NULL,NULL,'Indiamart','Karnataka','New Lead','Sales Lead','B2B',NULL,495,NULL,NULL,NULL,NULL,NULL,1),(991,NULL,'2025-12-16','491 Main Road','Delhi','India','2025-12-16 09:00:00.000000','sunita491@email.in','Sunita','Retail','Shah','9803874481','Xform Technologies',NULL,NULL,'Website','Telangana','New Lead','Sales Lead','B2B',NULL,496,NULL,NULL,NULL,NULL,NULL,1),(992,NULL,'2023-01-17','492 Main Road','Pune','India','2023-01-17 09:00:00.000000','vikram492@email.in','Vikram','Education','Mishra','9803882372','BuildRight Infra',NULL,NULL,'Referral','Tamil Nadu','New Lead','Sales Lead','B2B',NULL,497,NULL,NULL,NULL,NULL,NULL,1),(993,NULL,'2024-02-18','493 Main Road','Bangalore','India','2024-02-18 09:00:00.000000','pooja493@email.in','Pooja','Finance','Tiwari','9803890263','MedPlus Healthcare',NULL,NULL,'Direct','West Bengal','New Lead','Sales Lead','B2B',NULL,498,NULL,NULL,NULL,NULL,NULL,1),(994,NULL,'2025-03-19','494 Main Road','Hyderabad','India','2025-03-19 09:00:00.000000','mahesh494@email.in','Mahesh','Real Estate','Agarwal','9803898154','GreenField Agro',NULL,NULL,'Email','Rajasthan','New Lead','Sales Lead','B2B',NULL,499,NULL,NULL,NULL,NULL,NULL,1),(995,NULL,'2023-04-20','495 Main Road','Chennai','India','2023-04-20 09:00:00.000000','rekha495@email.in','Rekha','Automotive','Bose','9803906045','FinanceFirst Pvt Ltd',NULL,NULL,'Social Media','Gujarat','New Lead','Sales Lead','B2B',NULL,500,NULL,NULL,NULL,NULL,NULL,1),(996,NULL,'2024-05-21','496 Main Road','Kolkata','India','2024-05-21 09:00:00.000000','suresh496@email.in','Suresh','IT','Pillai','9803913936','AutoDrive Motors',NULL,NULL,'Other','Maharashtra','New Lead','Sales Lead','B2B',NULL,501,NULL,NULL,NULL,NULL,NULL,1),(997,NULL,'2025-06-22','497 Main Road','Jaipur','India','2025-06-22 09:00:00.000000','meena497@email.in','Meena','Manufacturing','Chauhan','9803921827','EduSmart Institute',NULL,NULL,'Indiamart','Delhi','New Lead','Sales Lead','B2B',NULL,502,NULL,NULL,NULL,NULL,NULL,1),(998,NULL,'2023-07-23','498 Main Road','Ahmedabad','India','2023-07-23 09:00:00.000000','anil498@email.in','Anil','Healthcare','Rao','9803929718','Reliance Industries',NULL,NULL,'Website','Karnataka','New Lead','Sales Lead','B2B',NULL,503,NULL,NULL,NULL,NULL,NULL,1),(999,NULL,'2024-08-24','499 Main Road','Surat','India','2024-08-24 09:00:00.000000','komal499@email.in','Komal','Retail','Pandey','9803937609','Tata Consultancy',NULL,NULL,'Referral','Telangana','New Lead','Sales Lead','B2B',NULL,504,NULL,NULL,NULL,NULL,NULL,1),(1000,NULL,'2025-09-25','500 Main Road','Mumbai','India','2025-09-25 09:00:00.000000','ravi500@email.in','Ravi','Education','Kumar','9803945500','Infosys Ltd',NULL,NULL,'Direct','Tamil Nadu','New Lead','Sales Lead','B2B',NULL,5,NULL,NULL,NULL,NULL,NULL,1);
/*!40000 ALTER TABLE `xformsales_lead` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformsales_lead_note`
--

DROP TABLE IF EXISTS `xformsales_lead_note`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformsales_lead_note` (
  `lead_note_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `lead_id_fk` bigint(20) DEFAULT NULL,
  `note_date` datetime(6) DEFAULT NULL,
  `note_text` text DEFAULT NULL,
  `user_id_fk` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`lead_note_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformsales_lead_note`
--

LOCK TABLES `xformsales_lead_note` WRITE;
/*!40000 ALTER TABLE `xformsales_lead_note` DISABLE KEYS */;
/*!40000 ALTER TABLE `xformsales_lead_note` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformsales_lead_reminder`
--

DROP TABLE IF EXISTS `xformsales_lead_reminder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformsales_lead_reminder` (
  `lead_reminder_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `lead_id_fk` bigint(20) DEFAULT NULL,
  `reminder_date` datetime(6) DEFAULT NULL,
  `reminder_text` text DEFAULT NULL,
  `user_id_fk` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`lead_reminder_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformsales_lead_reminder`
--

LOCK TABLES `xformsales_lead_reminder` WRITE;
/*!40000 ALTER TABLE `xformsales_lead_reminder` DISABLE KEYS */;
/*!40000 ALTER TABLE `xformsales_lead_reminder` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformsales_opportunity`
--

DROP TABLE IF EXISTS `xformsales_opportunity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformsales_opportunity` (
  `opp_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `lead_id_fk` bigint(20) DEFAULT NULL,
  `opp_actual_close_date` date DEFAULT NULL,
  `opp_amount` decimal(15,2) DEFAULT NULL,
  `opp_description` text DEFAULT NULL,
  `opp_doc` varchar(255) DEFAULT NULL,
  `opp_forcast_close_date` date DEFAULT NULL,
  `opp_name` varchar(255) DEFAULT NULL,
  `opp_status` varchar(255) DEFAULT NULL,
  `opp_title` varchar(255) DEFAULT NULL,
  `user_id_fk` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`opp_id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformsales_opportunity`
--

LOCK TABLES `xformsales_opportunity` WRITE;
/*!40000 ALTER TABLE `xformsales_opportunity` DISABLE KEYS */;
INSERT INTO `xformsales_opportunity` VALUES (1,1,'2024-06-25',850000.00,'Full ERP system implementation',NULL,'2024-06-30','TechCorp ERP Deal','Won','Enterprise ERP Implementation',1),(2,2,'2024-07-10',320000.00,'Upgrade from legacy CRM',NULL,'2024-07-15','Xform CRM Upgrade','Won','CRM Platform Upgrade',1),(3,3,NULL,1200000.00,'Web portal for project management',NULL,'2025-03-01','BuildRight Portal','Open','Construction Management Portal',1),(4,4,'2024-05-18',750000.00,'EHR system integration',NULL,'2024-05-20','MedPlus EHR','Won','Electronic Health Records',1),(5,5,'2024-08-05',280000.00,'Mobile app for crop management',NULL,'2024-08-01','GreenField AgriApp','Lost','Agricultural Management App',1),(6,6,NULL,950000.00,'BI and analytics dashboard',NULL,'2025-04-30','FinanceFirst Analytics','Open','Financial Analytics Platform',1),(7,7,'2024-09-28',420000.00,'Complete dealer management solution',NULL,'2024-09-30','AutoDrive DMS','Won','Dealer Management System',1),(8,8,NULL,380000.00,'Online learning platform',NULL,'2025-05-15','EduSmart LMS','Open','Learning Management System',1),(9,1,'2024-04-12',1800000.00,'Factory IoT monitoring system',NULL,'2024-04-15','Reliance IoT','Won','IoT Integration Project',1),(10,2,'2024-10-05',650000.00,'AWS cloud migration',NULL,'2024-10-01','TCS Cloud Migration','Lost','Cloud Migration Services',1),(11,3,NULL,480000.00,'Full security audit and pen testing',NULL,'2025-06-01','Infosys Security Audit','Open','Security Assessment',1),(12,4,'2024-11-25',360000.00,'CI/CD pipeline and training',NULL,'2024-11-30','Wipro DevOps','Won','DevOps Setup and Training',1),(13,5,NULL,520000.00,'Complete HRMS implementation',NULL,'2025-07-15','HCL HRMS','Open','Human Resource Management',1),(14,6,'2024-12-10',920000.00,'Vehicle tracking and management',NULL,'2024-12-15','Mahindra Fleet','Won','Fleet Management System',1),(15,7,NULL,1100000.00,'Mobile banking feature additions',NULL,'2025-08-30','HDFC Mobile Banking','Open','Banking App Enhancement',1),(16,8,'2025-01-10',280000.00,'NLP chatbot for customer service',NULL,'2025-01-15','ICICI Chatbot','Won','AI Customer Support Bot',1),(17,1,NULL,750000.00,'Real-time solar energy monitoring',NULL,'2025-09-01','Adani Solar Monitor','Open','Solar Farm Monitoring',1),(18,2,'2025-02-25',430000.00,'Digital claims processing system',NULL,'2025-02-28','Bajaj Insurance Portal','Won','Insurance Claims Portal',1),(19,3,'2024-09-05',195000.00,'Customer service booking app',NULL,'2024-09-01','Maruti Service App','Lost','Vehicle Service Tracker',1),(20,4,NULL,680000.00,'IoT home automation platform',NULL,'2025-10-15','Godrej Smart Home','Open','Smart Home Automation',1),(21,5,'2025-01-28',340000.00,'iOS/Android enterprise app',NULL,'2025-01-31','TechCorp Mobile','Won','Enterprise Mobile App',1),(22,6,NULL,560000.00,'Advanced analytics and reporting',NULL,'2025-11-01','Xform Analytics','Open','Business Analytics Tool',1),(23,7,'2025-02-12',290000.00,'AutoCAD cloud integration',NULL,'2025-02-14','BuildRight CAD','Won','CAD Integration Solution',1),(24,8,NULL,820000.00,'Video consultation platform',NULL,'2025-12-01','MedPlus Telemedicine','Open','Telemedicine Platform',1),(25,501,NULL,NULL,NULL,NULL,NULL,'Priya Sharma','Open','Sales Lead',1);
/*!40000 ALTER TABLE `xformsales_opportunity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformsales_organization`
--

DROP TABLE IF EXISTS `xformsales_organization`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformsales_organization` (
  `organization_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `organization_address` varchar(255) DEFAULT NULL,
  `organization_background` text DEFAULT NULL,
  `organization_city` varchar(255) DEFAULT NULL,
  `organization_country` varchar(255) DEFAULT NULL,
  `organization_email` varchar(255) DEFAULT NULL,
  `organization_moblie_no` varchar(255) DEFAULT NULL,
  `organization_name` varchar(255) DEFAULT NULL,
  `organization_occasion` varchar(255) DEFAULT NULL,
  `organization_occasion_date` date DEFAULT NULL,
  `organization_postcode` varchar(255) DEFAULT NULL,
  `organization_state` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`organization_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformsales_organization`
--

LOCK TABLES `xformsales_organization` WRITE;
/*!40000 ALTER TABLE `xformsales_organization` DISABLE KEYS */;
INSERT INTO `xformsales_organization` VALUES (1,'301 Nariman Point','Leading IT solutions provider','Mumbai','India','info@techcorp.in','9823456789','TechCorp Solutions','Anniversary','2021-06-15','400021','Maharashtra'),(2,'806 Crown Plaza, Sector 10','Software development company','Pune','India','contact@xform.in','9834567890','Xform Technologies','Founded','2015-03-01','411001','Maharashtra'),(3,'12 Connaught Place','Construction and real estate','Delhi','India','info@buildright.in','9845678901','BuildRight Infra','Anniversary','2019-09-20','110001','Delhi'),(4,'45 Banjara Hills','Healthcare services','Hyderabad','India','care@medplus.in','9856789012','MedPlus Healthcare','Founded','2010-11-12','500034','Telangana'),(5,'78 Gangapur Road','Agricultural products and services','Nashik','India','info@greenfield.in','9867890123','GreenField Agro','Conference','2022-01-15','422013','Maharashtra'),(6,'23 MG Road','Financial consulting','Bangalore','India','contact@financefirst.in','9878901234','FinanceFirst Pvt Ltd','Anniversary','2018-04-10','560001','Karnataka'),(7,'56 Anna Salai','Automobile dealership','Chennai','India','sales@autodrive.in','9889012345','AutoDrive Motors','Launch','2020-07-22','600002','Tamil Nadu'),(8,'34 Civil Lines','Education and training','Jaipur','India','admin@edusmart.in','9890123456','EduSmart Institute','Batch Start','2023-01-05','302006','Rajasthan');
/*!40000 ALTER TABLE `xformsales_organization` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformsales_permission`
--

DROP TABLE IF EXISTS `xformsales_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformsales_permission` (
  `permission_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `grp_perm` varchar(255) DEFAULT NULL,
  `role_id_fk` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`permission_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformsales_permission`
--

LOCK TABLES `xformsales_permission` WRITE;
/*!40000 ALTER TABLE `xformsales_permission` DISABLE KEYS */;
INSERT INTO `xformsales_permission` VALUES (1,'dashboard.view',1);
/*!40000 ALTER TABLE `xformsales_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformsales_project`
--

DROP TABLE IF EXISTS `xformsales_project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformsales_project` (
  `project_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `forecast_completed_date` date DEFAULT NULL,
  `opp_id_fk` bigint(20) DEFAULT NULL,
  `organisation_name` varchar(255) DEFAULT NULL,
  `project_code` varchar(255) DEFAULT NULL,
  `project_completed_date` date DEFAULT NULL,
  `project_description` text DEFAULT NULL,
  `project_doc` varchar(255) DEFAULT NULL,
  `project_name` varchar(255) DEFAULT NULL,
  `project_start_date` date DEFAULT NULL,
  `project_status` varchar(255) DEFAULT NULL,
  `user_id_fk` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`project_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformsales_project`
--

LOCK TABLES `xformsales_project` WRITE;
/*!40000 ALTER TABLE `xformsales_project` DISABLE KEYS */;
INSERT INTO `xformsales_project` VALUES (1,'2024-12-31',1,'TechCorp Solutions','PRJ-001',NULL,'Full ERP implementation for TechCorp',NULL,'ERP System Implementation','2024-01-15','In Progress',1),(2,'2024-07-31',2,'Xform Technologies','PRJ-002','2024-07-10','Upgrade legacy CRM to modern platform',NULL,'CRM Platform Upgrade','2024-02-01','Completed',1),(3,'2025-06-30',3,'BuildRight Infra','PRJ-003',NULL,'Web portal for construction management',NULL,'Construction Portal','2024-03-01','In Progress',1),(4,'2024-05-31',4,'MedPlus Healthcare','PRJ-004','2024-05-18','Integrate Electronic Health Records',NULL,'EHR Integration','2024-01-10','Completed',1),(5,'2025-03-31',7,'AutoDrive Motors','PRJ-005',NULL,'Mobile application development',NULL,'Mobile Dev App','2024-04-01','In Progress',1),(6,'2025-09-30',8,'EduSmart Institute','PRJ-006',NULL,'Learning Management System build',NULL,'LMS Development','2025-01-01','Not Started',1),(7,'2024-04-30',9,'Reliance Industries','PRJ-007','2024-04-12','IoT sensors for factory monitoring',NULL,'IoT Factory Monitoring','2023-10-01','Completed',1),(8,'2025-03-31',10,'Tata Consultancy','PRJ-008',NULL,'AWS cloud infrastructure migration',NULL,'Cloud Migration','2024-06-01','On Hold',1),(9,'2024-12-31',12,'Wipro Technologies','PRJ-009','2024-11-25','CI/CD and DevOps transformation',NULL,'DevOps Pipeline','2024-08-01','Completed',1),(10,'2024-12-31',14,'Mahindra Group','PRJ-010','2024-12-10','Vehicle fleet tracking system',NULL,'Fleet Management','2024-05-01','Completed',1),(11,'2025-04-30',16,'ICICI Bank','PRJ-011',NULL,'NLP chatbot for customer service',NULL,'AI Chatbot','2024-11-01','In Progress',1),(12,'2025-06-30',18,'Bajaj Auto','PRJ-012',NULL,'Digital insurance claims platform',NULL,'Insurance Portal','2024-12-01','In Progress',1),(13,'2025-11-30',6,'FinanceFirst Pvt Ltd','PRJ-013',NULL,'Business intelligence dashboard',NULL,'Analytics Dashboard','2025-02-01','Not Started',1),(14,'2025-12-31',24,'MedPlus Healthcare','PRJ-014',NULL,'Video consultation platform',NULL,'Telemedicine App','2025-03-01','Not Started',1),(15,'2025-10-31',17,'Adani Enterprises','PRJ-015',NULL,'Real-time solar energy tracking',NULL,'Solar Monitoring','2025-01-15','In Progress',1);
/*!40000 ALTER TABLE `xformsales_project` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformsales_role`
--

DROP TABLE IF EXISTS `xformsales_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformsales_role` (
  `role_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformsales_role`
--

LOCK TABLES `xformsales_role` WRITE;
/*!40000 ALTER TABLE `xformsales_role` DISABLE KEYS */;
INSERT INTO `xformsales_role` VALUES (1,'ADMIN'),(2,'Sales Manager'),(3,'Sales Executive'),(4,'Lead Qualifier'),(5,'Account Manager'),(6,'Support Executive');
/*!40000 ALTER TABLE `xformsales_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformsales_task`
--

DROP TABLE IF EXISTS `xformsales_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformsales_task` (
  `task_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `task_assign` varchar(255) DEFAULT NULL,
  `task_assigned_member` bigint(20) DEFAULT NULL,
  `task_assigned_team` bigint(20) DEFAULT NULL,
  `task_assigned_to` bigint(20) DEFAULT NULL,
  `task_completed_date` date DEFAULT NULL,
  `task_description` text DEFAULT NULL,
  `task_doc` varchar(255) DEFAULT NULL,
  `task_due_date` date DEFAULT NULL,
  `task_name` varchar(255) DEFAULT NULL,
  `task_percentage_completed` int(11) DEFAULT NULL,
  `task_priority` varchar(255) DEFAULT NULL,
  `task_related_to` varchar(255) DEFAULT NULL,
  `task_start_date` date DEFAULT NULL,
  `user_id_fk` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`task_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformsales_task`
--

LOCK TABLES `xformsales_task` WRITE;
/*!40000 ALTER TABLE `xformsales_task` DISABLE KEYS */;
INSERT INTO `xformsales_task` VALUES (1,'Rahul Sharma',NULL,NULL,NULL,NULL,'Configure servers and development tools',NULL,'2024-01-22','Setup ERP Development Environment',100,'High','ERP System Implementation','2024-01-15',1),(2,'Amit Verma',NULL,NULL,NULL,NULL,'Design normalized database schema',NULL,'2024-02-15','Database Design for ERP',100,'High','ERP System Implementation','2024-01-23',1),(3,'Priya Patel',NULL,NULL,NULL,NULL,'Develop React frontend components',NULL,'2024-04-30','Frontend Development - Phase 1',80,'Medium','ERP System Implementation','2024-02-16',1),(4,'Sneha Joshi',NULL,NULL,NULL,NULL,'Test all REST API endpoints',NULL,'2024-05-31','API Integration Testing',60,'High','CRM Platform Upgrade','2024-05-01',1),(5,'Karan Singh',NULL,NULL,NULL,NULL,'Conduct UAT with client stakeholders',NULL,'2024-06-30','User Acceptance Testing',40,'Medium','CRM Platform Upgrade','2024-06-01',1),(6,'Deepika Nair',NULL,NULL,NULL,NULL,'Prepare for production deployment',NULL,'2024-07-10','Go-Live Preparation',90,'Critical','CRM Platform Upgrade','2024-07-01',1),(7,'Vikram Mehta',NULL,NULL,NULL,NULL,'Gather all business requirements',NULL,'2024-03-15','Requirement Gathering',100,'Low','Construction Portal','2024-03-01',1),(8,'Anjali Desai',NULL,NULL,NULL,NULL,'Design system architecture',NULL,'2024-04-15','Architecture Design',100,'Medium','Construction Portal','2024-03-16',1),(9,'Rohan Gupta',NULL,NULL,NULL,NULL,'Develop Node.js backend APIs',NULL,'2024-09-30','Backend API Development',45,'High','EHR Integration','2024-04-16',1),(10,'Meena Reddy',NULL,NULL,NULL,NULL,'Design mobile app wireframes',NULL,'2024-05-31','Mobile App Design',100,'Medium','Mobile Dev App','2024-05-01',1),(11,'Rahul Sharma',NULL,NULL,NULL,NULL,'Conduct security vulnerability assessment',NULL,'2024-07-15','Security Audit',70,'Critical','EHR Integration','2024-06-15',1),(12,'Amit Verma',NULL,NULL,NULL,NULL,'Optimize database queries and caching',NULL,'2024-08-31','Performance Optimization',55,'High','IoT Factory Monitoring','2024-08-01',1),(13,'Priya Patel',NULL,NULL,NULL,NULL,'Write user and admin manuals',NULL,'2024-09-30','Training Documentation',0,'Low','Fleet Management','2024-09-01',1),(14,'Karan Singh',NULL,NULL,NULL,NULL,'Deploy application to production environment',NULL,'2024-11-25','Deployment to Production',100,'Critical','DevOps Pipeline','2024-11-15',1),(15,'Sneha Joshi',NULL,NULL,NULL,NULL,'Onboard client users to new system',NULL,'2025-01-31','Client Onboarding',30,'Medium','AI Chatbot','2025-01-01',1);
/*!40000 ALTER TABLE `xformsales_task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformsales_team`
--

DROP TABLE IF EXISTS `xformsales_team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformsales_team` (
  `team_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `team_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`team_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformsales_team`
--

LOCK TABLES `xformsales_team` WRITE;
/*!40000 ALTER TABLE `xformsales_team` DISABLE KEYS */;
INSERT INTO `xformsales_team` VALUES (1,'Sales Alpha'),(2,'Sales Beta'),(3,'Enterprise Team'),(4,'SMB Team'),(5,'Support Team');
/*!40000 ALTER TABLE `xformsales_team` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformsales_team_member`
--

DROP TABLE IF EXISTS `xformsales_team_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformsales_team_member` (
  `team_member_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `team_member_email` varchar(255) DEFAULT NULL,
  `team_member_mobile` varchar(255) DEFAULT NULL,
  `team_member_name` varchar(255) DEFAULT NULL,
  `team_member_role` bigint(20) DEFAULT NULL,
  `user_id_fk` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`team_member_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformsales_team_member`
--

LOCK TABLES `xformsales_team_member` WRITE;
/*!40000 ALTER TABLE `xformsales_team_member` DISABLE KEYS */;
INSERT INTO `xformsales_team_member` VALUES (1,'rahul.sharma@xform.in','9811111111','Rahul Sharma',2,1),(2,'priya.patel@xform.in','9822222222','Priya Patel',3,1),(3,'amit.verma@xform.in','9833333333','Amit Verma',2,1),(4,'sneha.joshi@xform.in','9844444444','Sneha Joshi',4,1),(5,'karan.singh@xform.in','9855555555','Karan Singh',3,1),(6,'deepika.nair@xform.in','9866666666','Deepika Nair',2,1),(7,'vikram.mehta@xform.in','9877777777','Vikram Mehta',5,1),(8,'anjali.desai@xform.in','9888888888','Anjali Desai',4,1),(9,'rohan.gupta@xform.in','9899999999','Rohan Gupta',2,1),(10,'meena.reddy@xform.in','9810101010','Meena Reddy',3,1);
/*!40000 ALTER TABLE `xformsales_team_member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xformsales_user`
--

DROP TABLE IF EXISTS `xformsales_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xformsales_user` (
  `userid` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_date` date DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(255) NOT NULL,
  `user_email` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  PRIMARY KEY (`userid`),
  UNIQUE KEY `UK_83fx8kr48oqan2ebwq2ewj0af` (`user_email`),
  UNIQUE KEY `UK_qbsr4bpnfl74wgck58hnelpec` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xformsales_user`
--

LOCK TABLES `xformsales_user` WRITE;
/*!40000 ALTER TABLE `xformsales_user` DISABLE KEYS */;
INSERT INTO `xformsales_user` VALUES (1,'2026-04-03','$2y$05$5TlY6VsuouSOkBQraVIGQ.1gFFwiP52/zNCQoYk/2.H0dj.wiFqdG','ADMIN','admin@crm.local','admin');
/*!40000 ALTER TABLE `xformsales_user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-08 12:32:04
