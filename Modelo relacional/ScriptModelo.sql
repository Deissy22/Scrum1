CREATE DATABASE  IF NOT EXISTS `polarizadosjava` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `polarizadosjava`;
-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: localhost    Database: polarizadosjava
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.32-MariaDB

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
-- Table structure for table `detalle_venta_producto`
--

DROP TABLE IF EXISTS `detalle_venta_producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detalle_venta_producto` (
  `id_detalle_producto` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la venta de productos en el sistema',
  `fk_id_venta` int(11) NOT NULL COMMENT 'Llave foranea de venta',
  `fk_id_producto` int(11) NOT NULL COMMENT 'Llave foranea de producto',
  `cantidad` int(11) NOT NULL COMMENT 'Cantidad de prodcutos que lleva',
  `precio_unitario` decimal(10,2) NOT NULL COMMENT 'Precio del producto (por si se aplica descuentos)',
  `fk_id_vendedor` int(11) NOT NULL,
  PRIMARY KEY (`id_detalle_producto`),
  KEY `detalle_venta_producto_ibfk_1` (`fk_id_venta`),
  KEY `detalle_venta_producto_ibfk_2` (`fk_id_producto`),
  KEY `id_vendedor` (`fk_id_vendedor`),
  CONSTRAINT `detalle_venta_producto_ibfk_1` FOREIGN KEY (`fk_id_venta`) REFERENCES `venta` (`id_venta`),
  CONSTRAINT `detalle_venta_producto_ibfk_2` FOREIGN KEY (`fk_id_producto`) REFERENCES `producto` (`id_producto`),
  CONSTRAINT `id_vendedor` FOREIGN KEY (`fk_id_vendedor`) REFERENCES `usuario` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Detalles de la venta de prodcutos';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalle_venta_producto`
--

LOCK TABLES `detalle_venta_producto` WRITE;
/*!40000 ALTER TABLE `detalle_venta_producto` DISABLE KEYS */;
/*!40000 ALTER TABLE `detalle_venta_producto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detalle_venta_servicio`
--

DROP TABLE IF EXISTS `detalle_venta_servicio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detalle_venta_servicio` (
  `id_detalle_servicio` int(11) NOT NULL,
  `fk_id_venta` int(11) NOT NULL,
  `fk_id_tecnico` int(11) NOT NULL,
  `fk_id_prod_serv` int(11) NOT NULL,
  PRIMARY KEY (`id_detalle_servicio`),
  KEY `detalle_venta_servicio_ibfk_1` (`fk_id_venta`),
  KEY `detalle_venta_servicio_ibfk_3` (`fk_id_tecnico`),
  KEY `fk_id_prod_serv` (`fk_id_prod_serv`),
  CONSTRAINT `detalle_venta_servicio_ibfk_1` FOREIGN KEY (`fk_id_venta`) REFERENCES `venta` (`id_venta`),
  CONSTRAINT `detalle_venta_servicio_ibfk_3` FOREIGN KEY (`fk_id_tecnico`) REFERENCES `usuario` (`id_usuario`),
  CONSTRAINT `fk_id_prod_serv` FOREIGN KEY (`fk_id_prod_serv`) REFERENCES `producto_servicio` (`id_prod_serv`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalle_venta_servicio`
--

LOCK TABLES `detalle_venta_servicio` WRITE;
/*!40000 ALTER TABLE `detalle_venta_servicio` DISABLE KEYS */;
/*!40000 ALTER TABLE `detalle_venta_servicio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventario_actual`
--

DROP TABLE IF EXISTS `inventario_actual`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventario_actual` (
  `id_inventario` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Identificacion del stock',
  `fk_id_producto` int(11) NOT NULL COMMENT 'Llave foranea del prodcuto',
  `stock` int(11) NOT NULL COMMENT 'Cantidad del prodcuto',
  `estado_stock` enum('disponible','bajo','agotado') NOT NULL DEFAULT 'disponible' COMMENT 'Estado del prodcuto',
  `precio` decimal(10,2) NOT NULL COMMENT 'Precio del producto',
  `fk_id_movimiento` int(11) NOT NULL,
  PRIMARY KEY (`id_inventario`),
  KEY `inventario_actual_ibfk_1` (`fk_id_producto`),
  KEY `fk_id_movimiento` (`fk_id_movimiento`),
  CONSTRAINT `fk_id_movimiento` FOREIGN KEY (`fk_id_movimiento`) REFERENCES `movimiento_inventario` (`id_movimiento`),
  CONSTRAINT `inventario_actual_ibfk_1` FOREIGN KEY (`fk_id_producto`) REFERENCES `producto` (`id_producto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Productos que estan en stock';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventario_actual`
--

LOCK TABLES `inventario_actual` WRITE;
/*!40000 ALTER TABLE `inventario_actual` DISABLE KEYS */;
/*!40000 ALTER TABLE `inventario_actual` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER actualizar_estado_stock
BEFORE UPDATE ON inventario_actual
FOR EACH ROW
BEGIN
  IF NEW.stock = 0 THEN
    SET NEW.estado_stock = 'agotado';
  ELSEIF NEW.stock <= 5 THEN
    SET NEW.estado_stock = 'bajo';
  ELSE
    SET NEW.estado_stock = 'disponible';
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `movimiento_inventario`
--

DROP TABLE IF EXISTS `movimiento_inventario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movimiento_inventario` (
  `id_movimiento` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Identificacion del movimiento en el sistema',
  `tipo` enum('entrada','salida') NOT NULL,
  `fecha` date NOT NULL,
  `cantidad` int(11) NOT NULL,
  PRIMARY KEY (`id_movimiento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Movimientos del entrada y salida de productos';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movimiento_inventario`
--

LOCK TABLES `movimiento_inventario` WRITE;
/*!40000 ALTER TABLE `movimiento_inventario` DISABLE KEYS */;
/*!40000 ALTER TABLE `movimiento_inventario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `persona`
--

DROP TABLE IF EXISTS `persona`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `persona` (
  `id_persona` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Identificacion de la persona para la base de datos',
  `tipo_documento` enum('CC','CE','TI','OTRO') NOT NULL COMMENT 'Tipo de documento unico(personal) de cada persona',
  `numero_documento` varchar(20) NOT NULL,
  `nombres` varchar(50) NOT NULL COMMENT 'Nombres personales',
  `apellidos` varchar(50) NOT NULL COMMENT 'Apellidos personales',
  `correo_personal` varchar(100) DEFAULT NULL COMMENT 'Correo para contacto personal',
  `telefono_celular` varchar(20) NOT NULL COMMENT 'Telefono de contacto de la persona',
  `genero` enum('M','F','OTRO') NOT NULL COMMENT 'Genero de la persona',
  `fecha_nacimiento` date DEFAULT NULL COMMENT 'Fecha de nacimiento de la persona',
  PRIMARY KEY (`id_persona`),
  UNIQUE KEY `numero_documento_UNIQUE` (`numero_documento`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Informacion personal de los usuarios';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `persona`
--

LOCK TABLES `persona` WRITE;
/*!40000 ALTER TABLE `persona` DISABLE KEYS */;
INSERT INTO `persona` VALUES (3,'CC','1193214808','Test','Admin','admin@correo.com','3213235318','F','2023-07-14'),(18,'CC','1598756347','Test','Cliente','cliente@correo.com','3216549874','M','2025-06-10'),(19,'CC','1598745632','Test','Vendedor','vendedor@correo.com','3216549875','F','2025-06-04'),(41,'CC','12345678910','Test','Tecnico','tecnico@correo.com','3216549879','M','2025-07-30');
/*!40000 ALTER TABLE `persona` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `producto`
--

DROP TABLE IF EXISTS `producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `producto` (
  `id_producto` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Identificacion del prodcuto en el sistema',
  `nombre` varchar(100) NOT NULL COMMENT 'Nombre del producto',
  `descripcion` text DEFAULT NULL COMMENT 'Descripcion breve del producto',
  PRIMARY KEY (`id_producto`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Productos que se venden o se utilizan para servicios';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `producto`
--

LOCK TABLES `producto` WRITE;
/*!40000 ALTER TABLE `producto` DISABLE KEYS */;
/*!40000 ALTER TABLE `producto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `producto_servicio`
--

DROP TABLE IF EXISTS `producto_servicio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `producto_servicio` (
  `id_prod_serv` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Identificador en el sistema',
  `nombreRegistro` varchar(100) NOT NULL,
  `fk_id_servicio` int(11) NOT NULL COMMENT 'Llave foranea de servicio',
  `fk_id_producto` int(11) NOT NULL COMMENT 'Llave foranea de producto',
  `cantidad` int(11) NOT NULL,
  PRIMARY KEY (`id_prod_serv`),
  KEY `producto_servicio_ibfk_1` (`fk_id_servicio`),
  KEY `producto_servicio_ibfk_2` (`fk_id_producto`),
  CONSTRAINT `producto_servicio_ibfk_1` FOREIGN KEY (`fk_id_servicio`) REFERENCES `servicio` (`id_servicio`),
  CONSTRAINT `producto_servicio_ibfk_2` FOREIGN KEY (`fk_id_producto`) REFERENCES `producto` (`id_producto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Productos utilizados en los servicios';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `producto_servicio`
--

LOCK TABLES `producto_servicio` WRITE;
/*!40000 ALTER TABLE `producto_servicio` DISABLE KEYS */;
/*!40000 ALTER TABLE `producto_servicio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `servicio`
--

DROP TABLE IF EXISTS `servicio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `servicio` (
  `id_servicio` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_servicio` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `precio` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id_servicio`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='tabla para los servicios';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `servicio`
--

LOCK TABLES `servicio` WRITE;
/*!40000 ALTER TABLE `servicio` DISABLE KEYS */;
/*!40000 ALTER TABLE `servicio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `id_usuario` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Identificacion del usuario en el sistema',
  `correo` varchar(100) DEFAULT NULL COMMENT 'Correo electronico para la autenticacion del usuario al ingreso del sistema (login)',
  `password` varchar(255) DEFAULT NULL COMMENT 'Contraseña para la autenticacion de ususario al ingreso del sistema (login)',
  `rol` enum('A','V','T','C') NOT NULL COMMENT 'Roles que permite el sistema',
  `fk_id_persona` int(11) NOT NULL COMMENT 'Llave foranea de la tabla persona',
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `correo_UNIQUE` (`correo`),
  KEY `usuario_ibfk_1` (`fk_id_persona`),
  CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`fk_id_persona`) REFERENCES `persona` (`id_persona`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Usuarios que ingresan al sistema';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (3,'admin@correo.com','123456A','A',3),(11,NULL,NULL,'C',18),(12,'vendedor@correo.com','123456V','V',19),(30,'tecnico@correo.com','123456T','T',41);
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `venta`
--

DROP TABLE IF EXISTS `venta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `venta` (
  `id_venta` int(11) NOT NULL AUTO_INCREMENT COMMENT 'identificador de venta en el sistema',
  `fecha_venta` date NOT NULL COMMENT 'fecha en la que se realizo la venta',
  `fk_id_cliente` int(11) NOT NULL COMMENT 'Identificacion del usuario cliente',
  `total` decimal(10,2) NOT NULL COMMENT 'Valor total de la venta',
  PRIMARY KEY (`id_venta`),
  KEY `venta_ibfk_1` (`fk_id_cliente`),
  CONSTRAINT `venta_ibfk_1` FOREIGN KEY (`fk_id_cliente`) REFERENCES `usuario` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='tabla de ventas';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `venta`
--

LOCK TABLES `venta` WRITE;
/*!40000 ALTER TABLE `venta` DISABLE KEYS */;
/*!40000 ALTER TABLE `venta` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-07-03 20:36:52
