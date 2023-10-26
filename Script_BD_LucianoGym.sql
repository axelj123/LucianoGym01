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
  `contraseña` varchar(255) DEFAULT NULL
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
INSERT INTO `productos` VALUES (19,'loolo','asdaads',1,5.00,_binary '�\��\�\0JFIF\0\0\0\0\0\0�\�\0C\0		\n\r\Z\Z $.\' \",#(7),01444\'9=82<.342�\�\0C			\r\r2!!22222222222222222222222222222222222222222222222222��\0\0�\0�\"\0�\�\0\0\0\0\0\0\0\0\0\0\0	\n�\�\0�\0\0\0}\0!1AQa\"q2���#B��R\��$3br�	\n\Z%&\'()*456789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz�����������������������������������\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\������������\�\0\0\0\0\0\0\0\0	\n�\�\0�\0\0w\0!1AQaq\"2�B����	#3R�br\�\n$4\�%�\Z&\'()*56789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz������������������������������������\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�����������\�\0\0\0?\0�\Z(��AEPER\0��y\�\�IQO�8����YX2�\�\Z`-Hj�N�Rt-�0zu��X��K$\�T�@^���\�\�S�\�F�5L=~�\0QE\0QE�(��\0(��\0(��\0*��+C�\\ȇ���Z��\��	\�%�t#+֓\�⺚F2�yf\�\0�S]��\����AE�ʡ�8\�z�g\�{x�\��<\�\�d=\nٱӮ\�/\�\�n����\��#0\��c\�%~PQ�\�\�?��q�B׊\�	?��\��\�\�[�\�,���GU\�e��\��sM�\�-5�\�@\�$8ڎW\�Z\0��\�\�y$\���ҳa�TMV\�͚5�������\0\n\��K;xB$\'h\0��ƺү$\�m�#�F$�cB`t߅���AES\0��(\0��(\0��)\0��v)\�R����y8�\�IW�����\�\�Fw/\�V��8`i��h�{~\�\�e6\�+�~���*6S/�X\�1[������y,\0��/�j�\�\��\�r:T�<J~iP~4\��I�%OΆ\�\�i7�\�d�L7qRT^W�>A\�KMQEPQ@Q@QH\nz���q$lU\�	W�_;�=\�\�\�N\�~�\�\���\��\ryX�\�\��\�2~EN[�\���\�z-�\�-1̌��\r�kZ\�\�7�lp\��+�Ҵ,la�I%)\�e��k~\�O�д�$��q�9��\\�����X�\�\Z��\�P#�\�\�̼�\\ְ��bb��U\�\�c�鵓�\�5i\�[0	#`�W�\�\�\\�����?y\�t�\Z��y�Ȍ\�јA ��s]\�y��\��\�1�01\�^�]4��<�B�\�\�(��\�\�(��\0(��\0(��@Q\�?\�s�\�\rּg}\�B\�\�\�(�M�\�\�#�W�k���\0p\�̿[f�����\0٩1��⿉7\�&�o�\�6\��TF&N\�\0*��-/hw\��\���)諆#�\'��\�\�\�\� \�\�DZ�1�\�ۀ\�yZM\�֝|�?�t�\r�;V\�\�铌������\'\��v�\�\�I�\�\�F����ֹ\�[\�_��D�\�Z��pZ4�w2\�\��\�\��co��;���#����\�\�?��X\������4ƫ��\�\�P�X\�c����/\'�\r�o,hǳ�oc�*/\n\��=\�\���շ\�muC\�ܡa\��kE\�c�^�&�\�\�f\�l�\�Tc*:)\�w5\�i6\�g�\�[�b�Ǵ\���ֶ��\�%F�\�AEU�QL�(��(�-c�A7?\�\Z�\�\�\�5�j\�[V�!�\0X\�~\�\�޾�\��\0\�q�\�%�K�\�BTߠ�?\�\�?�~��x�\�\��Ů�\�\�\�؀ڤ�\rè\�pA�Z\�|u\��CO:��\r�p��]�(�E��\�\�-t�$��\\�\�\�=?�4i\�j��i@\��\�\�$;��v�=NS\�W��y�}+Sҍ�Ԗp\�\�\�`ˎpqY�$�mi��\�q\�r�ܤw玵\�F\�]\�Y��i\��XIO\�\�\�1G�\�n ��X\�\"�PŽ�\�\�	ܾ�\��\0�P\Z�~\�M�F�H\�#�R\�Пj�GK\��c;�`a�\���S\� V�\�Lgj؂�(\�1\�=�[B�����*U�\�,x�\�>f\�oZ��k�6l�E��\�<~\�\�#fO�%Q�~\��U\�\Z\�\�\n(��QL�(��(�-_�AW\���ܩ�5c\�F?\�޵躷���?ݮWB��{	�dGi��t\�Q7mK�,��\�EBY���槶2�\�\�kE�����v�\�5�\�U-٩�]OjIO/ӎMfꢭ&E&�\�]\�4����w���Ye��K>\�=���\�\�\��oJ��\�\�\�\�\�ro�j\�RD6և\r�\�k~\�+n�b\�/R\�� T\Z\�b�R\���Đ�\0�����sV��\�{\"��+6;�z�#n�\�\�Ӝݳ\��%I\��\�]mrV��4����W[Z�Q@��(�EPER��3�\\`��F�\�0ǟ-��u�L�Y\�`�7QY�\\g!\�H\��K�P0���e�6NNXV�h$\�Zı���j��;�U��@\��T�\�weEHv\�y!�Kn54��\�*\�L1\�~U\�\�*���s\��E�[-\��0ĭ<\�.��nՕ��W�\r��^\��9��.s�\�^�;\�A�}ʊ��q�rG�T�%��\�Jj\�*Y�\0\�Й�?ʺ\�\�\�\'���\0\�\nq�8\�[���QE(��`QE\0QE\0�{���\�o\"\�\�\��5�N+&\�Kz\�+Lz\�`g>��\�f�=��\�ɫ�\�\���<Z\\i��-�`}��T��ڲ\�\��\�Uy5�\�U�\0��k\�**\'\�c?\�(�\�ִ@\���\�S4�f\�\'!eD�O\��d��.4x\��\n\��\�{I�\��\�L�\�\�++u�!�:�\�\�S\�~�y%\�;f��z�օ1QL�(��(��(�\�lDƩ��4v�R\�s��jut�颊\0q\�{TM�Ҋ(��q�2j(��w\�\�Q@A�o  ��}�B�(\0��(\0��)��\�'),(26,'ssasa','dassadsad',2,12.00,_binary '�\��\�\0JFIF\0\0\0\0\0\0�\�\0C\0		\n\r\Z\Z $.\' \",#(7),01444\'9=82<.342�\�\0C			\r\r2!!22222222222222222222222222222222222222222222222222��\0\0�\0�\"\0�\�\0\0\0\0\0\0\0\0\0\0\0	\n�\�\0�\0\0\0}\0!1AQa\"q2���#B��R\��$3br�	\n\Z%&\'()*456789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz�����������������������������������\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\������������\�\0\0\0\0\0\0\0\0	\n�\�\0�\0\0w\0!1AQaq\"2�B����	#3R�br\�\n$4\�%�\Z&\'()*56789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz������������������������������������\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�����������\�\0\0\0?\0�B��iڅ�\�#�\0	0Nzc�9\�X��G\�@�5�,ǀ�v�~���x\�\�<\���6^sQ���\r�\�Q\�2�S�FA�!�)6ԤSqWrH\�\�H�qHE4\�BE&ڙ��ݴ\�\"=�m�6Ѷ��\�6Իh\�L�\�\�vԑ\�_�>����b\�\�\�R�V�F�+5�9\�l\�\'j����of�\�v[\��5;v\�\�\�ޙ*\"jp}�W�\�\�&�yT��1BH^y��\0\"�=����\�\�B�Ӄ�l�7\0~�#��x��)Tm�\�g�xB\�I#%uY�-P\��~J\��o\0O%\�\�Z\��3Q$O-p�#�<v\��\�uo�r�\�7��z|�\�U���\�\�cI�a�x\�\�YW��[�\��\�U�\�^h�\�]ƍ%�đ��Q\��qWu)4{=Amf��<\�C��r�9�?\�\Z\�\�/�E_:�\����P���WG�\�R\��\�\�[eIbB�r\�j\�J�IŗF�)\�Ʀ�\�\�\���I�c�����\��1\�\�\�j�\�\�gwu<bo0I+G�`�pF2FA+\�\�\�]]ӕ\�]\�\�e�bw!F	��⤗��\�<<[�N{\�5ȼ�\"�ܯs�y\�iі\�X�H����}�^\�\�\Zmխ��&\�:B���7�y\�:WM<Df��\�:2���Å�Zu��w\�\�21��\\�x\�JeO.dbbi1��W9\��5/��Wi�kV�Cc\�L�9`=����.d\�tW\ru��\�!�\�O<&�\0��Lb�\�\�t\��+\Z���CO,\�tt��p�\�8�ު\\\�\�\�޳�\�Ų\�)�\�B��\���zu�*u�����3�ά����\�wPǀ�\�\�l5oGqb���LsF\�ف,\��<\0?J\�\�\�Q[�\�\r@���\0�\�\�Tq.k݉����\�zׄ�\�n%TWH�\\�\���\�x�\�\�\�\�ړ\�/mp������\0�ִ�#y-����\�f3ʓy�쥉\��~��s%��|K����$ga�~^z�\�k�snnM��Lb�RE�h/\�t�T�����M\�U\�C�\�9\�t>*\�\�\�58�-\�\�\�3��\0rW��\0f����X]%\�	\�ao�!<g8\��U�\0E\��\r��\0 �M\\\�6z���9�\�gkvh\�\�Du`F\�I\'�Fk\�V+i]e�4�\�\�\�n;\�\�C\�[\�\�qhZ,(�\��Fq\���\�B����^��\�\��Xj\n�\Z\�\�^)s��1��մ�wXj\�\�)J#^�\��x\�\�\�ss�FH�Յci\�\�CW�Y���\\~Q\�Ɇ���\�ӭRJڅ�3a��\��	䍮b��X��+g\�`��\�\�^=ԼQd\�u�vb	<�<�vȭ�`�\��޳b���\�tm5|.nW\�T\�\��h\��ö\�p�%\�\�\�!p~D�N~��I\�\����\��}�\���G���\��\�\\�s���`�G+�Y�H�\0�r�\0��t^)[�\�6O�\�\�ČF2T��\�\�޵�\��;U�	mƋq,�.XNS\��\�]8��M}\�\�W�Kq� ���ac3@T��\0n,	\�\�$ַ�\��\�=9b�q%\�Hı\��\�OP*\���*[�\��$e\�\�}\�jX�WW\�5;+\�\�Ȏ;�f\�;A\�\�d����+���S>Y\�i��)�_\��n�^\�\�\\\���\�:Ӵۏ�x����Pprw\�𫖚d�:\�\�2!��.����C(��~��6\�L�\�v\��\�Ov��I1�x\�\�~���\�W4�Z\�\�\\\�?\�\�&\���\�(�m�À7\�8��k\n[d\��郷�c��Mw\�Ŗ��\�\�]\��\�D\�G�*J����V\��\�\�̷7%#&O\�`~b�5#�k�\�8I\�\�o�\�x?ȏF\�R\�\�mH\�;7NO�U\r{L\�\���.mm$h\Z\��2�DK�\��\�}뭴\�4\�GA\�\�\�Ƕ�|\�\�1��c\��\�wW#6\�\��}�&\�Y�2�+�w�=�\�K\�\�\�.\�Y\'�\��_\�W\�\�\�x\�0r�\n�wm�\�K�\�V\�lW\�`\r�\�\'��\�6�q}t\�2\�+B��F�_��>��5��X�\�7p�F�rɳ\�\�F��Rk�e���T6���i�9��e1��W�0?:\�W��S�\�\�<;㦷\�Mm�ںF6[�c�m�jy~\"�u�˼��C�v\��H���\�\��\�\�\�o�\�F?\�\��\�\�gi�>�\�n\�\�\"+Sb �\���}\�¯\�S� ���\�\�p*���\�)5��n��-^4X�ہ�\�8��^��Ί\�F�m\�\�\���a&�\��s���\"kR=\"\�L\�\�k-Dݤ��Jy��^Ք���\�\�\��r\�s�����	��pv�\���Kx<?�-�Ldg\�L��\�\\H#�ޢ���~\�+�<��\����\�\�(q߂qڴ�(�fo�a�\��n	O1\�\�ӌ|��ұ.!M�Y\�і`\�,�&9\'�_֬\�\�ile�o\�6\�\�<m� �U\�g\�늶ﶤ齬t����\��oe\�`FA�\�ہ\r�8\���N\��>�\�gy��1��\0F3��p�\�\\[\��l�UUR�y[30ϯ��OO\�\�\�K{`#��r�z�\�4��\�n~��\�UI\�h����5��\�5ŌS\"\�\�e1E\�H|q\����_A(RJ\�I\��y�R��BǏ��\0�+�𾤓x�(��\�\'���]\�\�0�%\�\��]Yάm�\��\�\�I�<3F9\�A�	�tmrk-$�\�J\�R~`Iu9#�\�$qY^,�X~)�̡KK\�N3�W\�\�ߠov�\��U?ҹj��J\�[/\�려\�%7��\0Tz\Z�\�zv�\ZD�+A4[K}�\���\�|�x�\�\��\�\�0Cd\�\����y\�:\�Q\�\�\�{qĲ7#\��+�Ե�N\�\�\�\�]���P����\�@=�W$�\�t5f\�\�\�Oy\Z��34�1!\�9\�����\�\�(\��=?\���\�H���S\�\�\\���\�y\�;�~U\�\�;���PѤ2�GR����P�\0|\�U��5�\�nTg����\�<��\�3G��v\�8;�ˏֱ/~\�X\�\��|�01�S\�+�\�\�\��qa[v�=�[HK���\�S\"��\�E�N�r��\Z\�\��\�g�XIv\�\�o���\�h\\\�օ�]x�-*I\��R\�\��ln<���ը��i~�\�	\���\����S#`��_���]S÷v���j-\�]J?m\�o3\�z-bi\�1\�����\�<\�\n2I=2��$�^��%��٥��\�0͝ɗ\�8\�#=:\�ѧ�(\�hm-�^{\�\Z{�\�\\#�r{\��Z[3�]<�$�e(�G\�p>c\�{T�\�-\�[��c�y$F$gv[\��n���j\�\�d�iYБ�\��\�[\�\�z�֗��&�̺7�nm����sЌ��=�\���[X\�7\��\�2�6����y�\�E\n\�\�\���\�?0Q��x� }�u���X\�s�nE�8\�E�4�mqCdƤ<��>\��Nv��ث���\�<|\���=\��\0�K䗊�\�����\�p{T\��\"ڜ��\�t��+*RnRO�*i%w(�\�F�c\��-e��cAYz\\\'�%E�`i\�,�\�\�\��V�\��O�QIJ\�#���\�s�SO�a�_\� �r\�\��C~\�}:�ʧNT5~fu>��\��!v\n\�?8\�g�ǽf\�ይKA�����rdD\�Ig힣�q�R�v�\�\rJi\�\n�\�d$��S?��\�Q�Ν�,\�^hľw\�\�\�\�\�;\�-W\�F�ns�\�tfHV0c�	9�ҭ\�\�Jo��[�>f��\�qZ�Eޟk\��H�|\��ۃ)�\�\�Z2\�zt�\�BL�\�X\�R�\nm\�M^t�\�s6Z\r�~\�`��\�\�}�!88~\�\�Z{ϼ�띥�?ƶm�)%��\��\�~[�Ѕ��\�\�k�;�`�\�rq��=\�Ϝ\�k\�\�W��K\�_���i\�̊F\�\�n<Qi�\�\�\�Ewh\\B\�\"{2�Ì���X��\��$~�f;�\�r�ՇO\�R�D�\'��Uj-�\��E\�\��\�t5\�H�M\�\�\�ʇ�\�{\�\�\������n!��*z��7N{zT�tȷ����L�tcǡ��+jd�TfIbi��\0C�=\�^�\�o\����\�\�j\�k�u�\�Y6�gRWi`\�==EC\�\�D��\�W����\�\�\�V1�\�\�\�\�\�Ҩx�\�h�#3\�K�%9\�  cZ���s�\�\�:�Y\n\\\�d�\�Wz�T|R�44#\\/ocZ�\�m�\�]B#�\�o\Zŷ\�\���B\�/UI�\���Q{�\Zy���A�Ŗ|\�Rs�\�\�q�6\�:JѴA&�ft���c\��GZ\�\��\�/���\�\�zQG���aS\�_\"�Ĵo�N-�c-o9\�;����4\Z\�~b\r�Τ�v�\�V�)ZEu\�F| P\�)rA\�P\��\�&��\�@\�)Q�\�ο�\Z���v��C͎M/]T.U�\�[n>X\��5��3ZG$\�\'^$a���C���G�v�-���33��!^\����1���j�7�\�M�#m.\�Y\�\�t#��\�|��\�F�\\\�d Q�^��j�\�\��O?�j��\�;ca�ҡ%��\��;iR/\r\�i�SC�\�F�\�dv�l\�.Oq\�Q�K����.��\�%\n5�튭�q��NJ{�Ҟ5\rJ�4h\�.e]\�\� \�9>\���R��eN�d�[v[M1\�\�k�3\�/���\�kkT�]J\�FJF��_�\�G\�\�cd�ۡ�\�z�8\�\�Z6�I���g<|�\�W�\�?Ʀ4+Kwb�\�U�\�ӭ\�T�\�\n��61\�\�\�z\�\�mGY���X\���\��6�s�\�Ŧ�cf�b��tP	����\��p��0qRR��BS,q�\�\�.\�\�?ʬǭ\� �\���\�\�\�!\�#�\�S&�c���in�_�y\�,q�r\�\�]v��*�\�\���\�\�V\�;���\�Y#K�/l\�1������{\�x�K��Ű�\�7�b\'F��8�\0o������9�w\0�;e1�L�����i\�\�Zޑu�u\�K�8��0�\�\0\�t�ƴ�v�o��\�&���^��\\h��[v\�\�\\)\�O�\�J\�\�\�\�\�\�\�@~^�0�6�$�\�:��hz��~\�퍏N$\�ѱ�ջ\�꭪[_�徍J\�ʪ��\�}\�׊\�8�7�\�z��*F?\�e�\0��\��{M����\0\Z��[\����F�Snā�\�o\�k����_k\Z��l�\r�\"ۅA���\��9\�\�5\r³]<�\�o&Y�\�;nPv\��\'��sJ	��6N^\�\�F�X�\"\�kU`\�\�_<���k+y1m\�Z�����텤.�V\�\�1\�I\�t\�Jz���ۑX7}M�V#�1�\0�\�T�*mNq���:�\�\�9�n21PY�e�Z[�\�\�F�䌟\�\�֠�^�\�\��NR�>��l�xǽ>T���\0\\}M78<җ��	n�Qb�f27g�V���g_9I�<�Tbp��j\08&��*G��\�|�:��+\�\'��V���I`\�\'�B{{T\�W\�ݼ�ϖO��[a�\0��{����\"�hl�\0���\�I6�5��h��W�����VvuDQ�f8\0U	uF��zl{�\�4���\�R\�b��\\\�l���\�c�0��g�\�Lӵ��2&�D0\�@�0.�}:���\�~4�Җe&\�W�br_uD��\��\"=��u*\�\�o�\�-\�!�\�m\�m,Z�\��\0\�f�a(��·C׎�d\��ζ\�m4�ܮ鮦;��c�\���ji�6Z3�X�\�ߕQ�\�̹gbrF�U���\�\��Z��d��\�c�=���眓��r\���8\�<3�\�VJ3n6I�1bZωcU*�2�0+C8|�V\�\�Μ���@\�ք600�R�\�ӟZ�*��3���=)�$)![�i2I\�\0ri�\�<q�RZ$^>�˹x�\�\�<y��q��:P�\�l\�ɫ�~�!\")\�\��\�?\�YR4��\�Tjv�O\�LGc<b{w����w\�$q$H(���jb5Xf8C�X��\0\�V\�k&�¤V\�Q����\"\�\�\����:���H6��ޣ�\�\\�\�sZ�$L��C�k�,A{�iP\���7b<ەLqޟ�H%�v\'�����\�f�!��\�\�k�2�z�\�!2�\'�\0Z�,�c��w`ju\�8?�1S�\�)m�\n(��\'��T6(��@͌\��sEiX�\��b�$���\0U\�qҶ���,�\�2\�>�\�QC��\�D��\�-\�\�Y�㡢���࿖ӧ̝\��\0Jێa-�̠\�@4QI���JB\�rX�\0�Ʋ�`�Eq\�\�O\�0\rS%��\�'),(27,'ssss','adassdadsa',2,25.00,_binary '�\��\�\0JFIF\0\0\0\0\0\0�\�\0C\0		\n\r\Z\Z $.\' \",#(7),01444\'9=82<.342�\�\0C			\r\r2!!22222222222222222222222222222222222222222222222222��\0\0�\0�\"\0�\�\0\0\0\0\0\0\0\0\0\0\0	\n�\�\0�\0\0\0}\0!1AQa\"q2���#B��R\��$3br�	\n\Z%&\'()*456789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz�����������������������������������\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\������������\�\0\0\0\0\0\0\0\0	\n�\�\0�\0\0w\0!1AQaq\"2�B����	#3R�br\�\n$4\�%�\Z&\'()*56789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz������������������������������������\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�����������\�\0\0\0?\0\�-|W\�|�\��u���x�\rF\�kQ�V���#��O�uE�0�� �pJ�\�Ԍ��\0�L�2��Ha�oɧ:�V�Q\�4a���Ď\�\�G=\�m|\�n�~R�\�u^\�m��%�R\�\�W�|>u�\\\\.\���s\�\�eS+\Z\�\rrO&A\�A�\�Ib\\ƻ�5j/\n١�V�@����\�pK�E (\�-\�r��\�[�8}w[X��m��\�G!s�a\\�8cˠ\'\�q^�y\�% k�)b���jO]�4�\�\�\�\n\�\�?*낌�wgq)\��)����d�P��;�\�u\Z��/�c#tS\��O���Ѯ-\�^%\'�\0\��Mf)��!$\�\����|�\�:��N!�g	̌\'ӿZ�Vg\0<|\�c5@1�3.ApOE<��\�\� :��M+H��o��?vb\0�\�\�\�zS\�ۇ_�\�S���\�\�0O@q�\��4�W��S\�[q��)�r>0�\�\'�}鍜�\�}9�l1\�K�\0uy�		�?�\0}i2O^�2\�\�p�I=�h\�\�\�@�2Ǟ�zח\Zr�\�\�m#�zTeOj\��u�S�RK�\0=P��\�O��\�`sB\�\�\�8��\�\��$K=�j6\�\'�\�?֟��`\�Fb^H�\��8��0?|\�ߚ�t+�\�\�£:\���\�x\�\�4\�:�a^,j\�\�\�<���{�A\�@�\�{�H�vV\�:\��\�\'�%\���\0�����\�Y�q\�6|�\�\�tc�̛��O�,\�\��r+�m\"�t���\�L����*Ө��w8K��\�\Z8\�jȸ�-\�t$��W��:�!\�\��i�k� ��?\�`թ˳/�\�\�\�\��E\�m\��Vl\�\r�\'\r�\�\��g�n�؁�\0y��ݎ\�<�ej���+<i��O\�n=E5L�0�\�W�\�ad\��ɗ�\��6�fNp����Y�=�K{l,Q��ջ�Y\'�ZBp9\�֫\�&76	ҭ+h2]\�2�y�.���\�U�e�rp:\�\�\��~E�<U��\�>\\\�j2�\�M�-��4� n�����;�2A�\��\�g*;�]n\"4��\�9_�r]�߭g��\�k\�v}5\"�\�\r\�硠.1\�lt�jV�Oz�\�NGZ��pl\0Oց\\�ۀ#�\�OC\��\�\�9\�8���?�q\�ց\�ƻV\�~S\\����ʻ��\�⹝F\�\�GZ�`L\��wk�F�a��S�Ѵ��@,�a����\�k\�.\�\"\�x\�\�\Z%ߝ�[�9%y��\�6٬\�\�ޘp=�\��q�N\�\�\�T�Ə�;�F\�Zq��\��\�<i�^H\��!��7��{вC\�\n�zei\�\�	\0�@\�	5S\��g\�;s�q�Rno�-\�\�*+Uw0��\��d`Pr�\0Z��\�b��^e\�\�7p1P}�\�\�\����(\�\��\�;\Z\�4AWh���%\�m�\�L\�}8�uF8$v&?��wUč\�\0��ɠA\ZM�ݷ��\�)�8�\�\�?����y\��jS��\\\�\�\�-@�a�F;TA��\�cRc�{Tnx#�\0R�m\�X�鑞x5�.\�ϺF\���4�\�ČK\�y�o\�y:J\�\�\�F+Y�|�\�\�\��wR\"\�k\��U�z�\�\00}\�G#�&�	b{gڜ\�#끞�� �Q�0a�zb�\���.S�\���#�]8�~*1\"�v�\�qց�۹\n�\�>�\�X\�\���)�\�	$�*,Y\n$\\�n��pr6*�Ϋ��iL;����\��T\� ;�ZkH� �~:df�ȣ�M��f%�8\��\�|gq>�)����\�\�J�\�mǭ$*�U�z�\�On��0=q\��\�\�>l\����\�;�\0Z\0%�v̎=\�DI�\�\�+1�\�T�\0JL8\��w�W \�=GJ�\�\n\����wL\�0~��љ�\�ȩ��K��\�\'���5z<\ZW*\�VO��n$RcF�~y9?\�i۱� �j��R%%W\�p\��?����¬�g=�3U7BI\�I\0�jw�m�<\�v{�\�(��\�J�ـ(ʲ6,s\��\0��WH\�/,pq��\09�g�ڠ\0[i\�\�8=��4\�k���~��p~�\��\0\�@�ն�l�=G5V\�H$��Wݜg�ӽ[Frʮ����\�H�����\�4\� \���\'\��\0�R-]�2K�s\��*X\�.�,\\\�3�ͳ\�S�{P2o�$�\��	\�V�\"�&wA\�\��\0ק\�\n�mrx�\0N\�[��N[�����f��#o,\'r�zz\�\rϷe\� ��<\��\n���#��*!,#hXp\�z�\�ڐ\�W�N#��@\�O�\�C6੹�`����\��O����x+ߟ��\"\�,\�P�7\09�\0?\�֐\�?���늊@���R\�q�T��\�g��~c�UX\���V=\�\0|�=�.d�yc�@��\���\�\�J|�{�c8s\�lf6\�O��0��aޡ�\��2\�++\�J�Lu�\\߬%�pŗ\'<R\�\�o \�\�S�O~����I:a��a�`2:c�N\��!�tRe<�:�}*ܲ\��,?A���j�\��\'\��\�\��\�{\��\'ވ�*�\�\�։-\\\�^9\�Y�\�=y�\�m�\�v$`��\��T�aK�\�+o�R�u�Q2+bUrOr��\0\�T�\�\�\�\��#��\n\� R\�tm\��:[yؓ��q\�@\�¹dl�ydqڞ^Vdܣnޠ��T\�\�\��9\�1Ҡ�\�\�\�\�\��\�\�?�\06Y.cf+�\�8\�~��W73�c|M�GA��\�\�\�Ҁ\�\�����\�QJ\�\�\�~c\�R\�8;\�!󭶐8=j��΄~\���\�*˭\����b�Q�Ig���\�H\��\�#�qQ���d�Ι��\�$\��\��\�\�R\�v�%\��qڜB�A\�=(h�\�wԊ\�l�\����2�;8\�jh�/�9\nUT�3\�Q8�ܤ@\���\�B\�Sv:�����\0�^F>��nFӚ�D���h� �DjU�NW\�<~�\�E9r\��GM\�q\�Ҟq����84͸L\�\��\�	Ѕ�\��\�	��=�w/\�Ƞ��;�\\ԧ�\r�\��\�\�\�H\n�XĂg8\'z�\0�,��\�l�C9R6q\�Ҭe�1�0�)�JC�\�ڀ)Kmr\�1K��NG\�OoJ�uk;F6\�*�׏ִ\�\�\�q\�*\'9�\�-!�Mk;\'�ny+�\�Gҡ6��+b|!\�ʬG\�V� \�9SL\�7ۚC!ean��_\��Um�G\"�͓!Fx\�T\�3���԰Gvx\�~jR���\�\�L޻@\�}\�\�U\��\�b,\�\�0\\᱁\�T6@\�j\�#��R?@��\�m\�T\�\�	c�84Ɇ\�\�x\'j\�9\0�����A��\ZR�hʊk�p}z\�0\�8n�\0�1���\�A����\�(�\�\�[>Z\�n\���|\�\�Ҥ.0[��D\��x���\�|\��b#�\�R+`�\�:����̽:Pl\�*C/Z��]�\�\�~�\�<\�-�\�ʽ)� �N{\�e9���`0\�b��?\����\�9y\�R�g�(�D�V���0�\�QM\�hѓΪ<(G\�E\�\�,�S\n��\�4QSp�®3����}�\�?*(�r�����\�0��\�\�֊(�VDm3�9�Q5\�˷�ST5�C\�\�\�LgRs�t��D�WyS��\�ǿ\�E���\�'),(28,'Botella de agua','Botella de agua Loa 120 ml',2,5.00,_binary '�\��\�\0JFIF\0\0\0\0\0\0�\�\0C\0		\n\r\Z\Z $.\' \",#(7),01444\'9=82<.342�\�\0C			\r\r2!!22222222222222222222222222222222222222222222222222��\0\0�\0�\"\0�\�\0\0\0\0\0\0\0\0\0\0\0	\n�\�\0�\0\0\0}\0!1AQa\"q2���#B��R\��$3br�	\n\Z%&\'()*456789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz�����������������������������������\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\������������\�\0\0\0\0\0\0\0\0	\n�\�\0�\0\0w\0!1AQaq\"2�B����	#3R�br\�\n$4\�%�\Z&\'()*56789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz������������������������������������\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�����������\�\0\0\0?\0��(��\n(��\n(��\n(��\n(��\n(��\n(��\n(��\n(��\n(��\n(��\n(��\n(��\n+Q�f��ܽ�\�\�ٓ\� BH��3L�~��]�[[�g<�da�Ҳ�\���y�\���[���۽�\�(��0\n(��\n(��\n(��\n(��\n(��\n(��\nCKP\\�e�ն�\��\n\0\�C�\�wWG%\�;b$g�\�M\��-o�\�0\\42�ϖ@\�\�5\�&Ȣ���\�$!ְ��>n{ju�mog\�\�n��	�䊚�9�(��(��(��(��(��(���|�\�5�\�N}:�|\�I-\�:{�U�;\"*T�8�Kd_l\�<P�\�\�VT:\�ُyt\�h�b[\�\�ȯ#{U�>p˹A\����8�_��R�\Z�R�̿���7K�7�l���_j\��&�����\�\�Ţ�*\�\n(��\n(��\n(��\n(��\n(��\�\��\�ggl�w��\0W׌w�\�\�?\�})5T��EfQ�\�G~+l<�j�H\�\�\�ʋ�82\�d�\�\"0r셑d+���[G w$S�\�|D�M\�\���)�A&L�Ĝ��\�(�\�3C�K	~\�/\�\'u\�{��mc�kkW�(;��̸���J�UN{��8N��m���/y�\�p^~m\0\n\�\�s\�I\�-�@L\�\nޘ\�B:��J�y��\0�tb�}�\�\�Z(��Np��(\0��(\0��(\0��(\0��(\�E/j�����,V�|��\�\Z��\�\0���W�A\�4+\��J*8\�R\�EPEPEPEPEPEPPL~o§��6h&$\'jD<sHܭӡ�P�5-C\�\�\�\0QE\0QE\0QE\0QE\0QE\0QE\0Uk�\���5\�\"�)��dӻw�\n3�ӕy/-�\�\�\�\��\�Z}\0QE\0QE\0QE\0QE\0QE\0QE\0u��\0�Ku���\�R�:�\0(��\0(��\0(��\0(��\0(��\0(��\0(��\0(��\0(��\0(��\0(��\0(��\0(��\0�\�'),(29,'Scoop Proteina polvo','Scoop Proteina polvo por scoop chocolate',2,6.00,_binary '�\��\�\0JFIF\0\0\0\0\0\0�\�\0C\0		\n\r\Z\Z $.\' \",#(7),01444\'9=82<.342�\�\0C			\r\r2!!22222222222222222222222222222222222222222222222222��\0\0�\0�\"\0�\�\0\0\0\0\0\0\0\0\0\0\0	\n�\�\0�\0\0\0}\0!1AQa\"q2���#B��R\��$3br�	\n\Z%&\'()*456789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz�����������������������������������\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\������������\�\0\0\0\0\0\0\0\0	\n�\�\0�\0\0w\0!1AQaq\"2�B����	#3R�br\�\n$4\�%�\Z&\'()*56789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz������������������������������������\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�����������\�\0\0\0?\0��(��\n(��\n(��\n(��\n(��\n(��\n(��\n(��\n(��\n(��\n(��\n(�4\0�)	\�c\�^&\�4����(��\r��\��85\�x�\�L�o��x3��?Aڰ���Mjˍ9I�Υ�\�Jn��H\�d\�\��\�>\��`�X�����y\\�\�<�Ydg��K1\�4\�󧏨߸����\��M#\�Zn��\�\\u�Ѱ\�/\�Z�\�~���N��\�+$d;�W�iZ���l�\�M�h.�\�*Oc]�\\W�V�\�5i�liQHik�\�(��\0(��\0(��\0(��\0))i\r\0y\'\�-2k}p\�\�&\�\�G\�\�0\��\�+ټm2C\�{�ȮXPá\'�q������W�\�Vm��\�\�ׇ���WG�\�A����O�\0�[H�\0�A�\0}\Z˽Ӵ�6�\��{�+�I�\�+�B�5c�\�H>չ\��\�,�MfQ�I_\�q\�\�\�M�\�[ZCH\"\�*�\�\"�_C$�!�DRO���\�֮�q�\�qh�aKH:R\�У\�\n(��Q@Q@Q@%-\�x\�\�]Fѭ�,L�	�d�\�ú:5\�\��*�\����{h\�۽A+\�5�so��X\�\�[�\�#��q4�\'\����f�l�9;\�\�г\�\�h�$\�ݜ;G�\�A\�ϩ��/��\�\�\�\�n\�B\�܉X�hH9\nݏ=\�\�\Z����\\ԯ�d��@ų\�\��\�x�O�U�Ρc�\�!�u�\�g\'4�Ʊ\�qw9�j-b{�\�\r̳[1�~j�\�\�}\�t:f�4���2��bW�\�=\�\�R�F�>�\�\�e\�bm]ܶF��\��\0J\�l�b�VPX�U\�\�J��B\\�ay\Z�cRz\�H8�\�48�(�EPEPEPEP\ZƿM��<\�ɮ?\��,��ݢ�ϼ���\��\n\�\�\�u!diJ|����՝���`\�F��v\��^\�Z�\�T�kk���2}\�\�dg\�T4h�$\�䝷H	�2�\��V���a�\�=\�\�\�G\n�j�\Z|�jv�\'�\��\0ζ\�e�l׋\\�[W�XX�lѾs\'Y��zY\�dW���p2��C^���\�K�\�^���ӥ��\�9��(��(��(��(��BqU�o\"���\�vH]�Ҁ2<W\�h<9�y����b�>�ڼY��Rinn\�2\�#e��\���\�W\Z��-\�\�׈ײ/a\\�\�ۏ��Z\0\��yu�\��8�d��nP�\0�n�Hּ\�\r\�XF͉n^F\r�\���\���\�V�\�l\�\�;v\�C�\Z�\���\�\\X\�E\\z\��b�Erߩ-�kV-�e\�\�\�]\��Eu\�\�克@@\�z0�\0\Z⢌D�G�5�k0�6��*J>�\�5}WO��\�\�\� \�����\�\0�+\���YN�\0\�W,�\��5\�c�\0QE\0QE\0QE\0QQ\�(�w\ZM\�?��\�\�W\�sح��G2�bW\' �מj��R\�\�/%��1�\�\�+��«q�i�Nc��O��j��OT����r���o�\�m�\0@�\��\0\Z�E0.�F\�t\�x93�Y�{]CSS5�BI\�\�&\�Ϸzʩm_ʼ�O\�ȭ�\�e�⑑ԫЌT�C)uu{��OE�\��\�t��t��\���k�#��U���4�9@g#\���oP�\�̼\��\r\��#��=÷�\�ʤ1��\�L~\�\�k\�lL\Z}���\�@��U9\�hfi\�H \�\�ՀQE\0QE\0VuԻ\��\�j\�O.#���YՅYt\Z9�V�w�\'ls�\�?<\�׈\�О,��W�5(��\�1Q\�����N��l(�ҌJ\�A@8 ��`�Q�@�\�}N+魴��\�of\�F3]\�\�\�2��;O\�K�\rs_\r��\�{\�\�aX�\0��\Z\�T$�z�\�\�\�Q4	\Z��\n�\0S���E\�I7.\�\�t�U��\�0\�ZH��\�\�M9\�XL}Q[)J^\�Z�\�;9>�Rn\�\�U��̐\�\�EY�\0k�\'\��)~\�?�J\�۹E�0FG�@l�[XO��[\�s�\0w���\\�\0\��(W�\�Ϭ?�\�Q�O�������\�s�\0w��\�s�\0w��P\'�\r���\��\0~\�a��\0�X\�ب>\�?�J>\�?�Jz�n(\"�H�\�@�*�\�\��\�\�G\�\��\�\�K^�/\�T>\�?�J��9���q�iX\rZ�g\'2zt�s�Y�\��p>^�\��}`��1�Kcj\�t\�&u�Ue��� $�q�՚\�$)\�P�}&�\�?*(��zʍ�\�~TQ@�\�?*6A�QE\0���\�=\�E\0l��`��P�zʚ`��%\�ڊ(>\���_ʏ�ŏ�i�\0|\�E C9ع�T�QT�\�');
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
  `ContraseñaHash` longblob,
  `Sal` longblob,
  PRIMARY KEY (`Id_Usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarioadmin`
--

LOCK TABLES `usuarioadmin` WRITE;
/*!40000 ALTER TABLE `usuarioadmin` DISABLE KEYS */;
INSERT INTO `usuarioadmin` VALUES (9,'usuario1',_binary 'y�\��',_binary 'g����\0\0');
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
INSERT INTO `usuarios` VALUES (151,44444444,'Juan','Lope',231232123,'1990-10-01',_binary '�\��\�\0JFIF\0\0\0\0\0\0�\�\0C\0		\n\r\Z\Z $.\' \",#(7),01444\'9=82<.342�\�\0C			\r\r2!!22222222222222222222222222222222222222222222222222��\0\0\�\0\�\"\0�\�\0\0\0\0\0\0\0\0\0\0\0	\n�\�\0�\0\0\0}\0!1AQa\"q2���#B��R\��$3br�	\n\Z%&\'()*456789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz�����������������������������������\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\������������\�\0\0\0\0\0\0\0\0	\n�\�\0�\0\0w\0!1AQaq\"2�B����	#3R�br\�\n$4\�%�\Z&\'()*56789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz������������������������������������\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�����������\�\0\0\0?\0\�(����?>b\�\�iiZF��\�KH\�t�(B[����\�\�R\�iE!ER\�))i)i(�:�(�AKI@�!\�R\nZB\n(��ER��\�L�\�[J㪡#�\�+ɫX\�!G�P\�pp	�����\�J�Qҹ}\�5-v\�\�`L/ 2�\�9$�\�V�C��網l۬��<c�{\��\0*\�U��)\�,5��C��o�~�P\�t�+s��V���������C��QC��\�QH�h����Ν#�<�+*\�#N��J\�\�]8J��#�гi`�{�\��5%ƚb]ѱa\�kUT*�\0A=\r~k[��\�{H;G������wK��\�5yw��9�*\�\�^T䎍�\�~��\�CB��_�\�\�φ\�᥆�*R\�1ii\�s�EP ��(ڊ\��<\��\0�m��Zl�\�D��\0yH�\�3��\��T�M�ڍ1v�W\�F\�ۏ�kK�K}v8fFIQ�YX`�\�\�t\�\�\���k�����S�py�\�x�\�S�LQ��\�=�0ָ!�cѫ8Ε\�\�i�7�o�~�����\�]��U���\�t��*�RqL�U������\�x�\�F\�m\�-\"ߏRI�\0\n\�#���\�{Ԍ�xG쥳��\�k�u�]�\�X>x�\\�tt�nFV�\�^\���Ŧ\�cx�\�z@��\��e̮r֥\�\�\����\�E��Jf\���Ti\��\0z_���\�g�p˪5\�/��zy4T�\�O�\�5h�6��\�d	�\�r�T�죆\�:�0@\�\�ο.����T��]<�?Dub�\�\��\�\�\r\�+.��?�?����\�\�i�o�g\��$R\�]uK���O\�zn�:\�u+	Xnڋ��Q�\0�\�D�\0��߳\\~�m&�㖲��\�\�[�B\���\�\�\��.��\�b�#\�\�ñ�5ﺚ\�姀����\�n�i�Z��\�M靧#B*\�p?do6�<��Q�\�\�wլ]\�\�7IS�\���(�`6�AKL�--%����9$\��7\�?J�\�8\�?s\�֭}�=�|���lfw�\�\��m6�ۡ\�`2N.��MEt�S�V�\�|��yC�UZ�0��X�J�7t\�,V\Z�\Z��QY�\�|g�\����\"��c^\�~\�O�\�\�\�5\��v.\�\��\0I�I�\Z��>&���Bč�\�\Z����z$jK{K\�ߓ�T\��>�ŊSs�Oo\�.c\�|���R2J,N��n\\W��R\�@P2I�:�-�\�\��\�\��\0���Mm\�\��\��Wl-;�>3Z\��\0ڶ?��U�\'h\\\�k�6�O�F9P:�2\�\�L�����\�\�wqo\Z\�\�2�;t��ס�\�\�׳���y+CI|\\��\0ykJr�d�N\�~G�o)�t�	�+<ʃ\�`\�S[���\������\�\��N�Y\�;�ܿ�_\��Q�Vܳg,v���%�<LU��\�\��\�c\�\�k�r\�m�U\�\��l�*���3#T�/�eՋ\�\�\�\�Ϋ\�\�<=��-\�߷\�~}�\�|d�vZ}\��O5��J����!�\0ы^\��\�z>�\�\�fԦ�\�KTg����c\��\�^=\�V_㺸m�èG,���I?�]�\�n�_}\�D^.�\�9\�\���\�۵uՄ�Q4zxj��>��닻���\�\�k\�kϾ����\�b3^�]�\��\�w�QEG\�ZAKTXV�\�͏��\�p�\n�=@kr�_����\����֢z#l49\�\�3������}�V\�Ů\�^\��~\�t�\n�ΰ\�&�\r\�O�N\�G���\�^\�#@&\nݑ\�_�`�+��ZO��\0�~��bײt��\��KS�H\�v\�yy\�U\n\�/�6�\�~\�Ȏ�tu�\�Fa�ʟ]߫>75żV&U:l�MÑk�\'�L3G�nr=\rp�.�&�5�K�8�-!\\��\�޽P�}+\'\�:g�n���\�|\�=Fz�Z\�5)#��\"P�\���ÑhK+y�i��/���\Z\���\��\��֝P\�\�i�\�2\�C`Q8\�\r#�Sr�4��\������\�u\�ƥ�3�\�Q\�J�T�\�#\�ghtMf	\0e���\�\�\�cǯ\�0đG�ݤh���\0@)�뚽\�-��Ա?�+߅y�\�\��xr\��F\��\0 �>����Ut\�Zca��=3\�Z�N*\�G��:\rM�\�Tp?Z��?���\Z\�ФVRp+T�ܪ\����+�|vi<?G%�;6}\�\�^��Q�\�0���E%-~��ʹO�o�\�\��\0\r^�\��r!w\0Hr	f��\�]O�\0A�\�\��\0\Z\�\�\���qu�T\�\�\�6�G\���J\�w\�\0��J(\�@��vH\�r�\�\�-\�QEF)h^�\�h]M�g\��\\��x\�c�\"�i	\�\�o����\��	\�z�P�L�NT\�\��\0\�����\0�\�WN\'�Ҽ.�\�$\�嬉�ӟn*\�Q\��\0\�\�?\��5\�8ƥ��\��\�\���\�io�ɘ�\�Fs�\�\\b�wUI��\�FJ\�\�u9\�--s�\'�)\�V8-\�^\�A�\�\�\�Y^կu\rf\�]\\<��߂x0\�kgQsr�G	Q\�u^\�sE%-Y\�g\�x��tj\�\�\�j�`\�=�R�\��\�pj\�68\�2\�F7\�{\�r�+�_K\�@�yo4j�\�\��S�D�w#+U9�%��> �i\��X.��\�+K�:���\�\�n>M\� �`�d\��f�\�\�\�\��\�\�s��u\�͵�����ش�-�	霊\��ys��s\�	䓶I��\�\��\�].\�S�Ak.\�bm\�3�w�\�M\Z�\��[����c��H\�\�\�\�t`\�)����B�Xwo�\�\�7�k)z\�\�������� �\�Z\�&�(#2K\"�(\�$��\'_��Ys,�\0\�2�N�\\�\���\�3��S��e�^�\�B���qV�#\�q�z,%�pbYG�Fz:��ݛK#�\�G�W\�\�\�{+�\'zȹr�kf&��9����޵\�j�\\@ Yܗ�<\��\�O_�\�\�Z>��r��U�� \�}\�N@���P��mV\��a;g�$�B��ۖ�z�ʍ\�\�\Z-�|\�+�\'\�\�~�T:\���\�Y\�`\�M\�w�1E(\�v\�\�T\�\�be\��\Z��qx��fR\�\r\�c \�ַ�\��c��Ŭ_\�Lܓz�ֵ\�\�t��\'o�����Ͷ�\�/\�ԼEO�P\0�7o�[���\0�5/�{Z�Y\�r\��\�\�\�\�1��*i++����+/����\0ǚ\�O\�kv\�5r�x~��u�Ky\0��_q-\�ZJ�R�1SMjdi6\�{\�b>H�c�\�]0����\�\�#�\�X�&��\�T�#a�y���Y<Gr\��4L�2:�&�:\�KӠҭ/\�t\�&�$.p@#8?�ck\���j�\�\�)x�ۄ#�ubs�һ�b}=He|#�:\���Y}n1K�菬�N/-����\0_y�KM�W�|�R�J*@\�|}�\�w�i�»�e1:��\�\�?Z\�|?�Og\�Hm\'\\K����\0��ե���\���Ȓ\0;�9��4��uުX<W���\�d~�\�\�q\r\�t����\�}~?	\��zz�T�\\ե�\�YVg\�Ф�zW�|q\�!�Ե]v[XIxCFD\';\�!�!V<2�U��\��\�DL�J\�\�-�pA�sU�H�u	�Y�i\����|\�Oʭ\�\�/�\�%��ybF�{\�W�\0:\�N�=)ZΚ[#��4�1hE\0W9�\�d�g�\��<�\0�t�\�\�I\�_\���j��,y\����onR\�;hN\�捣$��U\�Z\�&�k������X���:\���U�\�\";�ҳ��,�\�ֺ�a�\��%ڋ��\�RJ�G�Bז\�>�-��\�\ZTfh[1�=\0\���Y]jW�3�X�F�.7c��\�U�\�N�7��6 �\��dx�\�\��\������.�\�Ge\�Պ���x��\0�ߝuWê\�_���\�s[��\��E{\�\�O�\�a�w{\�N)w���\�IU���ST\�V2\�Vu�J�\�\�-\r�OҊF��\�[�J\�\�\�Z[4�\�8\�\���sz\�њ�B�\�s���>H\�\�.�h�+\�/t˙�\\#��E8\�\�\��4�ݵ�\��	��\�Ż)\r��\�z\�L3\�n\�\�9R\�P�\��+�Ф/`P��\��Z�\�W�r��W�\�z3\�%,<h�\�\��W\�ԥ��W�yc���@X�\�	�#5\�>7�0�7�;�\r`X&�\��\�?�u�k\�\�ѧN�������bk\�\�:5]\�8\�#h�h\�a�\��mlkV\�%ʏ�[�\ZǯF����EҨ\�y�׷\�\�V\�gK�\�<Jp9$�=��\�F\�S�ά\�//[�u|�G\�u\Z��g��4ѮC�r/�@�?�XӴ\�4\�d�%�*3\���i(;�OM\�{\�X�\\��e�y$s\�c\'�\0r\�Mt\�\�\�r0a�d\�uM=#��v؞9U�\�^Y{�޲\�;Y\�{�\�\�6\�\�\Z|VĂ\�>b;�sV��#;}\��Ə\�V�\0\�2\�M� !Q����ּ�\��$y�\�W?Q\\-;\�z��Z�zէ]]�\�\�;U�\0�QU����\�e�D\npX�\�~�WE�y�\�]NƑ\�h���\�\�+��q�\�\�vV��XܨU�M�\�\�)�_\�ҡ�GR]\�y#ؘ\�\�\��)�i[��\Ze<ϸ\�wڌ\��k�-�V\'�\��\�\��\�o~+\�\�:��E c\�mxz_\�Mz�\���5��r+göWW�,	�8\��u�\0�U¤i\�JN\�p�:�傻:\Z*_�O�y/��j\�:l�J\n�\�u5\�WB�y�$oG/\�֟$`�\0\"�-_{F\���mbS��5\�,\��\�\�\���Ø\�;;%\�?L�\��8ю�\�-����\��\�!\�\\q\\k��Ե�\�\���jW���}�\�H�����\�+�wH\�]��s]�TA�\��٨N��\�J\�\�U\�M>cN\�2�;$\�r��\�S������G).��_��\��s�\0%p:5��K\�\�\�{���t*\�nǟN�rH\��n���wӇ|8�1\�^�\���I�_�ij�1C,_)\��оK\�\�?\�+\�|+r&\�\�$�й�\�Zƻl\�J��9�%��\�Jȧ\Z\��1{=Փ\�7\�!!Q��\��Vo��{o(~2	���\0\�֯�m�\ZB�eb�\0�A��&\��ҋ�WX\�b�t[��aw~G4T�\���\��\0뙢�\ZU��b�/QO\�z��k|�!��_\�ҡ���\��C\\F�EPM�w\Z��\�m]\�+�\�\095�>�k\n\�\�}�bQ����FG\�^�\�8��\�\�h%�V��\�z�x�\�=\�*��G�R�U͢3\�\\Kz\�\��s\�μ9S�\�eo\�}�\�ݭ\�}skhȷ\�\�p�\�c\�z�u8�P�s_;Y\\\�I�\�\�Ҽ�	��f$\�p�p���M9A�\�ی\�\�R�M+v\�k\�7A,d\�~��>��-,\�K[\n���ּ�\�?�\����*(�\���]K.\�Ӥ�\�3\�p�\�Z�p�*\�\�z���@�\"i.ぢ�9�I��\�g>\�Evg�\�^M��T��\�.\�iㅠ�\�ێ>R?���\�7�\�\�W�\��xܴK���z�}G�pB-NQJ\�3\�\�\�T\�Q\�\�{\�u\�\�kC\Z\�\��\��\n\�\�\��\0\�1q�\�WM-\��5\�q2�\0���s�\�\�e\�p\�~���\��\0\\�\0\�\Z\�_\�\�]�1��\��8p\�\�o�sF\�R��\0���\�\����ԗy\�R��\�\�k�\��&/\���\�iT]U�\�M��\�̚ts����?�|V��\ZŦZ��G��\'\�f��/Y��Ŵ\�E�\�]�!\�;g޺kx\�+h�Vܨ�A���w��7�iK�uhR\�	!�eJ����Y�!\�ޔUF�ں	֤����L���\�$\�^�o��Tw3��\��CS]�?J��Te�޸�E��\�}\n}\�X�Ui/\�o��\�\��\��\�\08Ac\�rk���n{��bI)��c�\0׬j��\�P��V\nQM�/@71�Q\�4\�P�\�F#�k_I�7��[��*DU:������ʛ6�\�록�\�J5kI\�\�S\nH$\�T�8\�\�^�|@��\�}Z�x�w𕵑��f�<�9)�\���Q\��^;x\�\�d�	\�o�=?J\��\�>\�2\�V���,\�Ԏ���r�V�\�\�H�8ϵxߋc1��\�?\�U���+ӛZ�\�K[�+Q�*\���;\�0\��\�|�zͼ�\�Ѵ�\��\\��Q�B�*.7�{�c*B�%J�ӕ-�q\�b\��\�M���\�C�6\�a�zQ�پ����>�fL�\�\�C$o��U\�ᔎA��̯��{�l|Ij�\�_�Đ3cq�_Q�����\0!����B�EX�RA�L\�f�\�C��y^IN]\�$�GSY{5ta��\�\�e\�q,�эq��\�@�\�\�.�������\0���\�\�ٜ\��D�d�V��;O\�\�uu\�)*\���\�Wg�h#��EE\�11\�2J\�Ц�j)��6��q\�J\�[�\ZO-f���C־��\0!D�\0u��L~$r\�\�3���+�\�\"�.�.*aUo$Dt�dR��3x\�V�#1ϘP�\0�*�\�E\�~\�\��\0�+@:��\�N�C��Gݑ׊��ˑ\�T�\rnQ@�\�\�P�=?*�\�\�1]�\�-Y�y%�t��\��؏\�N�Σ�id���y�6\����搜����\0\���}�F+H\�\�~u�gcka�\��e�w\�\�6\�\�絜�Ԩuǭ=�u\�\�X�g�/0ewB�i;�\n3�H\�c�0�O�\�FFzR��&$\�i1\�˕\'�5�m�\�7�	!��i\�NW�\�\�\�\�t/\�l��W\n\�\�\�)\�RQ\�\�t\�1\�j�\��V��SM�D�\�\�\�/#*�̅�p1�~��y�\�9Z\�[�,̲0.\�$\����*�,\�(<\n��t	w�\�k �L�#?�wӡeϱ\��R�\�;8�\n��Ŷ�\�U\��\0j\�|S�i�\�̎@���Pd0�\0j�l��,\�Yr^u\��1��\njvMw\"�ni�C�\�6�xz��I|H\�.�o�Z�\�5>c�UI$\�z��T�k;�>��W؞�\�yR>X�\�9&�U�gE\�.j�#�\��Ǽ���\nL\�p0	=�*\��>\�T�<D7\�A�V홣n䊻$��\'J1��\�gz�s��i�Z\�\�6\�\�0댜\n�j�I�(\�}*��࢛�\�1ws�j�?O$\�JŘ=\�p\r dc\��5\�>�\�mT�Llߟ4Ku\�a�k\�\�v�QElx�B�5_�\�֕g\�h\�ѕV`\�qJ��\�㹛J�BG\�IҊ\�4$\�:9�i\�\�A\��h�5[\�<��(�\'\�Qxu���$��7�_�\�Ԟ�\0���\0�\�ʓ*;���?\�//\��\0\�F��^m��\�?үx�Q��վl�\�_�\�N�w�M��ɝZE������\�z\�iɨ���3����\�ޝ\n�7\\�Ó޻}7J6�|\�\�\��k\r�z\�^_\�\�\Z^hQ��\�[�m\�\�~VS\��r\�\�;\�6��\�Uu0@<֊0q�S�Bt�7-�\�X퍶�\�P{X�\�)\'�\�O�_Z\���5ܫ}77s\�=j���!\�\rV!Y��D��țN�o�g��5iP�\����\�A��p2.4nah�BQ�\"�Ms\��\Z4��\�n\�\�\��\Z�*�\�\��	\�Y#q�Sު2�\�B��������\���\�6ȃхi\�>x呬\�z~F<�ǽe(x\�\����`\�ɧ�\�9¤o9\���C)\�y\�}jyY\\���S\��L\�\�\�s�\"ys\��)���%IEsKb��f��I\Z��9c\�+\�4�F\0�@�fi\�XE�m\"\'�7�&�\r\�ɿ�0\�Q\r�\�9�O�h�5��\�\�QEuy\rZ���\�M��q�UZ*\�ՙЦ\�Ԗ\��⼘��\0�E�-��Y\�\�j\��$R��s�ۓz�[I��\�}y�&�<��qH��\�g�ӥџ1	VS��gF=	��4�\�=��oQ\ZH��3�\��\Z^�\r��n\�yv���\�Z�\�Oy�ΐ�u��m�SPS�/�9?�N\�_�\�\�\�x�1ǰ���\�s���I��\�6Ԋ\'\0�\�(�\�`}\�Z\�\�FZ�Zx��\�\"\�\�\�tD�M�\Z������<�0\��\�8\�\�\�\�Å\0\0@\0R\nS���(�Yy+�?Yѭ��1ms�(m\�\�pT�\�\�Y�v\0��\�\Z�o�~��&+FJ�~\�D%8H\�ΛEr�(��~��.\�uPj��!̎}I�\Z��5ޟ%\�V\�7���EB@Q\�\'��\���ֻ]\�Q�\�h\�^	##� �NEq\�1�	ͫ\�\���\�#\�UqN\�W�O$\�4��]@�0\�*\"��\�Rp���w\Zv�$�L�\�\�8\'\�;WSa\r��涝k�K�\�\�\�q֛���ܒ\�y\'�<�1�6���VW\�\�Ͳ�\�iFnI\�؎x��āTzw�@���n\�>q�EP#�\�'),(152,23132132,'Jose','Martinez',323123212,'2023-10-31',_binary '�\��\�\0JFIF\0\0\0\0\0\0�\�\0C\0		\n\r\Z\Z $.\' \",#(7),01444\'9=82<.342�\�\0C			\r\r2!!22222222222222222222222222222222222222222222222222��\0\0\�\0\�\"\0�\�\0\0\0\0\0\0\0\0\0\0\0	\n�\�\0�\0\0\0}\0!1AQa\"q2���#B��R\��$3br�	\n\Z%&\'()*456789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz�����������������������������������\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\������������\�\0\0\0\0\0\0\0\0	\n�\�\0�\0\0w\0!1AQaq\"2�B����	#3R�br\�\n$4\�%�\Z&\'()*56789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz������������������������������������\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�����������\�\0\0\0?\0\�\�)i+\�8��(��(��(��(��(��(��(��(��(��(��(��(������(��(��(��(��(��(��(��;\�\�QۜR\0��)�(��QE\0QE\0-%-%\0QE\0QE\0QE\0QE\0QE\0QE\0�\�8\�\�\�(ɥ�N�\�\�AՐ��T�`[�y�x\�\�iL6\n`Es�Y�����\�b	�y.\�TRP>aߥtZ\'\�H5}(\�]j?g���Cr6\��\�rw�\���Kԋ|��a\�ױ��U��;�N-lz��\�^ZEq$P\�ڧ�w��+\�m�+���L\�WE]�w�\�8�\�(���B�(��(������(��(��(��(�AEPE��\"� u8�z�㨦�\�u�\�\�|�*9a�ԽK�WԋN6\"\����tg�7\�@=k+\�4��\'N�]=\�\�h\nG<��0Ź8�l�\�\�\�cq�/�H�V\��9\�cG�|��G��8Yf�\�$�6��\�7\�X��nq�\Z\�Wh�V#�\�j�ac�c\r�v5\���Y�J\ZD�\�&QEP��(�EP\�R\�PEPEPEPF8��W\��\04rgi��`{*�_a�\�s�)P�3�ڂ\�\�ד\�^!\�l/��\�\�r\�\�s�\�}kԭnb���\�#�$P�\�N�0\�O���79c���R1\�j��֭���\�:��\�X\�/P)H^I�\�\�Dg�\��\�f7�F^P9�\�*���}\Z7�淼}.\�\�܆&Ep�Uy\�{�\�\�a{�Kk�M�\�\�Ԡ��A\�\�`��S\\\"j�h:��\�r\�`	6(�A\�G$V�k�����1k���nX\"\�m\�ϓ^|�\�s�։B\�Sh�Ct�T�$�x#�k\\h\�<;�,�i,-!J��\����\�$\�o^\�f\�Tf\'��z�GC�}+��F�g5X$�EWI�QE\0QE\0����\0QE\0QE\0QEST��.�s8<�d���\�\�s݈\�\�y��c\��5\�> �����H	f�\��6[-K���4)+:Ȳ@�ߏo��qb]��2G�\�ds�}=+\�|p\�hF&\�\�\\��v�]|�5��Y\�.\�A)\�x\�?:\�\'�>��űpTԀ:чw�U���;\�Q]�⸄\�qI!)�ꒌ�Dp)ǩ\��1N\�Q\�����\�n\�R=U>Q�+���M�{\�9�Jx\�ʗ!Zp\�c�(�]��Kx\�\�Ugm\��IǶMe�\�5Y��V_1��\�ζ��k�#��D��\0���~�\���3\�\�G\�\�-�	|���͖#���7�$V�\�[�\�\��&�&�\�C�H\�+H�3�J\��NM\�\�{}�Ғd�\�D��g�\��ӫ\�N\�㖌(���B�(�b\�R\�PEPEPEPm x9\�=+/O\�%���\�H\�y�4�!%��珘�jз2\�]E}\Z3�O\�\�>��\0\nƵ>h�џ+7\�h��k�\�\�̸It\�\��\�`�\�\�X\�m!�[��cN��æ=}�Zлմ\�h�z<�|�gs�ry\�9\�Oj\�<!f-�a#�\�s#K!<�O�\0Z�`\�^�UE̎N)D��FGF*\�\�2�\�\�ǭ?\�[\�,Ҋ\�V�O�1��_\�O\�}G�\�`)\�\r�U�W}9�s��\0�\�95_Sb�\�P�vI!�7\'�S��,�*v�-�}*H��\�,�rX�\�*���V8�k\Z\�̍6���$�]�\�֣�]�\�=�jJ\�:�sOD\�\"\�\�`�a\"�!V`>]�r	��5\�HەX\�^B\�J���?x�\�m}�a[���\�\�8R={�TX�|Co�]u�Q���7�|�\��]W���W��\�`���\�( \�\�e]X䪬Ţ�+s ��(����\0QE�\n(��\n(��G<\�o\� �#Vs\�\09%Az��\'\n��\�l/�\�JM�4Tw�\�m:\�G\�a�Y,\�i�	�\��\01 �\'�\�\�\�3豬��\�fB?�\0Ze\�\�6�\�[�dY\�\�Q��֮X\0���G\�\\}�8\�\�O�Eg${�\�\'\���Cʼ�\\\�.�3�\�i\�n�[!\�V\�m?_ʽgU�\Z\�N\�p?PW�ם|Y�1\�\��\�\��h��9ήh�ʖz���k=�[\�\�CFÕ\�|�\�U.n\��\�k�B�4�ʞ�3s�\��\��^\'�P?\�$�~�\�����\\,NK\�\'��Wx�(\�E\�0\0��\�Edl6BD.@\�\�q���xr=XG}p�\�1�q�nWs�cǧO\�\�\�\�t\�7f�SG��\�H�� $K��4\�\"H�RD���\�rHΩn˖\�x��k���Jg����E�j\\�b~\�	̲ð\�+?���1��-WvQEtQ@IKI@9���\�\0Aiv.|�kC!B3�\���\�23\�k\�B�.b>�����L���\�\0���K�K\�\�osp\�d���o�\�A\��┤�ҹ8���9\��ZY�\�*�K�%��d�l֜^�\���N����Y0$P=X�v�z\�U�^\�Fׇ$�\�=��4\�c�\\��\�\�[\���YO���(}\�\��W)\�ۥ�_���\�2)ʱ�\�Ӱ?�*\�-��rJ\�\�\�aw8	�$�\�5\�?�\�ƾ���\�Xu�����o\�\\�\�\��I��s\�\�\'h�4�\�R,�Iu9\���\�q�\�W�ysl}F*V\�9\�\�O�,3\�o�\0\�k~/�\�g����\n\��\�\�\�X[?u��\�\�\��.�������\�8�E\�(��,d�\�\�\�j:�\�\�G�\�\�TyH\'�S\�c�j\�\��A�\��UOT]:\�b���sZ҂�2�+\"\�\"D�@U\�:�+�\�\�\�aEPESi)i(\0��(3TEō\�p!�U�\�|��\"��\�q�j��Y�\�:\�\�[kI>�\�\�>�\�\�|;pe@\�z\��\�>��B�>�5\�YkS˩���M29�d*��\'>�0�\Z\�\� �<�T6�v�0�\�+�{�\0��EX)\�]9���z\�\�\�\�ºhH pX)\���\�K).�k��\�\�Q\�:W�]\�\�\�}p�],Q\�v���ߟ_εa�ּ8�m���JFFa�q;�s\�=��J	\�\�ɫ�\����X][\�v�\�x��X�\�r@<z\�\\M�y&�R,�Jᅨ<w>��\����t�\�dfY�\�\�`pQ}c�z�\�\�G\0\�\�*\n*Zً-8۫���\0X\�\�ֳ\�A?�\�EmH�)o5�,4\�I+|�K��@�N{�t�=�ǥ\�\n�BTs\�@?�Lc\�ю����q:=���\�(W_C��\�\�����/\�\�B�\0rjWM�m\�6J�\0<�Z�x\n/\�;n���k��\�z�.\�\"���`�1�\�^\�X\�nT�α!\�m\'�$\�|��\�A�j\��(W\"I��cZ\�ҜɥZ�,���\�\�\�Td��z�\�סx~B��<��~����#\n\�\�Ң�+�\�aEPEP\�R\�PG>��L�8��� �1Y�H�^�\�c��\�?\�?�?\n\�5,���:~�d\�\�j\�^��8�P+8���\0\Z�;tt\�M\�$ι/�\�\��\\c�\0��I�ό_�i:�CP�4\����]J\�x\�c	,��\�\�\�WG.�h���\�v#(�%��Vu�(A\����a9$\�\�\�Nsc���X\�\nn\�7��\�ſc�\�\�\�nD�?�#H\�\\\�3�֊hk:�v��-�;ʉ�\�d1\�׵qWz�p\�q\�(%\��$\�?\n\�<=�\��ơ�\�_�+qG\�\�8�+9×b�\'-Ί\�\�HDPƨ�\��sSJ��u�R)Aⲵ�X\�vo5ԃ~>X\�\�cY\�SK��|�7e�\0�Ҩ�7UC�N\�zL�\0Χ\�.ό��\nW̖V\n�v\�?Zf��5���\0M������+\�)s����ZD\�prjjC���\r\�B¸Z\��(s�\����ZR��\��&\�Q]\�\n(��Q@IKI@dzQE\0S�����\�Ι\���)�\�\�\��\��;�z��\�?\�\�\��\��;�gI�\0?\��\��U\�)Xw(�\0g9�\0�\��w�*�ś����\�]\�y\�\nO��kR	��\�4\�IHQq7�lJs���_ztJ\�\�\�7\�\'\\�ma��k�x\"��Do@V�m>ՎZ\�<�\n9U�kk\�/\��p��ʤ\��\�e/,�i��i�W���\�\�6�d��\�\�j&ЬYmq��\Z��-����^/Z����Ǩ\��\�C\�\nW\��\�.?�?ֺ[?\ni�R\�2y��\�䷡\�*\�ׇ\�\�$��?�!\�\�`t�V\\�\�5\�W�\�c\�\�\�-K�z\�t�\�����\�\�Ǣi�\�\�#\'\�f�f\�\�\�8\��f�o\n��?\�1�\�Fx=�U,-\�[F��S�\�6�\0{U\�w\"S��QE��QE(��\0ZJZJ\0(��\0(��\0(��\0(��\0(��\0(��@QE0\n(��\n1E\0QE\0QE\0QE\0����\0QE\0QE\0QE\0QE\0QE\0QE\0QE\0QE\0QE\0QE\0QE\0QE�\�'),(153,55444444,'Mari','Martinez',312321321,'2003-10-08',_binary '�\��\�\0JFIF\0\0\0\0\0\0�\�\0C\0		\n\r\Z\Z $.\' \",#(7),01444\'9=82<.342�\�\0C			\r\r2!!22222222222222222222222222222222222222222222222222��\0\0\�\0�\"\0�\�\0\0\0\0\0\0\0\0\0\0\0	\n�\�\0�\0\0\0}\0!1AQa\"q2���#B��R\��$3br�	\n\Z%&\'()*456789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz�����������������������������������\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\������������\�\0\0\0\0\0\0\0\0	\n�\�\0�\0\0w\0!1AQaq\"2�B����	#3R�br\�\n$4\�%�\Z&\'()*56789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz������������������������������������\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�����������\�\0\0\0?\0��(��\n(��\n(��\n(��\n(��\n(��\n(��\n(��\n(��\n(��\n(��\n(��\n(��\n(��\n(��\n(��\n(��\n(��\n(��\n(��\n(��\n(��\n(��\n(��\n(��\n(��\n(��\n(��\n*9\�A$�	��\�5\�\��â��\�0\�\�\�W�O0b�0M��\'1�4\�UmB�-7M����*\�&��\�\n2�p�����\�]]&\�\���m&��m\��\��\�T�]V\�Dӥ�\�nR\�\�!�w?��>\�\����%s��V7pFʹ\\K	�<\�=6�d3Gq\nM����WS����\0(��\0(��\0(��\0(��\0(��\0(��\0(��\0(��\0��\�6\�����5�/#\�5_\nj\�n�Nú�\��\�?\n��P�\0�m\��q\�k\�\�\��T�uX<���\�?�7\�@I�\\\��\0�~\Z\�6\�-��\0��?�k\��|E\�bD\nWJ�>V\�rO\�\�h�Qח[��-�\��@-̸�U\0��ߕe|#�\�|G\�\�=d��o\�F��\0\Z�����4�Y���[���d���\�\�}�x�\�C�W\��t\Z,\��V5R�z�W\��u��j\'�\��\�2y�z�\�����E��\�o\�ȳX^@�Tte @�-fi��C@��\�t\��\�x_��_�z�e\��{K\�5����	\�`s�e^�թ@Q@Q@Q@Q@Q@Q@Q@Q@��\�\��F�:�a��&68Y��>�\�\��\�غ���n�\��\0#_Cb׶Д\'}���\�J\����:�\�啼s\�.�e$\�\�ݿ��һ��_�>i?�\r��\0F5rP\�o\�ź�.�t�v�\'�\������5Ǐt��\��\0�\Z�:ߍ�#Xx�8��Ħ\��Ts\�C��Ċ���Ɔ\�q\�RpP��m�<H���\����]B\�\�T\�类�e��\nH�Ѓ_.x�\��\�\�G±�I�\�vg\���h\��Er�S�\0	o�\�o\�#\�i�n@\�\"�?���k���(��(��(��(��(��(��(��(�\nڇ��n�\��\0#_3�4�]K\�V.2�\Z]\�G�d�ơ�\0 ۯ�\��\0\�\�\��\�\�\�\�\��\0Bz\0�\�x�\�[K�cL�\�\�LӮ9p\�A�\�~J*����t��O�\0�\Z��Շ�I��\�\�O�\�\�_�\0\�}\��\0\�?��j\0�Cp\�\�Z\�>0h�j���Zq0\�:�\��!\\O\�K�wH�e���\��[j\�h�*���А?�\�־1ɯ�!�>�d�S��[\���{@\��hw\�e\�\Z��d�C*Cx�:\�\'�\0B�{]x��\��\�\�o�0\�6J\�2/͏\�~u\�T\0QE\0QE\0QE\0QE\0QE\0QE\0QE\0QE\r\�m5��\'\�x\�GԊ�\�|-��t}R[\�g\�K\�(\�\�b\�`�6+\�u?�f]g�m�\�\��~\��q�lמ\�\�\��K\���\0�P�\��ƛuc/$N��R�3�O\�\��\0\nx�K\�弊u�\�HgE\�\�ņ=G8�*\�~.�\0Խ�\0�����\0R��=�\�x\��6\�5\�\�\�\��=\�\r�\�\��\��\ry,_\n|u5\�Yt\��׾@�a\�@ݟ\�\�q����/\�\�\�F~.�\0Խ�\0��\0v>�͟��4�,�ǖy��\�V5�\\߄�\�+�\�)���|��\�\�9\�\�]%\0QE\0QE\0QE\0QE\0QE\0W!\�OI���I���W6󼤎AE\���1�\�9�|Bծ�\�\'�;vuҧ�)zHT�0(���^�a���uW���>G^��\�l��^1\�[_\��R\�l�\'�\�ྷ.�;�RT�䏜�\�]�8Փ\�i\��tX\�Ⱅ�\0�\�u\�G�\�\0z=�Xk)�\0��\�\�\�9.F�q%W\'<\�\�|M��I�\�ZtW&{��\�$\��@\��\�2�\�|Aga,P�sOy@����y������nt��\�\�\�Őy�U,O\�`\�{Es6\"�\�\����U��r�͸\�v北Ğ\"�G����\�B壗p\�\�\0�X~T\�Q\\�\�=F\�\�\�\��,\�\�jH<\�\�\�c�\"���,�K���m;N�X`]�1upy\�@�EGo!�\�)��c�q\\>�\�+�3\�wZ|1Bb�k4�\�&b�\�\�Q^i�x\�]2\�L��k�\�\�m�/�DP�bO=Ni�ǚ��6�4=2)�f�wq���/���M\0zm\�\�\�\�[\�0x�0��+�c���$�\�\'\n:�m\�1�>��\0d:f�\�B�~c\"��\�\�4W-7��\��!#۪�f8����u4\0QE\0QE\�\���\�__\�\�\�G�m�`��X�\�O�>Ճ����\�\�͝��\\����{e΋oq�Zj\�\���h^\0��_\�\�+���_�^\�\�[��[R�\028Df\�\�\�tɠ%�\�p��9\�66PH;l�	?�Ȯ��\0\�\�\�w�\0��ӏ�\0�\�T�&��C�F\�,_n�\�n0�#�ۚl�\0\�d�LZ�4�le\\û�m\"��\�z�@�k�&>7�.�yH�,!>\�2\��MT�^tY��\�u9x��+p\�z7l+c\��������K�G�^Le.\��l%��֦\��	�\�$�\�gi\�H\�\"F\�JP\�Kj\0\�)�\0#���\0_z���*αe#�vҐ��$�BѬ�\Z\�\�>\ZY^4\r�yj\�\�,\�#$\�Aaӧ\�ˠ[\�\�+Mi���kv�W�{�\0?΀<\�÷\�\�o\�R\�JA\�\�X^�9��>)_<^7\�]\"�\�OH\��G�G-\�\\}H��\���}��sG$�e�ܷjž�\���\�Jv�\��\rZ}J[��u��[ɵ��\�}9�[^��_�>Y3f�e�\���c���\�H\�m\r�\�R����\�\��\�\�\�|�\�j\�S�k�v�A\"�a�\ny�\��\�\�Ϭ?��痩��\"\�څ�1 c����\0S:G�&\�D^i���vg��\�k\�<Su>��\�\�Z\�\�\�ioNB;+�\�	\�\Z/�!\�|;.�5\��\�K�;Nr\�X`�++N�m�\��-l�]HZ\�+�#�-���^�\0p���_\�\��Ѯ\�S\�\�t�����\�j՜m�x\'\�\�)��E\�ۘ7��i �bx�\�S�u�jvs@\�\\\��^\�z&��eg`=���\�]P\Zr��\�XvF�\�B��?΀<\�\�M\�����R�\�Gq�Hj�������w6kt<3��\�\���\Z����=6�U\�\\�3O��\�-\�견�ma�+�}\�+1~ڥ��p5+͚�ʲC��L�$����*ܑ�����\��\0\�z�\0s\\�.��k�j\0\�L\�\�6F�ʅ\�8\�`Wwm\�\�b�qo-\�=N3@\�E\0QE\0QE\0QE\0Sdm��c;A8�T7r<6sKfGHٕ�8\�\�~,m[Q*\�o�E�|��\�nܖ8�\0t\�Gm{myo��i�Hr\�z�2	� ג\�ڛ\�7\ZU�2Z\\k���2��B�Ќ�<+y�{T\���j�w6���3#H\�%]���\�u\0�\��\�\�\�\�O1�%�Q�\�\nU�6}�\�[�<\�ּ\�\'�����}>Y-\�&��2]B�F�=ݗ�Z�\�\��};\�\��3\�6�Oq�ڋ\�`g\���\�BNhԚx�K4�Xp}*(�I\r�K�\�\�\�˛��\��#��;�����V��;�@\�̽*Il\�{�\�\�\�z�\�Y�I#]>\�Z\�I\�\�\�v�TmtPTŕGb�4\�-sn\�2\r�ݖg�i�������\�,��ђ�8e8#�\"��]?Rkx?\�]|�X��\�Z��#x�\0>�^z�/\�jZl\�\�76\���\�\�\�꤅=�;�\�@�Q@Q@Q@Q@Q@Q@Q@Q@\rH\�1�EQ�\�V_��E��.�$\�R���Fw( ��G�E\02(\�(�4P��*�\0\�L����\�Ki\�<R.\�S\�zT\�P\01ҌJZ(\0��Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@�\�'),(154,23213213,'Pedro','Lorenzo',213212312,'1980-10-02',_binary '�\��\�\0JFIF\0\0\0\0\0\0�\�\0C\0		\n\r\Z\Z $.\' \",#(7),01444\'9=82<.342�\�\0C			\r\r2!!22222222222222222222222222222222222222222222222222��\0\0\�\0�\"\0�\�\0\0\0\0\0\0\0\0\0\0\0	\n�\�\0�\0\0\0}\0!1AQa\"q2���#B��R\��$3br�	\n\Z%&\'()*456789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz�����������������������������������\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\������������\�\0\0\0\0\0\0\0\0	\n�\�\0�\0\0w\0!1AQaq\"2�B����	#3R�br\�\n$4\�%�\Z&\'()*56789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz������������������������������������\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�����������\�\0\0\0?\0��(��\n(��\n(��\n(��\n(��\n(��\n(��\n(��\n(��\n(��\n(��\n(��\n(��\n(��\n(��\n(��\n(��\n(��\n(��\n(��\n(��\n(��\n(��\n(��\n(��\n(��\n(��\n(��\n*9\�A$�	��\�5\�\��â��\�0\�\�\�W�O0b�0M��\'1�4\�UmB�-7M����*\�&��\�\n2�p�����\�]]&\�\���m&��m\��\��\�T�]V\�Dӥ�\�nR\�\�!�w?��>\�\����%s��V7pFʹ\\K	�<\�=6�d3Gq\nM����WS����\0(��\0(��\0(��\0(��\0(��\0(��\0(��\0(��\0��\�6\�����5�/#\�5_\nj\�n�Nú�\��\�?\n��P�\0�m\��q\�k\�\�\��T�uX<���\�?�7\�@I�\\\��\0�~\Z\�6\�-��\0��?�k\��|E\�bD\nWJ�>V\�rO\�\�h�Qח[��-�\��@-̸�U\0��ߕe|#�\�|G\�\�=d��o\�F��\0\Z�����4�Y���[���d���\�\�}�x�\�C�W\��t\Z,\��V5R�z�W\��u��j\'�\��\�2y�z�\�����E��\�o\�ȳX^@�Tte @�-fi��C@��\�t\��\�x_��_�z�e\��{K\�5����	\�`s�e^�թ@Q@Q@Q@Q@Q@Q@Q@Q@��\�\��F�:�a��&68Y��>�\�\��\�غ���n�\��\0#_Cb׶Д\'}���\�J\����:�\�啼s\�.�e$\�\�ݿ��һ��_�>i?�\r��\0F5rP\�o\�ź�.�t�v�\'�\������5Ǐt��\��\0�\Z�:ߍ�#Xx�8��Ħ\��Ts\�C��Ċ���Ɔ\�q\�RpP��m�<H���\����]B\�\�T\�类�e��\nH�Ѓ_.x�\��\�\�G±�I�\�vg\���h\��Er�S�\0	o�\�o\�#\�i�n@\�\"�?���k���(��(��(��(��(��(��(��(�\nڇ��n�\��\0#_3�4�]K\�V.2�\Z]\�G�d�ơ�\0 ۯ�\��\0\�\�\��\�\�\�\�\��\0Bz\0�\�x�\�[K�cL�\�\�LӮ9p\�A�\�~J*����t��O�\0�\Z��Շ�I��\�\�O�\�\�_�\0\�}\��\0\�?��j\0�Cp\�\�Z\�>0h�j���Zq0\�:�\��!\\O\�K�wH�e���\��[j\�h�*���А?�\�־1ɯ�!�>�d�S��[\���{@\��hw\�e\�\Z��d�C*Cx�:\�\'�\0B�{]x��\��\�\�o�0\�6J\�2/͏\�~u\�T\0QE\0QE\0QE\0QE\0QE\0QE\0QE\0QE\r\�m5��\'\�x\�GԊ�\�|-��t}R[\�g\�K\�(\�\�b\�`�6+\�u?�f]g�m�\�\��~\��q�lמ\�\�\��K\���\0�P�\��ƛuc/$N��R�3�O\�\��\0\nx�K\�弊u�\�HgE\�\�ņ=G8�*\�~.�\0Խ�\0�����\0R��=�\�x\��6\�5\�\�\�\��=\�\r�\�\��\��\ry,_\n|u5\�Yt\��׾@�a\�@ݟ\�\�q����/\�\�\�F~.�\0Խ�\0��\0v>�͟��4�,�ǖy��\�V5�\\߄�\�+�\�)���|��\�\�9\�\�]%\0QE\0QE\0QE\0QE\0QE\0W!\�OI���I���W6󼤎AE\���1�\�9�|Bծ�\�\'�;vuҧ�)zHT�0(���^�a���uW���>G^��\�l��^1\�[_\��R\�l�\'�\�ྷ.�;�RT�䏜�\�]�8Փ\�i\��tX\�Ⱅ�\0�\�u\�G�\�\0z=�Xk)�\0��\�\�\�9.F�q%W\'<\�\�|M��I�\�ZtW&{��\�$\��@\��\�2�\�|Aga,P�sOy@����y������nt��\�\�\�Őy�U,O\�`\�{Es6\"�\�\����U��r�͸\�v北Ğ\"�G����\�B壗p\�\�\0�X~T\�Q\\�\�=F\�\�\�\��,\�\�jH<\�\�\�c�\"���,�K���m;N�X`]�1upy\�@�EGo!�\�)��c�q\\>�\�+�3\�wZ|1Bb�k4�\�&b�\�\�Q^i�x\�]2\�L��k�\�\�m�/�DP�bO=Ni�ǚ��6�4=2)�f�wq���/���M\0zm\�\�\�\�[\�0x�0��+�c���$�\�\'\n:�m\�1�>��\0d:f�\�B�~c\"��\�\�4W-7��\��!#۪�f8����u4\0QE\0QE\�\���\�__\�\�\�G�m�`��X�\�O�>Ճ����\�\�͝��\\����{e΋oq�Zj\�\���h^\0��_\�\�+���_�^\�\�[��[R�\028Df\�\�\�tɠ%�\�p��9\�66PH;l�	?�Ȯ��\0\�\�\�w�\0��ӏ�\0�\�T�&��C�F\�,_n�\�n0�#�ۚl�\0\�d�LZ�4�le\\û�m\"��\�z�@�k�&>7�.�yH�,!>\�2\��MT�^tY��\�u9x��+p\�z7l+c\��������K�G�^Le.\��l%��֦\��	�\�$�\�gi\�H\�\"F\�JP\�Kj\0\�)�\0#���\0_z���*αe#�vҐ��$�BѬ�\Z\�\�>\ZY^4\r�yj\�\�,\�#$\�Aaӧ\�ˠ[\�\�+Mi���kv�W�{�\0?΀<\�÷\�\�o\�R\�JA\�\�X^�9��>)_<^7\�]\"�\�OH\��G�G-\�\\}H��\���}��sG$�e�ܷjž�\���\�Jv�\��\rZ}J[��u��[ɵ��\�}9�[^��_�>Y3f�e�\���c���\�H\�m\r�\�R����\�\��\�\�\�|�\�j\�S�k�v�A\"�a�\ny�\��\�\�Ϭ?��痩��\"\�څ�1 c����\0S:G�&\�D^i���vg��\�k\�<Su>��\�\�Z\�\�\�ioNB;+�\�	\�\Z/�!\�|;.�5\��\�K�;Nr\�X`�++N�m�\��-l�]HZ\�+�#�-���^�\0p���_\�\��Ѯ\�S\�\�t�����\�j՜m�x\'\�\�)��E\�ۘ7��i �bx�\�S�u�jvs@\�\\\��^\�z&��eg`=���\�]P\Zr��\�XvF�\�B��?΀<\�\�M\�����R�\�Gq�Hj�������w6kt<3��\�\���\Z����=6�U\�\\�3O��\�-\�견�ma�+�}\�+1~ڥ��p5+͚�ʲC��L�$����*ܑ�����\��\0\�z�\0s\\�.��k�j\0\�L\�\�6F�ʅ\�8\�`Wwm\�\�b�qo-\�=N3@\�E\0QE\0QE\0QE\0Sdm��c;A8�T7r<6sKfGHٕ�8\�\�~,m[Q*\�o�E�|��\�nܖ8�\0t\�Gm{myo��i�Hr\�z�2	� ג\�ڛ\�7\ZU�2Z\\k���2��B�Ќ�<+y�{T\���j�w6���3#H\�%]���\�u\0�\��\�\�\�\�O1�%�Q�\�\nU�6}�\�[�<\�ּ\�\'�����}>Y-\�&��2]B�F�=ݗ�Z�\�\��};\�\��3\�6�Oq�ڋ\�`g\���\�BNhԚx�K4�Xp}*(�I\r�K�\�\�\�˛��\��#��;�����V��;�@\�̽*Il\�{�\�\�\�z�\�Y�I#]>\�Z\�I\�\�\�v�TmtPTŕGb�4\�-sn\�2\r�ݖg�i�������\�,��ђ�8e8#�\"��]?Rkx?\�]|�X��\�Z��#x�\0>�^z�/\�jZl\�\�76\���\�\�\�꤅=�;�\�@�Q@Q@Q@Q@Q@Q@Q@Q@\rH\�1�EQ�\�V_��E��.�$\�R���Fw( ��G�E\02(\�(�4P��*�\0\�L����\�Ki\�<R.\�S\�zT\�P\01ҌJZ(\0��Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@�\�'),(155,32121321,'Jose','Mendoza',122321321,'1999-10-13',_binary '�\��\�\0JFIF\0\0\0\0\0\0�\�\0C\0		\n\r\Z\Z $.\' \",#(7),01444\'9=82<.342�\�\0C			\r\r2!!22222222222222222222222222222222222222222222222222��\0\0\�\0�\"\0�\�\0\0\0\0\0\0\0\0\0\0\0	\n�\�\0�\0\0\0}\0!1AQa\"q2���#B��R\��$3br�	\n\Z%&\'()*456789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz�����������������������������������\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\������������\�\0\0\0\0\0\0\0\0	\n�\�\0�\0\0w\0!1AQaq\"2�B����	#3R�br\�\n$4\�%�\Z&\'()*56789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz������������������������������������\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�����������\�\0\0\0?\0��(��\n(��\n(��\n(��\n(��\n(��\n(��\n(��\n(��\n(��\n(��\n(��\n(��\n(��\n(��\n(��\n(��\n(��\n(��\n(��\n(��\n(��\n(��\n(��\n(��\n(��\n(��\n(��\n*9\�A$�	��\�5\�\��â��\�0\�\�\�W�O0b�0M��\'1�4\�UmB�-7M����*\�&��\�\n2�p�����\�]]&\�\���m&��m\��\��\�T�]V\�Dӥ�\�nR\�\�!�w?��>\�\����%s��V7pFʹ\\K	�<\�=6�d3Gq\nM����WS����\0(��\0(��\0(��\0(��\0(��\0(��\0(��\0(��\0��\�6\�����5�/#\�5_\nj\�n�Nú�\��\�?\n��P�\0�m\��q\�k\�\�\��T�uX<���\�?�7\�@I�\\\��\0�~\Z\�6\�-��\0��?�k\��|E\�bD\nWJ�>V\�rO\�\�h�Qח[��-�\��@-̸�U\0��ߕe|#�\�|G\�\�=d��o\�F��\0\Z�����4�Y���[���d���\�\�}�x�\�C�W\��t\Z,\��V5R�z�W\��u��j\'�\��\�2y�z�\�����E��\�o\�ȳX^@�Tte @�-fi��C@��\�t\��\�x_��_�z�e\��{K\�5����	\�`s�e^�թ@Q@Q@Q@Q@Q@Q@Q@Q@��\�\��F�:�a��&68Y��>�\�\��\�غ���n�\��\0#_Cb׶Д\'}���\�J\����:�\�啼s\�.�e$\�\�ݿ��һ��_�>i?�\r��\0F5rP\�o\�ź�.�t�v�\'�\������5Ǐt��\��\0�\Z�:ߍ�#Xx�8��Ħ\��Ts\�C��Ċ���Ɔ\�q\�RpP��m�<H���\����]B\�\�T\�类�e��\nH�Ѓ_.x�\��\�\�G±�I�\�vg\���h\��Er�S�\0	o�\�o\�#\�i�n@\�\"�?���k���(��(��(��(��(��(��(��(�\nڇ��n�\��\0#_3�4�]K\�V.2�\Z]\�G�d�ơ�\0 ۯ�\��\0\�\�\��\�\�\�\�\��\0Bz\0�\�x�\�[K�cL�\�\�LӮ9p\�A�\�~J*����t��O�\0�\Z��Շ�I��\�\�O�\�\�_�\0\�}\��\0\�?��j\0�Cp\�\�Z\�>0h�j���Zq0\�:�\��!\\O\�K�wH�e���\��[j\�h�*���А?�\�־1ɯ�!�>�d�S��[\���{@\��hw\�e\�\Z��d�C*Cx�:\�\'�\0B�{]x��\��\�\�o�0\�6J\�2/͏\�~u\�T\0QE\0QE\0QE\0QE\0QE\0QE\0QE\0QE\r\�m5��\'\�x\�GԊ�\�|-��t}R[\�g\�K\�(\�\�b\�`�6+\�u?�f]g�m�\�\��~\��q�lמ\�\�\��K\���\0�P�\��ƛuc/$N��R�3�O\�\��\0\nx�K\�弊u�\�HgE\�\�ņ=G8�*\�~.�\0Խ�\0�����\0R��=�\�x\��6\�5\�\�\�\��=\�\r�\�\��\��\ry,_\n|u5\�Yt\��׾@�a\�@ݟ\�\�q����/\�\�\�F~.�\0Խ�\0��\0v>�͟��4�,�ǖy��\�V5�\\߄�\�+�\�)���|��\�\�9\�\�]%\0QE\0QE\0QE\0QE\0QE\0W!\�OI���I���W6󼤎AE\���1�\�9�|Bծ�\�\'�;vuҧ�)zHT�0(���^�a���uW���>G^��\�l��^1\�[_\��R\�l�\'�\�ྷ.�;�RT�䏜�\�]�8Փ\�i\��tX\�Ⱅ�\0�\�u\�G�\�\0z=�Xk)�\0��\�\�\�9.F�q%W\'<\�\�|M��I�\�ZtW&{��\�$\��@\��\�2�\�|Aga,P�sOy@����y������nt��\�\�\�Őy�U,O\�`\�{Es6\"�\�\����U��r�͸\�v北Ğ\"�G����\�B壗p\�\�\0�X~T\�Q\\�\�=F\�\�\�\��,\�\�jH<\�\�\�c�\"���,�K���m;N�X`]�1upy\�@�EGo!�\�)��c�q\\>�\�+�3\�wZ|1Bb�k4�\�&b�\�\�Q^i�x\�]2\�L��k�\�\�m�/�DP�bO=Ni�ǚ��6�4=2)�f�wq���/���M\0zm\�\�\�\�[\�0x�0��+�c���$�\�\'\n:�m\�1�>��\0d:f�\�B�~c\"��\�\�4W-7��\��!#۪�f8����u4\0QE\0QE\�\���\�__\�\�\�G�m�`��X�\�O�>Ճ����\�\�͝��\\����{e΋oq�Zj\�\���h^\0��_\�\�+���_�^\�\�[��[R�\028Df\�\�\�tɠ%�\�p��9\�66PH;l�	?�Ȯ��\0\�\�\�w�\0��ӏ�\0�\�T�&��C�F\�,_n�\�n0�#�ۚl�\0\�d�LZ�4�le\\û�m\"��\�z�@�k�&>7�.�yH�,!>\�2\��MT�^tY��\�u9x��+p\�z7l+c\��������K�G�^Le.\��l%��֦\��	�\�$�\�gi\�H\�\"F\�JP\�Kj\0\�)�\0#���\0_z���*αe#�vҐ��$�BѬ�\Z\�\�>\ZY^4\r�yj\�\�,\�#$\�Aaӧ\�ˠ[\�\�+Mi���kv�W�{�\0?΀<\�÷\�\�o\�R\�JA\�\�X^�9��>)_<^7\�]\"�\�OH\��G�G-\�\\}H��\���}��sG$�e�ܷjž�\���\�Jv�\��\rZ}J[��u��[ɵ��\�}9�[^��_�>Y3f�e�\���c���\�H\�m\r�\�R����\�\��\�\�\�|�\�j\�S�k�v�A\"�a�\ny�\��\�\�Ϭ?��痩��\"\�څ�1 c����\0S:G�&\�D^i���vg��\�k\�<Su>��\�\�Z\�\�\�ioNB;+�\�	\�\Z/�!\�|;.�5\��\�K�;Nr\�X`�++N�m�\��-l�]HZ\�+�#�-���^�\0p���_\�\��Ѯ\�S\�\�t�����\�j՜m�x\'\�\�)��E\�ۘ7��i �bx�\�S�u�jvs@\�\\\��^\�z&��eg`=���\�]P\Zr��\�XvF�\�B��?΀<\�\�M\�����R�\�Gq�Hj�������w6kt<3��\�\���\Z����=6�U\�\\�3O��\�-\�견�ma�+�}\�+1~ڥ��p5+͚�ʲC��L�$����*ܑ�����\��\0\�z�\0s\\�.��k�j\0\�L\�\�6F�ʅ\�8\�`Wwm\�\�b�qo-\�=N3@\�E\0QE\0QE\0QE\0Sdm��c;A8�T7r<6sKfGHٕ�8\�\�~,m[Q*\�o�E�|��\�nܖ8�\0t\�Gm{myo��i�Hr\�z�2	� ג\�ڛ\�7\ZU�2Z\\k���2��B�Ќ�<+y�{T\���j�w6���3#H\�%]���\�u\0�\��\�\�\�\�O1�%�Q�\�\nU�6}�\�[�<\�ּ\�\'�����}>Y-\�&��2]B�F�=ݗ�Z�\�\��};\�\��3\�6�Oq�ڋ\�`g\���\�BNhԚx�K4�Xp}*(�I\r�K�\�\�\�˛��\��#��;�����V��;�@\�̽*Il\�{�\�\�\�z�\�Y�I#]>\�Z\�I\�\�\�v�TmtPTŕGb�4\�-sn\�2\r�ݖg�i�������\�,��ђ�8e8#�\"��]?Rkx?\�]|�X��\�Z��#x�\0>�^z�/\�jZl\�\�76\���\�\�\�꤅=�;�\�@�Q@Q@Q@Q@Q@Q@Q@Q@\rH\�1�EQ�\�V_��E��.�$\�R���Fw( ��G�E\02(\�(�4P��*�\0\�L����\�Ki\�<R.\�S\�zT\�P\01ҌJZ(\0��Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@Q@�\�'),(156,23123121,'aaaaaaa','sssssss',213213213,'2023-10-04',_binary '�\��\�\0JFIF\0\0\0\0\0\0�\�\0C\0		\n\r\Z\Z $.\' \",#(7),01444\'9=82<.342�\�\0C			\r\r2!!22222222222222222222222222222222222222222222222222��\0\0\�\0�\"\0�\�\0\0\0\0\0\0\0\0\0\0\0	\n�\�\0�\0\0\0}\0!1AQa\"q2���#B��R\��$3br�	\n\Z%&\'()*456789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz�����������������������������������\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\������������\�\0\0\0\0\0\0\0\0	\n�\�\0�\0\0w\0!1AQaq\"2�B����	#3R�br\�\n$4\�%�\Z&\'()*56789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz������������������������������������\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�����������\�\0\0\0?\0\��-�w�\�o\�R��\�E}�bno\�Q���KE\0&\�����ԴPno\�Q���KHh\0\�\�ޥ\�\�ޤ�R\n�\�x�E\�Q\��\�\�ޥ\�\�ަ\�\�&Rr�g\�OUC�f��_�\�\�G�d7sz�\��\�v\�ڐ�S�\"\�M\��\�77��\�\�A�77��\�\�ޠR\�!77��\�\�ޥ��sz�\��\�Z(77��\�\�\�\�i(=h`��\�A\�~�PHzR��s@\�%9W4\�J�R�ơrJ�GR�S�Զj��20BT�݉+-u ����\�~U\0u\�hjs�eGޓ\�N�\0\�޹\��1��B�,;C�`!R��U\�Y�Z\�\�\�;q\�}㞾�\�\�\'�\��G?�@��s�>��\0�\�?*�S~n�=��\�\��7�H\�r\�\���T�H\�(\�>���\��\0\�ʘ\�0\�\�jO{��E�[CF\�Q\�\�U�?u�ƴ\�|\�-\�\�I�\���A���i�k/\�Jo�n\�\�f\�|i�mIY1\�0�[+M)^�g�\�S#�*\�%F\�N\�N6\Z:QM\�)\�\�\nC֖����V�\�i\�2\�{ӂ���+���jUJUZ�-M\�c��\"�(+F\�\�a���\�T�l��\�7\�\�	LM响�8�⒕�e�9�f]�\�?\��\�dE�e�\�}kB\�N�X�G\�`|��\�\�\0\�O\�s^ߥ�cHѬ\�Gm?y4�7�&�W7*�~g\�е*��\�{\��e�\�s^�\0>���\�fu\�T���?��]6\��\0\�1X^ƾ\�\��\�\"����\�_C\�=���m�\�ت\�xr\�E�\�;]�+��E\�\�|��\�VE%J\�w��\�y���\��?�z�\r_\��F�`c6�\�SD�=�\�Q^/��W����v\�ea\�����^\'>5��i�\�\�\"��.)�\0g�\�e1�u|ƾ��-\��\n-\�Te�\�ե�\�v\�f�\��\��3U��\�J��\Z�\�\�D\�T���W���+I\�L\�\�\�?Z�V�1�TR��P(�@\�\�=j:����\�\Z\�Y{�$�˜ 1S\�O�8�\�Դ��h�S\�\�jV�.\0\��\�B9C\�7\ZeՔv2�\0�\�\�KE(\���w��C�C���61�_;�\�N�[\�O\�\��<�ˣV\���9�s^���ܤl\�\�O�#W�x�0\���ʲ�\0}�Mp�\�\�ss��F\n+�,��A\�]\�ǘ\�j��{\"�Ë�\�z�\�.|���.z�@נk\Z\\�\�\�h�4VY\�7�p\�z.}=\n\�𾎚E�����4D1\�\��&�Iwڇ\�(?S^$\�=V\�g�\�\n����mA��5���)�?+!\���мZ\��\�Xh$�C�\�\�KIQXO�|\��==+��,a�J\�s\���Z<�6eN�;c�\�l\�%�?\�-`w��i>��\�n�\�J\��\�Zh�\"�I[Hn.\�($y�Kr~s\�*iR\�c�S������[\�1�Đ\�9h�W=\�q�\�\�\�=`�}�\�}�݃R�\"+\�DQ\��!ux\�eJ��z�\�?\�}j\�hs�HVB�܁�\�K��B�\�J2Qݦy�:\�q�b��wv\�7��#U�H\��uŲ�H �\�\�xV �D�?\\ױ�O��k�<|��5f�fE�\�\�\Z(E�K�]��H\�s\���\���F�э�\�d��e\��W��p�\�W\���W+\�k�6\�\�K�s})Y�$�\'�ҸpX��*\�V\��\�vc��\�J\�\�\�9\�^*b)�8��\�|\�EVZ�o5e�G�j\�g@>cR(��x,\�!@\�)R��Toxr�\0K��R�\��Y@\�L~��z$,��\"`\�\� �ּ�U�/.��\\\�=��\�\�2�^\\\�ٞ�\�ǖ\���\�d�M\�\�\�\�ƛ唟�9�ם�.�\�S\�\�恉@\�\�d}9�k\�^!\�\���)\�[\�;$\��8\��\�\\�\0�5����owɇx�ۦZ\�JT!*M\�s�s�iƪ[LGGv\��\�\�O�� u\��5\r����mͤ�$N���Z\�^JNס\�]N:u<\�/��G�\�V[�OYK�p�<m=�8��N�R���\���D��\�M�9�\�\�\�VץtիΒ9\�\�\�w20{�^o\�?�\�\�B�Y!I#?�\��[\n3\�Q^���=�3�.�oPH?�*u}�J|\�\�\��\��\"\�O��ĵ�a��\�If?�5rU\�X�\��U8 G@+3X\�-���wU;I\nO,k^��ަ��8\��<�\�7\�\�m\�\�Ӗ���A�9<\�~u\�\�,vi�\��\0g\�&��=�J?�?j�\�\�\Z�\���ɻ1);}�\��5\��\�Z���}�&Z\��er\�_<\���r?\Z���!F�{e	F�ud�=\�fH\"2Jʈ�$�\�\�!�Ү���\�m�X�JW���k2\��\�\�B\�s4�:rEV5�.T3�\�ϋ\�%Yr��\�L\"��\Z�\�1�\"*<rjb)�晛B�\�?Z�TC\�\Z�h)��\�F���:SE8R)��)-\�\�p\�o\�Ƽ\�\�\�KK��U\�\�pk\�k��6�.\�\�\n\�h�\����Esbis+��V\Z�+\�gS�s_.n�Y\�,�%�=�8#�\��\0\"�pW\�\�e\�5\�MR�\"@Y�\�����om�/md\�\�w���L\Z�?s\�\�K\�\�\'�_\"\�Iv�إ���[Hִ�b\�$���$#\�\��\��\0���@e\�y��g÷������u\�\�\���m\'�\�q\�XE\�\�+���F�ԥcخ%�\�&�{�h\�%�L\n��j�j��s��HȬ\�ǎ\�ڼ|hZ�J#m�&bY\�O�\0\�\�5�\���{<�c_��\�O\�D޻Xs�\nQMO��\�5\��D&\��n�ā%`zg���\�^�\�mzh7Z�\�~\�q\Zww?uG\��f�d����\�[�\�|\�9ws݉ɮ�$]�\�\�\�iD-�人KxF\�\�\n�=>\�=>\�-\�\�o,\�\��5�\�\'\�\�\�U���\�}\��\0\�\�A��w\rK�s3\�\�U\�|�a�֧��\�]G \�\�\�O4��2Y7�<\�;�dsR-D>��C\�\�\�u#A)��:R)��\����p�\"\�~�y\�F1o1$\�\�\�t��z<9(\�5&c�H\�$�|�\'��	\�Gn��v�\�;\�9-\�#:\�{��),\�\Z\�eáǱ�\�\�\�\�\�O]�S\�f�x�H\�Y#q�]*���������5\�?\�o�\�-4�n٤Gf���Bǡ\�:W�\�Z\�z�/.cw�N7\Z��2P՞�֩�=,m<�\'/!oj��\�\�R\�^L�A\�H\�\0���z>��ޖ���jX�,���\�˾ \�ss�^\�\�N\�\�\�F?*�\�ޟ\�j�Z����|���9��\�o\�JUZ->ܑo8\�=]�ϧa���\�\�\'�B\�K2�\0�BF\��s\�V}�����oݱ��5\�6qXZGo�N�\�\�k\�\�QM�#\�\�Viy�\�=\�4QEzH�F�m8��\�HzR�4��H\�L=i\�ޙq�\�\Zx�\�<\Z	C\�8SA���N��:��R\�GZp�PW+\�`��[F�y�Y,{\�8\�W�I��vv\�#\���\�sb]�c�\r\�\�}�\�\�c�m�/ G!\'�ƽ/\���\�\�]@�j\�(W=���\0ׯ;�T\�@ސI�\�\n��R�\Z\�<\�\�~�\�\\�uz�^gV&_���.�2\��F����	ǮNO\�k\�>#Z��,\�#\'2�\� ׬�8�\��.�3\��\0\�\���\�_�E\�\�Gռ�?ZU��\�Ն�q~G!\�E�]݂�\�\n�[=�\�\�\�{\�\�_�둃���2?�vUنw�ˉV�R\ZSM=k�\��O4��6�\"\Zi�=)��1��ކ8���d\��\�1�T\�`~cS+Sdœ\�<*%4�i\Z&<\Zp<S3K�E�f�S\�\ZLi�\��\�(\�5�\�\�i$��.Kƺ\�r#F�`~g]��\��f�8\�\�s\\8�^I�{����f\�w�d���w_\��+\�>/M�@��?\�.y�)�!�m\�M3\�&�\�uC6\�nbO)7�����\�^8ҼZ�|:cN|����=���\�>Ƨ\�\�\"\�q\�S�I\�¹��0.yK�_\��yW\�\��\0\�\�\\B8\\n\0*\�<\�\�\�T�:��	\Z_0�\�\0#�\�\\\�}sM��WR\�$w�KdWޛHu,鶖*\�\�V\�<%��o\��y\r�\�W�8a\�]\�`ܩ\�<�\\\�t\0�\�\�\�3��E��\�`S�J\�	-Z#�L�M4�3HMv�\"I�	��L�\�	4LcL�\�cQ\�V<T[���d\�n\��jEj��O֜���\�V-�S\�\�uz�5fѴdO��\�j ٧Ai��Fi�\�\�w*\�6Q��\Z<6\�@\�XwZ-\�0\�0%\0S�WO�3\�eR�f\�oN�\�C\�62JUԫ��*��`��G �~���\����\�V��i\�LҠ`0=�\��\�ʏE\�J�33.r{\��\�4goE��^��\�Z\�	!�ꏇf�F~�L?��\0\Z;T\�bUS�\�Y�\�.��l�D��?�n\��cO�\�B\�1l�\�Vs�3]�\�F���R�\�h\�4f�4�\�\�7♚M\�\�\�ȸ1\�ǊFj���Fr��\�y�f\�⒮\�-\�)\�~����?Z)�*�*�C�@H�\�JV-�T�����J�1RѴfY\�J\Z�劉����8<Q��\�)jCOS�\�_\�\�\�9�\��t\�\�ӷ\�r�rN\�e\�\�٤c�\�g����ۃ\�f\�Ϛ\�\�+\�l��O��DZ\���vq�7�ֹ��k\�\�ܿ�鮗S_3N�G]�����r����:x�j��\r+ђ;\�\�f�����\�7���4�1�qE�r$/Q��\�\�l\�i\�c\�\�&bi	ɥ\�4�����KHz\�H���\�A�\�\�E0\nL\nZ(n#�-&ޞ$��p(4��\�b\�z�Q��\0&�/�ŌA���V��\�\�d�)\�z���;\���VuңVq\�KC.Y�\�Mw����\0t\\��i$�GJ\�\�sv#\�WNe\�\�X`\�\�\�:�\n�8\�%��6O\���p\�\�.\�n�:�ֻ\r�\�\�Y\�5�\�e\��\�\'�Q��\\�TԢο}\�]z8\�\n���\�g\�\�Z0\�%\�+,m�oҺa:rvL\�N�4���\�{\�KqL����Nnf $�\\Q�)�0(����-!\�H\0���hQL��(\0��(\0��(\�\�(\�����\�\r��\�o��\�E.1}\�%�c\�(\�;W8�Ҋ)�m�v�`@Z{k�-4[��	$�QD���\Z���]�Ɠb:A�\0���՘-\�B��\�\'$d�h��S�uHr�Rj\�m�\�EdQ@Q@�E�\�');
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
-- Temporary view structure for view `vistahistorialsociomañana`
--

DROP TABLE IF EXISTS `vistahistorialsociomañana`;
/*!50001 DROP VIEW IF EXISTS `vistahistorialsociomañana`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vistahistorialsociomañana` AS SELECT 
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
    -- Obtén el MontoPagado actual y el PrecioMembresia del cliente
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

    -- Obtiene el ID del producto recién insertado
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
-- Final view structure for view `vistahistorialsociomañana`
--

/*!50001 DROP VIEW IF EXISTS `vistahistorialsociomañana`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vistahistorialsociomañana` AS select `h`.`ClienteID` AS `ClienteID`,`u`.`Apellidos` AS `Apellidos`,`u`.`Nombres` AS `Nombres`,`u`.`Telefono` AS `Telefono`,`h`.`FechaInicio` AS `FechaInicio`,`h`.`FechaFin` AS `FechaFin` from (`historialsocio` `h` join `usuarios` `u` on((`h`.`ClienteID` = `u`.`codigo`))) where (cast(`h`.`FechaFin` as date) = cast((now() + interval 1 day) as date)) */;
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
