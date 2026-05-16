-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: stock_vetement
-- ------------------------------------------------------
-- Server version	8.0.46

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
-- Table structure for table `categorie`
--

DROP TABLE IF EXISTS `categorie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categorie` (
  `id_categorie` int NOT NULL AUTO_INCREMENT,
  `libelle_categorie` varchar(50) NOT NULL,
  `description` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id_categorie`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categorie`
--

LOCK TABLES `categorie` WRITE;
/*!40000 ALTER TABLE `categorie` DISABLE KEYS */;
INSERT INTO `categorie` VALUES (1,'Hauts','T-shirts, chemises, pulls, vestes'),(2,'Bas','Pantalons, jeans, jupes, shorts'),(3,'Chaussures','Baskets, escarpins, bottes, sandales'),(4,'Accessoires','Ceintures, sacs, bonnets, écharpes'),(5,'Sport','Tenues et équipements sportifs');
/*!40000 ALTER TABLE `categorie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `commande_fournisseur`
--

DROP TABLE IF EXISTS `commande_fournisseur`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `commande_fournisseur` (
  `id_commande` int NOT NULL,
  `date_commande` date NOT NULL,
  `statut` enum('EN_ATTENTE','EN_COURS','LIVREE') NOT NULL DEFAULT 'EN_ATTENTE',
  `montant_total` decimal(10,2) DEFAULT NULL,
  `date_livraison_prev` date DEFAULT NULL,
  `id_fournisseur` int NOT NULL,
  PRIMARY KEY (`id_commande`),
  KEY `id_fournisseur` (`id_fournisseur`),
  CONSTRAINT `commande_fournisseur_ibfk_1` FOREIGN KEY (`id_fournisseur`) REFERENCES `fournisseur` (`id_fournisseur`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `commande_fournisseur`
--

LOCK TABLES `commande_fournisseur` WRITE;
/*!40000 ALTER TABLE `commande_fournisseur` DISABLE KEYS */;
INSERT INTO `commande_fournisseur` VALUES (201,'2024-01-10','LIVREE',4480.00,'2024-01-20',1),(202,'2024-02-05','LIVREE',2990.00,'2024-02-15',2),(203,'2024-03-01','EN_COURS',8760.00,'2024-03-15',3),(204,'2024-03-10','EN_ATTENTE',3580.00,'2024-03-25',1),(205,'2024-03-12','LIVREE',2148.00,'2024-03-22',4);
/*!40000 ALTER TABLE `commande_fournisseur` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fournisseur`
--

DROP TABLE IF EXISTS `fournisseur`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fournisseur` (
  `id_fournisseur` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) NOT NULL,
  `telephone` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `adresse` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id_fournisseur`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fournisseur`
--

LOCK TABLES `fournisseur` WRITE;
/*!40000 ALTER TABLE `fournisseur` DISABLE KEYS */;
INSERT INTO `fournisseur` VALUES (1,'ATLAS TEXTILE','0522-441122','contact@atlas-textile.ma','Zone Industrielle, Casablanca'),(2,'MAROC MODE','0537-882233','info@marocmode.ma','Rue des Tisserands, Fès'),(3,'FASHION IMPORT','0539-771144','order@fashionimport.ma','Port Tanger Med, Tanger'),(4,'SPORT SUPPLY','0528-993355','pro@sportsupply.ma','Avenue Mohammed VI, Agadir');
/*!40000 ALTER TABLE `fournisseur` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ligne_commande`
--

DROP TABLE IF EXISTS `ligne_commande`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ligne_commande` (
  `id_ligne` int NOT NULL AUTO_INCREMENT,
  `quantite_commandee` int NOT NULL,
  `prix_unitaire_achat` decimal(10,2) NOT NULL,
  `quantite_recue` int NOT NULL DEFAULT '0',
  `id_commande` int NOT NULL,
  `id_produit` int NOT NULL,
  PRIMARY KEY (`id_ligne`),
  KEY `id_commande` (`id_commande`),
  KEY `id_produit` (`id_produit`),
  CONSTRAINT `ligne_commande_ibfk_1` FOREIGN KEY (`id_commande`) REFERENCES `commande_fournisseur` (`id_commande`),
  CONSTRAINT `ligne_commande_ibfk_2` FOREIGN KEY (`id_produit`) REFERENCES `produit` (`id_produit`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ligne_commande`
--

LOCK TABLES `ligne_commande` WRITE;
/*!40000 ALTER TABLE `ligne_commande` DISABLE KEYS */;
INSERT INTO `ligne_commande` VALUES (1,50,89.00,50,201,1),(2,30,89.00,30,201,2),(3,20,239.00,20,201,3),(4,15,199.00,15,202,5),(5,10,299.00,10,202,11),(6,30,329.00,20,203,6),(7,25,299.00,0,203,7),(8,20,114.00,0,203,8),(9,20,179.00,0,204,1),(10,15,179.00,0,204,2),(11,20,139.00,20,205,9),(12,15,119.00,15,205,10);
/*!40000 ALTER TABLE `ligne_commande` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produit`
--

DROP TABLE IF EXISTS `produit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produit` (
  `id_produit` int NOT NULL AUTO_INCREMENT,
  `reference` varchar(20) NOT NULL,
  `libelle` varchar(100) NOT NULL,
  `prix_vente` decimal(10,2) NOT NULL,
  `taille` varchar(10) DEFAULT NULL,
  `couleur` varchar(30) DEFAULT NULL,
  `id_categorie` int NOT NULL,
  PRIMARY KEY (`id_produit`),
  UNIQUE KEY `reference` (`reference`),
  KEY `id_categorie` (`id_categorie`),
  CONSTRAINT `produit_ibfk_1` FOREIGN KEY (`id_categorie`) REFERENCES `categorie` (`id_categorie`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produit`
--

LOCK TABLES `produit` WRITE;
/*!40000 ALTER TABLE `produit` DISABLE KEYS */;
INSERT INTO `produit` VALUES (1,'TS-BLC-M','T-shirt blanc col rond',149.00,'M','Blanc',1),(2,'TS-BLC-L','T-shirt blanc col rond',149.00,'L','Blanc',1),(3,'JN-BLU-42','Jean slim bleu délavé',399.00,'42','Bleu',2),(4,'JN-NR-40','Jean droit noir',379.00,'40','Noir',2),(5,'PL-GRS-M','Pull en laine gris',299.00,'M','Gris',1),(6,'BK-BLC-42','Baskets blanches running',549.00,'42','Blanc',3),(7,'BK-NR-41','Baskets noires lifestyle',499.00,'41','Noir',3),(8,'CE-MRN-85','Ceinture cuir marron 85cm',189.00,'85','Marron',4),(9,'SP-LGG-M','Legging sport femme',229.00,'M','Noir',5),(10,'SP-SHT-L','Short sport homme',199.00,'L','Gris',5),(11,'VE-VRT-S','Veste légère verte',459.00,'S','Vert',1),(12,'SC-BCL-UN','Sac à dos boucle',349.00,'UN','Beige',4);
/*!40000 ALTER TABLE `produit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stock`
--

DROP TABLE IF EXISTS `stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock` (
  `id_stock` int NOT NULL AUTO_INCREMENT,
  `quantite_disponible` int NOT NULL DEFAULT '0',
  `seuil_minimum` int NOT NULL DEFAULT '5',
  `emplacement_rayon` varchar(10) DEFAULT NULL,
  `id_produit` int NOT NULL,
  PRIMARY KEY (`id_stock`),
  UNIQUE KEY `id_produit` (`id_produit`),
  CONSTRAINT `stock_ibfk_1` FOREIGN KEY (`id_produit`) REFERENCES `produit` (`id_produit`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stock`
--

LOCK TABLES `stock` WRITE;
/*!40000 ALTER TABLE `stock` DISABLE KEYS */;
INSERT INTO `stock` VALUES (1,45,10,'A-01',1),(2,30,10,'A-02',2),(3,8,5,'B-01',3),(4,3,5,'B-02',4),(5,22,8,'A-03',5),(6,15,6,'C-01',6),(7,4,6,'C-02',7),(8,50,10,'D-01',8),(9,18,8,'E-01',9),(10,12,8,'E-02',10),(11,6,5,'A-04',11),(12,20,10,'D-02',12);
/*!40000 ALTER TABLE `stock` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-05-16 18:18:36
