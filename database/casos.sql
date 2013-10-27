
-- phpMyAdmin SQL Dump
-- version 2.11.4
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Oct 26, 2013 at 10:01 PM
-- Server version: 5.1.57
-- PHP Version: 5.2.17

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

--
-- Database: `a8044097_pulpo`
--

-- --------------------------------------------------------

--
-- Table structure for table `casos`
--

CREATE TABLE `casos` (
  `id` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `perfil` varchar(200) NOT NULL,
  `foto` varchar(200) NOT NULL,
  `categoria` varchar(200) NOT NULL,
  `revisado` int(11) NOT NULL DEFAULT '0',
  `observacion` varchar(400) NOT NULL,
  `longitud` double NOT NULL,
  `latitud` double NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `casos`
--

INSERT INTO `casos` VALUES(1, 1, 'cangrejo', 'kueryco2.jpg', 'atravesado', 0, '', -73.5726678710937, 4.46551890909714);
