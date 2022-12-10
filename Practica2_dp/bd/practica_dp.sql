# SQL-Front 5.1  (Build 4.16)

/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE */;
/*!40101 SET SQL_MODE='NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES */;
/*!40103 SET SQL_NOTES='ON' */;


# Host: 127.0.0.1    Database: practica_dp
# ------------------------------------------------------
# Server version 5.5.5-10.4.25-MariaDB

#
# Source for table addresses
#

DROP TABLE IF EXISTS `addresses`;
CREATE TABLE `addresses` (
  `Id_Distribuidor` varchar(25) DEFAULT NULL,
  `Calle` varchar(255) DEFAULT NULL,
  `Numero_Casa` varchar(25) DEFAULT NULL,
  `Colonia` varchar(120) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

#
# Dumping data for table addresses
#

INSERT INTO `addresses` VALUES ('A','HIDALGO','77','CENTRO');
INSERT INTO `addresses` VALUES ('b','contreras','33','las palmas');
INSERT INTO `addresses` VALUES ('C','ITURBIDE','33','CENTRO');
INSERT INTO `addresses` VALUES ('D','5 DE FEBRERRO','16','XOCHILTEOPEC');
INSERT INTO `addresses` VALUES ('E','PEDRO MORENO','45','LA ESTANCIA');
INSERT INTO `addresses` VALUES ('F','LAMALINCHE','67','CENTRO');
INSERT INTO `addresses` VALUES ('G','LOPEZ MATEOS','23','CENTRO');

#
# Source for table distributors
#

DROP TABLE IF EXISTS `distributors`;
CREATE TABLE `distributors` (
  `Id` varchar(11) NOT NULL,
  `Fecha_Registro` datetime DEFAULT NULL,
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

#
# Dumping data for table distributors
#

INSERT INTO `distributors` VALUES ('A','2022-12-10 07:32:56');
INSERT INTO `distributors` VALUES ('b','2022-12-10 10:54:17');
INSERT INTO `distributors` VALUES ('C','2022-12-10 11:00:07');
INSERT INTO `distributors` VALUES ('D','2022-12-10 11:28:06');
INSERT INTO `distributors` VALUES ('E','2022-12-10 11:33:06');
INSERT INTO `distributors` VALUES ('F','2022-12-10 11:55:19');
INSERT INTO `distributors` VALUES ('G','2022-12-10 11:56:40');

#
# Source for table persons
#

DROP TABLE IF EXISTS `persons`;
CREATE TABLE `persons` (
  `Id_Distribuidor` varchar(25) DEFAULT NULL,
  `Nombre` varchar(255) DEFAULT NULL,
  `Apellido_Paterno` varchar(255) DEFAULT NULL,
  `Apellido_Materno` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

#
# Dumping data for table persons
#

INSERT INTO `persons` VALUES ('A','JUAN','PEREZ','GARCIA');
INSERT INTO `persons` VALUES ('b','laura','aldana','castillo');
INSERT INTO `persons` VALUES ('C','OSCAR','CARO','IÑIGUEZ');
INSERT INTO `persons` VALUES ('D','ISABEL','RODRIGUEZ','ARMIENTA');
INSERT INTO `persons` VALUES ('E','ERNESTO','GONZALEZ','GONZALEZ');
INSERT INTO `persons` VALUES ('F','MARIA','ARANA','LOPEZ');
INSERT INTO `persons` VALUES ('G','DANIEL','GIMENEZ','ARTEAGA');

#
# Source for procedure GUARDAR_DISTRIBUIDOR
#

DROP PROCEDURE IF EXISTS `GUARDAR_DISTRIBUIDOR`;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GUARDAR_DISTRIBUIDOR`(IN `BAN` INT,
	IN `ID_I` VARCHAR(25),
	IN `NOMBRE_I` VARCHAR(120),
	IN `APELLIDOP_I` VARCHAR(120),
	IN `APELLIDOM_I` VARCHAR(120),
	IN `CALLE_I` VARCHAR(120),
	IN `NUMERO_I` VARCHAR(120),
	IN `COLONIA_I` VARCHAR(120))
BEGIN

	-- 1. Guarda un registro y guarda cambios
	DECLARE hasError BOOLEAN DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR sqlexception SET hasError = 1;
	
	CASE
		WHEN BAN = 1 THEN
			
			START TRANSACTION;
			
				INSERT INTO distributors 
					(
						Id,
						Fecha_Registro
					) 
					VALUES 
					(
						ID_I,
						NOW()
					);
					
				INSERT INTO persons 
				(
					Id_Distribuidor,
					Nombre,
					Apellido_Paterno,
					Apellido_Materno
				) 
				VALUES 
				(
					ID_I,
					NOMBRE_I,
					APELLIDOP_I, 
					APELLIDOM_I
				);
					
				INSERT INTO addresses 
				(
					Id_Distribuidor,
					Calle,
					Numero_Casa,
					Colonia
				) 
				VALUES 
				(
					ID_I,
					CALLE_I,
					NUMERO_I, 
					COLONIA_I
				);
					
			IF hasError THEN
		
				ROLLBACK;
				SELECT 'error';
				
			ELSE
		 
				COMMIT;
				
			END IF;
			
	END CASE;

END;


#
# Source for procedure OBTENER_DISTRIBUIDOR
#

DROP PROCEDURE IF EXISTS `OBTENER_DISTRIBUIDOR`;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OBTENER_DISTRIBUIDOR`(IN ID VARCHAR(25))
BEGIN
	SELECT CONCAT(p.Nombre," ",p.Apellido_Paterno," ",p.Apellido_Materno) AS nombre,
	a.Calle, a.Numero_Casa, a.Colonia
	FROM persons p
	LEFT JOIN addresses a ON a.Id_Distribuidor = p.Id_Distribuidor
	WHERE p.Id_Distribuidor = ID;
END;


/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
