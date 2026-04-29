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
