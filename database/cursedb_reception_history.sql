-- MySQL dump 10.13  Distrib 5.7.22, for Win64 (x86_64)
--
-- Host: localhost    Database: cursedb
-- ------------------------------------------------------
-- Server version	5.7.22-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `reception_history`
--

DROP TABLE IF EXISTS `reception_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reception_history` (
  `id_reception_history` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `patient_id` smallint(3) unsigned NOT NULL,
  `doctor_id` smallint(3) unsigned NOT NULL,
  `Purpose` varchar(255) DEFAULT NULL,
  `Reception_date` date NOT NULL,
  PRIMARY KEY (`id_reception_history`),
  KEY `fk_history_doctors_idx` (`doctor_id`),
  KEY `fk_history_patients_idx` (`patient_id`),
  KEY `reception_purpose_inx` (`Purpose`(5)),
  CONSTRAINT `fk_history_doctors` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`id_doctors`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_history_patients` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id_patients`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reception_history`
--

LOCK TABLES `reception_history` WRITE;
/*!40000 ALTER TABLE `reception_history` DISABLE KEYS */;
INSERT INTO `reception_history` VALUES (39,11,11,'Консультация','2018-01-26'),(40,11,12,'Консультация','2018-02-03'),(41,13,12,'Забрать снимок','2018-02-01'),(42,12,12,'Забрать снимок','2018-01-30'),(43,13,14,'Осмотр','2018-02-04'),(44,13,11,'Осмотр','2018-02-04'),(45,11,12,'Осмотр','2018-02-15'),(47,13,14,'Сдача курсового проекта','2018-01-25');
/*!40000 ALTER TABLE `reception_history` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `afterAddingReceptionHistory`
AFTER INSERT ON `cursedb`.`reception_history`
FOR EACH ROW BEGIN
  SET @cnt = (SELECT `Reception_count` FROM `cursedb`.`doctors` WHERE `id_doctors` = NEW.`doctor_id`) + 1;
  UPDATE `cursedb`.`doctors` 
  SET `Reception_count` = @cnt
  WHERE `id_doctors` = NEW.`doctor_id`;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `cursedb`.`reception_history_AFTER_UPDATE` AFTER UPDATE ON `reception_history` FOR EACH ROW
BEGIN
  IF (OLD.`doctor_id` != NEW.`doctor_id`) THEN
      SET @cnt1 = (SELECT `Reception_count` FROM `cursedb`.`doctors` WHERE `id_doctors` = OLD.`doctor_id`) - 1;
	  UPDATE `cursedb`.`doctors` 
      SET `Reception_count` = @cnt1
      WHERE `id_doctors` = OLD.`doctor_id`;
      
      SET @cnt2 = (SELECT `Reception_count` FROM `cursedb`.`doctors` WHERE `id_doctors` = NEW.`doctor_id`) + 1;
	  UPDATE `cursedb`.`doctors` 
      SET `Reception_count` = @cnt2
      WHERE `id_doctors` = NEW.`doctor_id`;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `cursedb`.`reception_history_AFTER_DELETE` AFTER DELETE ON `reception_history` FOR EACH ROW
BEGIN
  DECLARE id SMALLINT(3);
  
  DECLARE done INT DEFAULT FALSE;
  DECLARE curse CURSOR FOR SELECT `id_doctors` FROM `doctors` ORDER BY `id_doctors` DESC;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  
  OPEN curse;
  readLoop: LOOP
    FETCH curse INTO id;
    IF done THEN
      LEAVE readLoop;
	END IF;
    
    IF (id = OLD.`doctor_id`) THEN
      SET @newCount = (SELECT `Reception_count` FROM `cursedb`.`doctors` WHERE `id_doctors` = id) - 1;
      UPDATE `cursedb`.`doctors` 
      SET `Reception_count` = @newCount
      WHERE `id_doctors` = id;
	END IF;
  END LOOP;
  
  CLOSE curse;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-06-10 16:16:01
