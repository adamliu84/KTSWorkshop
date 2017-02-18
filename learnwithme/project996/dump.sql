DROP TABLE IF EXISTS `Readings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Readings` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `displayValue` int(11) NOT NULL,
  `previousValue` int(11) NOT NULL,
  `accumulator` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
