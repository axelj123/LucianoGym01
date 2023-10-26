-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: lucianogym
-- ------------------------------------------------------
-- Server version	8.0.33

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
-- Table structure for table `categorias`
--

DROP TABLE IF EXISTS `categorias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categorias` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(50) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categorias`
--

LOCK TABLES `categorias` WRITE;
/*!40000 ALTER TABLE `categorias` DISABLE KEYS */;
INSERT INTO `categorias` VALUES (1,'Bebidas'),(2,'Suplementos');
/*!40000 ALTER TABLE `categorias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detalleventa`
--

DROP TABLE IF EXISTS `detalleventa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detalleventa` (
  `Id_detalleVenta` int NOT NULL AUTO_INCREMENT,
  `VentaID` int NOT NULL,
  `ProductoID` int DEFAULT NULL,
  `CantidadVenta` int DEFAULT NULL,
  `PrecioUnitario` decimal(10,2) DEFAULT NULL,
  `SubTotal` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`Id_detalleVenta`),
  KEY `FK__DetalleVe__Venta__24285DB4` (`VentaID`),
  CONSTRAINT `detalleventa_ibfk_1` FOREIGN KEY (`VentaID`) REFERENCES `venta` (`ID_Venta`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalleventa`
--

LOCK TABLES `detalleventa` WRITE;
/*!40000 ALTER TABLE `detalleventa` DISABLE KEYS */;
INSERT INTO `detalleventa` VALUES (59,42,17,2,14.00,28.00),(60,49,27,2,25.00,50.00),(61,50,28,2,5.00,50.00),(62,51,28,2,5.00,10.00),(63,52,19,2,5.00,10.00);
/*!40000 ALTER TABLE `detalleventa` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `tr_DescuentoStock` AFTER INSERT ON `detalleventa` FOR EACH ROW BEGIN
    -- Actualizar StockPorUnidad
    UPDATE StockPorUnidad su
    SET su.CantidadEnStock = su.CantidadEnStock - NEW.CantidadVenta
    WHERE su.ProductoID = NEW.ProductoID;

    -- Actualizar StockPorPorcion
    UPDATE StockPorPorcion sp
    SET sp.ScoopsPorPote = sp.ScoopsPorPote - NEW.CantidadVenta
    WHERE sp.ProductoID = NEW.ProductoID;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `historialsocio`
--

DROP TABLE IF EXISTS `historialsocio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `historialsocio` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `ClienteID` int DEFAULT NULL,
  `PrecioMembresia` decimal(10,2) DEFAULT NULL,
  `MontoPagado` decimal(10,2) DEFAULT NULL,
  `FechaInicio` date DEFAULT NULL,
  `FechaFin` date DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_ClienteHistorial` (`ClienteID`),
  CONSTRAINT `historialsocio_ibfk_1` FOREIGN KEY (`ClienteID`) REFERENCES `usuarios` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=106 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `historialsocio`
--

LOCK TABLES `historialsocio` WRITE;
/*!40000 ALTER TABLE `historialsocio` DISABLE KEYS */;
INSERT INTO `historialsocio` VALUES (1,151,200.00,200.00,'2023-10-01','2023-10-05'),(98,151,200.00,200.00,'2023-10-19','2023-10-14'),(99,152,200.00,120.00,'2023-10-19','2023-11-26'),(100,153,200.00,24.00,'2023-10-19','2023-12-27'),(101,154,120.00,120.00,'2023-10-19','2024-01-01'),(102,155,300.00,32.00,'2023-10-31','2024-01-03'),(103,151,200.00,200.00,'2023-10-01','2023-10-07'),(104,151,200.00,200.00,'2023-10-03','2023-10-11'),(105,156,200.00,120.00,'2023-10-23','2023-10-31');
/*!40000 ALTER TABLE `historialsocio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `login`
--

DROP TABLE IF EXISTS `login`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `login` (
  `usuario` varchar(255) DEFAULT NULL,
  `contraseÃ±a` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `login`
--

LOCK TABLES `login` WRITE;
/*!40000 ALTER TABLE `login` DISABLE KEYS */;
INSERT INTO `login` VALUES ('hola','123');
/*!40000 ALTER TABLE `login` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pagomembresias`
--

DROP TABLE IF EXISTS `pagomembresias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pagomembresias` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `ClienteID` int NOT NULL,
  `PrecioMembresia` decimal(10,2) DEFAULT NULL,
  `MontoPagado` decimal(10,2) DEFAULT NULL,
  `MontoRestante` decimal(10,2) DEFAULT NULL,
  `FechaInicio` date DEFAULT NULL,
  `FechaFin` date DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_ClientePago` (`ClienteID`),
  CONSTRAINT `pagomembresias_ibfk_1` FOREIGN KEY (`ClienteID`) REFERENCES `usuarios` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=321 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pagomembresias`
--

LOCK TABLES `pagomembresias` WRITE;
/*!40000 ALTER TABLE `pagomembresias` DISABLE KEYS */;
INSERT INTO `pagomembresias` VALUES (314,152,200.00,120.00,80.00,'2023-10-19','2023-11-26'),(316,153,200.00,24.00,176.00,'2023-10-19','2023-12-27'),(318,155,300.00,32.00,268.00,'2023-10-31','2024-01-03'),(320,156,200.00,120.00,80.00,'2023-10-23','2023-10-31');
/*!40000 ALTER TABLE `pagomembresias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productos`
--

DROP TABLE IF EXISTS `productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productos` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(255) NOT NULL,
  `Descripcion` longtext,
  `CategoriaID` int DEFAULT NULL,
  `Precio` decimal(10,2) NOT NULL,
  `ImagenProducto` longblob,
  PRIMARY KEY (`ID`),
  KEY `FK__Productos__Categ__3C34F16F` (`CategoriaID`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productos`
--

LOCK TABLES `productos` WRITE;
/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
INSERT INTO `productos` VALUES (19,'loolo','asdaads',1,5.00,_binary 'ÿ\Øÿ\à\0JFIF\0\0\0\0\0\0ÿ\Û\0C\0		\n\r\Z\Z $.\' \",#(7),01444\'9=82<.342ÿ\Û\0C			\r\r2!!22222222222222222222222222222222222222222222222222ÿÀ\0\0–\0Œ\"\0ÿ\Ä\0\0\0\0\0\0\0\0\0\0\0	\nÿ\Ä\0µ\0\0\0}\0!1AQa\"q2‘¡#B±ÁR\Ñğ$3br‚	\n\Z%&\'()*456789:CDEFGHIJSTUVWXYZcdefghijstuvwxyzƒ„…†‡ˆ‰Š’“”•–—˜™š¢£¤¥¦§¨©ª²³´µ¶·¸¹º\Â\Ã\Ä\Å\Æ\Ç\È\É\Ê\Ò\Ó\Ô\Õ\Ö\×\Ø\Ù\Ú\á\â\ã\ä\å\æ\ç\è\é\êñòóôõö÷øùúÿ\Ä\0\0\0\0\0\0\0\0	\nÿ\Ä\0µ\0\0w\0!1AQaq\"2B‘¡±Á	#3Rğbr\Ñ\n$4\á%ñ\Z&\'()*56789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz‚ƒ„…†‡ˆ‰Š’“”•–—˜™š¢£¤¥¦§¨©ª²³´µ¶·¸¹º\Â\Ã\Ä\Å\Æ\Ç\È\É\Ê\Ò\Ó\Ô\Õ\Ö\×\Ø\Ù\Ú\â\ã\ä\å\æ\ç\è\é\êòóôõö÷øùúÿ\Ú\0\0\0?\0÷\Z(¢¬AEPER\0¢£y\áŒ\âIQO¡8§£¤ŠYX2\Ô\Z`-HjöNÁRt-’0zu¤‹X±™K$\èTš@^¢¡\î\ŞSˆ\æFú5L=~”\0QE\0QEÀ(¢Š\0(¢Š\0(¢Š\0*®¥+C¦\\È‡±’¥Zª÷\Ğ«	\à%€t#+Ö“\ÌâºšF2–yf\Ç\0·S]Ÿ†\îõ·´AEÊ¡‰8\Çz©g\á{x¡\ß»<\Ã\î™d=\nÙ±Ó®\Ò/\Ş\Çn“Œ\Ø•#0\ïc\Í%~PQ™\İ\Ï?µq¦B×Š\Ò	?¾¹\ÛÁ\ã\ë[÷\Î,õ”†GU\Ìe³·\åüsM·\Ò-5°\Â@\æ$8ÚW\ßZ\0µ¡\Û\Ûy$\Ú‘“Ò³a›TMV\×Íš5œ‰™ÿ\0\n\é­ôK;xB$\'h\0¸šÆºÒ¯$\×m™#¶F$©cB`tß…™¢¨AES\0¢Š(\0¢Š(\0¢Š)\0µòv)\ëRš«üy8¤\ÆIWŠ´¥ˆ¨\â\ÚFw/\çV”¦8`i¨h{~\×\Ôe6\í+š~‹¤*6S/˜X\ç¦1[¤§¨¨™‘y,\0õ /€j”\Î\êû\Ôr:T¯<J~iP~4\ĞñI€%OÎ†\Ò\Üi7°\èd¯L7qRT^W—>A\á…KMQEPQ@Q@QH\nz¬—q$lU\Õ	W¥_;£=\Õ\É\êN\ç~µ\Ú\ëò¹\çø\ryXğ\ê\ë­–\í¢Š2~EN[ñ\Ïô¤\Æz-\Ä-1ÌŒ§¡\rkZ\Ş\â7Œlp\Ä+–Ò´,la¶I%)\àeºık~\ÃOĞ´‰$­¹q‡9¤Œ\\±ª÷¼¥X‹\ï\Z‚ó\îP#‘\Ö\ÇÌ¼ñ\\Ö°³›bb©U\İ\ÃcŠéµ“óŠ\å5i\Ü[0	#`òW§\ã\í\\¸‡­•?y\èt¾\Z¿ºyôÈŒ\ÎÑ˜A ¼s]\Õy÷…\Îû\İ101\í^ƒ]4´Š<üBı\ì­\Ü(¢Š\Ğ\Ä(¢Š\0(¢Š\0(¢Š@Q\Ö?\äsş\á¯\rÖ¼g}\áB\Ö\Ş\Ö(˜M’\Å\Ç#œW¹kò¹ÿ\0p\×Ì¿[f½¥¯¨ÿ\0Ù©1ƒâ¿‰7\Ú&µo¢\é6\æöTF&N\åº\0*¿ü-/hw\Öñ\ëşÁ)è«†#¹\'‹¾\ß\ë—\Ö\Ş \Ğ\îDZŒ1§\îÛ€\ÅyZM\â¥Ö|š?t¡\rÀ;V\ç\Êé“Œ˜¤÷ş\'\Üøvò\Ê\ÃI±\Ü\İF’—¦ Ö¹\Í[\â_´DŠ\ãZğôpZ4w2\í\Éô\Ö\Äùco‰ú;¡Œ°#¡¸®«\ã\Ø?ğˆX\çş¯û¦€4Æ«·¤\Ù\êP©X\îc õ¢³/\'\ro,hÇ³ôoc*/\n\çş=\Ú\ßúšÕ·\ÓmuC\äÜ¡a\ê¬kE\Ëc»^&ù\Ë\Úf\Öl™\ãTc*:)\Åw5\Åi6\Ég¯\Û[¡b±Ç´\ëÀ®Ö¶Š\Ç%Fœ\ÛAEU…QLŠ( Š(¤-cşA7?\î\Zù\×\Æ\Õ5­j\Â[V™!ÿ\0X\Ê~\ï\ÍŞ¾Š\Õÿ\0\äqş\á¯%›K©\âBTß ?\ß\Î?“~”˜x®\Ï\ÇúÅ®¡\á\ë¹\æ²Ø€Ú¤¤\rÃ¨\ÆpA®Z\Ñ|u\ãıCO:“\r¤p’¢]À(¯Eğö\ç\Õ-t¶$®˜\\º\î\Ï=?4i\Ójğ‡i@\Å€\É\Ş$;±¼v¤=NS\âW‚õyµ}+SÒ½Ô–p\Ç\Å\æ`ËpqYş$ümiŸ¨\èq\År‡Ü¤wçµ\ê¶F\ç]\ÕYôûi\âûXIO\Ì\Å\è1Gˆ\ín ¾€X\È\"PÅ½À\Î\Ğ	Ü¾ø\Èÿ\0õP\Z½~\ÇM“FğîŸ§H\ë#ÁR\ËĞŸjGK\ä¿óc;ƒ`a‰\éôªS\Ï V¸\ÅLgjØ‚¿(\Î1\Ï=«[B·¹†ø¸*U‡\Ü,x¬\á>f\ìoZƒ¥kõ6l·E£\ä<~\×\×#fOü%Qğ~\éşU\×\Z\Ô\ç\n(¢˜QLŠ( Š(¤-_şAW\îšó«ˆÜ©’5c\ïF?\ÂŞµèº·ü‚®?İ®WB³·{	®dGi t\éQ7mK‰,–÷\ÜEBY€óæ§¶2ù\Ù\ÅkEŒ»ƒõ«vñ\æ5“\ËU-Ù©²]OjIO/ÓMfê¢­&E&’\Ó]\É4–ù¯†w¿µYe»’K>\Ú=±œ©\Ç\İ\ãµoJ¾–\é\ä\í\Â\ãro¸j\ÓRD6Ö‡\r¬\é–k~\×+n‚b\Ù/R\éı T\Z\æ­b·R\Ãö˜Äÿ\0¬±¶«øsV‚ò\ã{\"¤¤+6;€zŠ#n…\Í\ÔÓœİ³\Çü%I\ÏğŸ\å]mrVŸò4§û§ùW[Z…Q@‚Š(¦EPERª3¦\\`ó¶¼òFò\Ç0ÇŸ-˜±u¯L™Y\á`¼7QYñ\\g!\ÎH\ãµK·P0´»¹e6NNXVœh$\ÜZÄ±Ÿ­j¤Š;øU„@\íùTò\ÄweEHv\Úy!†Kn54¯•\ê*\ÃL1\Ğ~U\Ê\è*’¶s\ÌüE£[-\ì÷0Ä­<\Ç.²¯nÕ•„—Wñ\r…ó^\Íµ9Àş.s\é^©;\ÆAŠ}ÊŠ ÷qÀrGüT¨%±´\ëJj\Ò*Yÿ\0\ÈĞ™ô?Êº\Ú\Â\Ó\'–òÿ\0\Í\nqõ8\ë[µ¡ˆQE(¢Š`QE\0QE\0{§´„\Ío\"\Æ\ç\ïÀ5 N+&\ìKz\å+Lz\Ò`g>¢ö\Îf=ˆ\ÔÉ«¡\è\Ãşú<Z\\iü¬-„`}ÁùTŒ¤Ú²\ã\ïû\èUy5…\ÇUÿ\0¾…k\Ç**\'\Óc?\Â(°\İÖ´@\àû\èS4¨f\×\'!eDO\Íódş¶.4x\Ü”\n\Ïş\Ê{I¼\Ø£\ëL¾\Î\Ò++u†!€:\ç\ëS\Ö~—y%\Ì;fÀ™zûÖ…1QLŠ( Š( Š( \ælDÆ©ı¢4vµR\Äs«ºjutşé¢Š\0q\Ú{TM·ÒŠ(¤÷q§2j(¦Šw\Æ\ÆQ@A±o  “‚}«BŠ(\0¢Š(\0¢Š)ÿ\Ù'),(26,'ssasa','dassadsad',2,12.00,_binary 'ÿ\Øÿ\à\0JFIF\0\0\0\0\0\0ÿ\Û\0C\0		\n\r\Z\Z $.\' \",#(7),01444\'9=82<.342ÿ\Û\0C			\r\r2!!22222222222222222222222222222222222222222222222222ÿÀ\0\0–\0Œ\"\0ÿ\Ä\0\0\0\0\0\0\0\0\0\0\0	\nÿ\Ä\0µ\0\0\0}\0!1AQa\"q2‘¡#B±ÁR\Ñğ$3br‚	\n\Z%&\'()*456789:CDEFGHIJSTUVWXYZcdefghijstuvwxyzƒ„…†‡ˆ‰Š’“”•–—˜™š¢£¤¥¦§¨©ª²³´µ¶·¸¹º\Â\Ã\Ä\Å\Æ\Ç\È\É\Ê\Ò\Ó\Ô\Õ\Ö\×\Ø\Ù\Ú\á\â\ã\ä\å\æ\ç\è\é\êñòóôõö÷øùúÿ\Ä\0\0\0\0\0\0\0\0	\nÿ\Ä\0µ\0\0w\0!1AQaq\"2B‘¡±Á	#3Rğbr\Ñ\n$4\á%ñ\Z&\'()*56789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz‚ƒ„…†‡ˆ‰Š’“”•–—˜™š¢£¤¥¦§¨©ª²³´µ¶·¸¹º\Â\Ã\Ä\Å\Æ\Ç\È\É\Ê\Ò\Ó\Ô\Õ\Ö\×\Ø\Ù\Ú\â\ã\ä\å\æ\ç\è\é\êòóôõö÷øùúÿ\Ú\0\0\0?\0ôBô¬iÚ…§\Ú#ó\0	0Nzc±9\â¬Xø“G\Ô@û5ü,Ç€¬v¶~‡½¾x\Ş\×<\Õ½6^sQ°©·\r¹\íQ\ä2†SFA­!¢)6Ô¤SqWrH\Ê\ÓH©qHE4\ÄBE&Ú™“÷İ´\î\"=´m©6Ñ¶‹\Ú6Ô»h\ÛL‚\Ò\í©vÔ‘\Â_¾>µšŠ»b\ä\ì„\ÓR—VŠF+5–9\î¥l\å€\'j©º‡‰of\èv[\éğ±†5;v\Ó\É\çŞ™*\"jp}§W\Æ\Î&yT²ƒ1BH^y÷ÿ\0\"=÷Šõ‰\Ş\ëBÓƒ‡lª7\0~÷#¿µxø‰)Tm•\Ôg–xB\ÎI#%uY®-P\àò~J\éõo\0O%\ë\ÚZ\Í²3Q$O-p‹#¸<v\Ï…\àuoôr¤\ì7–œz|õ\ëU’²\È\ŞcI³aüx\Ç\áYW’‹[¢\éõ\êUğ\Â^hó\Ú]Æ%µÄ‘©õQ\Ğ¦qWu)4{=Amfºû<\ÛC¡‘r¸9ğ®?\Ã\Z\Ï\Ø/E_:ö\àù›øP¼œûWG¯\éR\ë–\×\Ö[eIbBr\êj\İJ‘IÅ—F)\ÉÆ¦…\æ\Ò\îú§I€cŸ¨ª\ï±1\Æ\É\Ïj•\Ò\Égwu<bo0I+G´`‚pF2FA+\é\Ó\é]]Ó•\Ò]\Ô\îeµbw!F	®˜â¤—½©\Ë<<[÷N{\ã5È¼\"ğÜ¯sªy\ÒiÑ–\ÜX«Hóœı}«^\Û\Å\ZmÕ­¼‹&\Ï:B‘«7y\ê:WM<Df¯±\Ï:2‹±°Ã…úZuªƒw\á•\Ş21œó\\óx\ËJeO.dbbi1»øW9\éô5/‡üWi«kVğCc\ÍL¶9`=­­®§.d\ìtW\ru‹­\Õ!ƒ\ìO<&ÿ\0›·Lb›\Í\ì‡t\àı+\Z‹©üCO,\ítt»‚p»\Ã8Şª\\\Û\ê\ÚŞ³™\ÛÅ²\Î)\ÚB„\Éşòzu®*uıœ¹º3¥Î¬À•“\ÃwPÇ€¹\æ°\ïl5oGqb’¬÷LsF\åÙ,\ì¯<\0?J\æ\Ş\ÛQ[ˆ\îµ\r@¬Œ \0£\Ğ\×Tq.kİ‰ƒ¢¢ı\æz×„\én%TWHş\\¸\É•\Äx·\Ä\Ò\Ø\êÚ“\Û/mpğ ‚¥ûÿ\0»Ö´ü#y-‡†õ‡\Óf3Ê“yˆì¥‰\ŞÀ~ƒ¥s%º|K·Œ¡$gaü~^z¹\ÜkŠsnnMş§Lb”RE¿h/\ât—T¼»£”³M\ÌU\âCÁ\ì9\Åt>*\Õ\å\Ğ58­-\ï\Ú\Ş3¸\0rW°ÿ\0f³¼¨ªX]%\Ñ	\ç¼aoğ!<g8\ãúUÿ\0E\î­§\rş\0 üM\\\×6z‡„ü9ª\Ùgkvh\ê\ÚDu`F\ĞI\'®Fk\ÔV+i]e–4ó\Ç\á\Ïn;\×\áC\Ä[\Ú\ÇqhZ,(\åõFq\àö®\éB÷¹÷­^»™\í±\äúXj\n\Z\à\Ü^)s•¯1²¿Õ´¹wXj\Ä\Ï)J#^³\áôx\í\å¯\Ëss’FHúÕ…ci\à\íCW¼Y¤öş\\~Q\ÜÉ†ù·õ\ãÓ­RJÚ…õ3aø\âû	ä®b»X€—+g\Ô`şµ\Û\è^=Ô¼Qd\Şu¬vb	<©<’vÈ­œ`ô\ÆÁŞ³bğ‰©\Ïtm5|.nW\ÎT\Ó\É…h\é“Ã¶\Ïp³%\Å\æ\Õ!p~D•N~´šI\ì\Òøª\Ã…}§\Êùñ£G§™\Ïù\í\\“s¦®›`óG+›YH€\0’r§\0Ÿ¥t^)[»\Û6O´\İ\ÏÄŒF2T²±\é\îŞµ…\áı;U	mÆ‹q,‹.XNS\åô\ã¥]8¨üM}\Ä\ÎWøKq˜ ²·òac3@T©“\0n,	\ë\Û$Ö·†\ÊÁ\â=9bq%\ÌHÄ±\ÈÁ\ÏOP*\çö¯*[¯\Ø¨$e\È\î}\ÅjXøWW\Ó5;+\É\íÈ;„f\Ã;A\É\àdô¯Ÿ+÷¿òS>Y\İiø’)¹_\éñnù^\Î\é\\\àˆ\ä:Ó´Û²x¨‘¶›Pprw\×ğ«–šd÷:\í•\Ü2!¶‰.„¥˜‚C(¯»~”ı6\ËL—\Äv\Ñù\ÒOv¶şI1ñx\Ş\á²~ñù¸\ÇW4µZ\Æ\×\\\Ç?\ã\í&\×ô¨\àº(­mûÃ€7\à±8÷ük\n[d\İûéƒ·ñc“ıMw\ÚÅ–‘®\ë\Ú]\Êñ\ßD\ÄG†*J‘‡ƒV\Ãş\Ò\ìÌ·7%#&O\Ğ`~b®5#¥kü\Å8I\É\ëo‘\Îx?ÈF\×R\İ\ÊmH\Ë;7NOøU\r{L\Ô\îõ™.mm$h\Z\Şû2¥DK¸\äñ\Æ}ë­´\Õ4\ÍGA\Ô\í\ì´Ç¶Š|\È\Â1óœc\éú\ÔwW#6\Ö\Öú}œ&\ÄY…2¹+µwõ=±\éK\Ú\Ê\í­.\ÍY\'©\Éø_\íW\Ò\Ü\Çx\Æ0r…\nªwmÁ\íK¨\ÌV\ëlW\×`\r¸\Ç\'´\ß6§q}t\Ò2\Ç+B®ÀF¸_>ı©5€·X\â7p½F¦rÉ³\Ù\ÂF›ŠRkúeøT6öö³i¬9 ‰e1²†W¾0?:\ïWƒÁSü\ë\Í<;ã¦·\ĞMmòÚºF6[œcœmüjy~\"uœË¼’C¸v\ÉùH÷­¹\ã\Üñ\ì\Ì\íoö\ÄF?\Ò\îó\ï\Ågi÷>¹\Ön\Í\Ì\"+Sb ª\ë‡ù·}\ÏÂ¯\èS· ›»­\Ø\îp*…­\á)5›™nôÀ-^4X”Û‡\î8¹´^„½ÎŠ\ÃFğm\ã\Ü\æù¡a&÷\á…s÷Áş\"kR=\"\ÇL\Ò\àk-Dİ¤·ÁJyŠş^Õ”£š\Ë\Ó\ßÀr\Ësö´òÁ—	şµpv®\îù­Kx<?Œ-¢Ldg\ÔL¥˜\í\\H#ûŞ¢¡”~\æ+¹<¯°\ßÁö‚\Ã\Ë(qß‚qÚ´ô(¼fo¯aŠ\êÁn	O1\È\à®ÓŒ|¾ƒÒ±.!MöY\ìÑ–`\Ó,œ&9\'®_Ö¬\Ø\èile’o\Ş6\Ø\É<m“ U\çœg\éëŠ¶ï¶¤é½¬tº‡ˆ\áòoe\Ô`FAœ\ÈÛ\r£8\Èü«N\Õõ>¾\Ögy£1µŒ\0F3÷pô\ëƒ\\[\ë‘lšUUR¢y[30Ï¯ğOO\Ì\Ó\ãšK{`#‘€r°z’\Ã4¾®\ãn~¦”\ïUI\Ãh«³©ñ5ı¤\Ú5ÅŒS\"\Ê\Åe1E\ÑH|q\×ñ©ô_A(RJ\ÄI\ïˆ…yüR„BÇ³ÿ\0‘+­ğ¾¤“xª(‘ \î\'ş™‘]\Ş\Æ0¥%\Ö\Ìó]YÎ¬mµ\Ñ¼\ï\ÄIš<3F9\á‘Aı	©tmrk-$û\ŞJ\íR~`Iu9#¯\İ$qY^,¸X~)˜Ì¡KK\ÚN3ò­W\Ñ\æß ov÷\ÄôU?Ò¹j¸ºJ\Ë[/\Ôë ¤\ë%7¥ÿ\0Tz\Z²\êzv³\ZD¢+A4[K}ò\çù\Ö|±x’\æ\ÚÀ\é\×0Cd\Ğ\íù±’y\Ü:\ĞQ\á–\Ç\Ä{qÄ²7#\Õü+–ÔµN\ê\Ê\Ø\Ú]˜­ PŠü\ä·@=˜W$¥\Êt5f\Ñ\Ï\ÜOy\Zµ34…1!\Ú9\äõÀ¨˜\Ì\Ç(\Ê =?\Ï»™\îœH®†S\Æ\ãŸ\\ô¨ş\ßy\Ü;Œ~U\Æ\ê;š©´PÑ¤2øGR‘˜—Pÿ\0|\ÉU–ş5Œ\ínTg÷¥ğó\Â<«½\Ó3Gö˜v\í8;‚ËÖ±/~\ÎX\Ë\ê²|²01S\Î+¥\Ä\Ì\ë´ıqa[v=¾[HK¤²\ÍS\"·†\í®E¼N„r\Z\É\Òş\Íg¨XIv\Ï\äo‘¥Á\ãh\\\ÖÖ…¢]x-*I\á¸ÁR\í\Æöln<ú‘úÕ¨·»i~…\â	\Ãö…\Ôô´’S#`ı_¦­«]SÃ·v±®‰j-\æ]J?m\Èo3\Ëz-bi\Ş1\Ñôº‹û\İ<\Ò\n2I=2˜­$ñ^¬%¥¢Ù¥Œ‘\ê0ÍÉ—\ï…8\Ç#=:\ãšÑ§±(\Ãhm-®^{\Â\Z{‚\á\\#¶r{\ÕıZ[3®]<¯$e(°G\Æp>c\Ğ{T¥\Ø-\Ò[¬¿cy$F$gv[\ÓŠn²²j\æ\å¢diYĞ‘Á\ïÁ\ï[\á’\çz˜Ö—¹ª&şÌº7“nm£™Š sĞŒı=ª\Õõ“[X\Ã7\Úü\â2›6‚§®y­\ÍE\n\Ü\é\à·\î?0Qñ´xø } uúõ«X\Õs”nE8\ÉE’4ömqCdÆ¤<‹¼>\à‚NvœØ«¶˜‹\â<|\Üñğ=\Óÿ\0¯Kä—Š²\ÆÁ ˆ˜\åp{T\êş\"Úœ¹ \àtûª+*RnRO³*i%w(ø\ĞF¿c\İ¹-e»ŒcAYz\\\'‡%E‹`i\ç,ˆ\ç\È\ëúV\Ä¹OˆQIJ\ê#…˜–\ÇsşSOŠa¤_\Ç r\Ü\ÎğC~\è}:ŸÊ§NT5~fu>Àƒ\Ä!v\n\à?8\Ìg¡Ç½f\Éá‹­KA²¾‚ù¢rdD\ÊIgí£œqŒRøvø\Ø\rJi\Õ\n²\Úd$œ‚S?‰®\ÄQµÎ§,\å^hÄ¾w\ï\à\È\É\Î;\×-W\ÚFñŒ¹ns·\étfHV0c	9ÁÒ­\Å\áˆJo¥–[‚>fğ£\ØqZúEŞŸk\æşH‘|\×’Ûƒ)Á\í\ïZ2\êztµ\ÒBLş\éX\ÌR¡\nm\êM^t½\Ôs6Z\rŒ~\Ô`¹‰\î\á}¯!88~\â²\ÂZ{Ï¼¡ë¥?Æ¶mõ)%ğ…\äñ\Ê~[¸Ğ…û­\Ï\êkµ;—`Š\ìrqŒğ=\ëÏœ\ê»k\Ğ\İW•ôK\î_©©i\ÑÌŠF\Ì\Èn<Qi¤\Û\Ø\ŞEwh\\B\ë\"{2ÃŒúŠ¦XÀ\Îö$~•f;·\îrƒÕ‡O\ëRDş\'÷Uj-¾\åşE\Ï\èö\ït5\ËH·M\Õ\È\ÇÊ‡¤\Õ{\Í\Ü\êúµ´¯n!¼¶*z‚„7N{zTštÈ·¿¹‘”LùtcÇ¡Áü+jdTfIbi¿ˆ\0C€=\Ç^•\Õo\ïıœ¾\Ö\Æj\êk¡uô\èY6™gRWi`\ä’==EC\â\íD—\æWÀ¯•÷\í\é\íV1¾\â\Î\Í\ê\íŸÒ¨x\Îhµ#3\ÚK“%9\Û  cZô°©s˜\â\ä:­Y\n\\\éd÷\ÔWz‘T|R»44#\\/ocZº\êmş\Ç]B#ú\Õo\ZÅ·\Ã\àöûB\è/UIû\Ğù‘Q{²\Zy–¶¤A³Å–|\àRs·\Ç\ÚqÀ6\İ:JÑ´A&Ÿft„À›c\í÷GZ\Ì\Ô—\ã­/…ı…\é\ÕzQGø’ôaS\à_\"¯Ä´oøN-¶c-o9\Ç;š ¶Œ4\Z\Ä~b\r³Î¤’võ\éVş)ZEu\â¸F| P\Ø)rA\éP\éñ\Û&¡¨\á@\İ)Q“\ÌÎ¿\Z›ûˆv÷™CÍM/]T.U­\ì™[n>X\ëõ5¾ö3ZG$\Ñ\'^$aş´C¦ı£G¿v€-¹´‰33œ¹!^\Ø¼ıœ1Á÷®j‰7©\ÓMµ#m.\ÒY\Î\Æt#şš\ëš|‚\èFò\\\İd Q‡^ƒ§j²\í\ï˜O?ıj¾š\Ä;caÒ¡%†õ\Üó;iR/\r\İi÷SC²\ÜFñ\Ädv¨l\ä.Oq\ÅQ‹K¼™÷¬.±œ\í%\nï–¡5˜íŠ­´qÀŠNJ{ŸÒ5\rJş4h\í.e]\Ø\É \Û9>\ŞõÁR¤§eNõdÁ[v[M1\Ê\âk¨3\È/»§°\â¤kkT»]J\åFJFƒ§_ğª\ÇG\Õ\îcd°Û¡ş\Øz8\ç\ëZ6şIœ›‰g<|¬\ÛW\è?Æ¦4+Kwb­\äUş\ÕÓ­\ÈT„\Ü\n¬Ÿ61\Ğ\ã\Ğz\Õ\ëmGY¼¼ŠX\à”®\ì¶õ6úsø\ÖÅ¦•cf›btP	ú¦®\Ç¦pµ¬0qRR“»BS,q¯\ï\ç‰.\ãŸ\Ç?Ê¬Ç­\Ş ò­\Ì÷²\á\áº\Ã!\ì#ğ\ÅS&Àc–õüin_y\Ò,q°r\Ï\ã]v¶·*÷\Ò\Åõ¼\Ñ\ïV\Ú;»«\îY#K—/l\Ì1ƒ»€¹ôù{\â¬xºK¹ôÅ°’\Ú7¸b\'F·”8‘\0o˜½üÀõ¬9µw\0Š;e1L ŸÀğüi\Ö\×ZŞ‘uúu\ÒKµ8·š0ñ\ã\0\ê¼tÆ´…všo¡œ\è&º^±\\h¶¡[v\Ø\Õ\\)\ÎO¡\ÇJ\Å\Ö\Æ\Ï\é§\å\à@~^œ0«6$ğ\îµ:¦±hz¡ù~\ÓíN$\ÇÑ±øÕ»\ïê­ª[_‹å¾J\áÊª \ä}\Ş×Š\é£8ó¹7½\Îz°—*F?\Åeÿ\0Šš\Ç©{M¹ı¦ÿ\0\Z­¡[\ÊúµûF™SnÄş\Ùo\êk¡ø…¡_k\Zöšl£\r¶\"Û…AœƒŸ\Äğ9\â \Ô5\rÂ³]<²\ïo&Y’\Ê;nPv\àƒ\'©©sJ	•ó6N^\æ\ãFX \"\ÆkU`\ç†\Ü_< ık+y1m\ÏZ¶·«—í…¤.»V\Ú\è™1\ÆI\àt\ÇJz«‚“Û‘X7}MöV#š1ÿ\0‡\éTù*mNq ù:«\æ\î9Œn21PYe£Z[\ä\ÛF¤äŒŸ\Ì\äÖ ¶^­\×\ÔóNR®>”õl‚xÇ½>T‰¸›\0\\}M78<Ò—¦˜	nœQb‘f27gV­¥…g_9I<óTbpõ«j\08&*G—ˆ\Õ|²:Á¬+\ï\'÷VÀ¼ŒI`\ç\'ŸB{{T\ÖW\æİ¼·Ï–Oıó[a\0ƒ{Š— š\"„hlÿ\0°§§\ãI65´‚h‰‘W§¨­Œ¨VvuDQ–f8\0U	uFùzl{‰\ë4ƒô\ãR\åb’¹\\\Ãl±‹›\ÈcŒ0À¹gú\ëLÓµ›½2&‹D0\Ú@•0.Œ}:ü£ı\Ü~4öÒ–e&\æW’br_uD¶“\Ùò‰\"=Àşu*\í\Üo–\Ö-\ë¾!½\Öm\ím,Zö\Æÿ\0\Ìfša(©ƒÂ·C×üd\àŠÎ¶\Òm4˜Ü®é®¦;¤–c½\Øú’ji¥6Z3µXı\Şß•Q–\ëÌ¹gbrFıU¦û™\Ú\Û—Z–•d™¾\ìcó=ª€œçœ“µr\åü»8\á<3ü\íVJ3n6I¸1bZÏ‰cU*ò²2’0+C8|õV\î\ÏÎœº²®@\ÏÖ„600ó“R©\İÓŸZ„*3õ§†=)±$)![®i2I\Å\0ri¬\ç<q‘RZ$^>ñ«‘Ë¹xû\İ\ë<y©£qŒ:P†\Ël\İÉ«º~¤!\")\î‰\àŸ\á?\áYR4‡¡\àTjvO\áLGc<b{wˆ“±ñœw\Í$q$H(•§jb5Xf8C÷Xöÿ\0\ëV\Îk&µÂ¤V\éQš º¼\"\ì\Ç\ÎÁÀğ :œ—H6·–Ş£§\å\\ü\ÖsZ¾$LƒüCkª,A{ŠiP\Ã±¦7b<Û•LqŞŸ¨H%¹v\'À­¡†\Íf!´¨\é\îkœ2zú\Õ!2ñ\'ÿ\0Z”,Àcƒïš‰‘w`ju\Î8?1S•\Å)m¼\n(¦Á\'š‘T6(¢‘@ÍŒ\âš³sEiX´\ã£bø$÷¢Š\0U\ÏqÒ¶´»ö,¶\Î2\İ>\ÔQCúµ\ÛD‚ò\Ç-\í\éYªã¡¢Š•°à¿–Ó§Ì\Ôÿ\0JÛa-ºÌ \á†@4QIªJB\ÇrXÿ\0ŸÆ²‹`Eq\í™\ïO\ê0\rS%Ÿÿ\Ù'),(27,'ssss','adassdadsa',2,25.00,_binary 'ÿ\Øÿ\à\0JFIF\0\0\0\0\0\0ÿ\Û\0C\0		\n\r\Z\Z $.\' \",#(7),01444\'9=82<.342ÿ\Û\0C			\r\r2!!22222222222222222222222222222222222222222222222222ÿÀ\0\0–\0Œ\"\0ÿ\Ä\0\0\0\0\0\0\0\0\0\0\0	\nÿ\Ä\0µ\0\0\0}\0!1AQa\"q2‘¡#B±ÁR\Ñğ$3br‚	\n\Z%&\'()*456789:CDEFGHIJSTUVWXYZcdefghijstuvwxyzƒ„…†‡ˆ‰Š’“”•–—˜™š¢£¤¥¦§¨©ª²³´µ¶·¸¹º\Â\Ã\Ä\Å\Æ\Ç\È\É\Ê\Ò\Ó\Ô\Õ\Ö\×\Ø\Ù\Ú\á\â\ã\ä\å\æ\ç\è\é\êñòóôõö÷øùúÿ\Ä\0\0\0\0\0\0\0\0	\nÿ\Ä\0µ\0\0w\0!1AQaq\"2B‘¡±Á	#3Rğbr\Ñ\n$4\á%ñ\Z&\'()*56789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz‚ƒ„…†‡ˆ‰Š’“”•–—˜™š¢£¤¥¦§¨©ª²³´µ¶·¸¹º\Â\Ã\Ä\Å\Æ\Ç\È\É\Ê\Ò\Ó\Ô\Õ\Ö\×\Ø\Ù\Ú\â\ã\ä\å\æ\ç\è\é\êòóôõö÷øùúÿ\Ú\0\0\0?\0\ä-|W\ä|¿\Ùñuˆ«²x®\rF\ÆkQ‚VÀù›#ù¨OƒuE”0òş ®pJ®\ŞÔŒ¬ÿ\0»L2õHa¹oÉ§:®V‘Q\çˆ4aò÷üÄ\Ø\ÅG=\Ôm|\Ïn›~R£\Åu^\ÕmÀú%°R\ß\áW¯|>u€\\\\.\è£ˆs\ë\ÍeS+\Z\Æ\rrO&A\ÜAú\×Ib\\Æ»‰5j/\nÙ¡Vü@ş•»§\èpK”E (\ç-\Ír¶¤\ì[²8}w[X‘­m¥ı\çG!sa\\“8cË \'\Õq^Ÿy\à% k‘)b…®jO]Á4›\Â\á\È\n\Î\Ê?*ë‚Œƒwgq)\Ñ«)¨‚£©dP™À;¸\Íu\Z§…/¬c#tS\ÂùOº±¦Ñ®-\â^%\'“\0\íµMf)ˆ!$\í\Çš€‡|„\Æ:¿•N!g	ÌŒ\'Ó¿Z†Vg\0<|\Øc5@1À3.ApOE<·ó¦\È\Ï :‘şM+H¤’o ©?vb\0»\î\É\ÎzS\ÒÛ‡_Œ\äŒS·¼¨\Î\Û0O@qø\âü4ŠW‘úS\Ø[q÷ü)Œr>0‰\È\'®}éœò\Ä}9§l1\ÊK†\0uy¦		õ?\0}i2O^•2\Â\ÎpªI=…h\Ã\á\ë—@ò2ÇŠz×—\Zr–\È\èm#”zTeOj\ß˜u¸SøRKÿ\0=Pş«\ØO°¹\â`sB\È\é\È8­³\á\ÙÁ$K=j6\Ğ\'ò\Ò?ÖŸ°Ÿ`\æFb^H§\ïô8©£0?|\ãßš¶t+\Í\æÂ£:\ÎıÀ\Æx\Ç\Ş4\Õ:‹a^,j\İ\Â\ì<ø¢‘{†A\Í@ö\Ú{ò’HƒvV\â§:\ç¤÷\Õ\'ö%\èşÿ\0¾ª’ªº\ÔYq\á½6|\à\×tcšÌ›ÀöOŸ,\Â\Ùôr+ªm\"øtşú¨\ÛL¿À§ş*Ó¨º•w8K¯‡\ç“\Z8\ì°jÈ¸ğ-\Ât$¼„W¨:ü!\è\ãüi­k¨ ûŒ?\à`Õ©Ë³/™\ä\à\ë\Ğ«E\Çm\ÄúVl\Ú\rô\'\rñ\é\Ïò¯g•núØÿ\0y¬ùİ\Ş<ûej½­·+<i­¦O\án=E5L¨0¹\ĞW­\Éad\ßòÉ—ı\Ö«6‘fNpÁ¦ª¡Yö=¾K{l,QªÕ»šY\'¯ZBp9\ëÖ«\É&76	Ò­+h2]\ë’2¹y¤. •ô\ëU¡e¸rp:\çœ\Ó\Ú°~Eõ<U°\Î>\\\çj2¹\éŠM‰-…©4© n§¹Á¦;‘2Aù\Ğü\æ¤g*;õ]n\"4®£\Ì9_¥r]¾ß­g§ó¨\Ìk\ßv}5\"¶\å\r\Ğç¡ .1\ãltıjV§Oz´\ï€NGZ›pl\0OÖ\\¨Û€#óª\îOC\Éú\Õ\Ù9\è8õ¨š?˜q\ÛÖ\ÜÆ»V\Ú~S\\¶¢¤·Ê»‰‚\àâ¹F\Ø\èGZ—`L\Â‘wk¾F»aÀ¯S³Ñ´”µ@,¡a¬»\æk\Í.\â\"\Ëx\ë\é\Z%ß¤[¹9%y¤£\ì6Ù¬\ä\ãŞ˜p=©\åòqN\á€\é\ïT„Æ¦;šF\ÏZq™¨\Ø“\Ï<i^H\ÍÁ!²€7ƒ¸{Ğ²C\ä\nªzei\ì\È	\0’@\è	5S\ì÷g\ß;sœqùRno‘-\ä\İ*+Uw0¨š\â¡d`Prÿ\0Z¡¹\Òb¹™^e\Ü\äœ7p1P}\ì\å\Êù›»(\ä\Üû\Ğ;\Z\É4AWh‚›%\Ãmı\ÜL\ì}8şuF8$v&?•”wUÄ\Ğ\0û÷É A\ZM¼İ·ğù\æ¤)·8õ\æ«\Ï?•·˜ıy\ÆıjS’\\\ä\ã\å-@…aF;TAŠ‘\ÇcRc°{Tnx#¥\0R¸m\ç‘X÷é‘x5«.\ëšÏºF\ØÀö4˜\ÌÄŒK\Æy­o\ßy:J\Ä\ç\æF+Y‘|’\â©\Ü\ÎöwR\"\çk\ãñ¤U®z†\Ü\00}\éG#¸&š	b{gÚœ\Î#ë¹« Q¸0a¹zb©\Í®À.S‘\ÉÁö#¥]8¯~*1\"¶v¸\ÆqÖ‘Û¹\n\Ù>˜\ÅX\Ê\àı)¬\Ê	$Œ*,Y\n$\\ún pr6*ŸÎ«±ŠiL;ŠºÀ\ãùT\Ù ;ŸZkH« —~:dfÈ£šM­”f%°8\Ğõ\ê|gq>)¤«ƒ\Ï\áJ§\åmÇ­$*ÁU”zŒ\ÔOnŸ0=q\Ôú\Ô\Ì>l\äô¨˜\à;ÿ\0Z\0%‹vÌ=\ÍDIÀ\É\Å+1€\ÎTÿ\0JL8\àœwªW \á=GJº\Ç\n\İù÷ªwL\Î0~´˜Ñ™³\çÈ©¤°K®\Ã\'¨ú•5z<\ZW*\ÇVOö¨n$RcF~y9?\ÎiÛ±· ıj±–R%%W\Ñp\Ùı?úõ¡…Â¬Œg=ò3U7BI\èI\0jwm§<\Õv{ \ß(\çŠJ«Ù€(Ê²6,s\Çÿ\0ª£WH\æ/,pqÁÿ\09¢g¸Ú \0[i\Î\Ò8=ºş4\Åk¢£ğ~ğùp~œ\çÿ\0\×@Õ¶†lò=G5V\âH$”–WİœgÓ½[FrÊ®­ÂŒ·š®\ÒH’°‚¥\Ü4\Û \Ú”¸\'\Üÿ\0œR-]¢2Kós\É÷*X\ä.š,\\\İ3©Í³\âSş{P2o’$û\Ç€	\ÅV¹\"&wA\Ç\Íÿ\0×§\É\n‚mrxı\0N\ä[¤¾N[‘—‘ùfˆ#o,\'r®zz\Ò\rÏ·e\È Š<\Æó\n­º„#±*!,#hXp\Êz¨\éÚ\ÂWóN#Ÿğ@\èOù\ÍC6à©¹·`œõ¨Œ\ÖñO„…³·x+ßŸş½\"\Ş,\ÅPğ7\09ÿ\0?\ÓÖ\É?‘©¸ëŠŠ@Á˜úR\èqøT”\Úg„’~c´UX\íü¸V=\Ì\0|½=©.d·yc‚@¤°\İ÷±\Ó\ãJ|¹{‚c8s\Ålf6\áO•Ÿ0©†aŞ¡ı\à2\Ü++\ÛJLu¦\\ß¬%¢pÅ—\'<R\Û\Ëo \Û\å¿S€O~ış´†I:a² aÁ`2:c±N\âˆ!’tRe<:ò}*Ü²\Ç’,?A»ø²j›\ÜÁ\'\Òü\Ø\ä…œ\à{\Ğ˜\'Şˆ‹*ƒ\î\ãÖ‰-\\\Ê^9\ÄYÁ\ã¾=y¦\Åmµ\ãv$`ù\çùTŒaK‚\Í+oÀR u Q2+bUrOrúÿ\0\äT€\Î\ã\ç\Ú¨#³‹\n\É R\ßtm\è¥:[yØ“…»q\é@\ÍÂ¹dl¦ydqÚ^VdÜ£nŞ ÷¦T\Ä\ê\Òô9\ì1Ò †\Ï\È\Ù\å\Ü¹\é\Î?\06Y.cf+°\È8\Ï~Ÿ¥W73ùc|MGAüª\Ü\è\îÒ€\Ã\ãˆ¬ö†\áQJ\É\É\Æ~c\ëR\Æ8;\Ë!ó­¶8=j„³Î„~\à¸\Î*Ë­\Şü¬¸b¿QšIg„Œó\ÎH\â»\Î#¦qQ¬‹´dÎ™‹¥\Ú$\É\Ô¨\ç\éR\Æv¨%\Æ€qÚœB‚A\ã=(h¹\ãwÔŠ\Äl·\Ó©™ª2—;8\ã§jhÂ€ /õ9\nUT3\íQ8ˆÜ¤@\Èü¨\ÚB\åSv:÷¦¬²ÿ\0«^F>´ğ£nFÓšD µhŠ ‰DjU¾NW\æ<~µ\ĞE9r\áòGM\Üq\íÒq¸ü£84Í¸L\à\äû\Ğ	Ğ…À\à‘\Æ	õ¦=©w/\çÈ œ;ş\\Ô§–\rù\Ò\Ã\æ\ëH\n’XÄ‚g8\'zÿ\0,–ò\Çl±C9R6q\ÛÒ¬e–1ó0ü)’JC–\çÚ€)Kmr\Ó1KªNG\ÌOoJ­uk;F6\Ü*‘×Ö´\Õ\È\Üq\î*\'9\ï-!™Mk;\'–ny+\ÊGÒ¡6—­+b|!\ÇÊ¬G\ÔV› \Ş9SL\Ú7ÛšC!ean¡ò_\ëùUm¬G\"®Í“!Fx\ïT\Ş3»úÔ°Gvx\Ü~jR ª©\Ï\åLŞ»@\Ü}\é\âU\İ÷\ëb,\È\Ú0\\á±\ÜT6@\Ìj\à#“¸R?@»”\Ğm\ÅT\à\â€	c€84É†\Î\Ôx\'j\â9\0’«õ¡‡Aƒø\ZRƒhÊŠk˜p}z\Ğ0\Ş8n­\0œ1ùºú\ÓAù›†ü\é(ò\İ\è[>Z\à·n\ÕŸœ|\Í\ÓÒ¤.0[¯¥D\îŸxôô¤\Ë|\Çñb#û\ËR+`±\Ü:÷ °òÌ½:Pl\Ù*C/Zˆ€]¾\é\â¦~«\È<\Ô-÷\ÏÊ½)© ùN{\Ôe9û¢¦`0\Ãbõ¨?\à¥”\Â9y\äR³gš(ªDV£ò©0¿\İQM\ÅhÑ“Îª<(G\ãE\Â\ä,„S\n»\Û4QSp¸Â®3óş”˜}¸\Ş?*(¥r†±óÁ\Å0´€\ç\ÓÖŠ(¹VDm3©9“Q5\×Ë·ST5®C\ã\ä\éLgRs°t¢ŠD´WySŸ”\ÔÇ¿\çE˜ÿ\Ù'),(28,'Botella de agua','Botella de agua Loa 120 ml',2,5.00,_binary 'ÿ\Øÿ\à\0JFIF\0\0\0\0\0\0ÿ\Û\0C\0		\n\r\Z\Z $.\' \",#(7),01444\'9=82<.342ÿ\Û\0C			\r\r2!!22222222222222222222222222222222222222222222222222ÿÀ\0\0–\0Œ\"\0ÿ\Ä\0\0\0\0\0\0\0\0\0\0\0	\nÿ\Ä\0µ\0\0\0}\0!1AQa\"q2‘¡#B±ÁR\Ñğ$3br‚	\n\Z%&\'()*456789:CDEFGHIJSTUVWXYZcdefghijstuvwxyzƒ„…†‡ˆ‰Š’“”•–—˜™š¢£¤¥¦§¨©ª²³´µ¶·¸¹º\Â\Ã\Ä\Å\Æ\Ç\È\É\Ê\Ò\Ó\Ô\Õ\Ö\×\Ø\Ù\Ú\á\â\ã\ä\å\æ\ç\è\é\êñòóôõö÷øùúÿ\Ä\0\0\0\0\0\0\0\0	\nÿ\Ä\0µ\0\0w\0!1AQaq\"2B‘¡±Á	#3Rğbr\Ñ\n$4\á%ñ\Z&\'()*56789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz‚ƒ„…†‡ˆ‰Š’“”•–—˜™š¢£¤¥¦§¨©ª²³´µ¶·¸¹º\Â\Ã\Ä\Å\Æ\Ç\È\É\Ê\Ò\Ó\Ô\Õ\Ö\×\Ø\Ù\Ú\â\ã\ä\å\æ\ç\è\é\êòóôõö÷øùúÿ\Ú\0\0\0?\0÷ú(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n+Qñf¥Ü½µ\Õ\ÖÙ“\ï BHü…3Lñ~«]‹[[‚g<…daŸÒ²ö\Ôù¹y•\Íş­[“Ÿ‘Û½\ê(¢µ0\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\nCKP\\–eòÕ¶“\Ôú\n\0\ãµC¨\êwWG%\Ï;b$g¸\ëM\Ğü-o¥\ë0\\42ƒÏ–@\é\ß5\Ù&È¢£ú\Ó$!Ö°ú½>n{ju¼mog\ì\ï¡nŠ†	¤äŠš·9Š( Š( Š( Š( Š( Š(  ˜|À\â¦5‹\âN}:š|\ÂI-\ì:{óU¹;\"*T8¹Kd_l\í<P€\í\äVT:\ÄÙyt\Éh¹b[\î\ÕÈ¯#{U•>pË¹A\à‘ô¥8¸_› R©\Z±R†Ì¿ù›ò©«7K¾7¦l¦ÀŒ_j\Ñœ&¦¹‘¬¢\â\ìÅ¢Š*\É\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\×\ãû\Óggl˜w–ÿ\0W×Œw®\È\×?\â})5T·ŠEfQ¸\áG~+l<”j©H\æ\Å\ÅÊ‹Š82\îd‚\Ş\"0rì…‘d+‘‘ü[G w$S£\Ô|D–M\ë\Ï¶˜)•A&LüÄœ˜\à(­\í3C·K	~\Ô/\Î\'u\Ü{¶¯mc°kkW(;™Ì¸öùJ¬UN{¸8N‚Œm¢Á÷/yõ\Ãp^~m\0\n\é\Ås\ŞI\Ã-»@L\ç\nŞ˜\×B:šó°ŠJŒy÷ÿ\0‚tbœ}³\å\ØZ(¢ºNp¢Š(\0¢Š(\0¢Š(\0¢Š(\0¢Š(\ÍE/jš¢›¨ ,V|„œ\Ñ\Z€˜\Ú\0ö§WšA\Ó4+\ÇJ*8\ëR\ĞEPEPEPEPEPEPPL~oÂ§ªóœ6h&$\'jD<sHÜ­Ó¡ Pô5-C\à\Ô\Ô\0QE\0QE\0QE\0QE\0QE\0QE\0UkŒ\îö«5\Ã\"€)œdÓ»w§\n3ùÓ•y/-¸\à\Ô\Ô\ÈÁ\ÏZ}\0QE\0QE\0QE\0QE\0QE\0QE\0u¢Š\0†Ku‘ƒƒ\íRµ:Š\0(¢Š\0(¢Š\0(¢Š\0(¢Š\0(¢Š\0(¢Š\0(¢Š\0(¢Š\0(¢Š\0(¢Š\0(¢Š\0(¢Š\0(¢Š\0ÿ\Ù'),(29,'Scoop Proteina polvo','Scoop Proteina polvo por scoop chocolate',2,6.00,_binary 'ÿ\Øÿ\à\0JFIF\0\0\0\0\0\0ÿ\Û\0C\0		\n\r\Z\Z $.\' \",#(7),01444\'9=82<.342ÿ\Û\0C			\r\r2!!22222222222222222222222222222222222222222222222222ÿÀ\0\0–\0Œ\"\0ÿ\Ä\0\0\0\0\0\0\0\0\0\0\0	\nÿ\Ä\0µ\0\0\0}\0!1AQa\"q2‘¡#B±ÁR\Ñğ$3br‚	\n\Z%&\'()*456789:CDEFGHIJSTUVWXYZcdefghijstuvwxyzƒ„…†‡ˆ‰Š’“”•–—˜™š¢£¤¥¦§¨©ª²³´µ¶·¸¹º\Â\Ã\Ä\Å\Æ\Ç\È\É\Ê\Ò\Ó\Ô\Õ\Ö\×\Ø\Ù\Ú\á\â\ã\ä\å\æ\ç\è\é\êñòóôõö÷øùúÿ\Ä\0\0\0\0\0\0\0\0	\nÿ\Ä\0µ\0\0w\0!1AQaq\"2B‘¡±Á	#3Rğbr\Ñ\n$4\á%ñ\Z&\'()*56789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz‚ƒ„…†‡ˆ‰Š’“”•–—˜™š¢£¤¥¦§¨©ª²³´µ¶·¸¹º\Â\Ã\Ä\Å\Æ\Ç\È\É\Ê\Ò\Ó\Ô\Õ\Ö\×\Ø\Ù\Ú\â\ã\ä\å\æ\ç\è\é\êòóôõö÷øùúÿ\Ú\0\0\0?\0÷ú(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(£4\0)	\Åc\ê^&\Ó4›•†ú(²–\r´°\ã±À85\Æxƒ\âL­o¤ˆx3°Á?AÚ°«ˆ§MjË9IÎ¥®\éšJn¼»H\Ïd\ê\Çğ\×>\ß´`øX®™½°y\\²\É<¦Ydg‘K1\É4\Êó§¨ß¸…‡Š\Ü÷M#\ÄZn´¤\Ù\\uûÑ°\Ã/\áZÀ\æ¾~°¾›N½Š\ê+$d;ûW¸iZ½«l²\ÛM‡h.ª\Ù*Oc]˜\\WµV–\æ5iòliQHik°\È(¢Š\0(¢Š\0(¢Š\0(¢Š\0))i\r\0y\'\Ä-2k}p\Ş\ì&\Ş\áG\Í\Ø0\àŠ\ä+Ù¼m2C\á{¢È®XPÃ¡\'­qğıµõœ—W‘\ïVm±Œ\ã\Ô×‡‹¦£WG¹\ÛA·£ğ¯Oÿ\0„[Hÿ\0ŸAÿ\0}\ZË½Ó´­6ö\è›’{¹+I§\ä+™Bû5c…\ÚH>Õ¹\àû\é,¼MfQˆI_\Ëq\ê\Ø\êM£\ß[ZCH\"\Ë*•\ã\"¸_C$ş!±DROœ¤ñ\ĞÖ®šqš\Òqh÷aKH:R\×Ğ£\Í\n(¢˜Q@Q@Q@%-\Èx\Ê\Ò]FÑ­€,L	¨d\ÇÃº:5\Ì\Ë´*¹\î©®¶{h\çÛ½A+\È5…so±ŠX\Ñ\Õ[€\Ã#Šòq4¹\'\Îú”fœl·9;\Ş\ëºĞ³\Ò\ì’h±$\Òİœ;GŸ\áA\ÈÏ©«/Á¢\Ü\İ\Û\Ãn\àB\ÑÜ‰X©hH9\nİ=\ë\Ã\Z¥¢øŸ\\Ô¯‰d™¶@Å³\æ\Ù€\Óx›O—UğÎ¡cú\é¡!«uñ\Åg\'4–Æ±\æqw9«j-b{³\É\rÌ³[1¶~jğ\Ç\İ}\Åt:f4‹©š2¸–bWû\Ø=\á\ÍRğF‡>•\á\ëe\Ôbm]Ü¶F¤ı\Üÿ\0J\îl­b‘VPXƒU\ì\ÕJ¶‡B\\¹ay\Z’cRz\âŸH8µ\ë­48Š(¦EPEPEPEP\ZÆ¿M—ö<\ÖÉ®?\Æş,°ğİ¢‰Ï¼¹ƒ\Ôú\n\ç\Ä\Òu!diJ|’¸š­Õ½ ™`\ìF€–v\ìõ^\ÃZŠ\âT¶kk¸ğ2}\ï\Ädg\ëT4hş$\Ùä·H	ò¤2ú\àúV½ö«a¥\Ú=\Õ\Í\ÂG\nõjòœ\Z|­jv©\'­\Ëÿ\0Î¶\íeºl×‹\\ü[WŒXX‰lÑ¾s\'Y·¥zî‡­Y\ëºdW¶”p2§ªC^†„¡\ïK©\Ï^¢–ˆÓ¥¢Š\í9‚Š( Š( Š( Š( ŠBqU¯o\"±²š\îvH]Ò€2<W\âh<9§y„º“ˆbõ>§Ú¼YºŸRinn\å2\Í#e™¿\Ï©¯\ëW\Zö­-\ì\í×ˆ×²/a\\õ\äÛ–½Z\0\ĞøyuŸ\ãû8‘d‡nPÿ\0…nüHÖ¼\ï\r\ØXFÍ‰n^F\rŒ\à\çô®\ÎV°\×l\î\ã;v\ÊCú\Z¹\âùš\ã\\X\äE\\z\Éşb©Erß©-¾kV-•e\Û\È\ï]\ï…üEu\á»\èå…‹@@\Äz0ÿ\0\Zâ¢ŒDGù5©k0‘6Ÿ¼*J>–\Ó5}WOŠò\Ù\Ã\Å \Èöö«µ\â\0ñ+\èúªYNÿ\0\èW,ƒ\Ñô5\íc¥\0QE\0QE\0QE\0QQ\Ë(‰w\ZM\Ø?ø‘\â\ÍW\ÃsØ­ƒ¢G2±bW\' û×jµR\Í\í/%ñ¹1Œ\ã\è+³øÂ«q¤i÷Ncœ®O¡ıjñúOTŸö²ùr‹şúoñ¨¾\Ùmÿ\0@ø\ï¦ÿ\0\Z£E0.«F\Æt\èx93Y‚{]CSS5ŒBI\Î\Ó&\æÏ·zÊ©m_Ê¼†O\îÈ­ú\Ğeâ‘‘Ô«ĞŒTC)uu{šõOE´\Ôô\átğƒt\Ü÷ük€#¬©Uö—ò4œ9@g#\Õô†oPğ\å…Ì¼\Èñ\r\Ä÷#Šñ=Ã·š\åÊ¤1•€\ŞL~\ê\êk\ÜlL\Z}„£\â@«øU9\Åhfi\ÑH \Ğ\ÒÕ€QE\0QE\0VuÔ»\äÀ\èµj\æO.#§YÕ…Yt\Z9‰Vşwƒ\'ls‘\È?<\Ğ×ˆ\×Ğ,·ûW…5(±’\Ğ1Q\Ïô¯ñN‹÷l(£ÒŒJ\ØA@8 ´`úQƒ@¿\á}N+é­´ö\Éof\ìF3]\Ğ\í\å2­Š;O\ÎKı\rs_\r­ü\Ô{\Ã\ÕaXÿ\0šô\Z\ã”T$ùz–\ä\Ş\ãQ4	\Zª \n£\0S¨¢ E\ëI7.\Ã\Ôt«U•˜\Ü0\íZHÁ”\Ğ\×M9\İXL}Q[)J^\ÕZù\Ú;9>ğRn\Ê\àU¸—Ì\ã\îEYÿ\0kŸ\'\åı)~\×?÷J\â•Û¹Eó‚0FG½@l­[XOı³[\ísÿ\0wô¥û\\ÿ\0\İı(W°\ÚÏ¬?÷\ìQöOùõ‡şıŠƒ\ísÿ\0wô£\ísÿ\0wô£P\'û\r§üú\Ãÿ\0~\Åa´ÿ\0ŸX\ïØ¨>\×?÷J>\×?÷Jzn(\"„H™\ëµ@©*‡\Ú\çş\ï\éG\Ú\çş\ï\éK^£/\ÑT>\×?÷J…µ9‘°ğq÷iX\rZ¹g\'2zt®sûY¸\àòp>^¿\çû}`ı¢1Kcj\át\î&u”Ue½…œ $’qøÕš\ì$)\ÍP±}&Á\è?*(¤°zÊƒ\Ğ~TQ@Á\è?*6AùQE\0 ü¨\Ø=\åE\0lƒò£`ô•P°zÊš`‰‰%\çÚŠ(>\Ïüó_Ê³Åõiÿ\0|\ÑE C9Ø¹úT”QTÿ\Ù');
/*!40000 ALTER TABLE `productos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stockporporcion`
--

DROP TABLE IF EXISTS `stockporporcion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stockporporcion` (
  `ProductoID` int NOT NULL,
  `CantidadEnStock` int NOT NULL,
  `ScoopsPorPote` int NOT NULL,
  PRIMARY KEY (`ProductoID`),
  CONSTRAINT `stockporporcion_ibfk_1` FOREIGN KEY (`ProductoID`) REFERENCES `productos` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stockporporcion`
--

LOCK TABLES `stockporporcion` WRITE;
/*!40000 ALTER TABLE `stockporporcion` DISABLE KEYS */;
INSERT INTO `stockporporcion` VALUES (19,2,43),(26,25,150),(29,2,40);
/*!40000 ALTER TABLE `stockporporcion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stockporunidad`
--

DROP TABLE IF EXISTS `stockporunidad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stockporunidad` (
  `ProductoID` int NOT NULL AUTO_INCREMENT,
  `CantidadEnStock` int NOT NULL,
  PRIMARY KEY (`ProductoID`),
  CONSTRAINT `stockporunidad_ibfk_1` FOREIGN KEY (`ProductoID`) REFERENCES `productos` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stockporunidad`
--

LOCK TABLES `stockporunidad` WRITE;
/*!40000 ALTER TABLE `stockporunidad` DISABLE KEYS */;
INSERT INTO `stockporunidad` VALUES (27,14),(28,28);
/*!40000 ALTER TABLE `stockporunidad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarioadmin`
--

DROP TABLE IF EXISTS `usuarioadmin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarioadmin` (
  `Id_Usuario` int NOT NULL,
  `Usuario` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `ContraseÃ±aHash` longblob,
  `Sal` longblob,
  PRIMARY KEY (`Id_Usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarioadmin`
--

LOCK TABLES `usuarioadmin` WRITE;
/*!40000 ALTER TABLE `usuarioadmin` DISABLE KEYS */;
INSERT INTO `usuarioadmin` VALUES (9,'usuario1',_binary 'y©\Äñ',_binary 'g—¿Š\0\0');
/*!40000 ALTER TABLE `usuarioadmin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `codigo` int NOT NULL AUTO_INCREMENT,
  `DNI` int DEFAULT NULL,
  `Nombres` varchar(100) DEFAULT NULL,
  `Apellidos` varchar(100) DEFAULT NULL,
  `Telefono` int DEFAULT NULL,
  `FechaNacimiento` date DEFAULT NULL,
  `Foto` longblob,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=157 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (151,44444444,'Juan','Lope',231232123,'1990-10-01',_binary 'ÿ\Øÿ\à\0JFIF\0\0\0\0\0\0ÿ\Û\0C\0		\n\r\Z\Z $.\' \",#(7),01444\'9=82<.342ÿ\Û\0C			\r\r2!!22222222222222222222222222222222222222222222222222ÿÀ\0\0\Ü\0\È\"\0ÿ\Ä\0\0\0\0\0\0\0\0\0\0\0	\nÿ\Ä\0µ\0\0\0}\0!1AQa\"q2‘¡#B±ÁR\Ñğ$3br‚	\n\Z%&\'()*456789:CDEFGHIJSTUVWXYZcdefghijstuvwxyzƒ„…†‡ˆ‰Š’“”•–—˜™š¢£¤¥¦§¨©ª²³´µ¶·¸¹º\Â\Ã\Ä\Å\Æ\Ç\È\É\Ê\Ò\Ó\Ô\Õ\Ö\×\Ø\Ù\Ú\á\â\ã\ä\å\æ\ç\è\é\êñòóôõö÷øùúÿ\Ä\0\0\0\0\0\0\0\0	\nÿ\Ä\0µ\0\0w\0!1AQaq\"2B‘¡±Á	#3Rğbr\Ñ\n$4\á%ñ\Z&\'()*56789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz‚ƒ„…†‡ˆ‰Š’“”•–—˜™š¢£¤¥¦§¨©ª²³´µ¶·¸¹º\Â\Ã\Ä\Å\Æ\Ç\È\É\Ê\Ò\Ó\Ô\Õ\Ö\×\Ø\Ù\Ú\â\ã\ä\å\æ\ç\è\é\êòóôõö÷øùúÿ\Ú\0\0\0?\0\ê(¤¥¯ ?>b\Ò\ÓiiZFû§\éKH\ßtı(B[•¨¢Š\Ü\éR\ÓiE!ER\ê))i)i(„:Š( AKI@¤!\ÔR\nZB\n(¢ER´´\ÑL\Ê[Jãª¡#ò¦\Ê+É«X\Å!G¸P\Êpp	©­¯­®\ÉJ¯QÒ¹}\Å5-v\Ö\Ú`L/ 2œ\ã9$\ÜV‹C‡Œç¶²lÛ¬ƒ<c¦{\àÿ\0*\çU›—)\Ó,5©ûC ¤oº~”P\ßtı+s“©V–’–º¥¤¢¤C¨ QC´´\ÚQH‘h¢¤·‹Î#õ<ı+*\Õ#N¤öJ\ï\ä]8J¤”#»Ğ³i`÷{©\Ø÷5%Æšb]Ñ±a\èkUT*…\0A=\r~k[‰ñ²\Ä{H;G¢²µ¼úŸwK‡ğ±£\É5ywóò9º*\Í\ì^Täü\êµ~‡ƒ\ÅCB£³_ğ\ë\äÏ†\Åá¥†­*R\İ1ii\Ğs‹EP ¢Š(ÚŠ\ïş<\çÿ\0®müªZl‰\æDñÿ\0yH¦\Ë3ôù\à¼ğTºMÚ1vW\æ•F\ïÛökK†K}v8fFIQ™YX`‚\à\Ót\é\å\Ñõ›k–…™­¥S¦py§\ï¬x¦\ãSòLQ³³\í=²0Ö¸!§cÑ«8Î•\Û\Õiò7¨oº~”‚†û§\é]§–U¥¤¥\Ğtˆî‘Œ»*RqLûU¿ü÷‹şû\Âxú\îF\Ôm\í·-\"ßRIÿ\0\n\æ#³¸–\Æ{ÔŒ›xGì¥³·ó\Úku¹]\ÚX>x©\\öttnFV \æ^\à©ıÅ¦\âcx¼\Ìz@şµ\è¤eÌ®rÖ¥\ì\ç\Ê´”´\ÌE«úJf\å›û«Ti\èÿ\0z_ şµ\ãgópËª5\Ù/½¤zy4T±\ĞO¿\ä›5h«6–¢\ä¶d	Œ\ÏrıTùì£†\é:¾0@\İ\éŸÎ¿.¬©ûT´õ]<·?Dub¥\Ë\ÔÁ\Õ\å\r\î+.µõ?õ?—ó¬Šı„\æ\å€iôoôg\Âñ$R\Æ]uKüŒ­O\Äzn‘:\Ãu+	XnÚ‹’½Qÿ\0„\ãDÿ\0“ß³\\~±m&­ã–²ó½\Å\Ò[«B\ä…™¬\è\×\Ú©.Ÿ¨\Âb#\È\ìÃ±¸5ïºš\Øå§€ƒ‚“¹\ëšn©i«Zı¢\ÒMé§#B*\åp?do6ş<ü¥Q±\ï\ÍwÕ¬]\Õ\Ï7IS¨\à‚Š(¦`6ŠAKL¶--%€¤“€9$\Ò´7\İ?Jš\Ş8\î?s\×Ö­}=»|±¶¼lfw‡\Â\Ôöm6úÛ¡\î`2N.ŸµMEt¿SV®\í|Ÿ™yCúUZö0¸ªXšJ¥7t\Î,V\Z¦\Z£§QY£\Ï|g›\Äöñ“€ñ\"“õc^\Ê~\èO¡\Ü\è\Ñ5\Ìv.\Æ\à³€\0II¯\Zñ›ù>&·”‚BÄõ\Ã\Zô»Ÿz$jK{K\×ß“›T\í¡>µÅŠSs÷Oo\à©.c\Í|©‰®R2J,N¤n\\W¡³R\Ì@P2I¯:ğ-®\Ê\ßô\î\Ùÿ\0¾–»Mm\Ê\é¬û\ÌúWl-;>3Z\Äÿ\0Ú¶?óğ¿­U²\'h\\\Õk—6ñO´F9P:“2\È\ïL½ğ†³§\Ù\Éwqo\Z\Ã\Ë2’;t°ú×¡›\Â\Î×³·¡¼y+CI|\\²ÿ\0ykJrúdN\Ü~G£o)†t	ı+<Êƒ\Å`\êS[µ§®\ëñ²¡Š„\Ş\ÉşN¦Y\Ç;ÀÜ¿‡_\ÓùQ±VÜ³g,v¨ö¥%«<LU˜À\Ò\Ü‘\Äc\Ï\êkò‹r\Óm­U\×\åşlı*÷–›3#T/½eÕ‹\é¼\Ù\È\ì¿Î«\×\é<=…–-\å¯ß·\à~}\â|dœvZ}\ßğO5şJ•§ı…!ÿ\0Ñ‹^\ßñ\Ãz>¹\á\éfÔ¦\ÒKTgŠñ‡ú¿c\ê§\å^=\ÄV_ãº¸mÃ¨G,ŠI?•]ñ\ïn¼_}\åD^.ı\Ì9\å\Ï÷›\ßÛµuÕ„¥Q4zxj‘>¶ğë‹»ü‹\Ï\âk\ĞkÏ¾ƒö›ó\Ûb3^ƒ]°\Øù\ìwñ˜QEG\ÊZAKTXV‹\ïÍ‡§\Øpó‘\nş=@kr¸_ˆ³¶\àñó¹Ö¢z#l49\ê\Å3£ğ¹ı¥£}’V\ÍÅ®\ç©^\Çú~\×t¯\nğÎ°\Ú&·\r\ÖO”N\ÉGªŸğ\ë^\ä³#@&\nİ‘\é_`œ+ªZOóÿ\0‚~‰”b×²t¦ş\ËşKS»H\Ìv\å€yy\ØU\n\ç/õ6º\Ö~\ÒÈıtuõ\ÙFa°ÊŸ]ß«>75Å¼V&U:l½MÃ‘k‚\'óL3Gnr=\rpº.&³5ºK²8-!\\÷À\ãŞ½Pœ}+\'\Ã:gön”»—\Î|\Ù=FzÀZ\ï5)#–\"P¦\ÕıøÃ‘hK+y¦i¤À/·°«\Z\ïüƒ\Çû\ãúÖP\Õ\ái´\ç2\ÊC`Q8\Ú\r#Sr—4‰¬\ìô¦³¤\Ğu\ÉÆ¥3ò±\ÇQ\ÇJ‹Tµ\Ó#\ÓghtMf	\0eœü‹\È\ë\ÅcÇ¯\ë0Ä‘G©İ¤hª‰˜\0@)³ëš½\Ü-ú…Ô±?+ß…y\Í\Üôxr\ÛôF\îÿ\0 ¸>‡ùš½Ut\èZca†’=3\ÍZ¯N*\ÑG–÷:\rMñ\ÂTp?Z³ª?•öŒ\Z\ÎĞ¤VRp+TúÜª\Éòœüª+ó|vi<?G%÷;6}\Ş\Ö^ªõQ…\Ò0³““E%-~Œ£Ê¹O‚o™\Ü\åµÿ\0\r^ü\İÁr!w\0Hr	f²¿\á]Oÿ\0A¿\ï\Ùÿ\0\Z\ï\è¤\à™´qu£T\Ì\è\è6’G\æù³J\Ùw\Æ\0­šJ(\ê@úšvH\Âr”\ä\å-\ÇQEF)h^§\èh]M®g\ÅŸ\\¹†x\îc‰\"i	\ïš\Ôoù“ş½\Ïó­	\èœzƒPõL¨NT\ä¥\Îÿ\0\á›ş‚ÿ\0÷\ËWN\'ºÒ¼.–\Ü$\Òå¬‰ÓŸn*\ÍQ\Õÿ\0\ã\Í?\ë§ô5\Ç8Æ¥”–\Úü\Ñ\İõª\Ëio§É˜µ\ÚFsı\Ñ\\b©wUIÀ®\ÑFJ\ê\Ãu9\ä--s\'ñ)\ÑV8-\Ñ^\êA»\æ\è‹\ëY^Õ¯u\rf\ì]\\<¡¡ß‚x0\İkgQsr›G	Q\Òu^\ÇsE%-Y\Êg\êšx»ƒtj\É\È\Çj±`\ë=”R¶\àñ\Üpj\Å68\Ö2\ÅF7\Ä{\Ôr¥+¡_K\Ü@’yo4jø\Î\ÒÀS’D‘w#+U9¯%ñ¸> ½i\ÃóX.ºö\Æ+KÁ:Œ¶ú\Ú\Ún>M\È ¯`Àd\Ófª\İ\Ø\í–\Ôù\Ó\és©ñu\ÕÍµ¥¹¶ºšØ´‡-›	éœŠ\Íğ®¡ys¬´s\ê	ä“¶I÷\È\çµ\â].\ãS°Ak.\Ébm\İ3¸w›\áM\Zú\Öö[»¹£c’H\É\Ç\áŠ\Ât`\ë)¸«÷°B»Xwo‘\Ö\×7­k)z\Ö\Ö·–Ÿ½Àû§ ğ\ÏZ\è&š(#2K\"¢(\É$ô®\'_‰›Ys,‹\0\Ç2Nõ\\\İşµ\Ñ3’ŒS–§e§^û\îBŸ”ıqV«#\Ãq¼z,%ŸpbYG÷Fz:±«İ›K#´\âGùW\Û\Ô\Ñ{+³\'zÈ¹r·kf&±9œ„ôŞµ\Ìj±\\@ YÜ—™<\ç®\âO_ \Ç\ëZ>º½r‘‡Uµ‡ \ä}\âN@úš‹P±’mV\Ö›a;g…$şB¸œÛ–§z§Ê\İ\Ó\Z-°|\ï+»\'\Ü\ä~”T:\Íü°\ÚY\Å`\ÛM\ÉwŒ1E(\Îv\Ü\ÒT\é\ßbe\ëø\ZÀñqxô›fR\Ê\r\Üc \ãÖ·\àŸcü«Å¬_\ÃLÜ“zŸÖµ\Å\×t­¾\'oÁ‘€ ªÍ¶ş\Å/\ÔÔ¼EO P\0û7o­[ª·ÿ\0ò5/ı{ZµY\å’r\ÂÁ\É\İ\Ø\Ï1Š*i++™’§—+/¿«ÿ\0Çš\×O\èkv\â5r¿x~µu§Ky\0Œ›_q-\éƒZJ›R²1SMjdi6\æ{\Õb>Hşcõ\í]0ªö–±\Ù\Â#\êXõ&§®\ÚTù#a¶yŸŒ–Y<Gr\Û’4L2:ş&½:\ßKÓ Ò­/\ít\è­&$.p@#8?ck\ëŸ£j·\Ó\í)xÛ„#–ubsùÒ»ùb}=He|#¦:\çò¯µY}n1K¯è¬¥N/-”Ÿòÿ\0_y‘KM§Wº|€RŠJ*@\æ|}¦\Íw§i³Â»™e1:’ø\Ç\ê?Z\æ|?§Og\ãHm\'\\K¶üÿ\0õ«Õ¥¶Šş\Ú±È’\0;•9¨„4´ñuŞªX<Wü¾ª\Üd~•\á\áq\r\×t¥£»ü\î}~?	\à•zz®T¿\\Õ¥”\ÙYVg\ÎĞ¤œzW¶|q\ç!¼Ôµ]v[XIxCFD\';\Ó!†!V<2‡U»š\Òú\ßDL’J\ä\ï-¸pAüsUôH­u	­YÀi\Õ‰ù‚|\ÄOÊ­\Â\Ğ/\í%˜°ybFù{\ÈWÿ\0:\æNò=)ZÎš[#º4Š1hE\0W9¯\Îd¾gˆ\×õ<ÿ\0…tµ\Æ\ßI\æ_\Îş®jª½,y\Ô÷¸øonR\Ş;hN\Ëæ£$·şU\ØZ\Ú&¡kö©œ—¹µX˜‚:\çõşU\á½\";•Ò³‚’,Œ\ãÖº¨a\ŞŠ%Ú‹À•\ÅRJöG§B×–\Æ>µ-•\Ø\ZTfh[1…=\0\â—©Y]jW÷3ºX˜FŠ.7cÀ\æŠUŒ\êN§7º´6 \è•dx†\Î\âó\Ãö–öñ•.‘\ÙGe\æµÕŠœƒŠx‘ÿ\0¾ßuWÃª\Í_£¹†\ès[ª·\åşE{\È\ŞO­\Âaûw{\ç¥N)w¿÷\çIU‡¢¨ST\ã²V2\ÄVuªJ£\İ\ê-\r÷OÒŠFû§\é[ıJ\Õ\İ\ÊZ[4­\Î8\Ô\Ôù½sz\İÑšğB§\äŒsõ««>H\Ü\é.Áh+\Ğ/tË™‚\\#ı¢E8\Ç\å\Ûñ¨¼4ºİµ¿\Øõ	£–\ÆÅ»)\rŸ¡\ëŒz\ÖL3\Ën\Ì\Ñ9R\ÊP‘\Ü‚+ Ğ¤/`PŸ¸\ä§Zó°\ÔW¶r–½W“\êz3\Ì%,<h¥\Ò\Í÷W\ĞÔ¥¤ W¦yc¨¢Š@X‚\à 	·#5\Ğ>7²0¾7·;½\r`X&û\Øı\î?…u½k\È\ÄÑ§N·´‚´ Ábk\Ö\Ã:5]\á²8\Ù#h¤h\Üa”\àŠmlkV\Ü%Êö[ú\ZÇ¯F”ı¤EÒ¨\ây´×·\×\ïV\êgKƒ\æ<Jp9$®=şµ\ÂF\ïSñÎ¬\Â//[¯u|»G\àu\Z–‡g©²4Ñ®C‡r/€@ş?¥XÓ´\Ø4\ÛdŠ%‚*3\ãöŒi(;›OM\Ù{\ÍX¹\\¾™e¡y$s\Îc\'„\0r\ÌMt\è\ê\ãr0aœd\ÓuM=#÷–vØ9U›\Ê^Y{ñŞ²\Ä;Y\á¡{¾\Å\í6\Ï\ì\Z|VÄ‚\Ê>b;’sV‚#;}\ÕšÆ\ÄVÿ\0\Ú2\ÛMò !QıûƒøÖ¼©\æÁ$yû\êW?Q\\-;\êz”Z´zÕ§]]õ\å\É;U¹\0ŒQU¦³¹·\Üe‚D\npX©\Æ~´WE¢yü\Ó]NÆ‘\ßh÷¥¨\å\ê+¶«q\Ñ\ËvV–öXÜ¨U¨Mü\ç¡\è)—_\ëÒ¡®GR]\Íy#Ø˜\İ\Î\å¡ü)†i[¬Œ\Ze<Ï¸\ì„wÚŒ\ÄğkŸ-¾V\'©\çù\Ö\Åó\íµo~+\Ô\ä:õ½E c\Ímxz_\ŞMz€\Ãüş5†¬r+gÃ¶WW,	º8\Æœuÿ\0õUÂ¤i\ÉJN\Èp§:’å‚»:\Z*_³Oœy/Ÿ÷j\Ô:lŒJ\n\Øu5\ÑWBœy¥$oG/\ÄÖŸ$`ÿ\0\"-_{F\ä°ö¡mbSœõ5\Ç,\ã•\Õ\ß\Èô£Ã˜\É;;%\ê?L\äõ8Ñ€\Ö-¾Šƒ\Ç²\Ü!\Ç\\q\\kõ‹Ôµ\é\àş©jW½‘ñ}¢\ÆHñ÷”‘õ\ê+’wH\Æ]‚s]¨TAŠ\àõÙ¨N•\ÈJ\ì\ÃU\äM>cN\î2µ;$\ërŸ\ÍS¿ñ½ŒòG).±±_”õ\Ç­s²\0%p:5—­K\å\é\å{»ı¥t*\ÒnÇŸN’rH\Ñğnº¶¶wÓ‡|8‘1\Ï^¿\Ëõ¯I†_·ijñ1C,_)\î§¯Ğ¾K\Ù\Ö?\ê+\Õ|+r&\Ò\Ì$üĞ¹\äZÆ»l\îŠJ«ó9ˆ%¶\á™JÈ§\Z\ëü1{=Õ“\Ç7\Ì!!Q»‘\éøVo‹¢{o(~2	õÁÿ\0\ëÖ¯†mŒ\ZB»ebÿ\0‡Aüª&\ï™Ò‹WX\×bót[‘œaw~G4Tš\Çü\îÿ\0ë™¢¦\ZUøŠb™/QO\ÉzŠôk|ó!ñ·_\ëÒ¡©®¿\×¥C\\FÁEPM¿w\Zúœ\Öm]\Õ+¦\â\095>§k\n\ç\Í}šbQ”ˆ´FG\ã^‹\á8­£\Ğ\ãh%Vï‘‘\Ãz¥x­\æ©=\Ñ*—÷G­RûUÍ¢3\Û\\Kz\Æ\å•s\â°Î¼9S±\îeo\êµ}¤\Õİ­\è}skhÈ·\Æ\îpŠ\Ìc\èz…u8P s_;Y\\\ÜI«\Ú\ÌÒ¼“	†f$\çp¯p¬ğùM9Aó¶\ÙÛŒ\Î\ëR©M+v\îk\ê7A,d\ê~•>¯¬-,\åK[\nˆ«’Ö¼¿\Æ?ˆ\î˜•ˆ*(ô\àú“]K.\ÃÓ¤¢\×3\îp¬\ßZ³p—*\í¿\æzŸƒ¼@\"i.ã¢Š9ŒI¸ò\Üg>\İEvg’\ã^MğóT´³\Ğ.\Öiã… ˜\ÊÛ>R?¡®³\Â7ƒ\Ä\×W–\Ï‚xÜ´KŸõ‘zı}G½pB-NQJ\É3\Ö\Ä\ÚT\áQ\Ê\í­{\îu\Õ\ÄkC\Z\Å\Ïû\Ãù\n\í\ë‰\Öÿ\0\ä1qõ\ÈWM-\Ïü5\êq2ÿ\0®÷sº\ä\Şe\Üp\Â~§üŠ\è¥ÿ\0\\ÿ\0\ï\Z\ä®_\Î\Õ]»1øŠ\ê†÷8p\ë\Şo±sF\çR˜ÿ\0²˜®\Ó\Ãú€°Ô—y\ÄRü\í\èk‰\Ñş&/\î‡ùŠ\èiT]U¸\ÔMŸŠ\íÌšts“óô?ı|V®›\ZÅ¦Z¢’G”§\'\Üf¹ı/Y‚òÅ´\İEö\î]‹!\î;gŞºkx\Ö+h¢VÜ¨AõÀ®w¢³7§iKuhR\â	!eJŸ¡¢’Y–!\êŞ”UFœÚº	Ö¤¥¹“L“¨§\Ó$\í^oTw3®¿\×¥CS]®?J™TeˆŞ¸E¢ª\É}\n}\ÒXûUi/\åo¸\Ì\Ğ‹\ç¶\Å\08Ac\îrk›­Ÿn{˜¤bI)ŒŸcÿ\0×¬jµ±\êP·³V\nQMò/@71ôQ\É4\äP£\ÏF#‚k_I´7®[¿Ÿ*DU:‘‘Ÿ§”¥Ê›6¾\Öë¡ \ÚJ5kI\Ú\ÚS\nH$\ÜT…8\ç¯\á^’|@ı­\Ô}Zºx wğ•µ‘À¿f<¶9)À\àú‘Q\Ùø^;x\Ë\ì‰d¸	\Üo =?J\áÁ\æ>\Ş2\åV³°ó,\éÔ·º¹röV’\Ê\ÌHÀ8Ïµxß‹c1øš\ï?\ÄU‡ıò+Ó›Z‘\æK[+Q¶*\Û¤·;\ç0\â¸ˆ\Ú|¶zÍ¼’\ÄÑ´°\à†\\ƒşQ–B¥*.7»{šc*B¦%JšÓ•-¬q\Õb\Æú\ãM¾†ò\ÒCñ6\äaşzQ¥Ù¾¥©µª>£fLô\È\ÅC$oŠU\Ôá”A®ıÌ¯­{ğŸl|Ij¨\î_¨Ä3cqõ_Qüª·ÿ\0!‹¨şB¼EX«RA¯L\Ğf–\ãCµ–y^IN]\Û$òGSY{5taŒ\é¥\æe\Ìq,‡Ñq\×@\íš\ì.øŸ÷«·ÿ\0…ú\Ö\ĞÙœ\Ø†Dúd¾V¥Á;O\ã\Åuu\Ä)*\à \äWg‚h#ƒEE\Ô11\Õ2J\ÕĞ¦”j)˜û6Ÿ—q\ÇJ\Å[˜\ZO-fŒ¿÷CÖ¾‡ÿ\0!Dÿ\0u¿•L~$r\Ê\é3«¢Š+´\ä\"¨.«.*aUo$DtÀdR¯ğ3x\îV#1Ï˜Pÿ\0²*‹\éE\Î~\Ğ\Äÿ\0´+@:Œ\ãN®C´™Gİ‘×Š´Ë‘\ÑTı\rnQ@µ\î–\íPğ=?*†\Ó\Ã1]¿\î-Yğy%tš\ÅóØ\çNğÎ£öid¶ò÷yŸ6\ìôÀ¢æœ–‰•ÿ\0\á·¸}¶F+H\ã\à~u½gcka†\Ö‰e›w\ã\í6\Î\é­çµœ‘Ô¨uÇ­=¼u\á\ÔXšg’/0ewB¦i;\n3²H\éc¾0¤Oı\êFFzR¾¦&$\Ïi1\êË•\'ò5‘m¯\è7‘	!½i\èNWù\Õ\è\Ş\Æt/\Ìl£©W\n\ã\Ã\á)\ĞRQ\ê\ît\â1\Õjµ\ÎöVû¿SMüDğ\Â\Â\Ş/#*«Ì…•p1~Ÿ•y‡\Ä9Z\î[‡,Ì²0.\Ç$\äõ«ª*ò¹,\ß(<\nÀñt	w¥\Çk ”Lô#?­wÓ¡eÏ±\ÎñR”\×;8¯\n°Å¶™\èU\×ÿ\0j\ë|S¦i÷\ÇÌ@—£‚Pd0ÿ\0j±l´¨,\äYr^u\èı1ô­\njvMw\"µni©C¡\Í6‰xz†­I|H\Ú.™o§Z’\æ5>cUI$\àzš“Tºk;‘>ùùWØõ\ÇyR>X‘\Ï9&œUõgE\ß.j›#¡\ÓõÇ¼‘¡º\nL\íp0	=«*\ßş>\ëTŠ<D7\äA«Ví™£näŠ»$\'J1»\Ìgz¿s©ºi°Z\Ä\Ä6\ß\Ş0ëŒœ\n¢j†Iœ(\ê}*¬à¢›»\è1wsŸjô?O$\ïJÅ˜=\Åp\r dc\Ü÷5\è>ˆ\ÄmTLlßŸ4Ku\êaŒk\Ù\êvôQElx¤B³5_¿\ĞÖ•g\êh\îÑ•V`\ÎqJ¿À\Íã¹›J‡BG\ãIÒŠ\á4$\È:9üi\Â\êA\×ğ¨h 5[\é<„Œ(\'\éQxu™µ…$“ò7ò¨µ_»\ÔÔÿ\0ºÿ\0¸\ßÊ“*;œ¯ˆ?\ä//\Ôÿ\0\èF³µ^m¬¿\Ü?Ò¯xQ®ûÕ¾l‘\Ç_˜\ÖN¥wºM‰…ÉZE‘û£§ñ«\èz\ÔiÉ¨´¿«3¦ğı\ÅŞ\nÁ7\\Ã“Ş»}7J6š|\Ğ\Î\Êşk\rÁz\é^_\á\Ï\Z^hQı™\â[‹m\Ù\Ø~VS\ß½r\Ò\ê;\í6¨ƒ\æUu0@<ÖŠ0q¿S‹Btª7-\ÉXí¶ñ\ÅP{X’\Ñ)\'©\ÅO¨_Z\éö5Ü«}77s\è=j¸‰À!\Æ\rV!Y¤D®È›Nµoùg¡5iPŒ\ãñ«Á\èA¥®p2.4nahBQ†\"¸Ms\Ã÷\Z4 œ\Én\Ç\å\Ğú\Zõ*Š\â\Ş¨	\ãY#q†SŞª2±\ÑB»¤üöü­\Ê¢¬\Â6ÈƒÑ…i\ê>xå‘¬\Ûz~F<Ç½e(x\Î\É«¡Á`\ÖÉ§±\è9Â¤o9\Æ½C)\Úy\ç«}jyY\\€“S\éúL\×\ç\Ìs²\"ys\Ôı)¦’»%IEsKb¶Ÿf÷·I\Zƒ·9c\è+\Ò4©F\0À@…fi\ÚXEòm\"\'»7õ&º\r\ÓÉ¿œ0\ÜQ\r\ç9¨Ohó±5½¦\Û\ÔQEuy\rZ±»û\æM›ò»qœUZ*\åÕ™Ğ¦\àÔ–\èùâ¼˜¹…\0÷E¬-ŸşY\ã\èj\ÍŸ$Rµ‚s”Û“z”[IŒı\É}y¦&‹<²¬qH…˜\àgŠÓ¥ÑŸ1	VSÁªgF=	„¯4\Ç=ªøoQ\ZHˆª3—\Ü«\Z^\rŒ¾n\æyv‘¸ğ\áZ²\ŞOy·Î·u¢³mSPS´/ó9?øN\ã_\Ş\â\Úx£1Ç°¬€ó\Îs‘õ®Iü®\Å6ÔŠ\'\0ğ\ë(õ\æ½`}\ÚZ\Ó\ØFZ³Zxú”\×\"\Ø\Ç\ÒtD‹M·\Zµ¬÷ª¿<¦0\Äó\Ç8\ä\ã\Ö\ÖÃ…\0\0@\0R\nSş«ş(«Yyî£©+³?YÑ­µ»1ms¼(m\ê\ÈpTô\Ï\ëYÁv\0£ \âº\ZÀo¼~µ†&+FJ›~\çD%8H\ã£Î›Er(¸”~¢.\ÜuPj½›!Ì}Iª\Z®‘5ŞŸ%\äV\Ò7»šEB@Q\×\'õ«\Í÷Ö»]\îQ¡\Åh\Û^	##¨ ‚NEq\ã1«	Í«\İ\Øô²\Ì#\ÅUqN\ÖWüO$\Ó4©õ]@¤0\É*\"ù’\ìRp¿‡½w\Zv‰$ÁL«\ä\Â8\'\è;WSa\r¾‹æ¶k³K\ì‰\É\ÆqÖ›½¤ùÜ’\Ìy\'½<¿1†6«‚‹VW\Ô\èÍ²ù\áiFnI\İØx­£ÄTzw©@¤¥¯n\Ö>q‹EP#ÿ\Ù'),(152,23132132,'Jose','Martinez',323123212,'2023-10-31',_binary 'ÿ\Øÿ\à\0JFIF\0\0\0\0\0\0ÿ\Û\0C\0		\n\r\Z\Z $.\' \",#(7),01444\'9=82<.342ÿ\Û\0C			\r\r2!!22222222222222222222222222222222222222222222222222ÿÀ\0\0\Ü\0\È\"\0ÿ\Ä\0\0\0\0\0\0\0\0\0\0\0	\nÿ\Ä\0µ\0\0\0}\0!1AQa\"q2‘¡#B±ÁR\Ñğ$3br‚	\n\Z%&\'()*456789:CDEFGHIJSTUVWXYZcdefghijstuvwxyzƒ„…†‡ˆ‰Š’“”•–—˜™š¢£¤¥¦§¨©ª²³´µ¶·¸¹º\Â\Ã\Ä\Å\Æ\Ç\È\É\Ê\Ò\Ó\Ô\Õ\Ö\×\Ø\Ù\Ú\á\â\ã\ä\å\æ\ç\è\é\êñòóôõö÷øùúÿ\Ä\0\0\0\0\0\0\0\0	\nÿ\Ä\0µ\0\0w\0!1AQaq\"2B‘¡±Á	#3Rğbr\Ñ\n$4\á%ñ\Z&\'()*56789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz‚ƒ„…†‡ˆ‰Š’“”•–—˜™š¢£¤¥¦§¨©ª²³´µ¶·¸¹º\Â\Ã\Ä\Å\Æ\Ç\È\É\Ê\Ò\Ó\Ô\Õ\Ö\×\Ø\Ù\Ú\â\ã\ä\å\æ\ç\è\é\êòóôõö÷øùúÿ\Ú\0\0\0?\0\ì\é)i+\Ò8‚Š( Š( Š( Š( Š( Š( Š( Š( Š( Š( Š( Š( ¤¥¤ Š( Š( Š( Š( Š( Š( Š( Š;\à\àQÛœR\0¢Š)ˆ(¢ŠQE\0QE\0-%-%\0QE\0QE\0QE\0QE\0QE\0QE\0\Â8\Ù\Ø\à(É¥¦N¥\í\åAÕùT·`[y­x\â\îiL6\n`EsóY±üª–Ÿ\â½b	£y.\ÚTRP>aß¥tZ\'\ÃH5}(\Ü]j?g»™‹Cr6\ç÷\Írwº\Úˆ›KÔ‹|„•a\Ñ×±õ®U•÷;¡N-lzµ¥\Ê^ZEq$P\ÃÚ§®wÁ²+\èm°+®«L\äWE]°w‰\Ç8ò\È(¢Š²BŠ( Š( ¤¥¤ Š( Š( Š( Š( AEPE›€\"€ u8£zŒã¨¦\Şuú\Ğ\Ê|·*9aŒÔ½KŠWÔ‹N6\"\Êòı–tg‘7\ã®@=k+\â4¶¶\'Nš]=\ï\Úh\nG<„‚0Å¹8ôlş\Ö\é\ëcqœ/¾HşV\ÙÁ9\ëŸcG|¯øG–À8Yfù\ã$‚6ş\æ7\ïXô´nq\Z\ÌWh–V#€\âºj­acc\r¬v5\Ú¯½Y¯J\ZDó¤\ï&QEP‚Š(¦EP\ÒR\ÒPEPEPEPF8ş”W\âÿ\04rgi³…`{*õ_aú\ÖsŸ)P3±Ú‚\à\Ò×“\é^!\Ôl/„¢\å\äˆr\Ñ\Ês‘\ì}kÔ­nb»µŠ\â#¹$PÀ\ÑN§0\çO”›¥79côö§R1\çjŒƒÖ­’€°\Î:ö¤\ÎX\Ü/P)H^Iú\â«\İDg\à\Êf7’F^P9ü\Î*¶¥¥}\Z7‰æ·¼}.\Ö\ÌÜ†&EpûUy\ä{Š\Õ\Öa{¿KkªMº\â\íÔ „ò°A\ã\Ø`œŸS\\\"jòh:\Är\Í`	6(ùA\í’G$Vók¶ú†‡ñ1kûòşnX\"\Äm\éŸÏ“^|\ås²Ö‰B\ÇSh‚CtTœ$ªx#¶k\\h\Ğ<;»,Ÿi,-!J¡û\íõôù\í$\Óo^\Æf\ÜTf\'şúzıGCø}+®Fôg5X$ôEWI€QE\0QE\0´”´”\0QE\0QE\0QEST¸û.—s8<¤dŠññ\Å\Äsİˆ\İ\Õy²Àc\Óó5\ë> ‰§ğıôH	f„\âªø6[-KÀ­§4)+:È²@§ßo¯µqb]¼2G•\äds}=+\Ò|p\ÓhF&\Ï\î\\¨úv®]|¬5Á¡Y\Ä.\ÈA)\êx\é€?:\ë¼\'¦>—ôÅ±pTÔ€:Ñ‡w‘Uş¡¥;\ÒQ]¬â¸„\ÎqI!)§ê’Œ‚Dp)Ç©\Éı1N\ëQ\Şü¾·ù\în\ŞR=U>Qı+»´M©{\Ò9Jx\ÛÊ—!Zp\Òc§(­]µ¶Kx\Î\ÄUgm\Ì¾IÇ¶MeÁ\Ú5Y¿‰V_1¾£\îÎ¶‰Ák…#¾§Dÿ\0Á°ù~…\Æ˜™3\ë“\ÅG\â\ë-ö	|£÷–Í–#ºøş7„$Vğ\å”[²\é\È·&&‰\ã‘C£H\ê+H»3J\çœıNM\Ø\â{}öÒ’d\ÌD§gñ\ëøÓ«\ĞN\èã–Œ(¢Š¢BŠ( b\ÒR\ÒPEPEPEPm x9\î=+/O\Ò%µ¼\ÛH\Ûy±4œ!%›Œç˜­jĞ·2\Ø]E}\Z3‡O\ï©\ê>½ÿ\0\nÆµ>hšÑŸ+7\ã°h£k–\á\ÛÌ¸It\Û\ßóŠ\æ`·\Ô\ÛX\Ôm!·[£cNŒÃ¦=}¿ZĞ»Õ´\áh–z<ş|÷gsòry\ç9\îOj\è<!f-ôa#Œ\Ís#K!<òOÿ\0Z¸`\Ü^‡UEÌN)D¡ÁFGF*\è\Ü2°\ê\éÇ­?\ï[\Ş,ÒŠ\ãV¶O1‹…_\âO\ï}Gò\Í`)\È\rU¹W}9ós…\0–\è95_Sb\éPvI!³7\'ùS¯²,§*vŸ-°}*H¯¬\ê,ŸrX“\Ø*üóùV8‡k\Z\áÌ6¹ó$¬]ª\ïÖ£·]¶\È=†jJ\ç:¯sOD\×\"\Ò\î`Ša\"“!V`>]Œr	ôÁ5\éHÛ•X\ë^B\ÊJ†»?x†\Şm}®a[·•—\ê\ã8R={şTX‰|Coö]u¦Q„ºŒ7ü|¿\Ë›]WŠ­úW€\ï¶`ü÷ø\×( \Ğ\×e]Xäª¬Å¢Š+s ¢Š(´”´”\0QE€\n(¢€\n(¢G<\Éo\Í ù#Vs\î\09%Az¥¬\'\n»›\Ël/©\ÇJM»4Tw¸\Ëm:\ãG\×a“Y,\Éi£	’\ìÿ\01 ş\'ò®\ë\Â\Ò3è±¬‹±\âfB?ÿ\0Ze\İ\Ì6°\ß[•dY\Ô\ÇQ’¿Ö®X\0š•ôG\Õ\\}¯8\í¾ƒ\î¥O¶Eg${’\â\'\ç˜üCÊ¼“\\\Õ.ü3®\Üi\ïn“[!\İV\Ãm?_Ê½gUù\Z\ÊN\ép?PWú×|Y³1\Ü\é÷\é\Æõh¶9Î®h—Ê–z­¶½k=¼[\ã”\ÆCFÃ•\Ï|÷\ëU.n\Úò\Êk¶B4…Ê¿3sü\ëğ\ãù^\'³P?\Ö$Š~˜\Ïó½’ú\\,NK\í\'óWx…(\ÚE\à0\0ö´\ëEdl6BD.@\É\Úqõ­¯xr=XG}pò\Å1ùqùnWsõcÇ§O\Ä\Ö\Ê\ï·t\Î7f½SG¶Š\ËH´‚ $Kü¹4\Ó\"H‡RD²ğõ\ÌrHÎ©nË–\êxÀükˆ‡ıJgû¢´üE¬j\\›b~\É	Ì²Ã°\ì+?¨®ª1¶§-WvQEtQ@IKI@9¢ó\Å\0Aiv.|ñ³kC!B3\Ùõ«\ë23\äk\ÓB½.b>«Áıü«Lœœú\Ò\0¢Š†KœK\ä\Åosp\àdı—oû\ÛA\Ûøâ”¤Ò¹8”™9\Ï•ZY®\ã*£K¿%¡dñlÖœ^ò\Şš÷N¸·…ùY0$P=X¦vŒz\â¡U‰^\ÎF×‡$ó´›\í=±º4\àc¡\\¯ş\È\ã[\Öó¨YO“‰ (}\È\çúW)\áÛ¥‹_„«‚\æ2)Ê±À\ïÓ°?ğ*\Ş-•„rJ\á\Æ\ïaw8	Á$\Ø5\É?ˆ\èÆ¾´»´\ÉXuˆ¬Ÿ‚°o\é\\·\Ä\ÈşIñ“ªs\éš\ë\'h¯4¹\ÌR,‘Iu9\Ø÷®\Åq›\ï‡W…ysl}F*V\å9\á\ĞO‹,3\Ğoÿ\0\Ğk~/ù\Úgû±ñø\n\Äğ\×\Í\âX[?uû\ä\Ö\èñ.‡ı’£õªŸ\Â8üE\ê(£¨,d¼\Æ\Õ\Ôj:û\Ü\ÚG§\é\îTyH\'¸S\Ğcî¯¿¿j\å\æ†Aş\ÉşUOT]:\ÛbõŒùsZÒ‚“2«+\"\Â\"D›@U\è:Š+¶\Ö\Ø\ãaEPESi)i(\0¢Š(3TEÅ\îp!U¿\İ|¯ó\"´\àqj«©Y›\í:\æ\Ù[kI>‡\Ï\í>ó\í\Ú|;pe@\äz\ãó©\ê>…‚B©>ƒ5\ÎYkSË©½­´M29ûd*¥\'>¼0ğ\Z\é\È ô<úT6–vö0˜\í¢+œ{ÿ\0ú…EX)\î]9¸­‹z\å\Ú\Ú\ÛÂºhH pX)\ÉÀó®\çK).“kµ•\×\ÊQ\ê:W“]\İ\Ü\Í}p°],Q\Âv©¸“ßŸ_Îµa¼Ö¼8¨m‡›»JFFa“q;£s\î=«–J	\Ù\ÅÉ«›\Úş‘§X][\êvÀ\Åx²‡X¢\ër@<z\ã½\\Mõy&ŸR,‘Já…¨<w>¦¬\è‹ˆ¡t¹\ÔdfY‰\ç\Ë`pQ}cızš\İ\áG\0\ï\Î*\n*ZÙ‹-8Û«³ª«\0X\ä\ãœÖ³\åA?‚\äEmHı)o5·,4\ÜI+|’KŒ¤@ğN{œt¥=ºÇ¥\Ë\n®BTs\í@?øLc\ÄÑ¸¡­q:=ŒˆŒ\Ã(W_C»™\á¡\åø¬¯³/\è\ÕBÿ\0rjWM´m\ç6Jÿ\0<ƒZµx\n/\Ş;nù£k•‹\ÄzŠ.\Ù\"¶ö`Œ1õ\ç^\ãX\ÔnT£Î±!\ím\'ñ$\Ö|¦œ\ÇA©j\Öö(W\"IˆùcZ\ÜÒœÉ¥Z¹,»¾\Õ\æ\áTd’z“\Ô×¡x~Bú±<¤~¦¶ ­#\n\î\èÒ¢Š+¬\æaEPEP\ÒR\ÒPG>‚ŠL8ö÷  ı1YºHò^ò\Äc÷¿\î?\Ì??\n\Ú5,“öğ:~ó­d\ß\Ûj\Ò^ı¢8òP+8™ÿ\0\Z‰;tt\ÛM\Ç$Î¹/³\ë\ãş\\cÿ\0ÀƒIöÏŒ_øi:CPó4\ìô««]J\îx\îc	,…\İ\×\ÔWG.¿hú¶ò\Çv#(«%”±Vu®(A\âÀıa9$\Ö\è¸\ÔNscŸŸ‘X\Ê\nn\ìµ7‚\ÏÅ¿cŠ\é\ç\ÓnD²?˜#H\è\\\à3øÖŠhk:„v÷¬-­;Ê‰²\äd1\í×µqWz”p\éq\Ï(%\å¯$\ç®?\n\í<=®\éúÆ¡¾\Ú_+qG\à©\È8ı+9Ã—b¡\'-ÎŠ\Ú\ÎHDPÆ¨‹\ĞşsSJ»¢uõR)Aâ²µ¿X\èvo5Ôƒ~>X\Ç\ŞcY\ÛSK£|7eÿ\0¦Ò¨ü7UCN\ìzLÿ\0Î§\Ò.ÏŒ¡¹\nWÌ–V\n‡v\î?Zf®¡5‹Áÿ\0M˜ş¹­¾Á+\â)sš¨¡ùZD\ÎprjjC‚»¯\r\è‘BÂ¸Z\íü(s¢\àö‘±ZRøŒ\êü&\İQ]\ç\n(¢˜Q@IKI@dzQE\0SšÁ¥º\İÎ™\ì¸Àı)¿\Ù\Ò\Ïõ\Çş;şzŠ›\Ê?\Ù\Ò\Ïõ\Çş;şgIÿ\0?\×ø\ïøU\ê)Xw(ÿ\0g9ÿ\0—\ëüwü*½Å›Àğ·ö…\È]\Çy\ã…\nO§µkR	Á§\Ê4\ÎIHQq7˜lJs½¿_ztJ\Ï\å\Î7\Å\'\\«maøk·x\"“‡Do@V¡m>ÕZ\Ş<û\n9Uµkk\â/\Ù³p±Ê¤\ãò\æ³e/,¦i¥’iW•òú\Õ\Õ6‘dü˜\Ï\àj&Ğ¬Ymq‘\Z¥Á-ƒœŠ^/Z’À¯›Ç¨\Ëõ\ëC\Ä\nW\Ä‹\Ï.?ô?Öº[?\niöR\Ç2y…‘\Ãä·¡\Î*\Í×‡\ì\ï¯$¹˜?™!\É\Ã`túV\\\Ö5\çW¹\çc\å¹\é\Ã-Kşz\×t¾\Ó”˜˜‘\ê\æ¬Ç¢i©\Ï\Ù#\'\Üff\Ç\í\ç˜8\àÀf»o\n‚º?\Ì1û\ÂFx=«U,-\î[F¿ğS¯\Ê6¨\0{U\Æw\"Sº°QE±ˆQE(¢Š\0ZJZJ\0(¢Š\0(¢Š\0(¢Š\0(¢Š\0(¢Š\0(¢Š@QE0\n(¢€\n1E\0QE\0QE\0QE\0´”´”\0QE\0QE\0QE\0QE\0QE\0QE\0QE\0QE\0QE\0QE\0QE\0QEÿ\Ù'),(153,55444444,'Mari','Martinez',312321321,'2003-10-08',_binary 'ÿ\Øÿ\à\0JFIF\0\0\0\0\0\0ÿ\Û\0C\0		\n\r\Z\Z $.\' \",#(7),01444\'9=82<.342ÿ\Û\0C			\r\r2!!22222222222222222222222222222222222222222222222222ÿÀ\0\0\È\0¾\"\0ÿ\Ä\0\0\0\0\0\0\0\0\0\0\0	\nÿ\Ä\0µ\0\0\0}\0!1AQa\"q2‘¡#B±ÁR\Ñğ$3br‚	\n\Z%&\'()*456789:CDEFGHIJSTUVWXYZcdefghijstuvwxyzƒ„…†‡ˆ‰Š’“”•–—˜™š¢£¤¥¦§¨©ª²³´µ¶·¸¹º\Â\Ã\Ä\Å\Æ\Ç\È\É\Ê\Ò\Ó\Ô\Õ\Ö\×\Ø\Ù\Ú\á\â\ã\ä\å\æ\ç\è\é\êñòóôõö÷øùúÿ\Ä\0\0\0\0\0\0\0\0	\nÿ\Ä\0µ\0\0w\0!1AQaq\"2B‘¡±Á	#3Rğbr\Ñ\n$4\á%ñ\Z&\'()*56789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz‚ƒ„…†‡ˆ‰Š’“”•–—˜™š¢£¤¥¦§¨©ª²³´µ¶·¸¹º\Â\Ã\Ä\Å\Æ\Ç\È\É\Ê\Ò\Ó\Ô\Õ\Ö\×\Ø\Ù\Ú\â\ã\ä\å\æ\ç\è\é\êòóôõö÷øùúÿ\Ú\0\0\0?\0÷ú(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n*9\åA$¬	¥ˆ\Ã5\ç\ŞøÃ¢ø«\Ä0\è\Ö\ÖW°O0b0M¤¨\'1ô4\è´UmBö-7M¹¾œŸ*\Ş&•ñ\×\n2•pşø·¤ø\Ç]]&\Î\ÂúŒm&ù‚m\Âı\Ğ \ÑTµ]V\ÇDÓ¥¿\ÔnR\Ş\Ú!–w? õ>\Õ\çö¿ü%s¨‹V7pFÍ´\\K	õ<\äÂ€=6Šd3Gq\nM¬‘º†WSÀ÷ú\0(¢Š\0(¢Š\0(¢Š\0(¢Š\0(¢Š\0(¢Š\0(¢Š\0(¢Š\0­¨\È6\ëş¸¿ò5òŸ‡/#\Ò5_\nj\ÈnŠNÃº™\çğ\Ü?\nú³Pÿ\0m\×ıq\äk\ã\Â\ÅôTˆuX<õú¬\Î?“7\å@Iü\\\Ôÿ\0³~\Z\ê„6\à-ºÿ\0À?¦k\ËşÂ|E\ÒbD\nWJ>V\ÜrO\ã\ÅhüQ×—[ğƒ-ƒ\çû@-Ì¸ôU\0ş¬ß•e|#˜\Ü|G\Ó\ç=d°¸o\ÎF ÿ\0\Zµ¿¶ø4™YŸ¦[‹™¢dÂƒù\Ì\×}¡x–\ÃC‡W\Õôt\Z,\ØùV5RŠzW\Øşuµñj\'ƒ\â´\Ì2y”z¨\Úùö¯ E¶\âo\ÅÈ³X^@ŒTte @Á-fi´­C@¸˜\Êt\Ù\Ïx_•ş_­z­e\Øø{K\Ó5¾²´	\ä…`sÀe^™Õ©@Q@Q@Q@Q@Q@Q@Q@Q@µù\İ\×şF¾:·aö&68Y¢’>\İ\×ú\×Øº‡üƒn¿\ë‹ÿ\0#_Cb×¶Ğ”\'}½Œ·\ìJ\Äş™ :µ\Åå•¼s\ä.“e$\ç\Õİ¿ø¿Ò»Ÿƒ_ò>i?ö\r›ÿ\0F5rP\éŸo\ÔÅºŒ.£t²vŒ\'˜\ßúü«­ø5Çt¯û\Ïÿ\0£\Z€:ßú#Xxš8ŒÄ¦\ÖõTs\å·CúŸÄŠ­ğƒÆ†\Âq\áRpPüúmÁ<H§¿\áøŠö]B\Â\ÛT\Óç±»‰e·\nHĞƒ_.x¯Â—\Şñ\Ñ\ÚGÂ±ŸI»\Îvg\×úıh\êÁEr¼Sÿ\0	oƒ\ío\ä#\íi˜n@\í\"õ?ˆÁük¬ Š( Š( Š( Š( Š( Š( Š( Š( \nÚ‡üƒn¿\ë‹ÿ\0#_3ü4²]K\ÅV.2·\Z]\ÜGşdôÆ¡ÿ\0 Û¯ú\âÿ\0\È\×\Î¿\ä\Ñ\ë\Ê\ãÿ\0Bz\0¿\àx‚\ß[KcL’\Ú\ÛLÓ®9p\ìAñ\Ã~J*§Á¿ùt¯ûOÿ\0£\Z¾…Õ‡üI¯¿\ë\ŞOı\×\Ï_ÿ\0\ä}\Òÿ\0\ì?şŒj\0úCp\ç‘\ÇZ\à>0h‘jº¼Zq0\È:®\Íú!\\O\ÅKıwHñeõ•\ìñ[j\Öhñ*¶‘£Ğ?Š\ÍÖ¾1É¯ø!ü>šdƒSºˆ[\Êùù{@\ë“ıhw\àe\á\Z¾¿d¼C*Cxª:\Ã\'ÿ\0B•{]x¯À\Ûş\Ö\×o‡0\Å6J\ã£2/Í\È~u\íT\0QE\0QE\0QE\0QE\0QE\0QE\0QE\0QE\r\äm5”ñ\'\Şx\ÙGÔŠò\ï|-¿ğ¯ˆt}R[\Èg\ÛK\Â(\Æ\Æb\Ä`÷6+\Óu?¶f]gùmò\Û\Èó~\îüqŸl×\ç\â\ïıK\ßøÿ\0øP¡\ê½Æ›uc/$N‹ŸR¯3ğO\Â\ëÿ\0\nx‹K\Ôå¼ŠuŠ\ÎHgE\Ø\ÌÅ†=G8ü*\Î~.ÿ\0Ô½ÿ\0…ø½ÿ\0R÷ş=ş\Ñx\ëÁ6\Ş5\Ñ\Ö\İ\äû=\ä\r¾\Ú\ä˜\Ûü\ry,_\n|u5\á‚Yt\è×¾@¾a\Î@İŸ\È\×qŸ‹¿õ/\ã\ß\áF~.ÿ\0Ô½ÿ\0…\0v>ğÍŸ„´4›,²Ç–yÁ‘\ÏV5·\\ß„¿\á+ò®¿\á)û™¹|±\ç\ç9\Ï\á]%\0QE\0QE\0QE\0QE\0QE\0W!\âOI ø³I²‘£W6ó¼¤AE\ÈÁü1ø\×9¤|BÕ®ô\Ù\'–;vuÒ§¾)zHT½0(¸»ñ^‹a¬®“uWŒ¡‚>G^œô\Ílƒ‘^1\â[_\ê§R\Ól®\'·\Òà¾·.˜;şRTœäœñ\í]8Õ“\Åi\ÚÀtX\îâ°•ÿ\0\Íu\ÎG°\Í\0z=ÁXk)ÿ\0±¯\Ú\Ó\ì9.F¹q%W\'<\â¤\Ô|M¯ŸI¦\éZtW&{“û\Â$\Êû@\ÍÁ\è2¿\Ô|Aga,P¬sOy@„€¿y¤¿ñı¯ˆnt•Š\ë©\Ú\ÚÅyU,O\Ô`\Ğ{Es6\"’\ë\â§¡U­¬r®Í¸\ãvï¥£Ä\"“Gñ‡¬¦\ÍBå£—p\É\Æ\0üX~T\ÓQ\\¯\ã=F\Ã\Å\í\áô†,\×\ËjH<\Ä\à\ïcô\"¨ø,üK«¸³m;N’X`]¿1upy\éƒ@EGo!–\Ú)« cq\\>½\ã+ı3\ÄwZ|1BbŠk4\Î&bò\Ç\ŞQ^i¨x\ã]2\ËL¶¶k÷\Ô\îm¢/÷DP¨bO=Ni£Çšş«6˜4=2)³f—wq±ùˆ/´„úM\0zm\å\Ú\ß\Ä[\İ0x–0‹›+˜c´½Ÿ$ƒ\Ï\'\n:±m\â1ñ>¢ÿ\0d:f–\×B»~c\"Œó\Ó\é4W-7ˆ®\ã»ğ¬!#Ûª‚f8û¸‹u4\0QE\0QE\ã\ß´»\İ__\Ñ\í\ìGm¥`‘‚X\ÊO¯>Õƒ §‘£\Ü\ÄÍ»\\ø…{eÎ‹oq¯Zj\ì\Ïö‹h^\0ü»_\Ï\ä+š½ø_£^\Ù\Ù[®£[Rÿ\028Df\Ü\È\ÜtÉ %ñ¼\Ëpú„9\Ì66PH;l’	?÷È®±ÿ\0\ã\æ\ìwÿ\0„Óø\0®\ïTğ&›ªC©F\Ï,_n\Ûn0‚#”Ûšl\0\ÒdñLZó4şle\\Ã»÷m\"ª\äz@økş&>7ñ.¬yH,!>\È2\ØüMTñ^tYøš\Æu9x¬õ+p\ßz7l+c\Ôüª÷‡ü¯KªGª^Le.\Ï„l%ºœÖ¦\Õü	¥\ë$·\Ögi\ÖH\Ê\"F\ÂJP\åKj\0\â¼)ÿ\0#–™ÿ\0_z§ş„*Î±e#üvÒ¨š$ºBÑ¬€\Z\Ü\Ô>\ZY^4\r£yj\Ğ\Ï,\á£#$\ÈAaÓ§\ÑË [\Ë\â+MiüûkvWŒ{ÿ\0?Î€<\×Ã·\Ì\ßo\îRî¤\ÔJA\Ø\ŞX^õ9úŠ>)_<^7\Ñ]\"•\×OH\îG™G-\è\\}H®ö\ÛÁº}¬ösG$şe­Ü·jÅ¾ó\É÷³\ÇJv©\àû\rZ}J[—›uıº[Éµ±µ\î}9 [^¹°_>Y3f»eƒ\ìıc•»ñ\ëH\èm\rü\ŞR¡·\Ù\ãı\Ú\î\î|§\İj\ÃS–kƒv²A\"¸aò˜\ny¬\Óğ\Ò\ĞÏ¬?ö•ç—©‡ó\"\ÈÚ…˜1 c¯ Šÿ\0S:G…&\ÔD^iµ´óvg°¹\Æk\Ê<Su>£«\Ş\İZ\í\æ\àioNB;+“\è	\ê\Z/†!\Ò|;.‹5\Ì÷\ĞK¼;Nr\ÅX`++Nøm¤\éö-l³]HZ\ê+ƒ#¸-û³”^\0pšº_\Ó\ÖıÑ®\×S\Õ\ìŸt¿”›ˆö\ÎjÕœm¥x\'\Ã\Ş)°E\æŸÛ˜7®·i bx®\ÏSøu¥jvs@\Ó\\\Äò^\Éz&Àeg`=ˆš\Ã]P\Zrşş\ì¢XvFø\ÆB·¯?Î€<\Æ\ÚM\å÷‰õıR\ÙGq™Hj©Œûøw6kt<3ñ\Ô\Ú«‘\Z÷ƒ¸=6şU\Û\\ø3Oº²\Ö-\æê²¬³ma•+·}\Ê+1~Ú¥ş¯p5+ÍššÊ²C‘±L‡$¢€*Ü‘ı¥ğ÷ı\Öÿ\0\Òzô\0s\\ü.ô‹k­j\0\ÛL\Ò\Ç6FõÊ…\Ú8\à`Wwm\Ù\íb‡qo-\î=N3@\ÑE\0QE\0QE\0QE\0Sdm‘³c;A8§T7r<6sKfGHÙ•ñ8\Í\è~,m[Q*\ëo£E¹|º°\ÚnÜ–8ÿ\0t\×Gm{myoö‹i’Hr\Ãz2	ò ×’\İÚ›\æ7\ZU¤2Z\\k¦´µ2´ğBĞŒõ<+y­{T\ÔôŸjöw6³­¤3#H\ê§%]•¦ò\Çu\0¹\ãû\Ş\Ô\è\ÒO1™%‘Q˜\à\nU–6}Š\ê[À<\ãÖ¼\Ò\'½ñƒ¢}>Y-\î&¸¿2]B³F¬=İ—¸Z¯\á\èõ};\Ä\ê÷3\Ã6—Oq•Ú‹\Ì`g\ïª¹\ÇBNhÔšx•K4ˆXp}*(õI\rÀKˆ\Ï\Ù\ßË›Ÿ¸\Øğ#ó¯;—¶¼‡ûV·;÷@\çÌ½*Il\Ã{ó\Ó\ä\çzş\ËYŠI#]>\àZ\ŞI\Í\Î\ëv™TmtPTrÍGb¹4\ë-sn\İ2\r˜İ–g¦i¶·–÷±´–\Ó,¨®Ñ’§8e8#ğ\"¼†]?Rkx?\â]|¬X¦ \ÓZ´¹#xŒ\0>ş^z»/\ÚjZl\×\Ö76\Ïüò\ï\Ğ\Èê¤…=À;³\ï@Q@Q@Q@Q@Q@Q@Q@Q@\rH\Ò1„EQœ\àV_ˆôEñ.›$\ïR²ù…Fw( •üG­E\02(\Ò(’4P¨ *¨\0\éLºµ†ò\ÖKi\Ğ<R.\×S\ÜzT\ÔP\01ÒŒJZ(\0À£Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@ÿ\Ù'),(154,23213213,'Pedro','Lorenzo',213212312,'1980-10-02',_binary 'ÿ\Øÿ\à\0JFIF\0\0\0\0\0\0ÿ\Û\0C\0		\n\r\Z\Z $.\' \",#(7),01444\'9=82<.342ÿ\Û\0C			\r\r2!!22222222222222222222222222222222222222222222222222ÿÀ\0\0\È\0¾\"\0ÿ\Ä\0\0\0\0\0\0\0\0\0\0\0	\nÿ\Ä\0µ\0\0\0}\0!1AQa\"q2‘¡#B±ÁR\Ñğ$3br‚	\n\Z%&\'()*456789:CDEFGHIJSTUVWXYZcdefghijstuvwxyzƒ„…†‡ˆ‰Š’“”•–—˜™š¢£¤¥¦§¨©ª²³´µ¶·¸¹º\Â\Ã\Ä\Å\Æ\Ç\È\É\Ê\Ò\Ó\Ô\Õ\Ö\×\Ø\Ù\Ú\á\â\ã\ä\å\æ\ç\è\é\êñòóôõö÷øùúÿ\Ä\0\0\0\0\0\0\0\0	\nÿ\Ä\0µ\0\0w\0!1AQaq\"2B‘¡±Á	#3Rğbr\Ñ\n$4\á%ñ\Z&\'()*56789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz‚ƒ„…†‡ˆ‰Š’“”•–—˜™š¢£¤¥¦§¨©ª²³´µ¶·¸¹º\Â\Ã\Ä\Å\Æ\Ç\È\É\Ê\Ò\Ó\Ô\Õ\Ö\×\Ø\Ù\Ú\â\ã\ä\å\æ\ç\è\é\êòóôõö÷øùúÿ\Ú\0\0\0?\0÷ú(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n*9\åA$¬	¥ˆ\Ã5\ç\ŞøÃ¢ø«\Ä0\è\Ö\ÖW°O0b0M¤¨\'1ô4\è´UmBö-7M¹¾œŸ*\Ş&•ñ\×\n2•pşø·¤ø\Ç]]&\Î\ÂúŒm&ù‚m\Âı\Ğ \ÑTµ]V\ÇDÓ¥¿\ÔnR\Ş\Ú!–w? õ>\Õ\çö¿ü%s¨‹V7pFÍ´\\K	õ<\äÂ€=6Šd3Gq\nM¬‘º†WSÀ÷ú\0(¢Š\0(¢Š\0(¢Š\0(¢Š\0(¢Š\0(¢Š\0(¢Š\0(¢Š\0­¨\È6\ëş¸¿ò5òŸ‡/#\Ò5_\nj\ÈnŠNÃº™\çğ\Ü?\nú³Pÿ\0m\×ıq\äk\ã\Â\ÅôTˆuX<õú¬\Î?“7\å@Iü\\\Ôÿ\0³~\Z\ê„6\à-ºÿ\0À?¦k\ËşÂ|E\ÒbD\nWJ>V\ÜrO\ã\ÅhüQ×—[ğƒ-ƒ\çû@-Ì¸ôU\0ş¬ß•e|#˜\Ü|G\Ó\ç=d°¸o\ÎF ÿ\0\Zµ¿¶ø4™YŸ¦[‹™¢dÂƒù\Ì\×}¡x–\ÃC‡W\Õôt\Z,\ØùV5RŠzW\Øşuµñj\'ƒ\â´\Ì2y”z¨\Úùö¯ E¶\âo\ÅÈ³X^@ŒTte @Á-fi´­C@¸˜\Êt\Ù\Ïx_•ş_­z­e\Øø{K\Ó5¾²´	\ä…`sÀe^™Õ©@Q@Q@Q@Q@Q@Q@Q@Q@µù\İ\×şF¾:·aö&68Y¢’>\İ\×ú\×Øº‡üƒn¿\ë‹ÿ\0#_Cb×¶Ğ”\'}½Œ·\ìJ\Äş™ :µ\Åå•¼s\ä.“e$\ç\Õİ¿ø¿Ò»Ÿƒ_ò>i?ö\r›ÿ\0F5rP\éŸo\ÔÅºŒ.£t²vŒ\'˜\ßúü«­ø5Çt¯û\Ïÿ\0£\Z€:ßú#Xxš8ŒÄ¦\ÖõTs\å·CúŸÄŠ­ğƒÆ†\Âq\áRpPüúmÁ<H§¿\áøŠö]B\Â\ÛT\Óç±»‰e·\nHĞƒ_.x¯Â—\Şñ\Ñ\ÚGÂ±ŸI»\Îvg\×úıh\êÁEr¼Sÿ\0	oƒ\ío\ä#\íi˜n@\í\"õ?ˆÁük¬ Š( Š( Š( Š( Š( Š( Š( Š( \nÚ‡üƒn¿\ë‹ÿ\0#_3ü4²]K\ÅV.2·\Z]\ÜGşdôÆ¡ÿ\0 Û¯ú\âÿ\0\È\×\Î¿\ä\Ñ\ë\Ê\ãÿ\0Bz\0¿\àx‚\ß[KcL’\Ú\ÛLÓ®9p\ìAñ\Ã~J*§Á¿ùt¯ûOÿ\0£\Z¾…Õ‡üI¯¿\ë\ŞOı\×\Ï_ÿ\0\ä}\Òÿ\0\ì?şŒj\0úCp\ç‘\ÇZ\à>0h‘jº¼Zq0\È:®\Íú!\\O\ÅKıwHñeõ•\ìñ[j\Öhñ*¶‘£Ğ?Š\ÍÖ¾1É¯ø!ü>šdƒSºˆ[\Êùù{@\ë“ıhw\àe\á\Z¾¿d¼C*Cxª:\Ã\'ÿ\0B•{]x¯À\Ûş\Ö\×o‡0\Å6J\ã£2/Í\È~u\íT\0QE\0QE\0QE\0QE\0QE\0QE\0QE\0QE\r\äm5”ñ\'\Şx\ÙGÔŠò\ï|-¿ğ¯ˆt}R[\Èg\ÛK\Â(\Æ\Æb\Ä`÷6+\Óu?¶f]gùmò\Û\Èó~\îüqŸl×\ç\â\ïıK\ßøÿ\0øP¡\ê½Æ›uc/$N‹ŸR¯3ğO\Â\ëÿ\0\nx‹K\Ôå¼ŠuŠ\ÎHgE\Ø\ÌÅ†=G8ü*\Î~.ÿ\0Ô½ÿ\0…ø½ÿ\0R÷ş=ş\Ñx\ëÁ6\Ş5\Ñ\Ö\İ\äû=\ä\r¾\Ú\ä˜\Ûü\ry,_\n|u5\á‚Yt\è×¾@¾a\Î@İŸ\È\×qŸ‹¿õ/\ã\ß\áF~.ÿ\0Ô½ÿ\0…\0v>ğÍŸ„´4›,²Ç–yÁ‘\ÏV5·\\ß„¿\á+ò®¿\á)û™¹|±\ç\ç9\Ï\á]%\0QE\0QE\0QE\0QE\0QE\0W!\âOI ø³I²‘£W6ó¼¤AE\ÈÁü1ø\×9¤|BÕ®ô\Ù\'–;vuÒ§¾)zHT½0(¸»ñ^‹a¬®“uWŒ¡‚>G^œô\Ílƒ‘^1\â[_\ê§R\Ól®\'·\Òà¾·.˜;şRTœäœñ\í]8Õ“\Åi\ÚÀtX\îâ°•ÿ\0\Íu\ÎG°\Í\0z=ÁXk)ÿ\0±¯\Ú\Ó\ì9.F¹q%W\'<\â¤\Ô|M¯ŸI¦\éZtW&{“û\Â$\Êû@\ÍÁ\è2¿\Ô|Aga,P¬sOy@„€¿y¤¿ñı¯ˆnt•Š\ë©\Ú\ÚÅyU,O\Ô`\Ğ{Es6\"’\ë\â§¡U­¬r®Í¸\ãvï¥£Ä\"“Gñ‡¬¦\ÍBå£—p\É\Æ\0üX~T\ÓQ\\¯\ã=F\Ã\Å\í\áô†,\×\ËjH<\Ä\à\ïcô\"¨ø,üK«¸³m;N’X`]¿1upy\éƒ@EGo!–\Ú)« cq\\>½\ã+ı3\ÄwZ|1BbŠk4\Î&bò\Ç\ŞQ^i¨x\ã]2\ËL¶¶k÷\Ô\îm¢/÷DP¨bO=Ni£Çšş«6˜4=2)³f—wq±ùˆ/´„úM\0zm\å\Ú\ß\Ä[\İ0x–0‹›+˜c´½Ÿ$ƒ\Ï\'\n:±m\â1ñ>¢ÿ\0d:f–\×B»~c\"Œó\Ó\é4W-7ˆ®\ã»ğ¬!#Ûª‚f8û¸‹u4\0QE\0QE\ã\ß´»\İ__\Ñ\í\ìGm¥`‘‚X\ÊO¯>Õƒ §‘£\Ü\ÄÍ»\\ø…{eÎ‹oq¯Zj\ì\Ïö‹h^\0ü»_\Ï\ä+š½ø_£^\Ù\Ù[®£[Rÿ\028Df\Ü\È\ÜtÉ %ñ¼\Ëpú„9\Ì66PH;l’	?÷È®±ÿ\0\ã\æ\ìwÿ\0„Óø\0®\ïTğ&›ªC©F\Ï,_n\Ûn0‚#”Ûšl\0\ÒdñLZó4şle\\Ã»÷m\"ª\äz@økş&>7ñ.¬yH,!>\È2\ØüMTñ^tYøš\Æu9x¬õ+p\ßz7l+c\Ôüª÷‡ü¯KªGª^Le.\Ï„l%ºœÖ¦\Õü	¥\ë$·\Ögi\ÖH\Ê\"F\ÂJP\åKj\0\â¼)ÿ\0#–™ÿ\0_z§ş„*Î±e#üvÒ¨š$ºBÑ¬€\Z\Ü\Ô>\ZY^4\r£yj\Ğ\Ï,\á£#$\ÈAaÓ§\ÑË [\Ë\â+MiüûkvWŒ{ÿ\0?Î€<\×Ã·\Ì\ßo\îRî¤\ÔJA\Ø\ŞX^õ9úŠ>)_<^7\Ñ]\"•\×OH\îG™G-\è\\}H®ö\ÛÁº}¬ösG$şe­Ü·jÅ¾ó\É÷³\ÇJv©\àû\rZ}J[—›uıº[Éµ±µ\î}9 [^¹°_>Y3f»eƒ\ìıc•»ñ\ëH\èm\rü\ŞR¡·\Ù\ãı\Ú\î\î|§\İj\ÃS–kƒv²A\"¸aò˜\ny¬\Óğ\Ò\ĞÏ¬?ö•ç—©‡ó\"\ÈÚ…˜1 c¯ Šÿ\0S:G…&\ÔD^iµ´óvg°¹\Æk\Ê<Su>£«\Ş\İZ\í\æ\àioNB;+“\è	\ê\Z/†!\Ò|;.‹5\Ì÷\ĞK¼;Nr\ÅX`++Nøm¤\éö-l³]HZ\ê+ƒ#¸-û³”^\0pšº_\Ó\ÖıÑ®\×S\Õ\ìŸt¿”›ˆö\ÎjÕœm¥x\'\Ã\Ş)°E\æŸÛ˜7®·i bx®\ÏSøu¥jvs@\Ó\\\Äò^\Éz&Àeg`=ˆš\Ã]P\Zrşş\ì¢XvFø\ÆB·¯?Î€<\Æ\ÚM\å÷‰õıR\ÙGq™Hj©Œûøw6kt<3ñ\Ô\Ú«‘\Z÷ƒ¸=6şU\Û\\ø3Oº²\Ö-\æê²¬³ma•+·}\Ê+1~Ú¥ş¯p5+ÍššÊ²C‘±L‡$¢€*Ü‘ı¥ğ÷ı\Öÿ\0\Òzô\0s\\ü.ô‹k­j\0\ÛL\Ò\Ç6FõÊ…\Ú8\à`Wwm\Ù\íb‡qo-\î=N3@\ÑE\0QE\0QE\0QE\0Sdm‘³c;A8§T7r<6sKfGHÙ•ñ8\Í\è~,m[Q*\ëo£E¹|º°\ÚnÜ–8ÿ\0t\×Gm{myoö‹i’Hr\Ãz2	ò ×’\İÚ›\æ7\ZU¤2Z\\k¦´µ2´ğBĞŒõ<+y­{T\ÔôŸjöw6³­¤3#H\ê§%]•¦ò\Çu\0¹\ãû\Ş\Ô\è\ÒO1™%‘Q˜\à\nU–6}Š\ê[À<\ãÖ¼\Ò\'½ñƒ¢}>Y-\î&¸¿2]B³F¬=İ—¸Z¯\á\èõ};\Ä\ê÷3\Ã6—Oq•Ú‹\Ì`g\ïª¹\ÇBNhÔšx•K4ˆXp}*(õI\rÀKˆ\Ï\Ù\ßË›Ÿ¸\Øğ#ó¯;—¶¼‡ûV·;÷@\çÌ½*Il\Ã{ó\Ó\ä\çzş\ËYŠI#]>\àZ\ŞI\Í\Î\ëv™TmtPTrÍGb¹4\ë-sn\İ2\r˜İ–g¦i¶·–÷±´–\Ó,¨®Ñ’§8e8#ğ\"¼†]?Rkx?\â]|¬X¦ \ÓZ´¹#xŒ\0>ş^z»/\ÚjZl\×\Ö76\Ïüò\ï\Ğ\Èê¤…=À;³\ï@Q@Q@Q@Q@Q@Q@Q@Q@\rH\Ò1„EQœ\àV_ˆôEñ.›$\ïR²ù…Fw( •üG­E\02(\Ò(’4P¨ *¨\0\éLºµ†ò\ÖKi\Ğ<R.\×S\ÜzT\ÔP\01ÒŒJZ(\0À£Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@ÿ\Ù'),(155,32121321,'Jose','Mendoza',122321321,'1999-10-13',_binary 'ÿ\Øÿ\à\0JFIF\0\0\0\0\0\0ÿ\Û\0C\0		\n\r\Z\Z $.\' \",#(7),01444\'9=82<.342ÿ\Û\0C			\r\r2!!22222222222222222222222222222222222222222222222222ÿÀ\0\0\È\0¾\"\0ÿ\Ä\0\0\0\0\0\0\0\0\0\0\0	\nÿ\Ä\0µ\0\0\0}\0!1AQa\"q2‘¡#B±ÁR\Ñğ$3br‚	\n\Z%&\'()*456789:CDEFGHIJSTUVWXYZcdefghijstuvwxyzƒ„…†‡ˆ‰Š’“”•–—˜™š¢£¤¥¦§¨©ª²³´µ¶·¸¹º\Â\Ã\Ä\Å\Æ\Ç\È\É\Ê\Ò\Ó\Ô\Õ\Ö\×\Ø\Ù\Ú\á\â\ã\ä\å\æ\ç\è\é\êñòóôõö÷øùúÿ\Ä\0\0\0\0\0\0\0\0	\nÿ\Ä\0µ\0\0w\0!1AQaq\"2B‘¡±Á	#3Rğbr\Ñ\n$4\á%ñ\Z&\'()*56789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz‚ƒ„…†‡ˆ‰Š’“”•–—˜™š¢£¤¥¦§¨©ª²³´µ¶·¸¹º\Â\Ã\Ä\Å\Æ\Ç\È\É\Ê\Ò\Ó\Ô\Õ\Ö\×\Ø\Ù\Ú\â\ã\ä\å\æ\ç\è\é\êòóôõö÷øùúÿ\Ú\0\0\0?\0÷ú(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n*9\åA$¬	¥ˆ\Ã5\ç\ŞøÃ¢ø«\Ä0\è\Ö\ÖW°O0b0M¤¨\'1ô4\è´UmBö-7M¹¾œŸ*\Ş&•ñ\×\n2•pşø·¤ø\Ç]]&\Î\ÂúŒm&ù‚m\Âı\Ğ \ÑTµ]V\ÇDÓ¥¿\ÔnR\Ş\Ú!–w? õ>\Õ\çö¿ü%s¨‹V7pFÍ´\\K	õ<\äÂ€=6Šd3Gq\nM¬‘º†WSÀ÷ú\0(¢Š\0(¢Š\0(¢Š\0(¢Š\0(¢Š\0(¢Š\0(¢Š\0(¢Š\0­¨\È6\ëş¸¿ò5òŸ‡/#\Ò5_\nj\ÈnŠNÃº™\çğ\Ü?\nú³Pÿ\0m\×ıq\äk\ã\Â\ÅôTˆuX<õú¬\Î?“7\å@Iü\\\Ôÿ\0³~\Z\ê„6\à-ºÿ\0À?¦k\ËşÂ|E\ÒbD\nWJ>V\ÜrO\ã\ÅhüQ×—[ğƒ-ƒ\çû@-Ì¸ôU\0ş¬ß•e|#˜\Ü|G\Ó\ç=d°¸o\ÎF ÿ\0\Zµ¿¶ø4™YŸ¦[‹™¢dÂƒù\Ì\×}¡x–\ÃC‡W\Õôt\Z,\ØùV5RŠzW\Øşuµñj\'ƒ\â´\Ì2y”z¨\Úùö¯ E¶\âo\ÅÈ³X^@ŒTte @Á-fi´­C@¸˜\Êt\Ù\Ïx_•ş_­z­e\Øø{K\Ó5¾²´	\ä…`sÀe^™Õ©@Q@Q@Q@Q@Q@Q@Q@Q@µù\İ\×şF¾:·aö&68Y¢’>\İ\×ú\×Øº‡üƒn¿\ë‹ÿ\0#_Cb×¶Ğ”\'}½Œ·\ìJ\Äş™ :µ\Åå•¼s\ä.“e$\ç\Õİ¿ø¿Ò»Ÿƒ_ò>i?ö\r›ÿ\0F5rP\éŸo\ÔÅºŒ.£t²vŒ\'˜\ßúü«­ø5Çt¯û\Ïÿ\0£\Z€:ßú#Xxš8ŒÄ¦\ÖõTs\å·CúŸÄŠ­ğƒÆ†\Âq\áRpPüúmÁ<H§¿\áøŠö]B\Â\ÛT\Óç±»‰e·\nHĞƒ_.x¯Â—\Şñ\Ñ\ÚGÂ±ŸI»\Îvg\×úıh\êÁEr¼Sÿ\0	oƒ\ío\ä#\íi˜n@\í\"õ?ˆÁük¬ Š( Š( Š( Š( Š( Š( Š( Š( \nÚ‡üƒn¿\ë‹ÿ\0#_3ü4²]K\ÅV.2·\Z]\ÜGşdôÆ¡ÿ\0 Û¯ú\âÿ\0\È\×\Î¿\ä\Ñ\ë\Ê\ãÿ\0Bz\0¿\àx‚\ß[KcL’\Ú\ÛLÓ®9p\ìAñ\Ã~J*§Á¿ùt¯ûOÿ\0£\Z¾…Õ‡üI¯¿\ë\ŞOı\×\Ï_ÿ\0\ä}\Òÿ\0\ì?şŒj\0úCp\ç‘\ÇZ\à>0h‘jº¼Zq0\È:®\Íú!\\O\ÅKıwHñeõ•\ìñ[j\Öhñ*¶‘£Ğ?Š\ÍÖ¾1É¯ø!ü>šdƒSºˆ[\Êùù{@\ë“ıhw\àe\á\Z¾¿d¼C*Cxª:\Ã\'ÿ\0B•{]x¯À\Ûş\Ö\×o‡0\Å6J\ã£2/Í\È~u\íT\0QE\0QE\0QE\0QE\0QE\0QE\0QE\0QE\r\äm5”ñ\'\Şx\ÙGÔŠò\ï|-¿ğ¯ˆt}R[\Èg\ÛK\Â(\Æ\Æb\Ä`÷6+\Óu?¶f]gùmò\Û\Èó~\îüqŸl×\ç\â\ïıK\ßøÿ\0øP¡\ê½Æ›uc/$N‹ŸR¯3ğO\Â\ëÿ\0\nx‹K\Ôå¼ŠuŠ\ÎHgE\Ø\ÌÅ†=G8ü*\Î~.ÿ\0Ô½ÿ\0…ø½ÿ\0R÷ş=ş\Ñx\ëÁ6\Ş5\Ñ\Ö\İ\äû=\ä\r¾\Ú\ä˜\Ûü\ry,_\n|u5\á‚Yt\è×¾@¾a\Î@İŸ\È\×qŸ‹¿õ/\ã\ß\áF~.ÿ\0Ô½ÿ\0…\0v>ğÍŸ„´4›,²Ç–yÁ‘\ÏV5·\\ß„¿\á+ò®¿\á)û™¹|±\ç\ç9\Ï\á]%\0QE\0QE\0QE\0QE\0QE\0W!\âOI ø³I²‘£W6ó¼¤AE\ÈÁü1ø\×9¤|BÕ®ô\Ù\'–;vuÒ§¾)zHT½0(¸»ñ^‹a¬®“uWŒ¡‚>G^œô\Ílƒ‘^1\â[_\ê§R\Ól®\'·\Òà¾·.˜;şRTœäœñ\í]8Õ“\Åi\ÚÀtX\îâ°•ÿ\0\Íu\ÎG°\Í\0z=ÁXk)ÿ\0±¯\Ú\Ó\ì9.F¹q%W\'<\â¤\Ô|M¯ŸI¦\éZtW&{“û\Â$\Êû@\ÍÁ\è2¿\Ô|Aga,P¬sOy@„€¿y¤¿ñı¯ˆnt•Š\ë©\Ú\ÚÅyU,O\Ô`\Ğ{Es6\"’\ë\â§¡U­¬r®Í¸\ãvï¥£Ä\"“Gñ‡¬¦\ÍBå£—p\É\Æ\0üX~T\ÓQ\\¯\ã=F\Ã\Å\í\áô†,\×\ËjH<\Ä\à\ïcô\"¨ø,üK«¸³m;N’X`]¿1upy\éƒ@EGo!–\Ú)« cq\\>½\ã+ı3\ÄwZ|1BbŠk4\Î&bò\Ç\ŞQ^i¨x\ã]2\ËL¶¶k÷\Ô\îm¢/÷DP¨bO=Ni£Çšş«6˜4=2)³f—wq±ùˆ/´„úM\0zm\å\Ú\ß\Ä[\İ0x–0‹›+˜c´½Ÿ$ƒ\Ï\'\n:±m\â1ñ>¢ÿ\0d:f–\×B»~c\"Œó\Ó\é4W-7ˆ®\ã»ğ¬!#Ûª‚f8û¸‹u4\0QE\0QE\ã\ß´»\İ__\Ñ\í\ìGm¥`‘‚X\ÊO¯>Õƒ §‘£\Ü\ÄÍ»\\ø…{eÎ‹oq¯Zj\ì\Ïö‹h^\0ü»_\Ï\ä+š½ø_£^\Ù\Ù[®£[Rÿ\028Df\Ü\È\ÜtÉ %ñ¼\Ëpú„9\Ì66PH;l’	?÷È®±ÿ\0\ã\æ\ìwÿ\0„Óø\0®\ïTğ&›ªC©F\Ï,_n\Ûn0‚#”Ûšl\0\ÒdñLZó4şle\\Ã»÷m\"ª\äz@økş&>7ñ.¬yH,!>\È2\ØüMTñ^tYøš\Æu9x¬õ+p\ßz7l+c\Ôüª÷‡ü¯KªGª^Le.\Ï„l%ºœÖ¦\Õü	¥\ë$·\Ögi\ÖH\Ê\"F\ÂJP\åKj\0\â¼)ÿ\0#–™ÿ\0_z§ş„*Î±e#üvÒ¨š$ºBÑ¬€\Z\Ü\Ô>\ZY^4\r£yj\Ğ\Ï,\á£#$\ÈAaÓ§\ÑË [\Ë\â+MiüûkvWŒ{ÿ\0?Î€<\×Ã·\Ì\ßo\îRî¤\ÔJA\Ø\ŞX^õ9úŠ>)_<^7\Ñ]\"•\×OH\îG™G-\è\\}H®ö\ÛÁº}¬ösG$şe­Ü·jÅ¾ó\É÷³\ÇJv©\àû\rZ}J[—›uıº[Éµ±µ\î}9 [^¹°_>Y3f»eƒ\ìıc•»ñ\ëH\èm\rü\ŞR¡·\Ù\ãı\Ú\î\î|§\İj\ÃS–kƒv²A\"¸aò˜\ny¬\Óğ\Ò\ĞÏ¬?ö•ç—©‡ó\"\ÈÚ…˜1 c¯ Šÿ\0S:G…&\ÔD^iµ´óvg°¹\Æk\Ê<Su>£«\Ş\İZ\í\æ\àioNB;+“\è	\ê\Z/†!\Ò|;.‹5\Ì÷\ĞK¼;Nr\ÅX`++Nøm¤\éö-l³]HZ\ê+ƒ#¸-û³”^\0pšº_\Ó\ÖıÑ®\×S\Õ\ìŸt¿”›ˆö\ÎjÕœm¥x\'\Ã\Ş)°E\æŸÛ˜7®·i bx®\ÏSøu¥jvs@\Ó\\\Äò^\Éz&Àeg`=ˆš\Ã]P\Zrşş\ì¢XvFø\ÆB·¯?Î€<\Æ\ÚM\å÷‰õıR\ÙGq™Hj©Œûøw6kt<3ñ\Ô\Ú«‘\Z÷ƒ¸=6şU\Û\\ø3Oº²\Ö-\æê²¬³ma•+·}\Ê+1~Ú¥ş¯p5+ÍššÊ²C‘±L‡$¢€*Ü‘ı¥ğ÷ı\Öÿ\0\Òzô\0s\\ü.ô‹k­j\0\ÛL\Ò\Ç6FõÊ…\Ú8\à`Wwm\Ù\íb‡qo-\î=N3@\ÑE\0QE\0QE\0QE\0Sdm‘³c;A8§T7r<6sKfGHÙ•ñ8\Í\è~,m[Q*\ëo£E¹|º°\ÚnÜ–8ÿ\0t\×Gm{myoö‹i’Hr\Ãz2	ò ×’\İÚ›\æ7\ZU¤2Z\\k¦´µ2´ğBĞŒõ<+y­{T\ÔôŸjöw6³­¤3#H\ê§%]•¦ò\Çu\0¹\ãû\Ş\Ô\è\ÒO1™%‘Q˜\à\nU–6}Š\ê[À<\ãÖ¼\Ò\'½ñƒ¢}>Y-\î&¸¿2]B³F¬=İ—¸Z¯\á\èõ};\Ä\ê÷3\Ã6—Oq•Ú‹\Ì`g\ïª¹\ÇBNhÔšx•K4ˆXp}*(õI\rÀKˆ\Ï\Ù\ßË›Ÿ¸\Øğ#ó¯;—¶¼‡ûV·;÷@\çÌ½*Il\Ã{ó\Ó\ä\çzş\ËYŠI#]>\àZ\ŞI\Í\Î\ëv™TmtPTrÍGb¹4\ë-sn\İ2\r˜İ–g¦i¶·–÷±´–\Ó,¨®Ñ’§8e8#ğ\"¼†]?Rkx?\â]|¬X¦ \ÓZ´¹#xŒ\0>ş^z»/\ÚjZl\×\Ö76\Ïüò\ï\Ğ\Èê¤…=À;³\ï@Q@Q@Q@Q@Q@Q@Q@Q@\rH\Ò1„EQœ\àV_ˆôEñ.›$\ïR²ù…Fw( •üG­E\02(\Ò(’4P¨ *¨\0\éLºµ†ò\ÖKi\Ğ<R.\×S\ÜzT\ÔP\01ÒŒJZ(\0À£Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@ÿ\Ù'),(156,23123121,'aaaaaaa','sssssss',213213213,'2023-10-04',_binary 'ÿ\Øÿ\à\0JFIF\0\0\0\0\0\0ÿ\Û\0C\0		\n\r\Z\Z $.\' \",#(7),01444\'9=82<.342ÿ\Û\0C			\r\r2!!22222222222222222222222222222222222222222222222222ÿÀ\0\0\È\0¾\"\0ÿ\Ä\0\0\0\0\0\0\0\0\0\0\0	\nÿ\Ä\0µ\0\0\0}\0!1AQa\"q2‘¡#B±ÁR\Ñğ$3br‚	\n\Z%&\'()*456789:CDEFGHIJSTUVWXYZcdefghijstuvwxyzƒ„…†‡ˆ‰Š’“”•–—˜™š¢£¤¥¦§¨©ª²³´µ¶·¸¹º\Â\Ã\Ä\Å\Æ\Ç\È\É\Ê\Ò\Ó\Ô\Õ\Ö\×\Ø\Ù\Ú\á\â\ã\ä\å\æ\ç\è\é\êñòóôõö÷øùúÿ\Ä\0\0\0\0\0\0\0\0	\nÿ\Ä\0µ\0\0w\0!1AQaq\"2B‘¡±Á	#3Rğbr\Ñ\n$4\á%ñ\Z&\'()*56789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz‚ƒ„…†‡ˆ‰Š’“”•–—˜™š¢£¤¥¦§¨©ª²³´µ¶·¸¹º\Â\Ã\Ä\Å\Æ\Ç\È\É\Ê\Ò\Ó\Ô\Õ\Ö\×\Ø\Ù\Ú\â\ã\ä\å\æ\ç\è\é\êòóôõö÷øùúÿ\Ú\0\0\0?\0\æ›-ów¦\îo\ïR§\ëE}òbno\ïQ¹¿½KE\0&\æşõ›ûÔ´Pno\ïQ¹¿½KHh\0\Ü\ßŞ¥\Ü\ßŞ¤ŠR\n‚\Ìx“E\×Q\Úı\Ü\ßŞ¥\Ü\ßŞ¦\È\Ë&Rr€g\ëOUC„f§_•\é\ÉG›d7sz\Íı\êv\ÃÚ£Sº\"\ÌM\Íı\ê77÷¨\Ù\ëAÀ77÷¨\Ü\ßŞ R\Ğ!77÷¨\Ü\ßŞ¥¢€sz\Íı\êZ(77÷©\Ê\Í\Ï\Ìi(=h`©ú\ÑA\ê~´PHzR´¡s@\ì%9W4\åJ•R•Æ¡rJGRªS‚Ô¶j©20BT€İ‰+-u ö²¬¼\È~U\0u\ÍhjsùeGŞ“\åNÿ\0\çŞ¹\Êò1ø¹B§,;C•`!R“U\ÕYúZ\í\Ş\Ö;q\Ğ}ã¾”\æ\Ô\'ò\Õ‚G?@°»s€>´ÿ\0³\ì?*ò¾±S~n–=¿ª\Ñ\ë»7¹H\ìr\Ì\ÄûšT–H\Û(\Ì>Š“\ìÿ\0\íÊ˜\Ğ0\ä\ÖjO{›òE«[CF\ÏQ\Ş\ŞUÁ?u¿Æ´\Ì|\×-\Ğ\×I¦\Ïö›AŸ¼‡i¯k/\ÆJo’n\ç\Íf\Ù|i¯mIY1\Í0¥[+M)^ºg‚\àS#š*\Ã%F\ÉN\æN6\Z:QM\Æ)\Ô\É\nCÖ–õ¤·Vú\Ói\Ì2\Ä{Ó‚ô¡+ˆ«jUJUZ”-M\Ícªµ\"¥(+F\è\äa‘‘‘\ÔT¶l£¡\àµ7\Ù\å	LMå“ø8¦â’•öeòµº9f]÷\Å?\ç˜ù\ÕdEŒeˆ\Ü}kB\ßN›XñG\Ø`|²•\É\è\0\êO\Ğs^ß¥øcHÑ¬\ÂGm?y4ª7¹&¾W7*²~g\ÙĞµ*‘\à{\Ôôeü\és^ÿ\0>¿‘’\ìfu\êTš¼?£·]6\Øÿ\0\Û1X^Æ¾\×\Èù\ë\"²¬\ã_C\Â=£³m¿\ïØª\×xr\ÂE\â;]º+ªƒE\Å\í|Ÿ\ÙVE%J\äw«º\ây£şò\çò?ız÷\r_\ÂúF¹`c6ğ£\ÌSD =ˆ\ÇQ^/„úW‰§±v\Éea\Øûıñ®¬­^\'>5ª˜i®\È\Ô\"¯.)ÿ\0g”\Äe1Œu|Æ¾›™-\Ùò\n-\ì®Te¨\ÊÕ¥\ßv\ÔfÀ\ÉÀ\Î­3U¦Œ\ÜJŒ•\Z¶\Ë\ÍD\ËT™Œ¢W¥ô¥+I\éL\Î\Ö\æ?Z•V…1©TR¹´P(©@\æ…\à=j:š¥¡·\á½\Z\ßY{˜$ŸËœ 1S\ÎO¾8ü\ë§Ô´±«h¾S\Å\åjVŸ.\0\àñ\ĞB9C\Ã7\ZeÕ”v2ÿ\0£\Ş\ÄKE(\á‰õúw®µC•C¹ñó61“_;\ÅN[\êŸO\ë\Ìú<§Ë£V\×úò9½s^µ¶µÜ¤l\é\ÆOò®#W¡x²0\Ş˜‘Ê²ÿ\0}ıMp–\Ö\íssF\n+»,¨¥A\Î]\ÙÇ˜\Ój²Œ{\"÷Ã‹“\Åz¥\Û.|„Àö.zş@× k\Z\\š\Â\Åhó4VY\İ7–p\Òz.}=\n\Íğ¾šEşª©’²4D1\ï„\çõ&ºIwÚ‡\Ä(?S^$\ß=V\ã³g¹\Æ\nıüŒ›mA´š5¶µ‚)£?+!\Ãõ­Ğ¼Z\áõ\ÏXh$ƒC\Ö\ŞKIQXO™|\âü==+¶·,aJ\ås\ëõ¥Z<‰6eN¯;cˆ\Çl\Ö%îƒ »?\Û-`w—–i>ñ÷\Ín\ÏJ\àõ\ïZh\"ƒI[Hn.\ç($yŸKr~s\î*iR\çc©S‘¥¶²[\Å1–Ä\Ğ9hıW=\Çqø\×\ã\İ=`ñ}\êŒ}¦İƒR¼\"+\ÓDQ\Âû!ux\ØeJœ€zù\×?\â}j\íhs¶HVB‡Üş\éµK¹¶B¨\İJ2Qİ¦y¶:\×q¡b÷Áwv\å7º‰#U’H\ÈşuÅ²H †\Õ\ßxV ºD±?\\×±šO–‚kº<|¶Ÿ5fŸfE¥\éŸ\Ù\Z(EˆK©]ü»H\ás\Øûõ\ÌøFµÑ´\Ìdœ®e\ÈûW¡°p­\å°W\Æ‘œW+\âk6\Ò\ÆK±s})Y$õ\'·Ò¸pXª•*\ßV\ï¯õ\ävc°´\áJ\×\Ò\Ú9\Ö^*b)Œ8¯¢\ê|\ëEVZo5e…Gj\Ìg@>cR(¤šx,\Õ!@\æ¤)RŠ“Toxrÿ\0K´óR·\ŞY@\ÉL~¿•z$,—‰\"`\è\Ã ƒÖ¼€U˜/.­\\\Ë=‘ˆ\æ\ã2õ^\\\éÙ\èÇ–\Ú—¬\ÃdúM\Ï\Û\æ\ÙÆ›å”Ÿ¸9ú×ø.ò\ÛS\Ö\íæ‰@\î\áƒÂœd}9®k\Ç^!\Ô\îô»)\É[\Ë;$\Ìù8\İô\ã\\ÿ\0…5÷ğö¹owÉ‡xóÛ¦Z\å¥JT!*M\ïs¦siÆª[LGGv\îø\Ï\áO”² u\êŒò5\r•õ¶£mÍ¤«$N ‚­Z\í^JN×¡\ê]N:u<\Æ/…GŠ\×V[ˆOYK¶p‡<m=À8ô¯N·R°ƒ‚\Øô¥D¶–\âMû9ô\É\Ç\åV×¥tÕ«Î’9\é\Ò\äw20{ñ^o\ã?‡\Ï\â­B«Y!I#?¼\Şû[\n3\î¸Q^“š­=¬3°.™oPH?¥*u}›J|\è\Ï\Ğô\èô\"\ÛO…üÄµa“û\ÎIf?™5rU\ÎXõ\çò©U8Â G@+3X\Õ-ô»šwU;I\nO,k^¬ıŞ¦‘µ8\İô<·\Ä7\Ö\Úm\í\ÌÓ–òüò¸A–9<\à~u\é\Ú,vi¤\Úÿ\0g\Ì&³’=ñJ?Œ?jù\Ó\Ä\Z»\êú‹É»1);}ó\Ôş5\Òø\ÄZ¥¦›}¥&Z\ÅÀer\Ä_<\íú€r?\Zõñ–!F’{e	Fƒud·=\ÊfH\"2JÊˆ£$±\Ç\ç!¿Ò®ü¸ô\Ûm¡X³JW‰úòk2\âö\î\åB\Ïs4Š:rEV5¶.T3•\ÙÏ‹\Ì%Yr¥ \ÃL\"¥¦\Zô\Ï1¢\"*<rjb)˜æ™›B¯\Ş?Z”TC\ï\Z‘h)¥”\êFƒ–œ:SE8R)µõ)-\ä\ãp\Èo\îÆ¼\æ\æ\ŞKK‡‚U\Ú\èpk\Ôkñ6”.\í¾\Ù\n\æh—\æø—üEsbis+®‡V\Z¯+\ågSğs_.nôY\Û,ª%ƒ=À8#ğ\Èÿ\0\"½pW\Ë\Öe\Ğ5\ËMRŸ\"@Yñ¡\á—ñ¯§¬omõ/md\ß\ÈwšùüL\Z—?s\Ü\ÃK\İ\å\'_\"\ŞIv—Ø¥¶§[HÖ´ıb\İ$·¼…$#\æ…\ß¾\Øÿ\0õŠ¶@e\ÚyŠògÃ·öš¬ööúu\İ\Ò\İ†m\'Œ\àq\éXE\Ù\Ù+´©F­Ô¥cØ®%‚\Î&–{»h\ã%L\n¡¥j±jös°ˆHÈ¬\ßÇ\ãÚ¼|hZºJ#mş&bY\í˜O¾\0\ë\Ú5€\Òô›{<‚c_˜\ïO\ëDŞ»Xs¡\nQMO™²\é5\âüD&\Ö—nüÄ%`zg’¿¯\é^©\âmzh7Z”\ä~\íq\Zww?uG\ãúf¾d¹¹–ö\î[©\ß|\Ó9wsİ‰É®œ$]ù\Ù\ç\âšiD-­äººKxF\é\à\nô=>\Æ=>\Í-\ã\ço,\İ\Ø÷5—\á\'\ì–\Â\îUıô£\å}\Õÿ\0\ë\×Aõ¯w\rK•s3\Å\ÄU\æ|«a”Ö§”\Ó]G \Î\Ô\ÃO4‡¥2Y7½<\Ó;šdsR-D>ñ©€C\é\Ô\Úu#AÂœ)¢œ:R)£ğ\Èô¢Šp¾\"\Ò~Áy\çF1o1$\Ê\İ\Åt¿¼z<9(\Ó5&c¦H\ß$|‡\'Ÿø	\êGn¾µvú\Î;\ë9-\å#:\Ä{Šó»‹),\ï\Z\ÚeÃ¡Ç±µ\å\â°\ë\ä\ÏO]¿S\ê¸fŠx’H\äY#q¹]*À÷¸©ƒ²œ«ô5\ä?\ïo¡\Ô-4ønÙ¤Gf„œ®BÇ¡\Î:W¢\ëZ\Üzœ/.cw‚N7\Zò–¯2PÕÖ©ò·=,m<¯\'/!oj¥¨\Ú\é–R\Ş^LA\ËH\ç\0‰öªz>°šŞ–·öñ¼jX£,ƒ¡ı\ëË¾ \Ïss©^\Û\ÜN\ì\ã\ËF?*ğ\×ŞŸ\Õj¹Z¦õŠ|·†·9Ÿø\Êo\êJUZ->Ü‘o8\É=]½Ï§aø“›\á\í\'ûB\ìK2ÿ\0£BF\ìôs\ØV}µ¤·—‰oİ±ô÷5\è–6qXZGoÀNı\É\îk\Õ\ÃQMù#\Í\ÄViy²\Ç=\Ï4QEzHóFšm8ô¦\ÓHzRµ4õ¦H\ÓL=i\æ™Ş™q£\ï\Zx¦\Í<\Z	C\Å8SA¥ñN¦­:‚‡R\ÓGZp¤PW+\â`¨[F yY,{\ã8\ÕWªIövv\ê#\Âûñ\Ísb]¡c£\r\Î\ç}ğ\Î\Õcñm¢/ G!\'şÆ½/\Çöğ\Ã\à]@´j\Ç(W=ñÿ\0×¯;øT\â@ŞIŸ\È\nôŠRü\Z\è<\É\Ğ~Ÿ\é\\¸uz±^gV&_¹“ò.ø2\ÚğF•µ¯”	Ç®NO\âk\É>#Z¬¾,\Ô#\'2\à ×¬ü8“\Íğ.3\Êÿ\0\ß\Æş•\å_œE\â\íGÕ¼°?ZU•ª\ËÕ†øq~G!\áEŒ]İ‚£\Î\n»[=¹\Ï\ëŠ\ê{\æ¸\İ_³ë‘ƒÀı2?•vUÙ†wË‰V˜R\ZSM=k \çšO4§¥6™\"\Zi¥=)¦1¦›Ş†8¦†¦d\ØÀ\ß1©T\Õ`~cS+SdÅ“\Í<*%4ği\Z&<\Zp<S3KšE’f”S\æ”\ZLiŠ\î˜\à(\É5Á\Â\Æi$.KÆº\Ír#F¸`~g]ƒñ\ãùf¹8\Æ\Ës\\8¹^I†{­ƒğf\ãwd‹¸¶w_\Ìı+\Ğ>/M³@°‹?\ë.y )¯!øm\âM3\Ã&¹\ÔuC6\ÓnbO)7–÷ö®·\Ç^8Ò¼Zº|:cN|–¸–=¼¸\Ç>Æ§\×\Ö\"\ßq\ãSöI\ïÂ¹·ø0.yK‡_\ä­yW\Å\Éÿ\0\â\à\\B8\\n\0*\é<\ã½\Â\ÚTö:œ“	\Z_0£\Ü\0#ó\í\\\Ä}sMñŒWR\Ó$wŠKdWŞ›Hu,é¶–*\Ş\ÚV\î<%ıŒo\ØÀy\r½\ÔWª8a\ïƒ]\à`Ü©\È<ƒ\\\Ãt\0\Õ\Ø\é3ùúE¼™\ç`SõJ\Ó	-Z#´L¼M4š3HMvœ\"Iš	¦“L–\Ó	4LcL†\ÄcQ\çšV<T[¹¦Œd\Æn\äıjEj€ğOÖœ­Š»\ÆV-«S\Ô\Õuz5fÑ´dO”\àj Ù§Ai’ƒFi \Ò\æ‘w*\ê6Qµ™\Z<6\à@\ëXwZ-\Ü0\â0%\0SøWOš3\ÍeRŒf\îoN¼\á§C\Î62JUÔ«¡†*ı»`ÀG Š~ºûõ\Éı¶\ĞV–i\ÂLÒ `0=º\æ¼õ\çÊE\ÔJŸ33.r{\Õ’\Î4goE®“^³†\ŞZ\Ú	!½ê‡f²F~ôL?‘ÿ\0\Z;T\åbUS§\ÏY¶\Ñ.¦‡l D÷¹?•n\éöcO´\âB\à1l‘\ëVsŠ3]ô\èF§R´\êh\Ã4f“4„\Ö\Æ7â™šM\Ô\Â\ÔÈ¸1\æ˜ÇŠFjšFrŒ\Õy¤f\Éâ’®\Æ-\ê)\ê~´†”õ?Z)*·*½CŠ@H¤\ÑJV-«Tª¢¿½J®1RÑ´fY\İJ\Z«ï§‡©±¢‘8<Qº¢\Å)jCOS‰\Ô_\Ì\Õ\î›9ı\á•t\Ú\ìÓ·\âr¥rN\Şe\ì\ïÙ¤cú\×g¦¯—¦Ûƒ\×f\ïÏš\à\Ã+\ÔlôñO–’DZ\êùšvq÷7óÖ¹ı¶k\Ö\ç±Ü¿øé®—S_3NG]¹ü«‘²rš­©:x…j©‹\r+Ñ’;\Ì\Òf™¾›º»\Ï7˜µ4½1ŸqE‰r$/Q³û\Ó\Ôl\Õi\Êc\Ù\ê&bi	É¥\Å4Œ›¸‚ƒKHz\ĞH§©ú\ÑAû\Ç\ëE0\nL\nZ(n#½-&Ş$÷¨p(4¬‡\Ïb\Èz»Q˜\0&³/¯ÅŒA¾ô÷V³£\Ö\Şd’)\Õz•½²;\Ö«¾VuÒ£Vq\çKC.Y€\îMw‘ªÿ\0t\\Ÿi$·GJ\Æ\Ãsv#\ÔWNe\É\éX`\à\Õ\Û:³\n©8\Æ%‰’6O\ï¿p\è\Å.\án„:ŸÖ»\rõ\Ë\İY\È5•\Ùe\ÉÀ\Ç\'úQŒ‹\\²TÔ¢Î¿}\ë]z8\ä\n‘³\íœg\é\ëZ0\Ü%\Ì+,m•oÒºa:rvL\ã«N¬4–Œ²\Ò{\ÓKqLõ¥À­Nnf $š\\QŠ)ˆ0(¢Š‡­-!\ëH\0Ÿ˜ıhQL¢Š(\0¢Š(\0¢Š(\È\Ş(\Üüñ£¼ \Ó\r­±\ëoıû\áE.1}\Ï%¢c\Ö(\Ó;W8ñÒŠ)¥m…võ`@Z{k—-4[˜€	$ôQD’’³\Zœ¡¬]ˆÆ“b:Aÿ\0·øÕ˜-\â·B¦\Õ\'$dh¢¥S„uHr«Rj\Òm’\ÑEdQ@Q@“Eÿ\Ù');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `venta`
--

DROP TABLE IF EXISTS `venta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `venta` (
  `ID_Venta` int NOT NULL AUTO_INCREMENT,
  `FechaVenta` date DEFAULT NULL,
  `TotalVenta` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`ID_Venta`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `venta`
--

LOCK TABLES `venta` WRITE;
/*!40000 ALTER TABLE `venta` DISABLE KEYS */;
INSERT INTO `venta` VALUES (42,'2023-10-23',28.00),(49,'2023-10-23',50.00),(50,'2023-10-23',50.00),(51,'2023-10-23',10.00),(52,'2023-10-23',10.00);
/*!40000 ALTER TABLE `venta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vistaclientescondeuda`
--

DROP TABLE IF EXISTS `vistaclientescondeuda`;
/*!50001 DROP VIEW IF EXISTS `vistaclientescondeuda`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vistaclientescondeuda` AS SELECT 
 1 AS `Codigo`,
 1 AS `Apellidos`,
 1 AS `Nombres`,
 1 AS `PrecioMembresia`,
 1 AS `MontoPagado`,
 1 AS `MontoRestante`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vistahistorialsocio`
--

DROP TABLE IF EXISTS `vistahistorialsocio`;
/*!50001 DROP VIEW IF EXISTS `vistahistorialsocio`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vistahistorialsocio` AS SELECT 
 1 AS `ID`,
 1 AS `ClienteID`,
 1 AS `Apellidos`,
 1 AS `Nombres`,
 1 AS `Telefono`,
 1 AS `FechaInicio`,
 1 AS `FechaFin`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vistahistorialsociomaÃ±ana`
--

DROP TABLE IF EXISTS `vistahistorialsociomaÃ±ana`;
/*!50001 DROP VIEW IF EXISTS `vistahistorialsociomaÃ±ana`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vistahistorialsociomaÃ±ana` AS SELECT 
 1 AS `ClienteID`,
 1 AS `Apellidos`,
 1 AS `Nombres`,
 1 AS `Telefono`,
 1 AS `FechaInicio`,
 1 AS `FechaFin`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vistaproductosconstock`
--

DROP TABLE IF EXISTS `vistaproductosconstock`;
/*!50001 DROP VIEW IF EXISTS `vistaproductosconstock`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vistaproductosconstock` AS SELECT 
 1 AS `ProductoID`,
 1 AS `NombreProducto`,
 1 AS `DescripcionProducto`,
 1 AS `NombreCategoria`,
 1 AS `PrecioProducto`,
 1 AS `StockUnidad`,
 1 AS `ImagenProducto`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vistaproductosconstockporporcion`
--

DROP TABLE IF EXISTS `vistaproductosconstockporporcion`;
/*!50001 DROP VIEW IF EXISTS `vistaproductosconstockporporcion`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vistaproductosconstockporporcion` AS SELECT 
 1 AS `ProductoID`,
 1 AS `NombreProducto`,
 1 AS `DescripcionProducto`,
 1 AS `NombreCategoria`,
 1 AS `PrecioProducto`,
 1 AS `Stock`,
 1 AS `ScoopsPorPote`,
 1 AS `ImagenProducto`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vistausuarios`
--

DROP TABLE IF EXISTS `vistausuarios`;
/*!50001 DROP VIEW IF EXISTS `vistausuarios`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vistausuarios` AS SELECT 
 1 AS `Codigo`,
 1 AS `DNI`,
 1 AS `Nombres`,
 1 AS `Apellidos`,
 1 AS `Telefono`,
 1 AS `FechaNacimiento`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'lucianogym'
--

--
-- Dumping routines for database 'lucianogym'
--
/*!50003 DROP PROCEDURE IF EXISTS `ActualizarProducto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ActualizarProducto`(
    IN p_precio DECIMAL(10, 2),
    IN p_stock INT,
    IN p_fotoProducto LONGBLOB,
    IN p_productoID INT
)
BEGIN
    -- Actualizar StockPorUnidad
    UPDATE StockPorUnidad
    SET CantidadEnStock = p_stock
    WHERE ProductoID = p_productoID;

    -- Actualizar Productos
    UPDATE Productos
    SET 
        Precio = p_precio,
        ImagenProducto = p_fotoProducto
    WHERE ID = p_productoID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ActualizarStockYProductoPor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ActualizarStockYProductoPor`(
    IN p_cantidadEnStock INT,
    IN p_scoopsPorPote INT,
    IN p_precio DECIMAL(10, 2),
    IN p_imagenProducto LONGBLOB,
    IN p_productoID INT
)
BEGIN
    -- Actualiza StockPorPorcion
    UPDATE StockPorPorcion
    SET CantidadEnStock = p_cantidadEnStock,
        ScoopsPorPote = p_scoopsPorPote
    WHERE ProductoID = p_productoID;

    -- Actualiza Productos
    UPDATE Productos
    SET Precio = p_precio,
        ImagenProducto = p_imagenProducto
    WHERE ID = p_productoID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `BuscarClientesPagos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `BuscarClientesPagos`(IN valorBusqueda VARCHAR(255))
BEGIN
    SELECT u.Codigo, u.Nombres, u.Apellidos, e.PrecioMembresia, e.MontoPagado, e.MontoRestante
    FROM PagoMembresias e
    JOIN Usuarios u ON e.ClienteID = u.Codigo
    WHERE u.Apellidos LIKE CONCAT(valorBusqueda, '%') AND e.MontoRestante > 0;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `BuscarProductosPorNombre` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `BuscarProductosPorNombre`(
    IN p_nombreProducto VARCHAR(255)
)
BEGIN
    SELECT P.ID, P.Nombre, P.Descripcion, P.CategoriaID, P.Precio, SP.CantidadEnStock, SP.ScoopsPorPote
    FROM Productos P
    INNER JOIN StockPorPorcion SP ON P.ID = SP.ProductoID
    WHERE P.Nombre LIKE CONCAT(p_nombreProducto, '%');
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `BuscarProductosPorNombreUnit` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `BuscarProductosPorNombreUnit`(IN p_nombreProducto VARCHAR(255))
BEGIN
    SELECT P.ID, P.Nombre, P.Descripcion, P.CategoriaID, P.Precio, SU.CantidadEnStock
    FROM Productos P
    INNER JOIN StockPorUnidad SU ON P.ID = SU.ProductoID
    WHERE P.Nombre LIKE CONCAT(p_nombreProducto, '%');
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `BuscarUsuariosPorApellidos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `BuscarUsuariosPorApellidos`(IN p_Valor VARCHAR(100))
BEGIN
    SELECT e.Codigo, e.DNI, e.Nombres, e.Apellidos, e.Telefono, e.FechaNacimiento
    FROM Usuarios e
    WHERE e.Apellidos LIKE CONCAT(p_Valor, '%');
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `EliminarProductoPor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `EliminarProductoPor`(IN p_ProductoID INT)
BEGIN
    DELETE FROM StockPorPorcion WHERE ProductoID = p_ProductoID;

    DELETE FROM Productos WHERE ID = p_ProductoID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `EliminarProductoUnit` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `EliminarProductoUnit`(IN p_ProductoID INT)
BEGIN
    DELETE FROM StockPorUnidad WHERE ProductoID = p_ProductoID;

    DELETE FROM Productos WHERE ID = p_ProductoID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `EliminarUsuarioYRelacionados` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `EliminarUsuarioYRelacionados`(IN p_codigo INT)
BEGIN
    DELETE FROM PagoMembresias WHERE ClienteID = p_codigo;

    DELETE FROM HistorialSocio WHERE ClienteID = p_codigo;

    DELETE FROM Usuarios WHERE codigo = p_codigo;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertarCliente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarCliente`(
    IN p_clienteDNI INT,
    IN p_clienteNombres VARCHAR(100),
    IN p_clienteApellidos VARCHAR(100),
    IN p_clienteTelefono INT,
    IN p_clienteFechaNacimiento DATE,
    IN p_Foto LONGBLOB,
    IN p_precioMembresia DECIMAL(10, 2),
    IN p_montoPagado DECIMAL(10, 2),
    IN p_clienteFechaInicio DATE,
    IN p_clienteFechaFin DATE
)
BEGIN
    DECLARE clienteID INT;
    DECLARE montoRestante DECIMAL(10, 2);
    
    INSERT INTO Usuarios (DNI, Nombres, Apellidos, Telefono, FechaNacimiento, Foto)
    VALUES (p_clienteDNI, p_clienteNombres, p_clienteApellidos, p_clienteTelefono, p_clienteFechaNacimiento, p_Foto);
    
    SET clienteID = LAST_INSERT_ID();
    
    SET montoRestante = p_precioMembresia - p_montoPagado;
    
    IF montoRestante = 0 THEN
        INSERT INTO HistorialSocio (ClienteID, PrecioMembresia, MontoPagado, FechaInicio, FechaFin)
        VALUES (clienteID, p_precioMembresia, p_montoPagado, p_clienteFechaInicio, p_clienteFechaFin);
    ELSE
        INSERT INTO PagoMembresias (ClienteID, PrecioMembresia, MontoPagado, MontoRestante, FechaInicio, FechaFin)
        VALUES (clienteID, p_precioMembresia, p_montoPagado, montoRestante, p_clienteFechaInicio, p_clienteFechaFin);
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertarCliente1` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarCliente1`(
    IN p_clienteDNI INT,
    IN p_clienteNombres VARCHAR(100),
    IN p_clienteApellidos VARCHAR(100),
    IN p_clienteTelefono INT,
    IN p_clienteFechaNacimiento DATE,
    IN p_Foto LONGBLOB,
    IN p_precioMembresia DECIMAL(10, 2),
    IN p_montoPagado DECIMAL(10, 2),
    IN p_clienteFechaInicio DATE,
    IN p_clienteFechaFin DATE
)
BEGIN
    DECLARE clienteID INT;
    DECLARE montoRestante DECIMAL(10, 2);
    
    INSERT INTO Usuarios (DNI, Nombres, Apellidos, Telefono, FechaNacimiento, Foto)
    VALUES (p_clienteDNI, p_clienteNombres, p_clienteApellidos, p_clienteTelefono, p_clienteFechaNacimiento, p_Foto);
    
    SET clienteID = LAST_INSERT_ID();
    
    SET montoRestante = p_precioMembresia - p_montoPagado;
    
    INSERT INTO HistorialSocio (ClienteID, PrecioMembresia, MontoPagado, FechaInicio, FechaFin)
    VALUES (clienteID, p_precioMembresia, p_montoPagado, p_clienteFechaInicio, p_clienteFechaFin);
    
    IF montoRestante > 0 THEN
        INSERT INTO PagoMembresias (ClienteID, PrecioMembresia, MontoPagado, MontoRestante, FechaInicio, FechaFin)
        VALUES (clienteID, p_precioMembresia, p_montoPagado, montoRestante, p_clienteFechaInicio, p_clienteFechaFin);
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertarDetalleVenta` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarDetalleVenta`(
     IN pVentaID INT,
     IN pProductoID INT,
     IN pCantidadVenta INT,
     IN pPrecioUnitario DECIMAL(10, 2),
     IN pSubTotal DECIMAL(10, 2)
 )
BEGIN
     INSERT INTO DetalleVenta (VentaID, ProductoID, CantidadVenta, PrecioUnitario, SubTotal)
     VALUES (pVentaID, pProductoID, pCantidadVenta, pPrecioUnitario, pSubTotal);
 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertarVenta` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarVenta`(IN totalVenta DECIMAL(10, 2))
BEGIN
    INSERT INTO Venta (FechaVenta, TotalVenta)
    VALUES (CURDATE(), totalVenta);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertarVentaConDetalle` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarVentaConDetalle`(
     IN totalVenta DECIMAL(10, 2),
     IN pProductoID INT,
     IN pCantidadVenta INT,
     IN pPrecioUnitario DECIMAL(10, 2),
     IN pSubTotal DECIMAL(10, 2)
)
BEGIN
    DECLARE ventaId INT;
    
    -- Insertar venta
    INSERT INTO Venta (FechaVenta, TotalVenta)
    VALUES (CURDATE(), totalVenta);
    
    -- Obtener el ID de la venta insertada
    SET ventaId = LAST_INSERT_ID();
    
    -- Insertar detalle de la venta
    INSERT INTO DetalleVenta (VentaID, ProductoID, CantidadVenta, PrecioUnitario, SubTotal)
    VALUES (ventaId, pProductoID, pCantidadVenta, pPrecioUnitario, pSubTotal);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `MoverAPagoAHistorial` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `MoverAPagoAHistorial`(
    IN p_ClienteID INT,
    IN p_NuevoMontoPagado DECIMAL(10, 2)
)
BEGIN
    DECLARE MontoRestante DECIMAL(10, 2);
    
    -- Actualiza el registro en PagoMembresias
    UPDATE PagoMembresias
    SET MontoPagado = MontoPagado + p_NuevoMontoPagado,
        MontoRestante = PrecioMembresia - (MontoPagado + p_NuevoMontoPagado)
    WHERE ClienteID = p_ClienteID;
    
    -- Obtiene el MontoRestante actualizado
    SET MontoRestante = (SELECT MontoRestante FROM PagoMembresias WHERE ClienteID = p_ClienteID);
    
    -- Verifica si el monto restante es igual o menor que cero
    IF MontoRestante <= 0 THEN
        -- Inserta el registro en HistorialSocio
        INSERT INTO HistorialSocio (ClienteID, PrecioMembresia, MontoPagado, FechaInicio, FechaFin)
        SELECT ClienteID, PrecioMembresia, MontoPagado, FechaInicio, FechaFin
        FROM PagoMembresias
        WHERE ClienteID = p_ClienteID;
        
        -- Elimina el registro de PagoMembresias
        DELETE FROM PagoMembresias WHERE ClienteID = p_ClienteID;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `MoverAPagoAHistorial1` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `MoverAPagoAHistorial1`(
    IN p_ClienteID INT,
    IN p_NuevoMontoPagado DECIMAL(10, 2)
)
BEGIN
    -- ObtÃ©n el MontoPagado actual y el PrecioMembresia del cliente
    SELECT MontoPagado, PrecioMembresia
    INTO @MontoPagadoActual, @PrecioMembresia
    FROM PagoMembresias
    WHERE ClienteID = p_ClienteID;

    -- Calcula el nuevo MontoPagado
    SET p_NuevoMontoPagado = @MontoPagadoActual + p_NuevoMontoPagado;

    -- Calcula el MontoRestante
    SET @NuevoMontoRestante = @PrecioMembresia - p_NuevoMontoPagado;

    -- Actualiza el registro en PagoMembresias
    UPDATE PagoMembresias
    SET MontoPagado = p_NuevoMontoPagado,
        MontoRestante = @NuevoMontoRestante
    WHERE ClienteID = p_ClienteID;

    -- Actualiza el monto pagado en el historial socio
    UPDATE HistorialSocio
    SET MontoPagado = p_NuevoMontoPagado
    WHERE ClienteID = p_ClienteID;

    -- Verifica si el MontoRestante es igual o menor que cero
    IF @NuevoMontoRestante <= 0 THEN
        DELETE FROM PagoMembresias WHERE ClienteID = p_ClienteID;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `newMembresia` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `newMembresia`(
    IN p_clienteID INT,
    IN p_precioMembresia DECIMAL(10, 2),
    IN p_montoPagado DECIMAL(10, 2),
    IN p_clienteFechaInicio DATE,
    IN p_clienteFechaFin DATE
)
BEGIN
    DECLARE montoRestante DECIMAL(10, 2);
   
    -- Calcular el monto restante
    SET montoRestante = p_precioMembresia - p_montoPagado;
    
    -- Insertar en HistorialSocio
    INSERT INTO HistorialSocio (ClienteID, PrecioMembresia, MontoPagado, FechaInicio, FechaFin)
    VALUES (p_clienteID, p_precioMembresia, p_montoPagado, p_clienteFechaInicio, p_clienteFechaFin);
    
    -- Insertar en PagoMembresias solo si el monto restante es mayor a 0
    IF montoRestante > 0 THEN
        INSERT INTO PagoMembresias (ClienteID, PrecioMembresia, MontoPagado, MontoRestante, FechaInicio, FechaFin)
        VALUES (p_clienteID, p_precioMembresia, p_montoPagado, montoRestante, p_clienteFechaInicio, p_clienteFechaFin);
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ps_ObtenerClientesDeuda` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ps_ObtenerClientesDeuda`(
    IN p_ClienteID INT
)
BEGIN
    DECLARE PaymentCount INT;
    
    SELECT COUNT(*) INTO PaymentCount
    FROM PagoMembresias
    WHERE ClienteID = p_ClienteID;
    SELECT PaymentCount AS PaymentCount;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spInsertarProducto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spInsertarProducto`(
    IN p_Nombre VARCHAR(255),
    IN p_Descripcion varchar(255),
    IN p_CategoriaID INT,
    IN p_Precio DECIMAL(18, 2),
    IN p_ImagenProducto LONGBLOB
)
BEGIN
    INSERT INTO Productos (Nombre, Descripcion, CategoriaID, Precio, ImagenProducto)
    VALUES (p_Nombre, p_Descripcion, p_CategoriaID, p_Precio, p_ImagenProducto);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spInsertarProductoPoryStockPor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spInsertarProductoPoryStockPor`(
    IN p_idProducto INT,
    IN p_nombre VARCHAR(255),
    IN p_descripcion VARCHAR(255),
    IN p_Precio DECIMAL(10, 2),
    IN p_categoria INT,
    IN p_imagenProducto LONGBLOB,
    IN p_stock INT,
    IN p_totalScoops INT
)
BEGIN
    INSERT INTO Productos (Nombre, Descripcion, CategoriaID, Precio, ImagenProducto)
    VALUES (p_nombre, p_descripcion, p_categoria, p_Precio, p_imagenProducto);

    SET @productoID = LAST_INSERT_ID();

    INSERT INTO StockPorPorcion (ProductoID, CantidadEnStock, ScoopsPorPote)
    VALUES (p_idProducto, p_stock, p_totalScoops);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spInsertarProductoUnitYStockUnit` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spInsertarProductoUnitYStockUnit`(
    IN p_idProducto INT,
    IN p_nombre VARCHAR(255),
    IN p_descripcion VARCHAR(255),
    IN p_Precio DECIMAL(10, 2),
    IN p_categoria INT,
    IN p_imagenProducto LONGBLOB,
    IN p_stock INT
)
BEGIN
    -- Inserta el producto en la tabla Productos
    INSERT INTO Productos (Nombre, Descripcion, CategoriaID, Precio, ImagenProducto)
    VALUES (p_nombre, p_descripcion, p_categoria, p_Precio, p_imagenProducto);

    -- Obtiene el ID del producto reciÃ©n insertado
    SET @productoID = LAST_INSERT_ID();

    -- Inserta el producto en la tabla StockPorUnidad
    INSERT INTO StockPorUnidad (ProductoID, CantidadEnStock)
    VALUES (p_idProducto, p_stock);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_UpdateUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_UpdateUser`(
    IN p_DNI INT,
    IN p_Nombres VARCHAR(255),
    IN p_Apellidos VARCHAR(255),
    IN p_FechaNacimiento DATE,
    IN p_Telefono INT,
    IN p_Foto LONGBLOB,
    IN p_Codigo INT
)
BEGIN
    UPDATE Usuarios
    SET DNI = p_DNI,
        Nombres = p_Nombres,
        Apellidos = p_Apellidos,
        FechaNacimiento = p_FechaNacimiento,
        Telefono = p_Telefono,
        Foto = p_Foto
    WHERE codigo = p_Codigo;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ValidarNuevaMembresia` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ValidarNuevaMembresia`(
    IN p_ClienteID INT
)
BEGIN
    SELECT ClienteID
    FROM HistorialSocio h
    WHERE ClienteID = p_ClienteID AND
        (
            FechaFin < CURDATE() AND
            NOT EXISTS (
                SELECT 1
                FROM HistorialSocio hs
                WHERE hs.ClienteID = h.ClienteID
                AND hs.FechaFin > CURDATE()
            ) AND
            NOT EXISTS (
                SELECT 1
                FROM pagoMembresias p
                WHERE p.ClienteID = h.ClienteID
                AND p.MontoRestante > 0
            )
        );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `vistaclientescondeuda`
--

/*!50001 DROP VIEW IF EXISTS `vistaclientescondeuda`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vistaclientescondeuda` AS select `u`.`codigo` AS `Codigo`,`u`.`Apellidos` AS `Apellidos`,`u`.`Nombres` AS `Nombres`,`p`.`PrecioMembresia` AS `PrecioMembresia`,`p`.`MontoPagado` AS `MontoPagado`,`p`.`MontoRestante` AS `MontoRestante` from (`usuarios` `u` join `pagomembresias` `p` on((`u`.`codigo` = `p`.`ClienteID`))) where (`p`.`MontoRestante` > 0) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vistahistorialsocio`
--

/*!50001 DROP VIEW IF EXISTS `vistahistorialsocio`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vistahistorialsocio` AS select `h`.`ID` AS `ID`,`h`.`ClienteID` AS `ClienteID`,`u`.`Apellidos` AS `Apellidos`,`u`.`Nombres` AS `Nombres`,`u`.`Telefono` AS `Telefono`,`h`.`FechaInicio` AS `FechaInicio`,`h`.`FechaFin` AS `FechaFin` from (`historialsocio` `h` join `usuarios` `u` on((`h`.`ClienteID` = `u`.`codigo`))) where (cast(`h`.`FechaFin` as date) = curdate()) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vistahistorialsociomaÃ±ana`
--

/*!50001 DROP VIEW IF EXISTS `vistahistorialsociomaÃ±ana`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vistahistorialsociomaÃ±ana` AS select `h`.`ClienteID` AS `ClienteID`,`u`.`Apellidos` AS `Apellidos`,`u`.`Nombres` AS `Nombres`,`u`.`Telefono` AS `Telefono`,`h`.`FechaInicio` AS `FechaInicio`,`h`.`FechaFin` AS `FechaFin` from (`historialsocio` `h` join `usuarios` `u` on((`h`.`ClienteID` = `u`.`codigo`))) where (cast(`h`.`FechaFin` as date) = cast((now() + interval 1 day) as date)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vistaproductosconstock`
--

/*!50001 DROP VIEW IF EXISTS `vistaproductosconstock`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vistaproductosconstock` AS select `p`.`ID` AS `ProductoID`,`p`.`Nombre` AS `NombreProducto`,`p`.`Descripcion` AS `DescripcionProducto`,`c`.`Nombre` AS `NombreCategoria`,`p`.`Precio` AS `PrecioProducto`,`su`.`CantidadEnStock` AS `StockUnidad`,`p`.`ImagenProducto` AS `ImagenProducto` from ((`productos` `p` left join `categorias` `c` on((`p`.`CategoriaID` = `c`.`ID`))) left join `stockporunidad` `su` on((`p`.`ID` = `su`.`ProductoID`))) where exists(select 1 from `stockporunidad` `su2` where (`su2`.`ProductoID` = `p`.`ID`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vistaproductosconstockporporcion`
--

/*!50001 DROP VIEW IF EXISTS `vistaproductosconstockporporcion`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vistaproductosconstockporporcion` AS select `p`.`ID` AS `ProductoID`,`p`.`Nombre` AS `NombreProducto`,`p`.`Descripcion` AS `DescripcionProducto`,`c`.`Nombre` AS `NombreCategoria`,`p`.`Precio` AS `PrecioProducto`,`pp`.`CantidadEnStock` AS `Stock`,`pp`.`ScoopsPorPote` AS `ScoopsPorPote`,`p`.`ImagenProducto` AS `ImagenProducto` from ((`productos` `p` left join `categorias` `c` on((`p`.`CategoriaID` = `c`.`ID`))) left join `stockporporcion` `pp` on((`p`.`ID` = `pp`.`ProductoID`))) where exists(select 1 from `stockporporcion` `pp2` where (`pp2`.`ProductoID` = `p`.`ID`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vistausuarios`
--

/*!50001 DROP VIEW IF EXISTS `vistausuarios`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vistausuarios` AS select `usuarios`.`codigo` AS `Codigo`,`usuarios`.`DNI` AS `DNI`,`usuarios`.`Nombres` AS `Nombres`,`usuarios`.`Apellidos` AS `Apellidos`,`usuarios`.`Telefono` AS `Telefono`,`usuarios`.`FechaNacimiento` AS `FechaNacimiento` from `usuarios` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-10-25 19:31:39
