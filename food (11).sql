-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 12, 2025 at 07:20 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `food`
--

-- --------------------------------------------------------

--
-- Table structure for table `addons`
--

CREATE TABLE IF NOT EXISTS `addons` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `category_id` bigint(20) UNSIGNED DEFAULT NULL,
  `cost` double NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `type` enum('vegetarian','non-vegetarian') NOT NULL DEFAULT 'vegetarian',
  `image` varchar(255) NOT NULL,
  `status` tinyint(1) NOT NULL COMMENT 'true = active , false = inactive',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `category_id` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `addons`
--

INSERT INTO `addons` (`id`, `name`, `category_id`, `cost`, `description`, `type`, `image`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Ice Mocha', 13, 3, 'Dark, rich espresso lies in wait under a smoothed and stretched', 'vegetarian', 'addons/Rl0l5lyJSu5meXCwW5lriuBYvezSTkY4l9S9MomY.jpg', 1, '2024-06-27 15:55:01', '2024-10-28 16:25:06'),
(2, 'Ice Latte', 13, 1.9, 'Dark, rich espresso lies in wait under a smoothed and stretched', 'vegetarian', 'addons/waPLqiS0rPcui3AhdE9Ujo68Co5l0s6QfRpt4Fds.png', 1, '2024-06-27 15:57:21', '2024-10-28 20:24:13'),
(3, 'Frappucccino', 13, 2, 'Dark, rich espresso lies in wait under a smoothed and stretched', 'vegetarian', 'addons/75ncLkEDDKcvTnSYJR2g0HlPpOLVJjN5EHEfIirT.jpg', 1, '2024-06-27 15:59:28', '2024-06-27 15:59:28'),
(4, 'Frabie', 13, 2.5, 'Dark, rich espresso lies in wait under a smoothed and stretched', 'vegetarian', 'addons/VM7gszVlfregI2RPuRj5DKxv4Kgc3OI9TWZMhxKF.jpg', 1, '2024-06-27 16:00:48', '2024-08-28 18:23:17'),
(5, 'Frabie test', 11, 2, 'Dark, rich espresso lies in wait under a smoothed and stretched', 'vegetarian', 'addons/UOY5bwchqgvaKF95eeL3iREW1pQjFwoyIgllE6Av.jpg', 1, '2024-06-27 16:05:11', '2024-06-27 16:05:11'),
(7, 'Frabie test\'s', 13, 2, 'Dark, rich espresso lies in wait under a smoothed and stretched', 'vegetarian', 'addons/DQSS6CQV7Im28ivyRwNrGdwYGvQD63uxYmnqWSA9.jpg', 1, '2024-06-27 16:26:57', '2024-06-27 16:26:57'),
(8, 'Cappuccino', 12, 2, 'Victorian Inn Mocha Hot Cappuccino 2 lb. Bag EACH', 'vegetarian', 'addons/QbOKgEjnxrDYOCofzoYqR18kjlf3HxQd4kE5D8mM.jpg', 1, '2024-06-27 17:19:29', '2024-06-27 17:19:29'),
(9, 'Cafe Latte', 12, 2.3, 'Victorian Inn Mocha Hot Cappuccino 2 lb. Bag EACH', 'vegetarian', 'addons/uhZn5hFaDqBnlfAVYcgv2vmgkuZdiBl6pbbkHLhV.jpg', 1, '2024-06-27 17:21:24', '2024-06-27 17:21:24'),
(10, 'Mohcha latte', 12, 2.3, 'Victorian Inn Mocha Hot Cappuccino 2 lb. Bag EACH', 'vegetarian', 'addons/CDrdW9ry8Va5Q0YGL40ry5ke7pe6ky6ueMICGxCL.jpg', 0, '2024-06-27 17:23:36', '2024-06-27 17:23:36'),
(11, 'Soda Can', 11, 1, 'Victorian Inn Mocha Hot Cappuccino 2 lb. Bag EACH', 'vegetarian', 'addons/8WygOThujOmQaqR9kU6mKk36LvBeJzjviLX34WPv.jpeg', 1, '2024-06-27 18:59:41', '2024-06-27 18:59:41'),
(12, 'Soda  Bottle', 11, 1, 'Victorian Inn Mocha Hot Cappuccino 2 lb. Bag EACH', 'vegetarian', 'addons/lbnuhNZ1rdeL7MncJj4HKxCco90BsfRQWPrHBjN4.jpg', 1, '2024-06-27 19:00:30', '2024-06-27 19:00:30'),
(13, 'addon', 2, 2, 'dddddddddd qwwww', 'vegetarian', 'addons/eAn5MQXoTyZxBjgRKe2dwttN3ZzxEBOWJBGrVnqj.jpg', 1, '2024-08-11 19:07:17', '2024-11-25 17:47:16'),
(14, 'extrass', 1, 7.7, 'dd nnnnnn nnnnnnnnnnnnn', 'non-vegetarian', 'addons/bJkOvlfRdfkjUY2pT2eL8sHQFsGKQZfU3fUsm1r8.png', 0, '2024-08-25 16:08:08', '2024-10-29 01:34:55'),
(15, 'addon test error', 1, 5, 'addon test error', 'non-vegetarian', 'addons/ZxYcyb270QEs8Tdmjiz3t3dLnnf3MHPbvqKeM6M4.jpg', 0, '2024-11-25 18:13:10', '2024-11-25 18:13:10'),
(16, 'addon error', 3, 3, 'test errors', 'non-vegetarian', 'addons/DozU9Z7AWXqSS7oLrvywcr89sjvQ3oc118560y5m.jpg', 1, '2024-11-25 18:24:28', '2024-11-25 18:24:28');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE IF NOT EXISTS `categories` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp(),
  `status` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `description`, `image`, `created_at`, `updated_at`, `status`) VALUES
(1, 'Appetizers', 'LMIV - Allergen - i). Contains cereals and dproducts thereof containing gluten. ii). Wheat.', 'categories/dltisBmzHWVi4i1ltfzkFiQfzXd2yk7LCKhOLx76.jpg', '2024-06-27 15:04:25', '2024-10-31 19:15:25', 0),
(2, 'Flame Grill Burgers', 'LMIV - Allergen - i). Contains cereals and products thereof containing gluten. ii). Wheat.', 'categories/gwxfvWdXWICekojNQun5zDGGh24pefhcqrcKiEnP.jpg', '2024-06-27 15:13:33', '2024-10-31 19:44:02', 1),
(3, 'Veggie & Plant Based Burgers', 'LMIV - Allergen - i). Contains cereals and products thereof containing gluten. ii). Wheat.', 'categories/PJqz6OlMbfTm6dAATtoOa3Zz9O0dhpKvIVKnwCYW.jpg', '2024-06-27 15:16:35', '2024-10-28 20:19:27', 1),
(4, 'Sandwich From The Grill', 'Sweet and tangy BBQ Chicken Sandwiches made with juicy slow cooke..', 'categories/gqSc4lx53OhluEs4rYCWF2SFq7IQWhTd0xoD7otY.jpg', '2024-06-27 15:20:46', '2024-06-27 15:20:46', 1),
(5, 'Hot Chicken Entrees', 'Sweet and tangy BBQ Chicken Sandwiches made with juicy slow cooke..', 'categories/QLiH5PkZ3vJuow0ThKBOhzsYV688zQvCouKbKhkA.jpg', '2024-06-27 15:22:08', '2024-06-27 15:22:08', 1),
(6, 'Beef Entrees', 'Sweet and tangy BBQ Chicken Sandwiches made with juicy slow cooke..', 'categories/E5kONaoPh2IbGVpgMvHo8R4f2JylaK4VzgdUpzZS.jpg', '2024-06-27 15:23:56', '2024-06-27 15:23:56', 1),
(7, 'Seafood Entrees', 'Sweet and tangy BBQ Chicken Sandwiches made with juicy slow cooke..', 'categories/ipTXvwTpntym9Q11x1jsCt95QasLIApM8b9NeetC.jpg', '2024-06-27 15:24:51', '2024-06-27 15:24:51', 1),
(8, 'House Special Salads', 'Sweet and tangy BBQ Chicken Sandwiches made with juicy slow cooke..', 'categories/NhaZQ8A2rgj6yfMEbj63sFgOG40LQZPCH9Iy1NrS.jpg', '2024-06-27 15:26:01', '2024-06-27 15:26:01', 1),
(9, 'Zoop Soups', 'Sweet and tangy BBQ Chicken Sandwiches made with juicy slow cooke..', 'categories/jNwt7qtMEghKDdrY1NuCMfwZhEwsiiWslRsJzRVH.jpg', '2024-06-27 15:27:41', '2024-06-27 15:27:41', 1),
(10, 'Side Orders', 'Sweet and tangy BBQ Chicken Sandwiches made with juicy slow cooke..', 'categories/OMWxiTO9hfLcRqobASRscwcHrAqS1FOt5JPsfNwb.jpg', '2024-06-27 15:28:57', '2024-06-27 15:28:57', 1),
(11, 'Beverages', 'Sweet and tangy BBQ Chicken Sandwiches made with juicy slow cooke..', 'categories/x973C2Ckcx6DusN4xkqHj2LJRx4pt1rOJdWPd2pM.jpg', '2024-06-27 15:29:59', '2024-06-27 15:29:59', 1),
(12, 'Hot Drinks', 'Sweet and tangy BBQ Chicken Sandwiches made with juicy slow cooke..', 'categories/v4SNzZw1DPp0mbVYN4x3yYmQTYS74F8brWTxOiHE.jpg', '2024-06-27 15:31:28', '2024-06-27 17:16:13', 1),
(13, 'Iced Drinks', 'Sweet and tangy BBQ Chicken Sandwiches made with juicy slow cooke..', 'categories/xMiLSTD6wEDK4PL6SRy9yqUpKhI4DdIB9iZOqfcv.jpg', '2024-06-27 15:32:11', '2024-06-27 15:51:05', 1),
(15, 'Onion', 'ghjkl hjikp;[ hjmkl;', 'categories/Mj3g7CvfoDoZkHtLKWLlP0beO1KGs9qUAGeOAuRN.png', '2024-08-15 11:32:28', '2024-08-15 11:32:28', 1),
(16, 'category', 'dddddddd ddddddddddddd', 'categories/GVw2gnS3HQYXbHUgGUq3KlXveiXx01qaAH9OGhIA.jpg', '2024-08-18 15:54:10', '2024-11-08 16:47:56', 1),
(19, 'test k', 'mmmmmmmmmm', 'categories/TkM6zYU7SEtEyheVkHWL1M0CFxqu0WKdJmMQReM7.jpg', '2024-10-31 21:55:05', '2024-10-31 21:55:05', 1),
(20, 'test add category', 'test add category', 'categories/0UPNlbW7qnjfJVVR1ST5C9fOzO1McmztFLR5icTN.jpg', '2024-11-08 16:45:36', '2024-11-08 16:46:21', 1);

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE IF NOT EXISTS `customers` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT current_timestamp(),
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT 'true = active , false =inactive',
  `loyalty_points` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`id`, `name`, `email`, `phone`, `password`, `email_verified_at`, `status`, `loyalty_points`, `created_at`, `updated_at`) VALUES
(8, 'ali', 'eng.ahmedkamal357@gmail.com', '01066056969', '$2a$12$pAJFamvsbj5U0tVGdYpq9.Ih7iF.hYscZR.GS83eG.TZXwXhlWQ7q\n', NULL, 1, 0, '2024-06-04 15:26:32', '2024-12-31 15:03:51'),
(10, 'aahmed', 'sonbaty1937@gmail.com', '01066056996125', '$2y$10$55eWKYgsveJHBUZeoqWlyekVf7Zf7M0GMg38mwHPIXsNHeqS3wyNK', NULL, 1, 0, '2024-06-04 15:31:48', '2024-08-19 11:05:20'),
(11, 'aahmed', 'sonbaty193s7@gmail.com', '01066056996125', '$2y$10$8BC3GLpdh81mXOVLCgfTae6vZRYsyANGAsOk2iZ1yDhbggbXIWnIq', NULL, 1, 0, '2024-06-04 15:46:26', '2024-08-19 11:05:28'),
(12, 'aahmed', 'sonbaty193ds7@gmail.com', '01066056996125', '$2y$10$LARlU4WkG0fjJNGrCs/9eepg8nyBWWrp1x5MAGRoPFBglriPkrfse', NULL, 1, 0, '2024-06-04 15:47:29', '2024-08-19 11:05:35'),
(13, 'aahmed', 'sonbatyx193ds7@gmail.com', '01066056996125', '$2y$10$gDtpuNtzQeJ7bLyGVNOSE.6IQj9/I.iVWtbE3ZujZK5tTOOGyGoDG', NULL, 0, 0, '2024-06-04 15:51:47', '2024-06-04 15:51:47'),
(14, 'aahmed', 'sonbatyx193sds7@gmail.com', '01066056996125', '$2y$10$zGTCqCW6qrxHMEUUvPQiNeuKKRUVlYAWHCAkNovD8K/ugiP7ZZiTC', NULL, 0, 0, '2024-06-04 15:54:06', '2024-06-04 15:54:06'),
(15, 'aahmed', 'sonbatyx1s93sds7@gmail.com', '01066056996125', '$2y$10$3dVeo.L3/oqiR/Bu/5GMw.sxFlzcPhyEKr3OJmHnMPfKNpPMWnPeG', NULL, 0, 0, '2024-06-04 16:09:43', '2024-06-04 16:09:43'),
(16, 'aahmed', 'sonbatyx1s93sdss7@gmail.com', '01066056996125', '$2y$10$Zdj0V1fGtJ/rj6EggaGe2elOQSxJ/T/L5TpffBygxqP7Z8UVEeT4m', NULL, 0, 0, '2024-06-04 16:14:58', '2024-06-04 16:14:58'),
(17, 'aahmed', 'son@gmail.com', '01066056996125', '$2y$10$e.kGGhWogKn0uQcnmsNXm.9Nw.0uNlw8GT.4Qq0CBWfkr/ozIhovW', NULL, 0, 0, '2024-06-04 16:21:03', '2024-06-04 16:21:03'),
(18, 'aahmed', 'sons@gmail.com', '01066056996125', '$2y$10$gOUoJn0fmsmg6Vmm1QNPzOAZ9mapW9x4N7sIvZfzyaX04vHgOlZ9e', NULL, 0, 0, '2024-06-04 16:24:55', '2024-06-04 16:24:55'),
(19, 'aahmed', 'sonss@gmail.com', '01066056996125', '$2y$10$jAlJe2Hss7wOFAoEJXYKSO2oZh8fQgDo4MDAUS9X27bLJYkXP.qWS', NULL, 0, 0, '2024-06-04 16:30:44', '2024-06-04 16:30:44'),
(20, 'aahmed', 'sonsds@gmail.com', '01066056996125', '$2y$10$S8bN7.pBGzzNkan4BYiVdeuU6FRozP5ip/kw3j4ee.4.YmnoFijl2', NULL, 0, 0, '2024-06-04 16:36:27', '2024-06-04 16:36:27'),
(21, 'aahmed', 'sosnsds@gmail.com', '01066056996125', '$2y$10$O3Yspbky67TUouvjbT3DgeZ/RXl4.V10yVC5n6mWOSO1//V6H48fa', NULL, 0, 0, '2024-06-04 16:43:37', '2024-06-04 16:43:37'),
(22, 'aahmed', 'sosnsdds@gmail.com', '01066056996125', '$2y$10$d2dvnuWfyXp6mZMOXt/WC.UWJGzTh1fNqO.Vav7QOu1OyyexKCyei', NULL, 0, 0, '2024-06-04 16:46:31', '2024-06-04 16:46:31'),
(23, 'aahmed', 'sosnpsdds@gmail.com', '01066056996125', '$2y$10$oY1elak1SeqT0jJzegqQpOVhLSjZkSAPu1pTF9eRjZjBsZI6PhC2i', NULL, 0, 0, '2024-06-04 16:59:57', '2024-06-04 16:59:57'),
(24, 'aahmed', 'sosdnpsdds@gmail.com', '01066056996125', '$2y$10$bFPd8M4P0RSEl/F9ugn9f.A/C3BocQx5HovwRBh6gEvYuLT9NPqMC', NULL, 0, 0, '2024-06-04 17:00:23', '2024-06-04 17:00:23'),
(25, 'aahmed', 'sosdnpsdsds@gmail.com', '01066056996125', '$2y$10$X58kwsaqseLBUQUm1IEAaeq80JFi0rD9S4Cp9Ma7lZUdcRABfBr1.', NULL, 0, 0, '2024-06-04 17:03:05', '2024-06-04 17:03:05'),
(26, 'aahmed', 'sosdnpssdsds@gmail.com', '01066056996125', '$2y$10$mN/jQl091N/XOpNtzKte2OAU2GBkFx6v.nkmbz8VzBbYaKNnpa7Qu', NULL, 0, 0, '2024-06-04 17:21:20', '2024-06-04 17:21:20'),
(27, 'aahmed', 'sosdnpssdssds@gmail.com', '01066056996125', '$2y$10$WWexRZbj.OtDj5H4JAG4ZuS1GOgGz5Y/7jbc102Vy6eg5Xm4OWEY.', NULL, 0, 0, '2024-06-04 17:34:43', '2024-06-04 17:34:43'),
(28, 'aahmed', 'sosdnpssdsssds@gmail.com', '01066056996125', '$2y$10$zkLWYOaF7i61rA9YBqnFL.wUFw1brfYOFRhAS.gDNU3auBmFLFrwK', NULL, 0, 0, '2024-06-04 17:38:12', '2024-06-04 17:38:12'),
(30, 'aahmed', 'eng.ahmedkamal3s57@gmail.com', '01066056996125', '$2y$10$TD31E4oBuPZLAwFmBnleZOHdjuQ1Vdzz6zoZhRvdtOcKrWdwqqepa', '2024-06-05 09:19:28', 0, 0, '2024-06-04 17:50:11', '2024-06-05 09:19:28'),
(31, 'aahmed', '7e27d1fb76@emailcbox.pro', '01066056996125', '$2y$10$yZL8d4xjvmzyTNl/YHP8Ue0SnsU5cWwAaF0Uo/TDsJpu1A83H89Ja', NULL, 0, 0, '2024-06-07 10:53:14', '2024-06-07 10:53:14'),
(32, 'aahmed', 'd3499f9a76@emailcbox.pro', '01066056996125', '$2y$10$bCkeuzEZuaSkAbm.NsqqNeCRd/.lSlRmPcWWYXmOI62g7vDZhK0CW', NULL, 0, 0, '2024-06-07 12:39:35', '2024-06-07 12:39:35'),
(33, 'aahmed', 'e850f489a3@emailcbox.pro', '01066056996125', '$2y$10$dTVMqj8rv3nEkr3QkvaAiehfMWY.EEpWZEPfmVEDySzy4IffnnFRC', NULL, 0, 0, '2024-06-07 12:45:41', '2024-06-07 12:45:41'),
(35, 'aahmed', 'asamtabrahym870@gmail.com', '01066056996125', '$2y$10$ZN0yySWuAjcDVKALsZVCxe/PJ7dJuqibYAVR2rCmYeQ6VkLyHBSpq', NULL, 0, 0, '2024-06-08 10:35:06', '2024-06-08 10:35:06'),
(39, 'aahmed', 'mostafaesam300@gmail.com', '01066056996125', '$2y$10$6T2uJT/JrZy.TJaUvJAXR.m.jRG4Iggc7h4MAfwQ9QDhPV2CrbPFi', NULL, 0, 0, '2024-06-08 12:29:41', '2024-06-08 12:29:41'),
(51, 'mostafa', 'mostafaesam1300@gmail.com', '01066056996125', '$2y$10$qu42sYiziCL2i74Q3VIVhOOx.fMUjTV52hUq0nWZcinpTLOmL/4XO', '2024-07-17 20:28:49', 1, 10600, '2024-07-17 17:28:24', '2025-01-07 15:19:17'),
(52, 'teset', 'twst@gmail.com', '201030621099', '$2y$10$nKCNbS8T4qo.PUQP4xdx4u654dBf/Fc.5suFyfQjo1azo/uxu3wUa', NULL, 1, 0, '2024-08-25 17:17:09', '2024-08-25 17:17:09'),
(53, 'ebtsam', 'ebtesam132015@gmail.com', '010660569961', '$2y$10$ks.vshhPebD72RStyMnaHezUUnD4FtxVlYnYuebV3ehPFzDhC01yW', NULL, 1, 0, '2024-10-31 16:02:37', '2024-12-28 14:45:53'),
(55, 'Ebtesam Roshdy', 'sam1038867@gmail.com', '+201030621099', '$2y$10$4GiRmD7Vzg66RvwsDMRGhO8PQ8bFnffsr6P.lS4H0HK.iAQ.RGksC', '2024-11-01 07:00:18', 1, 0, '2024-11-01 08:00:18', '2024-11-01 08:00:18'),
(56, 'Ebtesam Roshdy', 'ebtesam13tt2015@gmail.com', '010306210992', '$2y$10$DPyin635fQIlTw1prmbvn.XCGs2l70nhbFFhhdYmGoxlZvVgXpQMy', '2024-11-01 20:08:17', 1, 0, '2024-11-01 21:08:17', '2024-11-01 21:08:17'),
(57, 'salima', 'saleemaalkhusaibi@icloud.com', '+96876916812', '$2y$10$7DnUAn4Zof0fIpr3ATgOC.2mf.3CXU0F6FjsGY68eUDpfDlKqz5Jq', '2024-11-16 19:37:34', 1, 0, '2024-11-16 20:37:34', '2024-11-16 20:37:34'),
(58, 'Yousuf', 'yousufabdallah2000@gmail.com', '963275663434', '$2y$10$B9KIcvRVMZcOKKm9Fka31etE1lMWAjaK3AZVbKpoSKggIQcQM7bx2', '2024-11-17 20:38:53', 1, 0, '2024-11-17 21:38:53', '2024-11-17 21:38:53'),
(59, 'Ebtesam Roshdy', 'ebtesam13015@gmail.com', '+201030621099', '$2y$10$3XXDNHh5fk2ECF/uW50uquLVvLq6ZYhEeoZhub.0l5XkSabb5oROi', '2024-11-23 18:54:50', 1, 0, '2024-11-23 19:54:50', '2024-11-23 19:54:50'),
(60, 'Ola Hamdy Ali Mohamed', 'olahamdy139@gmail.com', '010969051566', '$2y$10$BtejVbE4kMtqdN0s3U/R5eVVplxFnZqnihDE3rUHZbxSqva3jnkKG', '2024-11-23 19:00:49', 1, 0, '2024-11-23 20:00:49', '2024-11-23 20:00:49');

-- --------------------------------------------------------

--
-- Table structure for table `customer_loyalty_points`
--

CREATE TABLE IF NOT EXISTS `customer_loyalty_points` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `points` int(11) UNSIGNED NOT NULL,
  `expiry_date` date NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `customer_id` (`customer_id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customer_loyalty_points`
--

INSERT INTO `customer_loyalty_points` (`id`, `customer_id`, `order_id`, `points`, `expiry_date`, `created_at`, `updated_at`) VALUES
(24, 51, 170, 24, '2025-01-30', '2024-12-31 15:01:13', '2024-12-31 15:01:13'),
(28, 51, 171, 10, '2025-02-06', '2025-01-07 15:19:17', '2025-01-07 15:19:17');

-- --------------------------------------------------------

--
-- Table structure for table `diningtables`
--

CREATE TABLE IF NOT EXISTS `diningtables` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `floor` int(11) NOT NULL,
  `size` int(11) NOT NULL,
  `num` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT 'true = active , false = inactive',
  `qr_code` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `diningtables_floor_num_unique` (`floor`,`num`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `diningtables`
--

INSERT INTO `diningtables` (`id`, `floor`, `size`, `num`, `status`, `qr_code`, `created_at`, `updated_at`) VALUES
(1, 1, 3, 2, 1, NULL, '2024-07-04 08:59:44', '2024-11-08 17:07:23'),
(2, 2, 5, 1, 1, 'storage/qr_codes/qrcode_2_1720086538.png', '2024-07-04 06:48:58', '2024-10-31 19:21:06'),
(3, 2, 5, 2, 1, NULL, '2024-07-04 07:42:01', '2024-07-04 07:42:01'),
(4, 2, 5, 3, 1, NULL, '2024-07-04 07:44:51', '2024-07-04 07:44:51'),
(5, 2, 5, 4, 1, NULL, '2024-07-04 07:49:17', '2024-07-04 07:49:17'),
(6, 1, 5, 5, 1, 'storage/qr_codes/qrcode_6_1720431071.png', '2024-07-08 06:31:10', '2024-07-08 06:31:11'),
(7, 1, 5, 6, 1, 'storage/qr_codes/qrcode_7_1720437024.png', '2024-07-08 08:10:24', '2024-07-08 08:10:24'),
(8, 1, 3, 11, 1, NULL, '2024-08-10 20:46:48', '2024-08-10 20:46:48'),
(9, 3, 3, 1, 1, NULL, '2024-08-18 15:57:38', '2024-08-18 15:57:38'),
(10, 3, 3, -1, 1, NULL, '2024-08-18 15:58:01', '2024-08-18 15:58:01'),
(11, 3, 3, 2, 1, NULL, '2024-08-18 16:11:21', '2024-08-18 16:11:21'),
(12, 22, 2, 1, 1, NULL, '2024-10-31 19:16:29', '2024-10-31 19:16:29'),
(13, 3, 3, 6, 1, NULL, '2024-11-08 17:01:20', '2024-11-08 17:01:20'),
(14, 1, 7, 33, 1, NULL, '2024-11-17 21:35:10', '2024-11-17 21:35:10');

-- --------------------------------------------------------

--
-- Table structure for table `email_verification_tokens`
--

CREATE TABLE IF NOT EXISTS `email_verification_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `expired_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `email_verification_tokens`
--

INSERT INTO `email_verification_tokens` (`id`, `email`, `token`, `expired_at`, `created_at`, `updated_at`) VALUES
(2, 'ahmed@gmail.com', '3499a2f4-cd0f-4024-8649-aeedb0171592', '2024-06-04 16:31:22', '2024-06-04 15:31:22', '2024-06-04 15:31:22'),
(3, 'sonbaty1937@gmail.com', '1627f8a1-e1d4-46d4-8ebc-d3911338dad4', '2024-06-04 16:31:48', '2024-06-04 15:31:48', '2024-06-04 15:31:48'),
(4, 'sonbaty193s7@gmail.com', 'ed0ea67d-649f-4d7e-92f6-2afd7fe938d9', '2024-06-04 16:46:26', '2024-06-04 15:46:26', '2024-06-04 15:46:26'),
(5, 'sonbaty193ds7@gmail.com', '4db2d65b-7e57-4ba3-805f-68124e7e165e', '2024-06-04 16:47:29', '2024-06-04 15:47:29', '2024-06-04 15:47:29'),
(6, 'sonbatyx193ds7@gmail.com', '84bc6b6a-211e-4d1d-b2b3-51e875c1a2b7', '2024-06-04 16:51:47', '2024-06-04 15:51:47', '2024-06-04 15:51:47'),
(7, 'sonbatyx193sds7@gmail.com', 'da237b64-ec67-4c74-a2cc-80c871c6ea6b', '2024-06-04 16:54:06', '2024-06-04 15:54:06', '2024-06-04 15:54:06'),
(8, 'sonbatyx1s93sds7@gmail.com', '5e14a7c9-d651-4d77-9b97-00f448f25d0a', '2024-06-04 17:09:43', '2024-06-04 16:09:43', '2024-06-04 16:09:43'),
(9, 'sonbatyx1s93sdss7@gmail.com', 'ff590c1f-3e27-4c9b-b6ea-1a32f42445e4', '2024-06-04 17:14:58', '2024-06-04 16:14:58', '2024-06-04 16:14:58'),
(10, 'sons@gmail.com', 'a881d345-e343-49a3-b37b-5b01a3c62b41', '2024-06-04 17:24:55', '2024-06-04 16:24:55', '2024-06-04 16:24:55'),
(11, 'sonss@gmail.com', 'c8e7a223-408a-41d9-8e84-f1f5d8996ae2', '2024-06-04 17:30:44', '2024-06-04 16:30:44', '2024-06-04 16:30:44'),
(12, 'sosnsds@gmail.com', 'b6a4d917-c5db-44a1-a3bd-3733c63afb54', '2024-06-04 17:43:37', '2024-06-04 16:43:37', '2024-06-04 16:43:37'),
(13, 'sosnsdds@gmail.com', 'c8d8e8f7-5b0b-4c93-a4b0-8a07c453eca5', '2024-06-04 17:46:31', '2024-06-04 16:46:31', '2024-06-04 16:46:31'),
(14, 'sosnpsdds@gmail.com', '9e7304d3-ec2d-4b1e-9204-d588d9febceb', '2024-06-04 17:59:57', '2024-06-04 16:59:57', '2024-06-04 16:59:57'),
(15, 'sosdnpsdds@gmail.com', '7983464a-e5ea-487b-aafb-b85c56632d06', '2024-06-04 18:00:23', '2024-06-04 17:00:23', '2024-06-04 17:00:23'),
(16, 'sosdnpsdsds@gmail.com', '900dd4c3-e79c-4611-a209-e81be4508fcb', '2024-06-04 18:03:05', '2024-06-04 17:03:05', '2024-06-04 17:03:05'),
(17, 'sosdnpssdsds@gmail.com', '7abefa6f-9c9d-44cd-82d9-c0c84529a028', '2024-06-04 18:21:20', '2024-06-04 17:21:20', '2024-06-04 17:21:20'),
(18, 'sosdnpssdssds@gmail.com', '619a5083-dc0c-4776-8b8d-106bc1410d69', '2024-06-04 18:34:43', '2024-06-04 17:34:43', '2024-06-04 17:34:43'),
(19, 'sosdnpssdsssds@gmail.com', '6678913e-5aad-4f38-adbb-973d8595223c', '2024-06-04 18:38:12', '2024-06-04 17:38:12', '2024-06-04 17:38:12'),
(24, 'eng.ahmedkamal3s57@gmail.com', '2aab4069-db52-4f9f-8215-7a4ac1bf41a4', '2024-06-07 09:45:11', '2024-06-07 08:45:11', '2024-06-07 08:45:11'),
(25, '7e27d1fb76@emailcbox.pro', '900be380-6cb9-45cc-a8b9-975c0ac6cd9f', '2024-06-07 11:53:15', '2024-06-07 10:53:15', '2024-06-07 10:53:15'),
(26, 'd3499f9a76@emailcbox.pro', 'ea1f525a-9357-465e-b801-781926256bda', '2024-06-07 13:39:35', '2024-06-07 12:39:35', '2024-06-07 12:39:35'),
(27, 'e850f489a3@emailcbox.pro', '05c735aa-2add-4103-86e5-805cb9566496', '2024-06-07 13:45:41', '2024-06-07 12:45:41', '2024-06-07 12:45:41'),
(29, 'asamtabrahym870@gmail.com', '3f592979-56de-49d1-b619-5551dde6b890', '2024-06-08 11:35:07', '2024-06-08 10:35:07', '2024-06-08 10:35:07'),
(39, 'mostafaesam300@gmail.com', '576de3df-8ba2-4598-9e8d-10747ff483f4', '2024-06-08 13:29:41', '2024-06-08 12:29:41', '2024-06-08 12:29:41'),
(55, 'eng.ahmedkamal357@gmail.com', '59d11e20-e198-4976-973e-2d12bef5818b', '2024-06-13 13:28:48', '2024-06-13 12:28:48', '2024-06-13 12:28:48'),
(56, 'mostafaesam1300@gmail.com', 'c5fd2463-f1ef-4c66-88b5-b425a955176c', '2024-07-17 18:28:24', '2024-07-17 17:28:24', '2024-07-17 17:28:24'),
(57, 'twst@gmail.com', '7820152a-9e53-444b-88b0-b41c5dda133e', '2024-08-25 18:17:12', '2024-08-25 17:17:12', '2024-08-25 17:17:12'),
(58, 'out.of.mood23@gmail.com', '876a3dbb-5e15-4d13-bfe6-41893d378ed3', '2024-11-01 08:57:14', '2024-11-01 07:57:14', '2024-11-01 07:57:14'),
(59, 'sam1038867@gmail.com', '9a133cb8-f745-4917-a9de-8948211b555a', '2024-11-01 09:00:18', '2024-11-01 08:00:18', '2024-11-01 08:00:18'),
(60, 'ebtesam13tt2015@gmail.com', '672169cb-e60a-4264-8e3c-81d429424299', '2024-11-01 22:08:18', '2024-11-01 21:08:18', '2024-11-01 21:08:18'),
(61, 'saleemaalkhusaibi@icloud.com', '17aa6992-da02-489a-b059-71a0874a44ff', '2024-11-16 21:37:34', '2024-11-16 20:37:34', '2024-11-16 20:37:34'),
(62, 'yousufabdallah2000@gmail.com', 'c1a37563-90fd-46d0-85b4-6043b5d8c7d1', '2024-11-17 22:38:53', '2024-11-17 21:38:53', '2024-11-17 21:38:53'),
(63, 'ebtesam13015@gmail.com', 'ff66bbf6-4e25-4be4-9e16-68e3442eb90c', '2024-11-23 20:54:50', '2024-11-23 19:54:50', '2024-11-23 19:54:50'),
(64, 'olahamdy139@gmail.com', '7fa37fa3-b05f-4bd2-b7b3-1a879b39e6ec', '2024-11-23 21:00:49', '2024-11-23 20:00:49', '2024-11-23 20:00:49');

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE IF NOT EXISTS `employees` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `Role` int(11) NOT NULL DEFAULT 3,
  `phone` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp(),
  `identity_card` varchar(255) DEFAULT NULL,
  `status` tinyint(1) DEFAULT 1 COMMENT 'true = active  , false = inactive',
  PRIMARY KEY (`id`),
  UNIQUE KEY `employees_email_unique` (`email`),
  UNIQUE KEY `identity_card` (`identity_card`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `employees`
--

INSERT INTO `employees` (`id`, `name`, `Role`, `phone`, `email`, `password`, `created_at`, `updated_at`, `identity_card`, `status`) VALUES
(1, 'hosam', 1, '01066056969', 'ahmed@gmail.com', '$2y$10$2WJkOKMdxs.nLhKNfkCmBucbsSwX1gFXRvbwMC7wcCnhBWB/9Kiwa', NULL, NULL, '22152554', 1),
(7, 'Rady', 3, '01066056969', 'elkasem@gmail.com', '$2y$10$ln4qFoynXFk1q8gEZrhPDe8vloZ9HMUoyYonQfFpEOCKvXOfZKbSW', '2024-06-11 02:50:08', '2024-11-04 18:42:25', '12451548', 0),
(9, 'Ahmed Kamal', 1, '01021122115', 'ahmed.ka51197@gmail.com', '$2y$10$LEVSUBnxgFjWZCzgVkZ.z.tzGd8sC2OVhla5JZbqe1s2yBqemMneO', '2024-06-13 08:55:40', '2024-06-13 09:21:06', '12451559', 1),
(10, 'Rady', 3, '010211221', 'ahmed.ka5117@gmail.com', '$2y$10$h3NOVW5Axp0SuJaQEM2dre/RHmyMEnb840RnXYRbH5PCT5Xuap0Pu', '2024-06-28 09:47:09', '2024-08-28 21:36:54', '1245156', 1),
(11, 'RadyMohamed', 2, '010211221', 'rady.ka5117@gmail.com', '$2y$10$we2VZKcvK9Aog4njdr0Ae.LPKjTpr2vCXLA1mZdOloa5x5IDyj83a', '2024-06-28 09:49:16', '2024-11-04 18:54:02', '12451567', 0),
(12, 'asser', 3, '010211221', 'asser@gmail.com', '$2y$10$XGCw3yHy6ndWRvuia1Q6RuYnQz/vXrCA.RPEJgf0yBcDmylcslbiu', '2024-06-28 10:04:10', '2024-06-28 10:23:35', '12451554', 1),
(13, 'sam', 1, '201030621099', 'ebtesam132015@gmail.com', '$2y$10$qMHrGhqgLn59B52TypfujuPG.mM3ISJPbb9w8Unj/d8tsWXmof2aC', '2024-08-10 21:09:07', '2024-08-10 21:09:07', '6784595', 1),
(14, 'ebtesam', 2, '201030621099', 'sam@gmail.com', '$2y$10$E7DUDDbntGDtoBNweNKreehwZiOOITAL/0pjiBunOIJXvSq4W.OkW', '2024-08-28 13:27:58', '2024-08-28 13:30:55', '1684324', 1),
(15, 'ebtesam', 2, '20103333322', 'test4@gmail.com', '$2y$10$1vN.2GCBMZoGLA6sBtLhBOY45fXdpZqiQm0.7dXnpo4tamR45ChrS', '2024-08-28 21:39:49', '2024-08-28 21:40:07', '16843244', 1),
(16, 'ebtesam', 2, '20103333322', 'test8@gmail.com', '$2y$10$N2W9Sh11O1Pin9UddZznDeD2BYmwBqI7uHteg050..7EKYt6IvToK', '2024-08-29 13:24:39', '2024-08-29 13:24:39', '16843246', 1),
(17, 'chef', 2, '201030621022', 'chef@gmail.com', '$2y$10$2G5tHM.h/HyLsWmnypGGJOTEEC7Yq3sVY2xiedj9BHdxV32NEZhs.', '2024-09-09 22:42:24', '2024-09-09 22:42:24', '12843244', 1),
(18, 'casher', 3, '201030621022', 'casher@gmail.com', '$2y$10$BUBDKTq6MlfRfEU7HI9o7eqYROV/v.dwtvO4AnyaVssmFBE4zVEmq', '2024-09-09 22:42:50', '2024-09-09 22:42:50', '1685323', 1),
(19, 'chef', 2, '201030621022', 'chef1@gmail.com', '$2y$10$KwJy1cmK3P61ZZgNkb2eKefhZJlrY3TcLU7ngpb7ts4rKYylSlvtK', '2024-09-09 22:46:23', '2024-09-09 22:46:23', '12323432', 1),
(20, 'chef', 2, '201030621022', 'chef2@gmail.com', '$2y$10$6KRufTScQJaZhsWwtHqjEu9SXIqalFRzX4Jb1kzLakVRLRzhp1mly', '2024-09-09 22:46:43', '2024-09-09 22:46:43', '12223432', 1),
(21, 'chef', 2, '201030621022', 'chef3@gmail.com', '$2y$10$qmZZpiCexY2WNBCkPXwRpObNSdRBwIKysmePHh1z19LjSculac7pG', '2024-09-09 22:46:55', '2024-09-09 22:46:55', '12324432', 1),
(23, 'Ebtesam Roshdy', 3, '010306210992', 'chef55@gmail.com', '$2y$10$SJ7NSEUXeg81V4vEvEKuE.rrMBYUHPvJpk5L0VpJkuBSkvYiQ7xuS', '2024-10-31 23:21:27', '2024-10-31 23:21:27', '67845955', 0),
(24, 'Ebtesam Roshdy', 2, '010306210992', 'chef88@gmail.com', '$2y$10$zdJAgMTbgcezzjFUQ3mv/eu6vEYMam8YsNnl9ulHtA/kWAXS5Bm1O', '2024-11-01 09:04:16', '2024-11-04 18:37:45', '67845966', 1),
(25, 'Ebtesam Roshdy', 2, '010306210992', 'chefjj@gmail.com', '$2y$10$It9lroqLw0MzHJSXJfhBfOxW2R3QjyP1jpSx4vBeq7QSePvE9u8hC', '2024-11-01 09:28:50', '2024-11-04 18:37:58', '6788895', 1),
(26, 'Ebtesam Roshdy', 1, '010306210992', 'sam10388967@gmail.com', '$2y$10$ObCH4/wouHHszTzIRTG23eIsPvwhI5R9sT5unbqpdj42cuq0eFWh.', '2024-11-01 16:49:12', '2024-11-01 16:49:12', '85845955', 1),
(27, 'Ebtesam Roshdy', 1, '010306210992', 'ebtesamghg132015@gmail.com', '$2y$10$FoEMi.eJGJH8oLVRgqQOwudFr0otuLj083ZQAWkNgaAIhuAQnLc/y', '2024-11-01 21:09:17', '2024-11-01 21:09:17', '6779890', 1),
(28, 'Ebtesam Roshdy', 1, '010306210992', 'ebtesamffff132015@gmail.com', '$2y$10$q9qViRvbP06w0fpKt1LBX.yehnynF8FgsZPItDmMhx.AuyqY62VX.', '2024-11-01 21:10:42', '2024-11-01 21:10:42', '6665955', 1),
(29, 'Ebtesam Roshdy', 1, '010306210992', 'same1038867@gmail.com', '$2y$10$zD93yAWh/zdq.xIUTA5/suPwZ7Gb2ytY58c9vEgKbA2vc5dxD6y1a', '2024-11-02 16:32:21', '2024-11-02 16:32:21', '67842222', 1),
(30, 'Ebtesam Roshdy', 1, '010306210992', 'chef443@gmail.com', '$2y$10$azGty.okE6vJCqeI7Y3k6eTOjaZmBBOU0BYstSOL.sMX.DWAKc1pC', '2024-11-04 18:26:45', '2024-11-04 18:26:45', '67842225', 1),
(31, 'Yousuf ALBAHLOULI', 1, '96327566', 'Yousufabdallah2000@gmail.com', '$2y$10$O9Zk//dohfb1pzD6QWvQVOZOAHqNG2U7P68sxSga5Q5RRoAJMr/sW', '2024-11-16 20:30:02', '2024-11-16 20:30:02', '22019153', 1);

-- --------------------------------------------------------

--
-- Table structure for table `expired_offers`
--

CREATE TABLE IF NOT EXISTS `expired_offers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `offer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `expired_Date` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `offer_id` (`offer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `expired_offers`
--

INSERT INTO `expired_offers` (`id`, `offer_id`, `expired_Date`, `created_at`, `updated_at`) VALUES
(9, 15, '2024-07-28 22:12:00', '2024-09-24 14:25:47', '2024-09-24 14:25:47'),
(10, 16, '2024-07-28 22:12:00', '2024-09-25 16:51:19', '2024-09-25 16:51:19'),
(11, 17, '2024-07-28 22:12:00', '2024-09-25 16:54:03', '2024-09-25 16:54:03'),
(12, 18, '2024-07-28 22:12:00', '2024-09-25 16:54:14', '2024-09-25 16:54:14'),
(13, 19, '2024-07-28 22:12:00', '2024-09-25 16:54:15', '2024-09-25 16:54:15'),
(14, 20, '2024-07-28 22:12:00', '2024-09-25 16:54:20', '2024-09-25 16:54:20'),
(15, 21, '2024-07-30 02:50:10', '2024-09-25 17:12:50', '2024-09-25 17:12:50'),
(16, 22, '2024-09-20 00:00:00', '2024-09-25 17:24:28', '2024-09-25 17:24:28'),
(17, 23, '2024-07-30 02:50:10', '2024-09-25 17:24:45', '2024-09-25 17:24:45'),
(18, 24, '2024-07-30 02:50:00', '2024-09-30 03:39:53', '2024-09-30 03:39:53'),
(19, 27, '2024-07-30 02:45:00', '2024-09-30 03:45:33', '2024-09-30 03:45:33'),
(20, 28, '2024-07-30 02:45:00', '2024-09-30 18:31:45', '2024-09-30 18:31:45'),
(21, 29, '2024-07-30 02:45:00', '2024-09-30 18:36:56', '2024-09-30 18:36:56'),
(22, 30, '2024-07-30 02:45:00', '2024-09-30 19:43:23', '2024-09-30 19:43:23'),
(23, 31, '2024-07-30 02:45:00', '2024-10-05 14:34:49', '2024-10-05 14:34:49');

-- --------------------------------------------------------

--
-- Table structure for table `extras`
--

CREATE TABLE IF NOT EXISTS `extras` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `category_id` bigint(20) UNSIGNED DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `type` enum('vegetarian','non-vegetarian') NOT NULL DEFAULT 'vegetarian',
  `cost` double NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `extras`
--

INSERT INTO `extras` (`id`, `name`, `category_id`, `description`, `image`, `status`, `type`, `cost`, `created_at`, `updated_at`) VALUES
(1, 'Onion', 2, 'Serve mayo and green chili sauce.', 'extras/qTUHnSeYm9vKt5ahkulTjF4sc8xr4p8vWjRYvxPB.jpeg', 1, 'vegetarian', 4, '2024-06-27 18:30:45', '2024-10-31 19:22:01'),
(2, 'Baked Potato', 10, 'Serve with mayo and green chili sauce.', 'extras/bLBI60Ki5i7mu0AeWLm0M0wAG0ytDsdvm8ln3ejw.jpg', 1, 'vegetarian', 2.9, '2024-06-27 18:33:21', '2024-11-18 15:23:30'),
(3, 'French Fries', 10, 'Serve with mayo and green chili sauce.', 'extras/cYKzBV8DWALLS6q2iWqcoOc249Qo6bTbmhlZbZWF.jpg', 1, 'vegetarian', 2, '2024-06-27 18:34:22', '2024-06-27 18:34:22'),
(4, 'Hot & Sour Soup', 9, 'Serve with mayo and green chili sauce.', 'extras/LzdnjThwlZqlNDwEeulrsJWFI1eYObkXqfhrHwfN.jpg', 1, 'vegetarian', 2, '2024-06-27 18:35:36', '2024-06-27 18:45:09'),
(5, 'Chicken Noodles Soup', 9, 'Serve with mayo and green chili sauce.', 'extras/pxBAzZAgM8XGVWb7N7v5BzxWR1YY7EZHYq36uX9M.jpg', 1, 'non-vegetarian', 2, '2024-06-27 18:36:49', '2024-06-27 18:45:14'),
(6, 'Wonton Soup', 9, 'Serve with mayo and green chili sauce.', 'extras/Gq9Lb00PBZqF7nq3qD0LDBL6e2QJanG0bSIwZKW8.jpg', 1, 'non-vegetarian', 2.3, '2024-06-27 18:37:40', '2024-06-27 18:45:19'),
(7, 'Fresh Tuna Salad', 8, 'Serve with mayo and green chili sauce.', 'extras/D3IqOBHrsJzknPxzXD8OG8QPrtzTAoMQB53jrpxW.jpg', 1, 'non-vegetarian', 4, '2024-06-27 18:38:35', '2024-06-27 18:44:08'),
(8, 'Roasted Salmon Salad', 8, 'Serve with mayo and green chili sauce.', 'extras/dkLJ21AVbxaXr7d98evbt0EmVVpC0b6Kz1EhPGvf.jpg', 1, 'non-vegetarian', 4, '2024-06-27 18:39:47', '2024-06-27 18:44:18'),
(9, 'Classic Caesar Salad', 8, 'Serve with mayo and green chili sauce.', 'extras/PZOgPSWs9feFQphepr8w8e6bA4uKATkX2tV6pqWF.jpg', 1, 'vegetarian', 12, '2024-06-27 18:40:59', '2024-07-08 08:02:38'),
(10, 'Poached Pear Salad', 8, 'Serve with mayo and green chili sauce.', 'extras/vE5KWi0CRpXI8VlFvtJxXw4YAj7omm9Anh4uLh2Y.jpeg', 0, 'vegetarian', 1.2, '2024-06-27 18:41:49', '2024-07-08 08:49:53'),
(13, 'Onions', 10, 'sdvgfd rfghmknbv erfgfd', 'extras/LJ0IsbXNOl8hS6oQ9usFU1qgjx6FdvZpTMnnIDnK.png', 0, 'non-vegetarian', 4, '2024-08-10 20:53:29', '2024-08-10 20:54:21'),
(14, 'extra', 1, 'sddds eeeeeeeeeee eeeeee', 'extras/oyBHxhEtwTKoCyl5kTfKdCsqujRZVGUNSM6EDZav.png', 1, 'vegetarian', 4, '2024-08-11 19:06:00', '2024-08-11 19:06:00'),
(15, 'Onion test', 4, 'giop[ hjkl;\' iop', 'extras/pRttMN5QjFEsfFVhC0BMwXVXIWyj3t0Wx4Ki6fAg.jpg', 0, 'non-vegetarian', 4, '2024-08-15 11:35:46', '2024-08-15 11:36:00'),
(16, 'extras', 1, 'test test test', 'extras/D8WI0PsSvfMTa8MGLu8IjhdATADktWu7cgOY8Wcr.png', 1, 'vegetarian', 2.32, '2024-08-18 18:52:56', '2024-08-18 18:53:38'),
(17, 'extrass', 1, '444444444444444444444', 'extras/aeCJ715dPkvyT8S6cLe4VrvA3Lig9FSSFoAy4smH.png', 0, 'vegetarian', 2.32, '2024-08-25 16:49:14', '2024-08-25 16:49:47'),
(18, 'test', 3, 'mmmmmmmm mmmmmmmm', 'extras/iqaaUY6EmBaXxd70jeccC2mkkcHF9e0sPaJp3HSW.jpg', 0, 'non-vegetarian', 1.9, '2024-10-31 19:22:36', '2024-10-31 19:23:40'),
(19, 'test add extras', 3, 'test add in extras', 'extras/hs4WzYZ1BG9186KfcsFcks4fRijkF0o9oBahcnc5.jpg', 1, 'vegetarian', 2.5, '2024-11-08 17:22:31', '2024-11-08 17:23:29');

-- --------------------------------------------------------

--
-- Table structure for table `loyalty_settings`
--

CREATE TABLE IF NOT EXISTS `loyalty_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `loyalty_points_expiry_days` int(11) DEFAULT NULL,
  `loyalty_min_redeem_points` int(11) DEFAULT NULL,
  `loyalty_max_redeem_points` int(11) DEFAULT NULL,
  `loyalty_max_discount_rate` decimal(5,2) DEFAULT NULL,
  `min_order_price_for_points` decimal(10,2) DEFAULT NULL,
  `price_per_point` decimal(10,0) DEFAULT NULL,
  `currency_per_point` float UNSIGNED DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `loyalty_settings`
--

INSERT INTO `loyalty_settings` (`id`, `loyalty_points_expiry_days`, `loyalty_min_redeem_points`, `loyalty_max_redeem_points`, `loyalty_max_discount_rate`, `min_order_price_for_points`, `price_per_point`, `currency_per_point`, `created_at`, `updated_at`) VALUES
(1, 30, 100, 5000, 10.00, 50.00, 10, 0.001, '2024-11-19 00:51:53', '2024-11-22 01:06:32');

-- --------------------------------------------------------

--
-- Table structure for table `meals`
--

CREATE TABLE IF NOT EXISTS `meals` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `type` enum('vegetarian','non-vegetarian') NOT NULL,
  `status` tinyint(1) NOT NULL COMMENT 'true = active , flase = inactive',
  `image` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `meals_category_id_foreign` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `meals`
--

INSERT INTO `meals` (`id`, `category_id`, `name`, `description`, `type`, `status`, `image`, `created_at`, `updated_at`) VALUES
(1, 6, 'Chicken Dumplingss', 'With a side of fried rice or supreme soy noodles, and steamed', 'vegetarian', 1, 'meals/WdU3xy7BZltFuh2b9XqsjEf9ph7UEzyT4T4OP3vl.jpg', '2024-06-27 16:43:27', '2024-11-16 22:36:49'),
(2, 1, 'Vegetable Dumplings', 'With a side of fried rice or supreme soy noodles, and steamed', 'non-vegetarian', 1, 'meals/hpQuaBe254mqHy7rnEt58tTvoAymcEdqfFtu472Q.jpg', '2024-06-27 16:47:19', '2024-10-31 05:19:15'),
(3, 1, 'Fried Cheese Wonton', 'With a side of fried rice or supreme soy noodles, and steamed', 'non-vegetarian', 1, 'meals/WfIZyNw5UwprkNZCG08KmslgM64KTj8jRRLxlOFr.jpg', '2024-06-27 16:53:11', '2024-06-27 16:53:11'),
(4, 2, 'American BBQ Double', 'With a side of fried rice or supreme soy noodles, and steamed', 'non-vegetarian', 1, 'meals/MXSRRVGS8psUfmrkixWoQehXNNNq4DBpI4v0phfr.jpeg', '2024-06-27 17:27:45', '2024-06-27 17:27:45'),
(5, 2, 'American BBQ Single', 'With a side of fried rice or supreme soy noodles, and steamed', 'non-vegetarian', 1, 'meals/pryCYgiCnPn9GTkdeQNft84kWdqu7thlywqXcxit.jpeg', '2024-06-27 17:28:24', '2024-06-27 17:28:24'),
(6, 2, 'Cheeseburger', 'With a side of fried rice or supreme soy noodles, and steamed', 'non-vegetarian', 1, 'meals/Ag1gBM14mNvkLnQi9TrlvbJyNpr3UtRTZgMfuo23.jpeg', '2024-06-27 17:28:41', '2024-06-27 17:28:41'),
(7, 2, 'Whopper', 'With a side of fried rice or supreme soy noodles, and steamed', 'non-vegetarian', 0, 'meals/eBTPnGKuc120Jg3XDz1r1Ha9UFbi8c8aHwx8eg1g.jpeg', '2024-06-27 17:28:56', '2024-06-27 17:28:56'),
(8, 2, 'Peppercorn Anger', 'With a side of fried rice or supreme soy noodles, and steamed', 'non-vegetarian', 0, 'meals/gBOYEQjSrXUt1u3DN3uqzURhfjUW8LEixnjIO7W7.jpeg', '2024-06-27 17:29:18', '2024-06-27 17:29:18'),
(9, 3, 'Plant Based Bacon', 'With a side of fried rice or supreme soy noodles, and steamed', 'vegetarian', 0, 'meals/JngivZFIt3ClQ496tX6fqEciKG66L341jdLB2fcq.jpg', '2024-06-27 17:32:08', '2024-06-27 17:32:08'),
(10, 3, 'Plant Based Whopper', 'With a side of fried rice or supreme soy noodles, and steamed', 'vegetarian', 1, 'meals/dtqcJbHVJX2onpxPdRyVvf31sOqM2IloQpbA0AEr.jpg', '2024-06-27 17:32:25', '2024-06-27 17:32:25'),
(11, 3, 'Vegan Hum Burger', 'With a side of fried rice or supreme soy noodles, and steamed', 'vegetarian', 1, 'meals/yvJbr2PMkHUfE2Hxqz4f8xNvdIR4JSkUv4tdLZab.jpg', '2024-06-27 17:33:15', '2024-06-27 17:33:15'),
(12, 4, 'BBQ Chicken', 'With a side of fried rice or supreme soy noodles, and steamed', 'non-vegetarian', 1, 'meals/PF2cxnqK6Q5mooX5qrWwPzrSaAqplVqAyjW8Os2G.jpg', '2024-06-27 17:38:02', '2024-06-27 17:38:02'),
(13, 4, 'Steak Sandwich', 'With a side of fried rice or supreme soy noodles, and steamed', 'non-vegetarian', 1, 'meals/HZxVHBsdDNQJMcJHXqQnZy31HFcQwgQS00OotCOd.jpg', '2024-06-27 17:38:22', '2024-06-27 17:38:22'),
(14, 5, 'Hentai Chicken', 'With a side of fried rice or supreme soy noodles, and steamed', 'non-vegetarian', 1, 'meals/mJSULVrH33w82YbXrkGfqZz1tnjGdnRRVbsTQmUm.jpg', '2024-06-27 17:43:20', '2024-06-27 17:43:20'),
(16, 6, 'Beef With Broccoli', 'With a side of fried rice or supreme soy noodles, and steamed', 'non-vegetarian', 1, 'meals/hnIlwMCd2fatSDgTsCRNJCI57xKlarSq1jQ0NW0w.jpg', '2024-06-27 17:47:08', '2024-06-27 17:47:08'),
(17, 6, 'Szechuan Beef', 'With a side of fried rice or supreme soy noodles, and steamed', 'non-vegetarian', 1, 'meals/4ONHgzP0ObJsjlT0dJAhRRNnQJb3vgRUPEDJ0oi6.jpg', '2024-06-27 17:47:21', '2024-06-27 17:47:21'),
(18, 7, 'Kung Pao Squid', 'With a side of fried rice or supreme soy noodles, and steamed', 'non-vegetarian', 1, 'meals/xpLBiweObuuH77mt9ci0icl1FcdMOdPKUgrct4fq.jpeg', '2024-06-27 17:49:22', '2024-06-27 17:49:22'),
(19, 7, 'Shrimp With Broccoli', 'With a side of fried rice or supreme soy noodles, and steamed', 'non-vegetarian', 1, 'meals/ZNfUR6sALsHsCUAHE2bs4T8C0a4jaAJlOmgymUvw.jpeg', '2024-06-27 17:50:15', '2024-06-27 17:50:15'),
(27, 1, 'Pizza Margarita d', 'Delicious pizza with assorted vegetables', 'vegetarian', 1, 'meals/YJmszbt5HEDxvwYHQkhuDLQot0WLFlQDJQAeDg33.jpeg', '2024-07-08 04:20:51', '2024-07-08 04:20:51'),
(28, 1, 'test', 'test test test', 'vegetarian', 0, 'meals/vrcMcXJoilPYIhmzjt0DjZMOshiUpVy4hWzjTr4A.png', '2024-08-10 20:44:38', '2024-08-10 20:44:38'),
(29, 1, 'test meal', 'asdfgbhnm wsdfgbh defgh', 'vegetarian', 1, 'meals/Q6Pd9FHQzqIaP5DJytKJhA2lVrcLZRNY5FzFZ9Zx.jpg', '2024-08-11 19:05:12', '2024-11-01 07:30:40'),
(30, 1, 'Chicken Dumplings', 'fghjikop; ghjkl;\'', 'non-vegetarian', 1, 'meals/xiQnURQRNOms0cFtS46pAjnPU526jroLUblOoDdI.jpg', '2024-08-15 11:30:00', '2024-11-16 22:43:51'),
(31, 15, 'meals', 'wf wdfv rfvb dfvg werf', 'vegetarian', 1, 'meals/Au7Q0RUzy3yoc0CwgzdDXYPC8mxgBSYDADPVKWZO.jpg', '2024-08-18 15:22:38', '2024-08-18 15:23:57'),
(33, 1, 'teat add meal', 'description', 'vegetarian', 1, 'meals/EQvk159NbBZnLuB9sidbdXgXvM9AT8duLQM1Y75X.png', '2024-10-28 16:57:11', '2024-10-28 16:57:11'),
(34, 2, 'test add meal', 'test add meal', 'vegetarian', 1, 'meals/e2jypNyjFKM8HkUMsyZHnJPzA6PYTuk4x9qheS4N.jpg', '2024-10-28 16:57:20', '2024-10-28 16:57:20'),
(35, 2, 'test add', 'message Internal server error', 'vegetarian', 1, 'meals/8pcl4GZVmof0O2dFbARGogMPAfFqsw8y3ODZIjJ1.jpg', '2024-10-28 17:00:33', '2024-10-28 17:00:33'),
(36, 3, 'test add meal vv', 'test test test', 'vegetarian', 0, 'meals/GOtEe8eDf5uWDf6tdBAAcOcBxTD1ZZLPqipf7Phi.jpg', '2024-10-31 19:08:03', '2024-10-31 19:12:06'),
(37, 7, 'test add meals', 'test test test test', 'non-vegetarian', 1, 'meals/m9bD7qReGwK8DSJX1ik6atBvxnIGaFZYIwRNmeZf.jpg', '2024-11-08 16:42:47', '2024-11-08 16:42:47');

-- --------------------------------------------------------

--
-- Table structure for table `meals_size_cost`
--

CREATE TABLE IF NOT EXISTS `meals_size_cost` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `meal_id` bigint(20) UNSIGNED NOT NULL,
  `size` int(11) DEFAULT NULL COMMENT '1=SMALL, 2=Medium, 3=BIG, 4=FAMILY',
  `cost` double NOT NULL,
  `number_of_pieces` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `unique_index` (`meal_id`,`cost`,`size`,`number_of_pieces`),
  KEY `meal_id` (`meal_id`)
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `meals_size_cost`
--

INSERT INTO `meals_size_cost` (`id`, `meal_id`, `size`, `cost`, `number_of_pieces`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 9, 0, '2024-06-27 16:43:27', '2024-10-31 19:48:10'),
(2, 1, 2, 2.5, 0, '2024-06-27 16:43:27', '2024-11-08 16:37:44'),
(3, 1, 3, 3, 0, '2024-06-27 16:43:27', '2024-11-08 16:38:13'),
(4, 2, 1, 2, 4, '2024-06-27 16:47:19', '2024-06-27 16:47:19'),
(5, 2, 2, 2.3, 6, '2024-06-27 16:47:19', '2024-06-27 16:47:19'),
(6, 2, 3, 3, 8, '2024-06-27 16:47:19', '2024-06-27 16:47:19'),
(7, 3, 1, 2.3, 6, '2024-06-27 16:53:11', '2024-06-27 16:53:11'),
(8, 3, 2, 2.5, 8, '2024-06-27 16:53:11', '2024-06-27 16:53:11'),
(9, 3, 3, 10, 3, '2024-06-27 16:53:11', '2024-06-27 16:53:11'),
(10, 4, 1, 2.3, NULL, '2024-06-27 17:27:45', '2024-06-27 17:27:45'),
(11, 4, 2, 2.5, NULL, '2024-06-27 17:27:45', '2024-06-27 17:27:45'),
(12, 4, 3, 20, NULL, '2024-06-27 17:27:45', '2024-06-27 17:27:45'),
(13, 5, 1, 2.3, NULL, '2024-06-27 17:28:24', '2024-06-27 17:28:24'),
(14, 5, 2, 2.5, NULL, '2024-06-27 17:28:24', '2024-06-27 17:28:24'),
(15, 6, 3, 1200, NULL, '2024-06-27 17:28:41', '2024-08-28 15:13:31'),
(16, 6, 2, 2.5, 4, '2024-06-27 17:28:41', '2024-08-29 13:18:41'),
(17, 7, 1, 2.3, NULL, '2024-06-27 17:28:56', '2024-06-27 17:28:56'),
(18, 7, 2, 2.5, NULL, '2024-06-27 17:28:56', '2024-06-27 17:28:56'),
(19, 8, 1, 2.3, NULL, '2024-06-27 17:29:18', '2024-06-27 17:29:18'),
(20, 8, 2, 2.5, NULL, '2024-06-27 17:29:18', '2024-06-27 17:29:18'),
(21, 9, 1, 2.3, 2, '2024-06-27 17:32:08', '2024-09-11 17:48:07'),
(22, 9, 2, 2.5, NULL, '2024-06-27 17:32:08', '2024-06-27 17:32:08'),
(23, 10, 1, 2.3, NULL, '2024-06-27 17:32:25', '2024-06-27 17:32:25'),
(24, 10, 2, 2.5, NULL, '2024-06-27 17:32:25', '2024-06-27 17:32:25'),
(25, 11, 4, 2.3, NULL, '2024-06-27 17:33:15', '2024-06-27 17:33:15'),
(26, 11, 2, 2.5, NULL, '2024-06-27 17:33:15', '2024-06-27 17:33:15'),
(27, 12, 1, 2.3, NULL, '2024-06-27 17:38:02', '2024-06-27 17:38:02'),
(28, 12, 2, 2.5, NULL, '2024-06-27 17:38:02', '2024-06-27 17:38:02'),
(29, 13, 1, 2.3, NULL, '2024-06-27 17:38:22', '2024-06-27 17:38:22'),
(30, 13, 2, 2.5, NULL, '2024-06-27 17:38:22', '2024-06-27 17:38:22'),
(31, 14, 1, 2.3, 6, '2024-06-27 17:43:20', '2024-06-27 17:43:20'),
(32, 14, 2, 2.5, 8, '2024-06-27 17:43:20', '2024-06-27 17:43:20'),
(33, 14, 3, 10, 3, '2024-06-27 17:43:20', '2024-06-27 17:43:20'),
(37, 16, 1, 2.3, NULL, '2024-06-27 17:47:08', '2024-06-27 17:47:08'),
(38, 16, 2, 2.5, NULL, '2024-06-27 17:47:08', '2024-06-27 17:47:08'),
(39, 16, 3, 10, NULL, '2024-06-27 17:47:08', '2024-06-27 17:47:08'),
(40, 17, 1, 2.3, NULL, '2024-06-27 17:47:21', '2024-06-27 17:47:21'),
(41, 17, 2, 2.5, NULL, '2024-06-27 17:47:21', '2024-06-27 17:47:21'),
(42, 17, 3, 10, NULL, '2024-06-27 17:47:21', '2024-06-27 17:47:21'),
(43, 18, 1, 2.3, NULL, '2024-06-27 17:49:22', '2024-06-27 17:49:22'),
(44, 18, 2, 2.5, NULL, '2024-06-27 17:49:22', '2024-06-27 17:49:22'),
(45, 18, 3, 10, NULL, '2024-06-27 17:49:22', '2024-06-27 17:49:22'),
(46, 19, 1, 2.3, 6, '2024-06-27 17:50:15', '2024-06-27 17:50:15'),
(47, 19, 2, 2.5, 8, '2024-06-27 17:50:15', '2024-06-27 17:50:15'),
(48, 19, 3, 10, 3, '2024-06-27 17:50:15', '2024-06-27 17:50:15'),
(59, 27, 1, 80, 4, '2024-07-08 04:20:51', '2024-07-08 04:20:51'),
(60, 27, 1, 120, NULL, '2024-07-08 04:20:51', '2024-07-08 04:20:51'),
(61, 27, 2, 150, NULL, '2024-07-08 04:20:51', '2024-07-08 04:20:51'),
(62, 28, 3, 2, NULL, '2024-08-10 20:44:38', '2024-08-10 20:44:38'),
(63, 29, 3, 5, 0, '2024-08-11 19:05:12', '2024-11-01 07:31:07'),
(64, 1, 4, 4, 0, '2024-08-14 20:25:22', '2024-09-23 18:56:42'),
(65, 2, 4, 3, NULL, '2024-08-14 21:17:40', '2024-08-14 21:17:40'),
(66, 3, 4, 10, NULL, '2024-08-15 11:26:19', '2024-08-15 11:26:19'),
(67, 30, 2, 3, NULL, '2024-08-15 11:30:00', '2024-08-15 11:30:00'),
(68, 31, 2, 2, NULL, '2024-08-18 15:22:38', '2024-08-18 15:22:38'),
(69, 31, 1, 3, NULL, '2024-08-18 15:29:15', '2024-08-18 15:29:15'),
(70, 5, 4, 4, NULL, '2024-08-25 17:40:12', '2024-08-25 17:40:12'),
(71, 4, 4, 36, NULL, '2024-08-28 13:07:19', '2024-08-28 13:07:19'),
(72, 6, 1, 2, NULL, '2024-08-29 13:18:58', '2024-08-29 13:18:58'),
(73, 6, 4, 1, NULL, '2024-08-29 13:20:04', '2024-08-29 13:20:04'),
(74, 7, 3, 33, NULL, '2024-09-20 22:47:06', '2024-09-20 22:47:06'),
(75, 33, 2, 2, NULL, '2024-10-28 16:57:11', '2024-10-28 16:57:11'),
(76, 34, 3, 2, 2, '2024-10-28 16:57:20', '2024-10-28 16:57:20'),
(77, 35, 1, 2, NULL, '2024-10-28 17:00:33', '2024-10-28 17:00:33'),
(78, 36, 2, 2, NULL, '2024-10-31 19:08:03', '2024-10-31 19:08:03'),
(79, 29, 2, 2, 0, '2024-11-01 07:30:57', '2024-11-01 07:30:57'),
(80, 37, 1, 2, NULL, '2024-11-08 16:42:47', '2024-11-08 16:42:47'),
(81, 37, 2, 3, 0, '2024-11-08 16:43:23', '2024-11-08 16:43:23');

-- --------------------------------------------------------

--
-- Table structure for table `meal_extras`
--

CREATE TABLE IF NOT EXISTS `meal_extras` (
  `meal_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `extra_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`meal_id`,`extra_id`),
  KEY `extra_id` (`extra_id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `meal_extras`
--

INSERT INTO `meal_extras` (`meal_id`, `extra_id`, `created_at`, `updated_at`) VALUES
(1, 1, '2024-08-28 18:42:32', '2024-08-28 18:42:32'),
(1, 2, '2024-11-08 16:38:29', '2024-11-08 16:38:29'),
(1, 3, '2024-08-10 21:46:11', '2024-08-10 21:46:11'),
(1, 5, '2024-08-28 13:06:22', '2024-08-28 13:06:22'),
(1, 7, '2024-11-08 16:38:34', '2024-11-08 16:38:34'),
(3, 1, '2024-10-05 15:33:21', '2024-10-05 15:33:21'),
(3, 3, '2024-10-05 15:33:51', '2024-10-05 15:33:51'),
(3, 5, '2024-08-15 11:27:31', '2024-08-15 11:27:31'),
(3, 6, '2024-10-05 15:33:28', '2024-10-05 15:33:28'),
(4, 2, '2024-06-27 21:50:40', '2024-06-27 21:50:40'),
(5, 3, '2024-08-25 17:43:29', '2024-08-25 17:43:29'),
(5, 5, '2024-08-25 17:43:41', '2024-08-25 17:43:41'),
(9, 1, '2024-06-27 21:51:42', '2024-06-27 21:51:42'),
(12, 4, '2024-06-27 21:51:07', '2024-06-27 21:51:07'),
(29, 5, '2024-11-01 07:31:40', '2024-11-01 07:31:40'),
(31, 4, '2024-08-18 15:29:36', '2024-08-18 15:29:36'),
(36, 2, '2024-10-31 19:10:53', '2024-10-31 19:10:53');

-- --------------------------------------------------------

--
-- Table structure for table `meal_with_addons`
--

CREATE TABLE IF NOT EXISTS `meal_with_addons` (
  `meal_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `addon_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`meal_id`,`addon_id`),
  KEY `meal_with_addons_addon_id_foreign` (`addon_id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `meal_with_addons`
--

INSERT INTO `meal_with_addons` (`meal_id`, `addon_id`, `created_at`, `updated_at`) VALUES
(1, 1, '2024-09-11 15:40:24', '2024-09-11 15:40:24'),
(1, 2, NULL, NULL),
(1, 3, '2024-08-10 21:45:56', '2024-08-10 21:45:56'),
(1, 4, '2024-09-11 15:40:35', '2024-09-11 15:40:35'),
(1, 7, '2024-11-08 16:38:48', '2024-11-08 16:38:48'),
(1, 8, '2024-11-08 16:38:57', '2024-11-08 16:38:57'),
(3, 2, '2024-08-15 11:27:49', '2024-08-15 11:27:49'),
(5, 2, '2024-08-25 17:44:04', '2024-08-25 17:44:04'),
(8, 4, NULL, NULL),
(14, 4, NULL, NULL),
(29, 2, '2024-11-01 07:31:26', '2024-11-01 07:31:26'),
(31, 3, '2024-08-18 15:31:22', '2024-08-18 15:31:22'),
(31, 5, '2024-08-18 15:31:27', '2024-08-18 15:31:27'),
(31, 9, '2024-08-18 15:31:32', '2024-08-18 15:31:32'),
(36, 7, '2024-10-31 19:11:12', '2024-10-31 19:11:12'),
(36, 11, '2024-10-31 19:11:17', '2024-10-31 19:11:17');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(2, '2024_06_02_111238_create_customers_table', 1),
(3, '2024_06_02_111438_create_employees_table', 1),
(4, '2024_06_02_111801_create_categories_table', 1),
(5, '2024_06_02_111857_create_meals_table', 1),
(6, '2024_06_02_112010_create_addons_table', 1),
(7, '2024_06_02_112311_create_diningtables_table', 1),
(8, '2024_06_02_112500_create_meal_with_addons_table', 1),
(9, '2024_06_02_112838_create_orders_table', 1),
(10, '2024_06_02_113106_create_order_meals_table', 1),
(11, '2024_06_02_113327_create_order_addons_table', 1),
(12, '2024_06_04_085108_create_email_verification_tokens_table', 2),
(13, '2024_06_04_092226_create_sessions_table', 3);

-- --------------------------------------------------------

--
-- Table structure for table `offers`
--

CREATE TABLE IF NOT EXISTS `offers` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `discount` int(11) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `startDate` timestamp NOT NULL DEFAULT current_timestamp(),
  `endDate` timestamp NULL DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `status` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `offers`
--

INSERT INTO `offers` (`id`, `name`, `discount`, `type`, `startDate`, `endDate`, `quantity`, `image`, `status`, `created_at`, `updated_at`) VALUES
(4, 'winter Offer', 10, NULL, '2024-07-23 21:00:00', '2024-07-24 21:00:00', NULL, 'offers/QXoMz0wbhCOlJkSRL8SVMwZ2DFIwoHv4IJPVZI2Q.jpg', 1, '2024-07-26 09:12:51', '2024-11-18 15:09:28'),
(5, 'friday', 10, NULL, '2024-07-28 21:00:00', '2024-07-30 21:00:00', NULL, 'offers/Qeiiy74sK7SX9NBLEiAJBKQcuXIqYXdLTJagyYNM.jpg', 1, '2024-07-27 18:22:12', '2024-11-02 20:34:18'),
(6, 'saturday', 7, NULL, '2024-07-28 21:00:00', '2024-07-30 21:00:00', NULL, 'offers/OGJw915NnEtXlVBz4ABXUbjnNRmR0lQotYvQqiXQ.jpg', 1, '2024-07-27 19:36:26', '2024-11-02 20:34:24'),
(7, 'sunday', 7, NULL, '2024-07-28 21:00:00', '2024-07-28 21:00:00', NULL, 'offers/UY7Pkvhcn75ces326efy2qLDJjRt9BVMyxuQGP0d.jpg', 1, '2024-07-28 18:26:25', '2024-11-02 20:34:31'),
(8, 'sunday2', 7, NULL, '2024-07-28 21:00:00', '2024-07-28 21:00:00', NULL, 'offers/gxW1wvoTDnDyjP4agQIZAp3TOp9s1jRpYzoryK58.jpg', 0, '2024-07-28 18:36:07', '2024-11-02 20:34:03'),
(9, 'sunday23', 7, NULL, '2024-07-28 21:00:00', '2024-07-28 21:00:00', NULL, 'offers/0utwtpocSC3QAxl733d6n06Kg5XQYPf9zCbSdOTh.jpg', 1, '2024-07-28 18:37:50', '2024-07-29 18:29:40'),
(10, 'sunday233', 7, NULL, '2024-07-28 21:00:00', '2024-07-28 21:00:00', NULL, 'offers/pVdL1QH3htPgjjmfNbdO4Cq0ERYZ4YEYmLTrKfkd.jpg', 1, '2024-07-28 21:48:51', '2024-07-29 18:29:44'),
(11, 'sunday235', 7, NULL, '2024-07-28 21:00:00', '2024-07-28 21:00:00', NULL, 'offers/aNSiYYMvAWqPNkUReC4p6wVThu15dh9zTaaw1Fik.jpg', 1, '2024-07-28 21:49:50', '2024-07-29 18:29:49'),
(12, 'sunday231', 7, NULL, '2024-07-28 21:00:00', '2024-07-28 21:00:00', NULL, 'offers/UqzwJ5fSiSyUC6PBXEqnyd2VGaUQZ8Y0tpN1Oc0k.jpg', 1, '2024-07-28 21:52:54', '2024-07-29 18:29:53'),
(13, 'sunday5', 7, NULL, '2024-07-28 21:00:00', '2024-07-29 21:00:00', NULL, 'offers/Ss3frVF8NjLHClHPXhHLuNK3yunniwOQsesvegzR.png', 0, '2024-07-28 22:09:43', '2024-10-31 05:17:31'),
(14, 'sunday51', 7, NULL, '2024-07-28 21:00:00', '2024-07-28 21:00:00', NULL, 'offers/pDrlwf7tldRpUfXjMzMQT3jEIsMDO5lFn9XGPapS.jpg', 0, '2024-07-28 22:12:08', '2024-07-29 18:30:00'),
(15, 'sunday51', 7, NULL, '2024-07-28 21:00:00', '2024-07-28 21:00:00', NULL, 'offers/wpYCB2tCexCVCAaKojQ5P0aJhYOFULYbNBqH5aak.jpg', 1, '2024-09-24 14:25:47', '2024-09-24 14:25:47'),
(16, 'sunday51', 7, NULL, '2024-07-28 21:00:00', '2024-07-28 21:00:00', NULL, 'offers/tzRU847WH7T5iaPHqsY50Dgq1Mk0Cpnai69fySfg.jpg', 1, '2024-09-25 16:51:19', '2024-09-25 16:51:19'),
(17, 'sunday51', 7, NULL, '2024-07-28 21:00:00', '2024-07-28 21:00:00', NULL, 'offers/63Bsxy0s51a11fZoO8dAEtszisvhBHC1FgDEYBln.jpg', 1, '2024-09-25 16:54:03', '2024-09-25 16:54:03'),
(18, 'sunday51', 7, NULL, '2024-07-28 21:00:00', '2024-07-28 21:00:00', NULL, 'offers/VWiUfvWVOg18E2UZRW8ul21Sk4ZcGC8pJIx0spU2.jpg', 1, '2024-09-25 16:54:14', '2024-09-25 16:54:14'),
(19, 'sunday51', 7, NULL, '2024-07-28 21:00:00', '2024-07-28 21:00:00', NULL, 'offers/se87LC4gEtv6B4aF41KwxUm4D0aBIWs3814cATFh.jpg', 1, '2024-09-25 16:54:15', '2024-09-25 16:54:15'),
(20, 'sunday51 ff', 7, NULL, '2024-07-28 21:00:00', '2024-07-28 21:00:00', NULL, 'offers/RVXWaNorOjeLebpc25ruJ7nCk8VIsG3kKxKk5a9B.jpg', 1, '2024-09-25 16:54:20', '2024-09-25 16:54:20'),
(21, 'sunday51 ff', 7, NULL, '2024-07-28 23:50:10', '2024-07-30 02:50:10', NULL, 'offers/jQyQ85vmGcVCgLE0FV2TLdev8EJ924vOpuTVVUzw.jpg', 1, '2024-09-25 17:12:50', '2024-09-25 18:12:15'),
(22, 'test rr', 2, NULL, '2024-09-06 00:00:00', '2024-09-20 00:00:00', NULL, 'offers/SORwhyiUDMeOY7ySuEGxTsS3bjU95D4fPcUo4hXz.png', 1, '2024-09-25 17:24:28', '2024-09-25 17:24:28'),
(23, 'sunday51 ff', 7, NULL, '2024-07-29 02:50:10', '2024-07-30 02:50:10', NULL, 'offers/77lUeVWf0xAq8d4KR38JcFO7URn160OkX4cIM1vu.jpg', 1, '2024-09-25 17:24:45', '2024-09-25 17:24:45'),
(24, 'sunday51 ff', 7, NULL, '2024-07-29 02:50:00', '2024-07-30 02:50:00', NULL, 'offers/syU1F5J9axe7EpDuLPtFsCUO1wQTWuV50sC9ygfj.jpg', 1, '2024-09-30 03:39:53', '2024-09-30 03:39:53'),
(25, '', NULL, NULL, '2024-09-30 03:03:00', NULL, NULL, NULL, 1, '2024-09-30 03:43:44', '2024-10-05 15:03:45'),
(26, '', NULL, NULL, '2024-10-26 03:44:24', '2024-10-26 03:44:00', NULL, NULL, 1, '2024-09-30 03:44:24', '2024-10-05 14:39:03'),
(27, 'sunday51 ff', 7, NULL, '2024-07-29 02:50:00', '2024-07-30 02:45:00', NULL, 'offers/a6nLbvxSNMjF2K6SavCVaMa44gNMsoTNKtchwU33.jpg', 1, '2024-09-30 03:45:33', '2024-09-30 03:45:33'),
(28, 'sunday51', 7, NULL, '2024-07-29 02:50:00', '2024-07-30 02:45:00', NULL, 'offers/lbSIVf3PFJcqs2YA2wFW3OqFyV0DLtMPlOKh8gGU.jpg', 1, '2024-09-30 18:31:45', '2024-09-30 18:31:45'),
(29, 'sunday51', 7, NULL, '2024-07-29 14:50:00', '2024-07-30 02:45:00', NULL, 'offers/XFmXaqiJaTXrPRk7M0pMHsJeE8wHKOxpuqgiYV9z.jpg', 1, '2024-09-30 18:36:56', '2024-09-30 18:36:56'),
(30, 'sunday51', 7, NULL, '2024-07-29 14:50:00', '2024-07-30 02:45:00', NULL, 'offers/IBS8Areb3jt3NOfDSKQ7m5nkeyZs3OfVWojhqFVe.jpg', 1, '2024-09-30 19:43:23', '2024-09-30 19:43:23'),
(31, 'sunday51', 7, NULL, '2024-07-29 14:50:00', '2024-07-30 02:45:00', NULL, 'offers/RQaw0yMXbFtgYhoODUloFBaQuKFTRQWy548jWZzk.jpg', 1, '2024-10-05 14:34:49', '2024-10-05 14:34:49'),
(33, 'test offer', 15, NULL, '2024-07-09 21:00:00', '2024-07-23 21:00:00', NULL, 'offers/miLIdU3SzQmg9kHcR88wS05TEp0amtFU4AqiA2Va.png', 1, '2024-10-31 03:51:21', '2024-10-31 03:51:21'),
(34, 'test jjj', 4, NULL, '2024-10-02 21:00:00', '2024-10-25 21:00:00', NULL, 'offers/9r15KpPvUS83hmOu55zYHC3eyOoUAJDpplnrRwPI.jpg', 1, '2024-10-31 03:52:18', '2024-10-31 03:52:18'),
(35, 'Appetizers', 44, NULL, '2024-10-01 21:00:00', '2024-10-16 21:00:00', NULL, 'offers/29OVJSILZhGAl2v9wqDixjFHq1uYNlz27My5Ifq6.jpg', 1, '2024-10-31 05:07:50', '2024-10-31 05:07:50'),
(36, 'Appetizers', 10, NULL, '2024-10-31 22:00:00', '2024-11-06 22:00:00', NULL, 'offers/ZeJm7BrnKdAPSeD21dnoUPsYw0PSY92Jlk3icfPO.jpg', 1, '2024-11-01 07:48:01', '2024-11-01 07:48:01'),
(37, 'Appetizers', 10, NULL, '2024-11-04 22:00:00', '2024-11-05 22:00:00', NULL, 'offers/sMDk0bOcNA82k9RBeKncB33rTtZFqm3UwEJvnQyJ.jpg', 1, '2024-11-18 14:50:03', '2024-11-18 14:50:03');

-- --------------------------------------------------------

--
-- Table structure for table `offer_addons`
--

CREATE TABLE IF NOT EXISTS `offer_addons` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `offer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `addon_id` bigint(20) UNSIGNED DEFAULT NULL,
  `addon_quantity` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `addon_id` (`addon_id`),
  KEY `offer_id` (`offer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `offer_addons`
--

INSERT INTO `offer_addons` (`id`, `offer_id`, `addon_id`, `addon_quantity`, `created_at`, `updated_at`) VALUES
(1, 4, 3, 10, '2024-10-04 17:58:11', '2024-10-31 22:18:10'),
(2, 4, 5, 2, '2024-10-04 17:58:24', '2024-10-04 17:58:24'),
(3, 7, 3, 4, '2024-10-31 03:34:54', '2024-10-31 03:42:13'),
(4, 4, 7, 4, '2024-10-31 22:08:55', '2024-10-31 22:08:55'),
(5, 36, 5, 10, '2024-11-01 07:49:28', '2024-11-01 07:49:28');

-- --------------------------------------------------------

--
-- Table structure for table `offer_extras`
--

CREATE TABLE IF NOT EXISTS `offer_extras` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `offer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `extra_id` bigint(20) UNSIGNED DEFAULT NULL,
  `extra_quantity` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `offer_id` (`offer_id`),
  KEY `extra_id` (`extra_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `offer_extras`
--

INSERT INTO `offer_extras` (`id`, `offer_id`, `extra_id`, `extra_quantity`, `created_at`, `updated_at`) VALUES
(1, 5, 2, 10, '2024-10-04 17:51:00', '2024-10-04 17:51:00'),
(2, 5, 2, 10, '2024-10-04 17:51:59', '2024-10-04 17:51:59'),
(5, 4, 2, 1, '2024-10-04 18:03:56', '2024-10-31 22:20:00'),
(6, 7, 2, 3, '2024-10-31 03:35:08', '2024-10-31 03:41:47'),
(7, 4, 3, 3, '2024-10-31 22:08:35', '2024-10-31 22:08:35'),
(9, 36, 5, 3, '2024-11-01 07:49:11', '2024-11-01 07:49:11');

-- --------------------------------------------------------

--
-- Table structure for table `offer_items`
--

CREATE TABLE IF NOT EXISTS `offer_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `offer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `meal_id` bigint(20) UNSIGNED DEFAULT NULL,
  `meal_quantity` int(11) DEFAULT NULL,
  `extra_id` bigint(20) UNSIGNED DEFAULT NULL,
  `extra_quantity` int(11) DEFAULT NULL,
  `addon_id` bigint(20) UNSIGNED DEFAULT NULL,
  `addon_quantity` int(11) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `meal_id` (`meal_id`),
  KEY `extra_id` (`extra_id`),
  KEY `addon_id` (`addon_id`),
  KEY `offer_id` (`offer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `offer_items`
--

INSERT INTO `offer_items` (`id`, `offer_id`, `meal_id`, `meal_quantity`, `extra_id`, `extra_quantity`, `addon_id`, `addon_quantity`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 4, 5, 5, NULL, NULL, NULL, NULL, '2024-07-29 20:20:21', '2024-07-27 18:06:15', '2024-07-29 20:20:21'),
(3, 4, 14, 5, NULL, NULL, NULL, NULL, NULL, '2024-07-27 18:06:15', '2024-07-27 18:14:34');

-- --------------------------------------------------------

--
-- Table structure for table `offer_meals`
--

CREATE TABLE IF NOT EXISTS `offer_meals` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `offer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `meal_id` bigint(20) UNSIGNED DEFAULT NULL,
  `meal_size` enum('1','2','3','4') NOT NULL DEFAULT '1',
  `meal_quantity` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `offer_id` (`offer_id`),
  KEY `meal_id` (`meal_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `offer_meals`
--

INSERT INTO `offer_meals` (`id`, `offer_id`, `meal_id`, `meal_size`, `meal_quantity`, `created_at`, `updated_at`) VALUES
(1, 6, 1, '1', 1, '2024-10-04 14:10:38', '2024-10-04 14:10:38'),
(3, 4, 1, '1', 1, '2024-10-04 18:04:27', '2024-10-04 18:04:27'),
(4, 6, 8, '1', 1, '2024-10-05 17:02:17', '2024-10-05 17:02:17'),
(5, 6, 8, '2', 1, '2024-10-05 17:08:14', '2024-10-05 17:08:14'),
(6, 6, 1, '2', 1, '2024-10-05 17:08:53', '2024-10-05 17:08:53'),
(7, 6, 1, '3', 1, '2024-10-05 17:09:02', '2024-10-05 17:09:02'),
(8, 6, 1, '4', 1, '2024-10-05 17:09:08', '2024-10-05 17:09:08'),
(9, 7, 1, '1', 6, '2024-10-31 03:40:56', '2024-10-31 03:41:10'),
(10, 4, 2, '1', 2, '2024-10-31 22:08:23', '2024-10-31 22:08:23'),
(11, 36, 2, '1', 3, '2024-11-01 07:48:35', '2024-11-01 07:52:53');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE IF NOT EXISTS `orders` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `customer_id` bigint(20) UNSIGNED NOT NULL,
  `DiningTable_id` bigint(20) UNSIGNED DEFAULT NULL,
  `location_id` bigint(20) UNSIGNED DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 1 COMMENT '1 => Not Started 2=>In Progressing,\r\n3=>Cancelled\r\n4=>Accepted\r\n',
  `notes` varchar(255) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `phone` varchar(25) DEFAULT NULL,
  `tax` double DEFAULT NULL,
  `delivery_fee` double DEFAULT NULL,
  `discount` decimal(10,2) UNSIGNED NOT NULL,
  `total_cost` decimal(10,2) NOT NULL,
  `PaymentType` enum('online','cashed') DEFAULT NULL,
  `pay` int(11) NOT NULL DEFAULT 0 COMMENT '0=>Not paid ,\r\n1 => paid\r\n',
  `created_by` int(11) NOT NULL DEFAULT 0 COMMENT '0=> for customers\r\n1=>for casher',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=174 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `customer_id`, `DiningTable_id`, `location_id`, `status`, `notes`, `address`, `phone`, `tax`, `delivery_fee`, `discount`, `total_cost`, `PaymentType`, `pay`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 11, 1, NULL, 4, NULL, '', '', 0, 0, 0.00, 1640.00, '', 1, 0, '2024-07-04 06:00:10', '2024-08-28 18:20:51'),
(2, 8, 1, NULL, 4, NULL, '', '', 0, 0, 0.00, 1640.00, '', 1, 0, '2024-07-06 11:40:47', '2024-11-22 03:49:59'),
(3, 8, 1, NULL, 4, NULL, '', '', 0, 0, 0.00, 1640.00, '', 0, 0, '2024-07-06 11:43:00', '2024-09-09 22:52:57'),
(4, 8, 1, NULL, 4, NULL, '', '', 0, 0, 0.00, 1640.00, '', 1, 0, '2024-07-06 11:43:20', '2024-11-22 02:54:04'),
(5, 8, 1, NULL, 4, NULL, '', '', 0, 0, 0.00, 1640.00, '', 1, 0, '2024-07-06 11:44:10', '2024-08-06 20:03:38'),
(6, 8, 1, NULL, 4, NULL, '', '', 0, 0, 0.00, 1640.00, '', 0, 0, '2024-07-06 11:48:17', '2024-08-28 18:47:33'),
(7, 8, 1, NULL, 4, NULL, '', '', 0, 0, 0.00, 1640.00, '', 0, 0, '2024-07-06 11:49:29', '2024-09-24 11:24:37'),
(8, 8, 1, NULL, 4, NULL, '', '', 0, 0, 0.00, 1640.00, '', 0, 0, '2024-07-06 11:55:54', '2024-07-06 11:55:54'),
(9, 8, 1, NULL, 4, NULL, '', '', 0, 0, 0.00, 1640.00, '', 0, 0, '2024-07-06 12:00:09', '2024-07-06 12:00:09'),
(10, 8, 1, NULL, 4, NULL, '', '', 0, 0, 0.00, 1640.00, '', 0, 0, '2024-07-06 12:48:11', '2024-07-06 12:48:11'),
(11, 8, 1, NULL, 4, NULL, '', '', 0, 0, 0.00, 1640.00, '', 0, 0, '2024-07-06 12:52:51', '2024-07-06 12:52:51'),
(12, 8, 1, NULL, 4, NULL, '', '', 0, 0, 0.00, 1640.00, '', 0, 0, '2024-07-06 12:53:08', '2024-07-06 12:53:08'),
(13, 8, 1, NULL, 4, NULL, '', '', 0, 0, 0.00, 1640.00, '', 0, 0, '2024-07-06 12:53:32', '2024-07-06 12:53:32'),
(14, 8, 1, NULL, 4, NULL, '', '', 0, 0, 0.00, 1640.00, '', 0, 0, '2024-07-06 12:54:00', '2024-07-06 12:54:00'),
(15, 8, 1, NULL, 4, NULL, '', '', 0, 0, 0.00, 1640.00, '', 0, 0, '2024-07-06 12:54:52', '2024-07-06 12:54:52'),
(16, 8, 1, NULL, 4, NULL, '', '', 0, 0, 0.00, 1640.00, '', 0, 0, '2024-07-06 13:13:26', '2024-07-06 13:13:26'),
(17, 8, 1, NULL, 4, NULL, '', '', 0, 0, 0.00, 1640.00, '', 0, 0, '2024-07-06 13:14:02', '2024-07-06 13:14:02'),
(18, 8, 1, NULL, 4, NULL, '', '', 0, 0, 0.00, 1640.00, '', 0, 0, '2024-07-06 13:22:06', '2024-07-06 13:22:06'),
(19, 8, 1, NULL, 4, NULL, '', '', 0, 0, 0.00, 1640.00, '', 0, 0, '2024-07-07 06:12:03', '2024-07-07 06:12:03'),
(20, 8, 1, NULL, 4, NULL, '', '', 0, 0, 0.00, 1640.00, '', 0, 0, '2024-07-07 17:01:55', '2024-07-07 17:01:55'),
(21, 8, 2, NULL, 4, NULL, '', '', 0, 0, 0.00, 1640.00, '', 0, 0, '2024-07-07 17:14:38', '2024-07-07 17:14:38'),
(22, 8, 2, NULL, 4, NULL, '', '', 0, 0, 0.00, 1640.00, '', 0, 0, '2024-07-07 17:38:28', '2024-07-07 17:38:28'),
(23, 8, 2, NULL, 4, NULL, '', '', 0, 0, 0.00, 1640.00, '', 0, 0, '2024-07-07 17:38:33', '2024-07-07 17:38:33'),
(24, 8, 1, NULL, 4, NULL, '', '', 0, 0, 0.00, 8.00, '', 0, 0, '2024-07-08 05:47:20', '2024-07-08 05:47:20'),
(25, 11, 1, NULL, 4, NULL, '', '', 0, 0, 0.00, 1.00, '', 0, 0, '2024-07-08 05:51:00', '2024-07-08 05:51:00'),
(26, 8, 1, NULL, 4, NULL, '', '', 0, 0, 0.00, 1.00, '', 0, 0, '2024-07-08 05:56:37', '2024-07-08 05:56:37'),
(27, 8, 1, NULL, 4, NULL, '', '', 0, 0, 0.00, 2.00, '', 0, 0, '2024-07-08 05:57:25', '2024-07-08 05:57:25'),
(28, 8, 1, NULL, 4, NULL, '', '', 0, 0, 0.00, 8.00, '', 0, 0, '2024-07-08 08:55:15', '2024-07-08 08:55:15'),
(29, 8, 1, NULL, 4, NULL, '', '', 0, 0, 0.00, 7.00, '', 0, 0, '2024-07-08 08:58:59', '2024-07-08 08:58:59'),
(30, 8, 1, NULL, 4, NULL, '', '', 0, 0, 0.00, 1.00, '', 0, 0, '2024-07-08 09:00:20', '2024-07-08 09:00:20'),
(32, 51, 1, NULL, 4, NULL, '', '', 0, 0, 0.00, 1640.00, '', 0, 0, '2024-08-02 11:59:43', '2024-08-02 11:59:43'),
(33, 51, 1, NULL, 4, NULL, '', '', 0, 0, 0.00, 1640.00, 'cashed', 0, 0, '2024-08-06 20:05:34', '2024-08-06 20:05:34'),
(34, 51, 1, NULL, 4, NULL, '', '', 0, 0, 0.00, 1640.00, 'cashed', 0, 0, '2024-08-06 20:07:54', '2024-08-06 20:07:54'),
(35, 51, 2, NULL, 4, NULL, '', '', 0, 0, 0.00, 1640.00, 'online', 1, 0, '2024-08-06 20:08:35', '2024-08-06 20:10:49'),
(36, 8, NULL, NULL, 4, '2d', '3d', '222211', 0, 0, 0.00, 11.00, NULL, 0, 0, '2024-08-06 12:25:05', NULL),
(37, 8, NULL, NULL, 4, '2d', '3d', '222211', 0, 0, 0.00, 11.00, NULL, 0, 0, '2024-08-06 12:25:44', NULL),
(41, 8, NULL, NULL, 4, NULL, 'sohag', '01030621099', 0, 0, 0.00, 10.00, 'cashed', 1, 1, '2024-10-24 12:53:00', '2024-11-22 02:59:40'),
(42, 8, NULL, NULL, 4, NULL, 'sohag', '01030621099', 0, 0, 0.00, 10.00, 'cashed', 1, 1, '2024-10-24 12:53:32', '2024-11-22 03:51:38'),
(45, 8, NULL, NULL, 4, NULL, 'sohag', '01030621099', 0, 0, 0.00, 222.00, 'cashed', 1, 1, '2024-10-24 12:57:54', '2024-11-22 04:02:52'),
(46, 12, NULL, NULL, 4, NULL, 'sohag', '01030621099', 0, 0, 0.00, 222.00, 'cashed', 0, 1, '2024-10-24 12:58:57', '2024-10-24 12:58:57'),
(47, 12, NULL, NULL, 4, NULL, 'sohag', '01030621099', 0, 0, 0.00, 232.00, 'cashed', 0, 1, '2024-10-24 13:00:19', '2024-10-24 13:00:19'),
(48, 12, NULL, NULL, 4, NULL, 'sohag', '01030621099', 20, 0, 0.00, 252.00, 'cashed', 0, 1, '2024-10-24 13:29:16', '2024-10-24 13:29:16'),
(49, 13, NULL, NULL, 4, NULL, 'sohag', '01030621099', 20, 10, 0.00, 262.00, 'cashed', 0, 1, '2024-10-24 13:35:13', '2024-10-24 13:35:13'),
(50, 13, NULL, NULL, 4, NULL, 'sohag', '01030621099', 20, 10, 0.00, 262.00, 'cashed', 0, 1, '2024-10-24 14:11:45', '2024-10-24 14:11:45'),
(51, 13, NULL, NULL, 4, NULL, 'sohag', '01030621099', 20, 10, 0.00, 262.00, 'cashed', 0, 1, '2024-10-24 14:14:47', '2024-10-24 14:14:47'),
(52, 13, NULL, NULL, 4, NULL, 'sohag', '01030621099', 20, 10, 0.00, 262.00, 'cashed', 0, 1, '2024-10-24 14:15:05', '2024-10-24 14:15:05'),
(53, 13, NULL, NULL, 4, NULL, 'sohag', '01030621099', 20, 10, 0.00, 262.00, 'cashed', 0, 1, '2024-10-24 14:15:17', '2024-10-24 14:15:17'),
(54, 13, NULL, NULL, 4, NULL, NULL, NULL, 0, NULL, 0.00, 262.00, 'cashed', 0, 1, '2024-10-24 14:18:37', '2024-10-24 14:18:37'),
(55, 8, NULL, NULL, 4, NULL, NULL, NULL, 0, NULL, 0.00, 4.00, 'cashed', 0, 1, '2024-10-24 14:19:21', '2024-10-24 14:19:21'),
(56, 13, NULL, NULL, 4, 'no comment', NULL, NULL, 20, NULL, 0.00, 262.00, 'cashed', 1, 1, '2024-10-24 14:40:57', '2024-11-17 22:25:47'),
(57, 13, 1, NULL, 4, 'no comment', NULL, NULL, 20, NULL, 0.00, 262.00, 'cashed', 0, 0, '2024-10-25 13:05:12', '2024-10-25 13:05:12'),
(58, 13, NULL, NULL, 4, 'no comment', 'sohag', '01030621099', 20, 10, 0.00, 262.00, 'cashed', 0, 1, '2024-10-25 13:06:42', '2024-10-25 13:06:42'),
(59, 13, NULL, NULL, 4, 'no comment', 'sohag', '01030621099', 20.13, 10.22, 0.00, 262.00, 'cashed', 0, 1, '2024-10-27 16:11:06', '2024-10-27 16:11:06'),
(60, 13, NULL, NULL, 4, 'no comment', 'sohag', '01030621099', 20.13, 10.22, 0.00, 262.00, 'cashed', 0, 1, '2024-10-27 16:15:50', '2024-10-27 16:15:50'),
(61, 13, NULL, NULL, 4, 'no comment', 'sohag', '01030621099', 20.13, 10.22, 0.00, 262.00, 'cashed', 0, 1, '2024-10-27 16:25:31', '2024-10-27 16:25:31'),
(62, 13, NULL, NULL, 4, 'no comment', 'sohag', '01030621099', 20.13, 10.22, 0.00, 262.00, 'cashed', 0, 1, '2024-10-27 16:26:08', '2024-10-27 16:26:08'),
(63, 13, NULL, NULL, 4, 'no comment', 'sohag', '01030621099', 20.13, 10.22, 0.00, 262.00, 'cashed', 0, 1, '2024-10-27 16:30:54', '2024-10-27 16:30:54'),
(66, 13, NULL, NULL, 4, 'no comment', 'sohag', '01030621099', 20.13, 10.22, 0.00, 262.00, 'cashed', 0, 1, '2024-10-27 16:36:42', '2024-10-27 16:36:42'),
(68, 13, NULL, NULL, 4, 'no comment', 'sohag', '01030621099', 20.13, 10.22, 0.00, 262.00, 'cashed', 0, 1, '2024-10-27 16:40:29', '2024-10-27 16:40:29'),
(69, 13, NULL, NULL, 4, 'no comment', 'sohag', '01030621099', 20.13, 10.22, 0.00, 262.00, 'cashed', 0, 1, '2024-10-27 16:42:19', '2024-10-27 16:42:19'),
(70, 13, NULL, NULL, 4, 'no comment', 'sohag', '01030621099', 20.13, 10.22, 0.00, 262.00, 'cashed', 0, 1, '2024-10-27 16:43:47', '2024-10-27 16:43:47'),
(71, 13, 1, NULL, 4, 'no comment', NULL, NULL, 20, NULL, 0.00, 262.00, 'cashed', 0, 1, '2024-10-27 16:45:05', '2024-10-27 16:45:05'),
(72, 13, 1, NULL, 4, 'no comment', NULL, NULL, 20, NULL, 0.00, 262.00, 'cashed', 0, 1, '2024-10-27 16:45:49', '2024-10-27 16:45:49'),
(73, 13, 1, NULL, 4, 'no comment', NULL, NULL, 20, NULL, 0.00, 262.00, 'cashed', 0, 1, '2024-10-27 16:46:14', '2024-10-27 16:46:14'),
(74, 13, 1, NULL, 4, 'no comment', NULL, NULL, 20, NULL, 0.00, 262.00, 'cashed', 0, 1, '2024-10-27 17:30:42', '2024-10-27 17:30:42'),
(75, 13, 1, NULL, 4, 'no comment', NULL, NULL, 20.3, NULL, 0.00, 262.00, 'cashed', 0, 1, '2024-10-27 17:34:34', '2024-10-27 17:34:34'),
(76, 13, 1, NULL, 4, 'no comment', NULL, NULL, 20.32, NULL, 0.00, 262.00, 'cashed', 0, 1, '2024-10-27 17:34:41', '2024-10-27 17:34:41'),
(77, 13, 1, NULL, 4, 'no comment', NULL, NULL, 20.32, NULL, 0.00, 262.00, 'cashed', 0, 1, '2024-10-27 17:49:48', '2024-10-27 17:49:48'),
(78, 13, 1, NULL, 4, 'no comment', NULL, NULL, 20.32, NULL, 0.00, 262.00, 'cashed', 0, 1, '2024-10-27 17:52:08', '2024-10-27 17:52:08'),
(79, 13, 1, NULL, 4, 'no comment', NULL, NULL, 20.32, NULL, 0.00, 262.00, 'cashed', 0, 1, '2024-10-27 18:27:31', '2024-10-27 18:27:31'),
(80, 13, 1, NULL, 4, 'no comment', NULL, NULL, 20.32, NULL, 0.00, 262.00, 'cashed', 0, 1, '2024-10-27 19:25:07', '2024-10-27 19:25:07'),
(81, 10, 7, NULL, 4, 'no', NULL, NULL, 3.75, NULL, 0.00, 31.00, 'cashed', 0, 1, '2024-10-27 22:27:52', '2024-10-27 22:27:52'),
(82, 10, NULL, NULL, 4, NULL, 'ss', '010306210992', 1.26, 12, 0.00, 10.00, 'cashed', 0, 1, '2024-10-27 22:42:12', '2024-10-27 22:42:12'),
(83, 11, NULL, NULL, 4, NULL, 'dd', '12', 0.35, 10, 0.00, 3.00, 'cashed', 0, 1, '2024-10-27 22:48:18', '2024-10-27 22:48:18'),
(84, 10, NULL, NULL, 4, NULL, 'dd', '010306210992', 1.75, 10, 0.00, 14.00, 'cashed', 0, 1, '2024-10-28 15:14:01', '2024-10-28 15:14:01'),
(85, 10, NULL, NULL, 4, NULL, 'test', '01030621099', 0.35, 12, 0.00, 15.00, 'cashed', 0, 1, '2024-10-28 15:18:41', '2024-10-28 15:18:41'),
(86, 8, 2, NULL, 4, NULL, NULL, NULL, 0.35, NULL, 0.00, 3.00, 'cashed', 0, 1, '2024-10-28 15:36:13', '2024-10-28 15:36:13'),
(87, 10, NULL, NULL, 4, NULL, 'test', '010306210992', 0.84, 12, 0.00, 19.00, 'cashed', 0, 1, '2024-10-28 15:40:16', '2024-10-28 15:40:16'),
(88, 8, 3, NULL, 4, NULL, NULL, NULL, 3.08, NULL, 0.00, 25.00, 'cashed', 0, 1, '2024-10-29 14:43:19', '2024-11-16 22:36:01'),
(90, 13, 1, NULL, 1, 'no comment', NULL, NULL, 20.32, NULL, 0.00, 262.00, 'cashed', 0, 1, '2024-10-30 11:18:16', '2024-10-30 11:18:16'),
(91, 51, 1, NULL, 1, NULL, NULL, NULL, NULL, NULL, 0.00, 1640.00, 'cashed', 0, 0, '2024-10-30 11:22:34', '2024-10-30 11:22:34'),
(92, 51, 1, NULL, 1, NULL, NULL, NULL, NULL, NULL, 0.00, 1640.00, 'cashed', 0, 0, '2024-10-30 16:13:03', '2024-10-30 16:13:03'),
(93, 51, 1, NULL, 1, NULL, NULL, NULL, 14, NULL, 0.00, 114.00, 'cashed', 0, 0, '2024-10-30 16:22:30', '2024-10-30 16:22:30'),
(94, 51, 1, NULL, 1, NULL, NULL, NULL, 23.8, NULL, 0.00, 194.00, 'cashed', 0, 0, '2024-10-30 16:24:05', '2024-10-30 16:24:05'),
(95, 8, 1, NULL, 1, NULL, NULL, NULL, 9.38, NULL, 0.00, 76.00, 'cashed', 0, 1, '2024-10-31 21:04:52', '2024-10-31 21:04:52'),
(96, 8, 3, NULL, 1, NULL, NULL, NULL, 2.21, NULL, 0.00, 18.00, 'cashed', 0, 1, '2024-11-01 14:24:30', '2024-11-01 14:24:30'),
(97, 53, 2, NULL, 4, NULL, NULL, NULL, 6.34, NULL, 0.00, 52.00, 'cashed', 1, 1, '2024-11-01 14:26:43', '2024-11-01 14:58:12'),
(98, 10, 2, NULL, 1, NULL, NULL, NULL, 0.56, NULL, 0.00, 5.00, 'cashed', 0, 1, '2024-11-01 15:38:30', '2024-11-01 15:38:30'),
(99, 10, 3, NULL, 1, NULL, NULL, NULL, 2.28, NULL, 0.00, 19.00, 'cashed', 0, 1, '2024-11-01 17:19:49', '2024-11-01 17:19:49'),
(100, 8, 2, NULL, 2, NULL, NULL, NULL, 2.6, NULL, 0.00, 21.00, 'cashed', 0, 1, '2024-11-01 20:04:12', '2024-11-01 20:05:20'),
(101, 51, 3, NULL, 1, NULL, NULL, NULL, 1.47, NULL, 0.00, 12.00, 'cashed', 0, 0, '2024-11-01 20:19:31', '2024-11-01 20:19:31'),
(102, 10, NULL, NULL, 1, NULL, 'sohag', '010306210992', 3.68, 20, 0.00, 50.00, 'cashed', 0, 1, '2024-11-01 20:24:39', '2024-11-01 20:24:39'),
(103, 51, 4, NULL, 1, NULL, NULL, NULL, 8.54, NULL, 0.00, 70.00, 'cashed', 0, 0, '2024-11-01 21:41:36', '2024-11-01 21:41:36'),
(104, 51, 3, NULL, 4, NULL, NULL, NULL, 42.81, NULL, 0.00, 349.00, 'cashed', 0, 0, '2024-11-01 21:53:45', '2024-11-01 21:54:40'),
(105, 11, 3, NULL, 1, NULL, NULL, NULL, 173.32, NULL, 0.00, 1411.00, 'cashed', 0, 1, '2024-11-01 21:56:28', '2024-11-01 21:56:28'),
(106, 51, 3, NULL, 1, NULL, NULL, NULL, 168, NULL, 0.00, 1368.00, 'cashed', 0, 0, '2024-11-01 22:08:00', '2024-11-01 22:08:00'),
(107, 51, 4, NULL, 1, NULL, NULL, NULL, 174.62, NULL, 0.00, 1422.00, 'cashed', 0, 0, '2024-11-01 22:11:43', '2024-11-01 22:11:43'),
(108, 10, 2, NULL, 1, NULL, NULL, NULL, 7.97, NULL, 0.00, 65.00, 'cashed', 0, 1, '2024-11-02 15:03:49', '2024-11-02 15:03:49'),
(109, 51, 4, NULL, 4, NULL, NULL, NULL, 7.41, NULL, 0.00, 60.00, 'cashed', 1, 0, '2024-11-02 17:02:28', '2024-11-22 03:35:54'),
(110, 51, 3, NULL, 1, NULL, NULL, NULL, 1.23, NULL, 0.00, 10.00, 'cashed', 0, 0, '2024-11-02 17:08:50', '2024-11-02 17:08:50'),
(111, 51, 2, NULL, 4, NULL, NULL, NULL, 8.61, NULL, 0.00, 70.00, 'cashed', 1, 0, '2024-11-04 19:12:59', '2024-11-04 19:14:17'),
(112, 51, 2, NULL, 4, NULL, NULL, NULL, 11.77, NULL, 0.00, 96.00, 'cashed', 0, 0, '2024-11-08 14:15:36', '2024-11-08 14:16:58'),
(113, 55, 2, NULL, 4, NULL, NULL, NULL, 183.85, NULL, 0.00, 1497.00, 'cashed', 0, 1, '2024-11-08 14:20:05', '2024-11-08 14:24:13'),
(114, 10, NULL, NULL, 4, NULL, 'sohag', '01030621099', 5.73, 20, 0.00, 67.00, 'cashed', 0, 1, '2024-11-08 14:22:25', '2024-11-08 14:25:28'),
(115, 11, 3, NULL, 1, 'no', NULL, NULL, 178.42, NULL, 0.00, 1453.00, 'cashed', 0, 1, '2024-11-08 15:10:05', '2024-11-08 15:10:05'),
(116, 10, 1, NULL, 2, NULL, NULL, NULL, 185.25, NULL, 0.00, 1508.00, 'cashed', 1, 1, '2024-11-08 15:14:18', '2024-11-22 02:38:17'),
(117, 51, 1, NULL, 4, NULL, NULL, NULL, 4.56, NULL, 0.00, 37.00, 'cashed', 0, 0, '2024-11-16 18:31:59', '2024-11-16 18:35:13'),
(118, 51, NULL, NULL, 4, NULL, 'assuit , egypt\r\nassuit ,egypt', '01066056969', 167.36, 10, 0.00, 1373.00, 'cashed', 1, 1, '2024-11-16 18:44:02', '2024-11-17 22:16:21'),
(119, 8, 1, NULL, 4, NULL, NULL, NULL, 6.16, NULL, 0.00, 50.00, 'cashed', 1, 1, '2024-11-16 19:29:51', '2024-11-17 22:17:42'),
(120, 51, 1, NULL, 1, NULL, NULL, NULL, 4.98, NULL, 0.00, 41.00, 'cashed', 0, 0, '2024-11-17 20:33:45', '2024-11-17 20:33:45'),
(121, 58, 1, NULL, 4, NULL, NULL, NULL, 23.45, NULL, 0.00, 191.00, 'cashed', 1, 0, '2024-11-17 21:40:36', '2024-11-17 21:43:26'),
(122, 51, 5, NULL, 1, NULL, NULL, NULL, 1404.2, NULL, 0.00, 1505.00, 'cashed', 0, 0, '2024-11-19 15:25:57', '2024-11-19 15:25:57'),
(123, 51, 1, NULL, 1, NULL, NULL, NULL, 22960, NULL, 0.00, 24600.00, 'cashed', 0, 0, '2024-11-19 15:29:36', '2024-11-19 15:29:36'),
(124, 51, 5, NULL, 1, NULL, NULL, NULL, 1299.2, NULL, 0.00, 1392.00, 'cashed', 0, 0, '2024-11-19 15:41:55', '2024-11-19 15:41:55'),
(125, 51, 5, NULL, 1, NULL, NULL, NULL, 1843.8, NULL, 0.00, 1976.00, 'cashed', 0, 0, '2024-11-19 15:43:07', '2024-11-19 15:43:07'),
(126, 51, 4, NULL, 1, NULL, NULL, NULL, 614.6, NULL, 0.00, 659.00, 'cashed', 0, 0, '2024-11-19 15:45:01', '2024-11-19 15:45:01'),
(127, 51, 4, NULL, 1, NULL, NULL, NULL, 3.51, NULL, 0.00, 47.00, 'cashed', 0, 0, '2024-11-19 15:48:05', '2024-11-19 15:48:05'),
(139, 51, 3, NULL, 2, NULL, NULL, NULL, 6.44, NULL, 0.00, 87.00, 'cashed', 1, 0, '2024-11-22 01:35:14', '2024-11-22 02:36:25'),
(140, 51, 1, NULL, 1, NULL, NULL, NULL, 0.8, NULL, 0.00, 10.00, 'cashed', 0, 0, '2024-11-22 22:05:20', '2024-11-22 22:05:20'),
(141, 51, 1, NULL, 1, NULL, NULL, NULL, 0.8, NULL, 1.00, 10.00, 'cashed', 0, 0, '2024-11-22 22:09:47', '2024-11-22 22:09:47'),
(142, 51, 1, NULL, 1, NULL, NULL, NULL, 0.8, NULL, 0.00, 10.00, 'cashed', 0, 0, '2024-11-22 22:10:39', '2024-11-22 22:10:39'),
(143, 51, 1, NULL, 1, NULL, NULL, NULL, 8, NULL, 10.00, 108.00, 'cashed', 0, 0, '2024-11-22 22:19:38', '2024-11-22 22:19:38'),
(144, 51, 1, NULL, 1, NULL, NULL, NULL, 8, NULL, 10.00, 108.00, 'cashed', 0, 0, '2024-11-22 22:22:12', '2024-11-22 22:22:12'),
(145, 51, 3, NULL, 4, NULL, NULL, NULL, 3.1, NULL, 0.00, 42.00, 'cashed', 0, 0, '2024-11-23 20:47:42', '2024-11-23 20:51:03'),
(146, 51, 5, NULL, 1, NULL, NULL, NULL, 8.02, NULL, 10.00, 108.00, 'cashed', 0, 0, '2024-12-28 12:31:11', '2024-12-28 12:31:11'),
(147, 51, 3, NULL, 1, NULL, NULL, NULL, 8, NULL, 0.00, 108.00, 'cashed', 0, 0, '2024-12-28 12:36:14', '2024-12-28 12:36:14'),
(148, 51, 3, NULL, 1, NULL, NULL, NULL, 8, NULL, 0.00, 108.00, 'cashed', 0, 0, '2024-12-28 12:36:54', '2024-12-28 12:36:54'),
(149, 51, 4, NULL, 1, NULL, NULL, NULL, 8, NULL, 10.00, 108.00, 'cashed', 0, 0, '2024-12-28 12:40:06', '2024-12-28 12:40:06'),
(150, 11, 11, NULL, 1, NULL, NULL, NULL, 1.6, NULL, 0.00, 22.00, 'cashed', 0, 1, '2024-12-28 13:22:24', '2024-12-28 13:22:24'),
(151, 8, 12, NULL, 1, NULL, NULL, NULL, 0.8, NULL, 0.00, 11.00, 'cashed', 0, 1, '2024-12-28 13:24:29', '2024-12-28 13:24:29'),
(152, 52, 13, NULL, 1, NULL, NULL, NULL, 0.8, NULL, 0.00, 11.00, 'cashed', 0, 1, '2024-12-28 13:27:57', '2024-12-28 13:27:57'),
(153, 11, 12, NULL, 1, NULL, NULL, NULL, 0.8, NULL, 0.00, 11.00, 'cashed', 0, 1, '2024-12-28 13:35:01', '2024-12-28 13:35:01'),
(154, 11, 13, NULL, 1, NULL, NULL, NULL, 0.8, NULL, 0.00, 10.80, 'cashed', 0, 1, '2024-12-28 13:42:21', '2024-12-28 13:42:21'),
(155, 51, 3, NULL, 1, NULL, NULL, NULL, 24, NULL, 0.00, 324.00, 'cashed', 0, 0, '2024-12-28 13:43:51', '2024-12-28 13:43:51'),
(156, 51, 1, NULL, 1, NULL, NULL, NULL, 12.8, NULL, 10.00, 172.80, 'cashed', 0, 0, '2024-12-28 13:45:33', '2024-12-28 13:45:33'),
(157, 51, 3, NULL, 4, NULL, NULL, NULL, 10.54, NULL, 0.00, 142.24, 'cashed', 1, 0, '2024-12-28 13:49:05', '2024-12-28 14:28:45'),
(158, 51, 2, NULL, 1, NULL, NULL, NULL, 10.54, NULL, 10.00, 132.24, 'cashed', 0, 0, '2024-12-28 13:49:35', '2024-12-28 13:49:35'),
(159, 52, NULL, NULL, 1, NULL, 'test', '010306210992', 8.08, 20, 0.00, 129.08, 'cashed', 0, 1, '2024-12-28 14:03:09', '2024-12-28 14:03:09'),
(160, 51, 1, NULL, 1, NULL, NULL, NULL, 8.4, NULL, 10.00, 103.40, 'cashed', 0, 0, '2024-12-28 14:40:38', '2024-12-28 14:40:38'),
(168, 51, 2, NULL, 3, NULL, NULL, NULL, 8, NULL, 10.00, 98.00, 'cashed', 0, 0, '2024-12-31 12:57:49', '2024-12-31 13:36:40'),
(169, 51, 2, NULL, 3, NULL, NULL, NULL, 21.07, NULL, 20.00, 264.47, 'cashed', 0, 0, '2024-12-31 13:45:03', '2024-12-31 14:02:03'),
(170, 51, 2, NULL, 1, NULL, NULL, NULL, 19.99, NULL, 22.00, 247.89, 'cashed', 1, 0, '2024-12-31 14:01:33', '2024-12-31 15:01:39'),
(171, 51, 3, NULL, 4, NULL, NULL, NULL, 8.8, NULL, 11.00, 107.80, 'cashed', 1, 0, '2025-01-07 15:09:30', '2025-01-07 15:19:17'),
(172, 51, 5, NULL, 1, NULL, NULL, NULL, 4, NULL, 0.00, 54.00, 'cashed', 0, 0, '2025-01-07 16:38:18', '2025-01-07 16:38:18'),
(173, 51, 3, NULL, 1, NULL, NULL, NULL, 10.54, NULL, 0.00, 142.24, 'cashed', 0, 0, '2025-01-07 16:43:45', '2025-01-07 16:43:45');

-- --------------------------------------------------------

--
-- Table structure for table `order_addons`
--

CREATE TABLE IF NOT EXISTS `order_addons` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) UNSIGNED DEFAULT NULL,
  `addon_id` bigint(20) UNSIGNED DEFAULT NULL,
  `total_cost` double NOT NULL,
  `quantity` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `addon_id` (`addon_id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=163 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_addons`
--

INSERT INTO `order_addons` (`id`, `order_id`, `addon_id`, `total_cost`, `quantity`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 200, 10, '2024-07-04 06:00:10', '2024-07-04 06:00:10'),
(2, 1, 2, 240, 10, '2024-07-04 06:00:10', '2024-07-04 06:00:10'),
(3, 2, 1, 200, 10, '2024-07-06 11:40:47', '2024-07-06 11:40:47'),
(4, 2, 2, 240, 10, '2024-07-06 11:40:47', '2024-07-06 11:40:47'),
(5, 3, 1, 200, 10, '2024-07-06 11:43:00', '2024-07-06 11:43:00'),
(6, 3, 2, 240, 10, '2024-07-06 11:43:00', '2024-07-06 11:43:00'),
(7, 4, 1, 200, 10, '2024-07-06 11:43:20', '2024-07-06 11:43:20'),
(8, 4, 2, 240, 10, '2024-07-06 11:43:20', '2024-07-06 11:43:20'),
(9, 5, 1, 200, 10, '2024-07-06 11:44:10', '2024-07-06 11:44:10'),
(10, 5, 2, 240, 10, '2024-07-06 11:44:10', '2024-07-06 11:44:10'),
(11, 6, 1, 200, 10, '2024-07-06 11:48:17', '2024-07-06 11:48:17'),
(12, 6, 2, 240, 10, '2024-07-06 11:48:17', '2024-07-06 11:48:17'),
(13, 7, 1, 200, 10, '2024-07-06 11:49:29', '2024-07-06 11:49:29'),
(14, 7, 2, 240, 10, '2024-07-06 11:49:29', '2024-07-06 11:49:29'),
(15, 8, 1, 200, 10, '2024-07-06 11:55:54', '2024-07-06 11:55:54'),
(16, 8, 2, 240, 10, '2024-07-06 11:55:54', '2024-07-06 11:55:54'),
(17, 9, 1, 200, 10, '2024-07-06 12:00:09', '2024-07-06 12:00:09'),
(18, 9, 2, 240, 10, '2024-07-06 12:00:09', '2024-07-06 12:00:09'),
(19, 10, 1, 200, 10, '2024-07-06 12:48:11', '2024-07-06 12:48:11'),
(20, 10, 2, 240, 10, '2024-07-06 12:48:11', '2024-07-06 12:48:11'),
(21, 11, 1, 200, 10, '2024-07-06 12:52:51', '2024-07-06 12:52:51'),
(22, 11, 2, 240, 10, '2024-07-06 12:52:51', '2024-07-06 12:52:51'),
(23, 12, 1, 200, 10, '2024-07-06 12:53:08', '2024-07-06 12:53:08'),
(24, 12, 2, 240, 10, '2024-07-06 12:53:08', '2024-07-06 12:53:08'),
(25, 13, 1, 200, 10, '2024-07-06 12:53:32', '2024-07-06 12:53:32'),
(26, 13, 2, 240, 10, '2024-07-06 12:53:32', '2024-07-06 12:53:32'),
(27, 14, 1, 200, 10, '2024-07-06 12:54:00', '2024-07-06 12:54:00'),
(28, 14, 2, 240, 10, '2024-07-06 12:54:00', '2024-07-06 12:54:00'),
(29, 15, 1, 200, 10, '2024-07-06 12:54:52', '2024-07-06 12:54:52'),
(30, 15, 2, 240, 10, '2024-07-06 12:54:52', '2024-07-06 12:54:52'),
(31, 16, 1, 200, 10, '2024-07-06 13:13:26', '2024-07-06 13:13:26'),
(32, 16, 2, 240, 10, '2024-07-06 13:13:26', '2024-07-06 13:13:26'),
(33, 17, 1, 200, 10, '2024-07-06 13:14:02', '2024-07-06 13:14:02'),
(34, 17, 2, 240, 10, '2024-07-06 13:14:02', '2024-07-06 13:14:02'),
(35, 18, 1, 200, 10, '2024-07-06 13:22:06', '2024-07-06 13:22:06'),
(36, 18, 2, 240, 10, '2024-07-06 13:22:06', '2024-07-06 13:22:06'),
(37, 19, 1, 200, 10, '2024-07-07 06:12:03', '2024-07-07 06:12:03'),
(38, 19, 2, 240, 10, '2024-07-07 06:12:03', '2024-07-07 06:12:03'),
(39, 20, 1, 200, 10, '2024-07-07 17:01:56', '2024-07-07 17:01:56'),
(40, 20, 2, 240, 10, '2024-07-07 17:01:56', '2024-07-07 17:01:56'),
(41, 21, 1, 200, 10, '2024-07-07 17:14:38', '2024-07-07 17:14:38'),
(42, 21, 2, 240, 10, '2024-07-07 17:14:38', '2024-07-07 17:14:38'),
(43, 22, 1, 200, 10, '2024-07-07 17:38:28', '2024-07-07 17:38:28'),
(44, 22, 2, 240, 10, '2024-07-07 17:38:28', '2024-07-07 17:38:28'),
(45, 23, 1, 200, 10, '2024-07-07 17:38:33', '2024-07-07 17:38:33'),
(46, 23, 2, 240, 10, '2024-07-07 17:38:33', '2024-07-07 17:38:33'),
(47, 24, 12, 1, 1, '2024-07-08 05:47:21', '2024-07-08 05:47:21'),
(48, 25, 12, 1, 1, '2024-07-08 05:51:00', '2024-07-08 05:51:00'),
(49, 26, 12, 1, 1, '2024-07-08 05:56:37', '2024-07-08 05:56:37'),
(50, 29, 8, 2, 1, '2024-07-08 08:58:59', '2024-07-08 08:58:59'),
(51, 30, 12, 1, 1, '2024-07-08 09:00:20', '2024-07-08 09:00:20'),
(52, 35, 1, 20, 10, '2024-08-06 20:08:35', '2024-08-06 20:08:35'),
(53, 35, 2, 240, 10, '2024-08-06 20:08:35', '2024-08-06 20:08:35'),
(54, 41, 1, 10, 10, '2024-10-24 12:53:00', '2024-10-24 12:53:00'),
(55, 42, 1, 10, 10, '2024-10-24 12:53:32', '2024-10-24 12:53:32'),
(56, 45, 1, 10, 10, '2024-10-24 12:57:54', '2024-10-24 12:57:54'),
(57, 46, 1, 10, 10, '2024-10-24 12:58:57', '2024-10-24 12:58:57'),
(58, 47, 1, 10, 10, '2024-10-24 13:00:19', '2024-10-24 13:00:19'),
(59, 48, 1, 10, 10, '2024-10-24 13:29:16', '2024-10-24 13:29:16'),
(60, 49, 1, 10, 10, '2024-10-24 13:35:13', '2024-10-24 13:35:13'),
(61, 50, 1, 10, 10, '2024-10-24 14:11:45', '2024-10-24 14:11:45'),
(62, 51, 1, 10, 10, '2024-10-24 14:14:47', '2024-10-24 14:14:47'),
(63, 56, 1, 10, 10, '2024-10-24 14:40:57', '2024-10-24 14:40:57'),
(64, 57, 1, 10, 10, '2024-10-25 13:05:12', '2024-10-25 13:05:12'),
(65, 58, 1, 10, 10, '2024-10-25 13:06:42', '2024-10-25 13:06:42'),
(66, 59, 1, 10, 10, '2024-10-27 16:11:06', '2024-10-27 16:11:06'),
(67, 60, 1, 10, 10, '2024-10-27 16:15:50', '2024-10-27 16:15:50'),
(68, 61, 1, 10, 10, '2024-10-27 16:25:31', '2024-10-27 16:25:31'),
(69, 62, 1, 10, 10, '2024-10-27 16:26:08', '2024-10-27 16:26:08'),
(70, 63, 1, 10, 10, '2024-10-27 16:30:54', '2024-10-27 16:30:54'),
(71, 66, 1, 10, 10, '2024-10-27 16:36:42', '2024-10-27 16:36:42'),
(72, 68, 1, 10, 10, '2024-10-27 16:40:29', '2024-10-27 16:40:29'),
(73, 69, 1, 10, 10, '2024-10-27 16:42:20', '2024-10-27 16:42:20'),
(74, 70, 1, 10, 10, '2024-10-27 16:43:47', '2024-10-27 16:43:47'),
(75, 71, 1, 10, 10, '2024-10-27 16:45:05', '2024-10-27 16:45:05'),
(76, 72, 1, 10, 10, '2024-10-27 16:45:49', '2024-10-27 16:45:49'),
(77, 73, 1, 10, 10, '2024-10-27 16:46:14', '2024-10-27 16:46:14'),
(78, 74, 1, 10, 10, '2024-10-27 17:30:42', '2024-10-27 17:30:42'),
(79, 75, 1, 10, 10, '2024-10-27 17:34:34', '2024-10-27 17:34:34'),
(80, 76, 1, 10, 10, '2024-10-27 17:34:41', '2024-10-27 17:34:41'),
(81, 77, 1, 10, 10, '2024-10-27 17:49:48', '2024-10-27 17:49:48'),
(82, 78, 1, 10, 10, '2024-10-27 17:52:08', '2024-10-27 17:52:08'),
(83, 79, 1, 10, 10, '2024-10-27 18:27:31', '2024-10-27 18:27:31'),
(84, 80, 1, 10, 10, '2024-10-27 19:25:07', '2024-10-27 19:25:07'),
(85, 81, 4, 2.5, 1, '2024-10-27 22:27:52', '2024-10-27 22:27:52'),
(86, 81, 2, 5.7, 3, '2024-10-27 22:27:52', '2024-10-27 22:27:52'),
(87, 83, 4, 2.5, 1, '2024-10-27 22:48:18', '2024-10-27 22:48:18'),
(88, 84, 3, 10, 5, '2024-10-28 15:14:01', '2024-10-28 15:14:01'),
(89, 84, 4, 2.5, 1, '2024-10-28 15:14:01', '2024-10-28 15:14:01'),
(90, 85, 4, 2.5, 1, '2024-10-28 15:18:41', '2024-10-28 15:18:41'),
(91, 41, 4, 2.5, 1, '2024-10-28 15:36:13', '2024-10-28 15:36:13'),
(92, 41, 3, 6, 3, '2024-10-28 15:40:16', '2024-10-28 15:40:16'),
(94, 90, 1, 10, 10, '2024-10-30 11:18:16', '2024-10-30 11:18:16'),
(95, 95, 3, 8, 4, '2024-10-31 21:04:52', '2024-10-31 21:04:52'),
(96, 95, 1, 3, 1, '2024-10-31 21:04:52', '2024-10-31 21:04:52'),
(97, 95, 4, 2.5, 1, '2024-10-31 21:04:52', '2024-10-31 21:04:52'),
(98, 96, 2, 3.8, 2, '2024-11-01 14:24:30', '2024-11-01 14:24:30'),
(99, 96, 1, 6, 2, '2024-11-01 14:24:30', '2024-11-01 14:24:30'),
(100, 96, 3, 2, 1, '2024-11-01 14:24:30', '2024-11-01 14:24:30'),
(101, 97, 4, 5, 2, '2024-11-01 14:26:43', '2024-11-01 14:26:43'),
(102, 97, 13, 6, 3, '2024-11-01 14:26:43', '2024-11-01 14:26:43'),
(103, 99, 3, 2, 1, '2024-11-01 17:19:49', '2024-11-01 17:19:49'),
(104, 99, 13, 2, 1, '2024-11-01 17:19:49', '2024-11-01 17:19:49'),
(105, 100, 13, 2, 1, '2024-11-01 20:04:12', '2024-11-01 20:04:12'),
(106, 101, 13, 2, 1, '2024-11-01 20:19:31', '2024-11-01 20:19:31'),
(107, 102, 4, 2.5, 1, '2024-11-01 20:24:39', '2024-11-01 20:24:39'),
(108, 102, 3, 2, 1, '2024-11-01 20:24:39', '2024-11-01 20:24:39'),
(109, 102, 1, 3, 1, '2024-11-01 20:24:39', '2024-11-01 20:24:39'),
(110, 102, 13, 2, 1, '2024-11-01 20:24:39', '2024-11-01 20:24:39'),
(111, 104, 13, 2, 1, '2024-11-01 21:53:45', '2024-11-01 21:53:45'),
(112, 108, 13, 2, 1, '2024-11-02 15:03:49', '2024-11-02 15:03:49'),
(113, 108, 2, 1.9, 1, '2024-11-02 15:03:49', '2024-11-02 15:03:49'),
(114, 109, 2, 1.9, 1, '2024-11-02 17:02:28', '2024-11-02 17:02:28'),
(115, 111, 2, 1.9, 1, '2024-11-04 19:12:59', '2024-11-04 19:12:59'),
(116, 111, 13, 2, 1, '2024-11-04 19:12:59', '2024-11-04 19:12:59'),
(117, 112, 2, 3.8, 2, '2024-11-08 14:15:36', '2024-11-08 14:15:36'),
(118, 112, 13, 2, 1, '2024-11-08 14:15:36', '2024-11-08 14:15:36'),
(119, 113, 3, 2, 1, '2024-11-08 14:20:05', '2024-11-08 14:20:05'),
(120, 113, 1, 3, 1, '2024-11-08 14:20:05', '2024-11-08 14:20:05'),
(121, 113, 2, 1.9, 1, '2024-11-08 14:20:05', '2024-11-08 14:20:05'),
(122, 114, 2, 39.9, 21, '2024-11-08 14:22:25', '2024-11-08 14:22:25'),
(123, 115, 1, 3, 1, '2024-11-08 15:10:05', '2024-11-08 15:10:05'),
(124, 115, 2, 3.8, 2, '2024-11-08 15:10:05', '2024-11-08 15:10:05'),
(125, 116, 2, 1.9, 1, '2024-11-08 15:14:18', '2024-11-08 15:14:18'),
(126, 118, 2, 30.4, 16, '2024-11-16 18:44:02', '2024-11-16 18:44:02'),
(127, 119, 1, 3, 1, '2024-11-16 19:29:51', '2024-11-16 19:29:51'),
(128, 119, 3, 2, 1, '2024-11-16 19:29:51', '2024-11-16 19:29:51'),
(129, 119, 7, 2, 1, '2024-11-16 19:29:51', '2024-11-16 19:29:51'),
(130, 120, 2, 3.8, 2, '2024-11-17 20:33:45', '2024-11-17 20:33:45'),
(131, 121, 4, 2.5, 1, '2024-11-17 21:40:36', '2024-11-17 21:40:36'),
(132, 122, 13, 2, 1, '2024-11-19 15:25:57', '2024-11-19 15:25:57'),
(133, 122, 5, 2, 1, '2024-11-19 15:25:57', '2024-11-19 15:25:57'),
(134, 122, 9, 2.3, 1, '2024-11-19 15:25:57', '2024-11-19 15:25:57'),
(151, 139, 2, 7.6, 4, '2024-11-22 01:35:14', '2024-11-22 01:35:14'),
(152, 139, 4, 2.5, 1, '2024-11-22 01:35:14', '2024-11-22 01:35:14'),
(153, 145, 1, 6, 2, '2024-11-23 20:47:42', '2024-11-23 20:47:42'),
(154, 145, 4, 5, 2, '2024-11-23 20:47:42', '2024-11-23 20:47:42'),
(155, 146, 2, 1.9, 1, '2024-12-28 12:31:11', '2024-12-28 12:31:11'),
(156, 150, 3, 20, 10, '2024-12-28 13:22:24', '2024-12-28 13:22:24'),
(157, 151, 4, 10, 4, '2024-12-28 13:24:29', '2024-12-28 13:24:29'),
(158, 152, 4, 10, 4, '2024-12-28 13:27:57', '2024-12-28 13:27:57'),
(159, 153, 4, 10, 4, '2024-12-28 13:35:01', '2024-12-28 13:35:01'),
(160, 154, 4, 10, 4, '2024-12-28 13:42:21', '2024-12-28 13:42:21'),
(161, 159, 4, 5, 2, '2024-12-28 14:03:09', '2024-12-28 14:03:09'),
(162, 160, 1, 9, 3, '2024-12-28 14:40:38', '2024-12-28 14:40:38');

-- --------------------------------------------------------

--
-- Table structure for table `order_extras`
--

CREATE TABLE IF NOT EXISTS `order_extras` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `extra_id` bigint(20) UNSIGNED DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `total_cost` double NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=117 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_extras`
--

INSERT INTO `order_extras` (`id`, `order_id`, `extra_id`, `quantity`, `total_cost`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 10, 150, '2024-07-04 06:00:10', '2024-07-04 06:00:10'),
(2, 2, 1, 10, 150, '2024-07-06 11:40:47', '2024-07-06 11:40:47'),
(3, 3, 1, 10, 150, '2024-07-06 11:43:00', '2024-07-06 11:43:00'),
(4, 4, 1, 10, 150, '2024-07-06 11:43:20', '2024-07-06 11:43:20'),
(5, 5, 1, 10, 150, '2024-07-06 11:44:10', '2024-07-06 11:44:10'),
(6, 6, 1, 10, 150, '2024-07-06 11:48:17', '2024-07-06 11:48:17'),
(7, 7, 1, 10, 150, '2024-07-06 11:49:29', '2024-07-06 11:49:29'),
(8, 8, 1, 10, 150, '2024-07-06 11:55:54', '2024-07-06 11:55:54'),
(9, 9, 1, 10, 150, '2024-07-06 12:00:09', '2024-07-06 12:00:09'),
(10, 10, 1, 10, 150, '2024-07-06 12:48:11', '2024-07-06 12:48:11'),
(11, 11, 1, 10, 150, '2024-07-06 12:52:51', '2024-07-06 12:52:51'),
(12, 12, 1, 10, 150, '2024-07-06 12:53:08', '2024-07-06 12:53:08'),
(13, 13, 1, 10, 150, '2024-07-06 12:53:32', '2024-07-06 12:53:32'),
(14, 14, 1, 10, 150, '2024-07-06 12:54:00', '2024-07-06 12:54:00'),
(15, 15, 1, 10, 150, '2024-07-06 12:54:52', '2024-07-06 12:54:52'),
(16, 16, 1, 10, 150, '2024-07-06 13:13:26', '2024-07-06 13:13:26'),
(17, 17, 1, 10, 150, '2024-07-06 13:14:02', '2024-07-06 13:14:02'),
(18, 18, 1, 10, 150, '2024-07-06 13:22:06', '2024-07-06 13:22:06'),
(19, 19, 1, 10, 150, '2024-07-07 06:12:03', '2024-07-07 06:12:03'),
(20, 20, 1, 10, 150, '2024-07-07 17:01:56', '2024-07-07 17:01:56'),
(21, 21, 1, 10, 150, '2024-07-07 17:14:38', '2024-07-07 17:14:38'),
(22, 22, 1, 10, 150, '2024-07-07 17:38:28', '2024-07-07 17:38:28'),
(23, 23, 1, 10, 150, '2024-07-07 17:38:33', '2024-07-07 17:38:33'),
(24, 24, 1, 1, 2, '2024-07-08 05:47:21', '2024-07-08 05:47:21'),
(25, 27, 1, 1, 2, '2024-07-08 05:57:25', '2024-07-08 05:57:25'),
(26, 33, 1, 10, 150, '2024-08-06 20:05:34', '2024-08-06 20:05:34'),
(27, 34, 1, 10, 150, '2024-08-06 20:07:54', '2024-08-06 20:07:54'),
(28, 35, 1, 10, 150, '2024-08-06 20:08:35', '2024-08-06 20:08:35'),
(29, 45, 1, 10, 10, '2024-10-24 12:57:54', '2024-10-24 12:57:54'),
(30, 46, 1, 10, 10, '2024-10-24 12:58:57', '2024-10-24 12:58:57'),
(31, 47, 1, 10, 10, '2024-10-24 13:00:19', '2024-10-24 13:00:19'),
(32, 48, 1, 10, 10, '2024-10-24 13:29:16', '2024-10-24 13:29:16'),
(33, 49, 1, 10, 10, '2024-10-24 13:35:13', '2024-10-24 13:35:13'),
(34, 50, 1, 10, 10, '2024-10-24 14:11:45', '2024-10-24 14:11:45'),
(35, 51, 1, 10, 10, '2024-10-24 14:14:47', '2024-10-24 14:14:47'),
(36, 56, 1, 10, 10, '2024-10-24 14:40:57', '2024-10-24 14:40:57'),
(37, 57, 1, 10, 10, '2024-10-25 13:05:12', '2024-10-25 13:05:12'),
(38, 58, 1, 10, 10, '2024-10-25 13:06:42', '2024-10-25 13:06:42'),
(39, 59, 1, 10, 10, '2024-10-27 16:11:06', '2024-10-27 16:11:06'),
(40, 60, 1, 10, 10, '2024-10-27 16:15:50', '2024-10-27 16:15:50'),
(41, 61, 1, 10, 10, '2024-10-27 16:25:31', '2024-10-27 16:25:31'),
(42, 62, 1, 10, 10, '2024-10-27 16:26:08', '2024-10-27 16:26:08'),
(43, 63, 1, 10, 10, '2024-10-27 16:30:54', '2024-10-27 16:30:54'),
(44, 66, 1, 10, 10, '2024-10-27 16:36:42', '2024-10-27 16:36:42'),
(45, 68, 1, 10, 10, '2024-10-27 16:40:29', '2024-10-27 16:40:29'),
(46, 69, 1, 10, 10, '2024-10-27 16:42:20', '2024-10-27 16:42:20'),
(47, 70, 1, 10, 10, '2024-10-27 16:43:47', '2024-10-27 16:43:47'),
(48, 71, 1, 10, 10, '2024-10-27 16:45:05', '2024-10-27 16:45:05'),
(49, 72, 1, 10, 10, '2024-10-27 16:45:49', '2024-10-27 16:45:49'),
(50, 73, 1, 10, 10, '2024-10-27 16:46:14', '2024-10-27 16:46:14'),
(51, 74, 1, 10, 10, '2024-10-27 17:30:42', '2024-10-27 17:30:42'),
(52, 75, 1, 10, 10, '2024-10-27 17:34:34', '2024-10-27 17:34:34'),
(53, 76, 1, 10, 10, '2024-10-27 17:34:41', '2024-10-27 17:34:41'),
(54, 77, 1, 10, 10, '2024-10-27 17:49:48', '2024-10-27 17:49:48'),
(55, 78, 1, 10, 10, '2024-10-27 17:52:08', '2024-10-27 17:52:08'),
(56, 79, 1, 10, 10, '2024-10-27 18:27:31', '2024-10-27 18:27:31'),
(57, 88, 1, 10, 10, '2024-10-27 19:25:07', '2024-10-27 19:25:07'),
(58, 82, 2, 2, 4, '2024-10-27 22:42:12', '2024-10-27 22:42:12'),
(59, 88, 2, 1, 2, '2024-10-29 14:43:19', '2024-10-29 14:43:19'),
(61, 90, 1, 10, 10, '2024-10-30 11:18:16', '2024-10-30 11:18:16'),
(62, 91, 1, 10, 150, '2024-10-30 11:22:34', '2024-10-30 11:22:34'),
(63, 92, 1, 10, 150, '2024-10-30 16:13:03', '2024-10-30 16:13:03'),
(64, 93, 1, 10, 150, '2024-10-30 16:22:30', '2024-10-30 16:22:30'),
(65, 94, 1, 10, 150, '2024-10-30 16:24:05', '2024-10-30 16:24:05'),
(66, 96, 1, 1, 4, '2024-11-01 14:24:30', '2024-11-01 14:24:30'),
(67, 97, 1, 2, 8, '2024-11-01 14:26:43', '2024-11-01 14:26:43'),
(68, 98, 1, 1, 4, '2024-11-01 15:38:30', '2024-11-01 15:38:30'),
(69, 99, 2, 1, 2, '2024-11-01 17:19:49', '2024-11-01 17:19:49'),
(70, 99, 1, 2, 8, '2024-11-01 17:19:49', '2024-11-01 17:19:49'),
(71, 100, 2, 1, 2, '2024-11-01 20:04:12', '2024-11-01 20:04:12'),
(72, 100, 1, 2, 8, '2024-11-01 20:04:12', '2024-11-01 20:04:12'),
(73, 101, 1, 1, 4, '2024-11-01 20:19:31', '2024-11-01 20:19:31'),
(74, 102, 2, 2, 4, '2024-11-01 20:24:39', '2024-11-01 20:24:39'),
(75, 102, 1, 2, 8, '2024-11-01 20:24:39', '2024-11-01 20:24:39'),
(76, 104, 1, 1, 4, '2024-11-01 21:53:45', '2024-11-01 21:53:45'),
(77, 105, 2, 1, 2, '2024-11-01 21:56:28', '2024-11-01 21:56:28'),
(78, 108, 3, 1, 2, '2024-11-02 15:03:49', '2024-11-02 15:03:49'),
(79, 108, 1, 1, 4, '2024-11-02 15:03:49', '2024-11-02 15:03:49'),
(80, 109, 5, 1, 2, '2024-11-02 17:02:28', '2024-11-02 17:02:28'),
(81, 109, 3, 1, 2, '2024-11-02 17:02:28', '2024-11-02 17:02:28'),
(82, 110, 3, 1, 2, '2024-11-02 17:08:50', '2024-11-02 17:08:50'),
(83, 110, 5, 1, 2, '2024-11-02 17:08:50', '2024-11-02 17:08:50'),
(84, 111, 5, 1, 2, '2024-11-04 19:12:59', '2024-11-04 19:12:59'),
(85, 111, 1, 1, 4, '2024-11-04 19:12:59', '2024-11-04 19:12:59'),
(86, 112, 5, 2, 4, '2024-11-08 14:15:36', '2024-11-08 14:15:36'),
(87, 112, 3, 2, 4, '2024-11-08 14:15:36', '2024-11-08 14:15:36'),
(88, 112, 1, 2, 8, '2024-11-08 14:15:36', '2024-11-08 14:15:36'),
(89, 113, 5, 1, 2, '2024-11-08 14:20:05', '2024-11-08 14:20:05'),
(90, 115, 5, 1, 2, '2024-11-08 15:10:05', '2024-11-08 15:10:05'),
(91, 116, 5, 1, 2, '2024-11-08 15:14:18', '2024-11-08 15:14:18'),
(92, 116, 3, 1, 2, '2024-11-08 15:14:18', '2024-11-08 15:14:18'),
(93, 120, 1, 1, 4, '2024-11-17 20:33:45', '2024-11-17 20:33:45'),
(94, 120, 5, 2, 4, '2024-11-17 20:33:45', '2024-11-17 20:33:45'),
(95, 121, 5, 1, 2, '2024-11-17 21:40:36', '2024-11-17 21:40:36'),
(96, 122, 1, 1, 4, '2024-11-19 15:25:57', '2024-11-19 15:25:57'),
(97, 122, 4, 12, 24, '2024-11-19 15:25:57', '2024-11-19 15:25:57'),
(98, 123, 1, 10, 150, '2024-11-19 15:29:36', '2024-11-19 15:29:36'),
(107, 139, 3, 3, 6, '2024-11-22 01:35:14', '2024-11-22 01:35:14'),
(108, 140, 1, 10, 150, '2024-11-22 22:05:20', '2024-11-22 22:05:20'),
(109, 141, 1, 10, 150, '2024-11-22 22:09:47', '2024-11-22 22:09:47'),
(110, 142, 1, 10, 150, '2024-11-22 22:10:39', '2024-11-22 22:10:39'),
(111, 143, 1, 10, 150, '2024-11-22 22:19:38', '2024-11-22 22:19:38'),
(112, 144, 1, 10, 150, '2024-11-22 22:22:12', '2024-11-22 22:22:12'),
(113, 145, 2, 2, 5.8, '2024-11-23 20:47:42', '2024-11-23 20:47:42'),
(114, 146, 3, 1, 2, '2024-12-28 12:31:11', '2024-12-28 12:31:11'),
(115, 160, 3, 3, 6, '2024-12-28 14:40:38', '2024-12-28 14:40:38'),
(116, 170, 1, 9, 36, '2024-12-31 14:01:33', '2024-12-31 14:01:33');

-- --------------------------------------------------------

--
-- Table structure for table `order_locations`
--

CREATE TABLE IF NOT EXISTS `order_locations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `street` varchar(255) NOT NULL,
  `building` varchar(255) NOT NULL,
  `area` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `order_meals`
--

CREATE TABLE IF NOT EXISTS `order_meals` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `meal_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` int(11) NOT NULL,
  `size` enum('1','2','3','4') NOT NULL DEFAULT '1',
  `total_cost` double NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=170 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `order_meals`
--

INSERT INTO `order_meals` (`id`, `order_id`, `meal_id`, `quantity`, `size`, `total_cost`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 10, '1', 1050, '2024-07-04 06:00:10', '2024-07-04 06:00:10'),
(2, 2, 1, 10, '1', 1050, '2024-07-06 11:40:47', '2024-07-06 11:40:47'),
(3, 3, 1, 10, '1', 1050, '2024-07-06 11:43:00', '2024-07-06 11:43:00'),
(4, 4, 1, 10, '1', 1050, '2024-07-06 11:43:20', '2024-07-06 11:43:20'),
(5, 5, 1, 10, '1', 1050, '2024-07-06 11:44:10', '2024-07-06 11:44:10'),
(6, 6, 1, 10, '1', 1050, '2024-07-06 11:48:17', '2024-07-06 11:48:17'),
(7, 7, 1, 10, '1', 1050, '2024-07-06 11:49:29', '2024-07-06 11:49:29'),
(8, 8, 1, 10, '1', 1050, '2024-07-06 11:55:54', '2024-07-06 11:55:54'),
(9, 9, 1, 10, '1', 1050, '2024-07-06 12:00:09', '2024-07-06 12:00:09'),
(10, 10, 1, 10, '1', 1050, '2024-07-06 12:48:11', '2024-07-06 12:48:11'),
(11, 11, 1, 10, '1', 1050, '2024-07-06 12:52:51', '2024-07-06 12:52:51'),
(12, 12, 1, 10, '1', 1050, '2024-07-06 12:53:08', '2024-07-06 12:53:08'),
(13, 13, 1, 10, '1', 1050, '2024-07-06 12:53:32', '2024-07-06 12:53:32'),
(14, 14, 1, 10, '1', 1050, '2024-07-06 12:54:00', '2024-07-06 12:54:00'),
(15, 15, 1, 10, '1', 1050, '2024-07-06 12:54:52', '2024-07-06 12:54:52'),
(16, 16, 1, 10, '1', 1050, '2024-07-06 13:13:26', '2024-07-06 13:13:26'),
(17, 17, 1, 10, '1', 1050, '2024-07-06 13:14:02', '2024-07-06 13:14:02'),
(18, 18, 1, 10, '1', 1050, '2024-07-06 13:22:06', '2024-07-06 13:22:06'),
(19, 19, 1, 10, '1', 1050, '2024-07-07 06:12:03', '2024-07-07 06:12:03'),
(20, 20, 1, 10, '1', 1050, '2024-07-07 17:01:56', '2024-07-07 17:01:56'),
(21, 21, 1, 10, '1', 1050, '2024-07-07 17:14:38', '2024-07-07 17:14:38'),
(22, 22, 1, 10, '1', 1050, '2024-07-07 17:38:28', '2024-07-07 17:38:28'),
(23, 23, 1, 10, '1', 1050, '2024-07-07 17:38:33', '2024-07-07 17:38:33'),
(24, 24, 1, 1, '1', 2.5, '2024-07-08 05:47:21', '2024-07-08 05:47:21'),
(25, 24, 12, 1, '1', 2.5, '2024-07-08 05:47:21', '2024-07-08 05:47:21'),
(26, 28, 1, 4, '1', 8, '2024-07-08 08:55:15', '2024-07-08 08:55:15'),
(27, 29, 5, 2, '1', 5, '2024-07-08 08:58:59', '2024-07-08 08:58:59'),
(28, 35, 1, 10, '1', 1050, '2024-08-06 20:08:35', '2024-08-06 20:08:35'),
(30, 41, 1, 10, '1', 10, '2024-10-24 12:53:00', '2024-10-24 12:53:00'),
(31, 42, 1, 10, '1', 10, '2024-10-24 12:53:32', '2024-10-24 12:53:32'),
(32, 45, 1, 10, '1', 10, '2024-10-24 12:57:54', '2024-10-24 12:57:54'),
(33, 46, 1, 10, '1', 10, '2024-10-24 12:58:57', '2024-10-24 12:58:57'),
(34, 47, 1, 10, '1', 10, '2024-10-24 13:00:19', '2024-10-24 13:00:19'),
(35, 47, 2, 10, '1', 10, '2024-10-24 13:00:19', '2024-10-24 13:00:19'),
(36, 48, 1, 10, '1', 10, '2024-10-24 13:29:16', '2024-10-24 13:29:16'),
(37, 48, 2, 10, '1', 10, '2024-10-24 13:29:16', '2024-10-24 13:29:16'),
(38, 49, 1, 10, '1', 10, '2024-10-24 13:35:13', '2024-10-24 13:35:13'),
(39, 49, 2, 10, '1', 10, '2024-10-24 13:35:13', '2024-10-24 13:35:13'),
(40, 50, 1, 10, '1', 10, '2024-10-24 14:11:45', '2024-10-24 14:11:45'),
(41, 50, 2, 10, '1', 10, '2024-10-24 14:11:45', '2024-10-24 14:11:45'),
(42, 56, 1, 10, '1', 10, '2024-10-24 14:40:57', '2024-10-24 14:40:57'),
(43, 56, 2, 10, '1', 10, '2024-10-24 14:40:57', '2024-10-24 14:40:57'),
(44, 57, 1, 10, '1', 10, '2024-10-25 13:05:12', '2024-10-25 13:05:12'),
(45, 57, 2, 10, '1', 10, '2024-10-25 13:05:12', '2024-10-25 13:05:12'),
(46, 58, 1, 10, '1', 10, '2024-10-25 13:06:42', '2024-10-25 13:06:42'),
(47, 58, 2, 10, '1', 10, '2024-10-25 13:06:42', '2024-10-25 13:06:42'),
(48, 59, 1, 10, '1', 10, '2024-10-27 16:11:06', '2024-10-27 16:11:06'),
(49, 59, 2, 10, '1', 10, '2024-10-27 16:11:06', '2024-10-27 16:11:06'),
(50, 60, 1, 10, '1', 10, '2024-10-27 16:15:50', '2024-10-27 16:15:50'),
(51, 60, 2, 10, '1', 10, '2024-10-27 16:15:50', '2024-10-27 16:15:50'),
(52, 61, 1, 10, '1', 10, '2024-10-27 16:25:31', '2024-10-27 16:25:31'),
(53, 61, 2, 10, '1', 10, '2024-10-27 16:25:31', '2024-10-27 16:25:31'),
(54, 62, 1, 10, '1', 10, '2024-10-27 16:26:08', '2024-10-27 16:26:08'),
(55, 62, 2, 10, '1', 10, '2024-10-27 16:26:08', '2024-10-27 16:26:08'),
(56, 63, 1, 10, '1', 10, '2024-10-27 16:30:54', '2024-10-27 16:30:54'),
(57, 63, 2, 10, '1', 10, '2024-10-27 16:30:54', '2024-10-27 16:30:54'),
(58, 66, 1, 10, '1', 10, '2024-10-27 16:36:42', '2024-10-27 16:36:42'),
(59, 66, 2, 10, '1', 10, '2024-10-27 16:36:42', '2024-10-27 16:36:42'),
(60, 68, 1, 10, '1', 10, '2024-10-27 16:40:29', '2024-10-27 16:40:29'),
(61, 68, 2, 10, '1', 10, '2024-10-27 16:40:29', '2024-10-27 16:40:29'),
(62, 69, 1, 10, '1', 10, '2024-10-27 16:42:20', '2024-10-27 16:42:20'),
(63, 69, 2, 10, '1', 10, '2024-10-27 16:42:20', '2024-10-27 16:42:20'),
(64, 70, 1, 10, '1', 10, '2024-10-27 16:43:47', '2024-10-27 16:43:47'),
(65, 70, 2, 10, '1', 10, '2024-10-27 16:43:47', '2024-10-27 16:43:47'),
(66, 71, 1, 10, '1', 10, '2024-10-27 16:45:05', '2024-10-27 16:45:05'),
(67, 71, 2, 10, '1', 10, '2024-10-27 16:45:05', '2024-10-27 16:45:05'),
(68, 72, 1, 10, '1', 10, '2024-10-27 16:45:49', '2024-10-27 16:45:49'),
(69, 72, 2, 10, '3', 40, '2024-10-27 16:45:49', '2024-10-27 16:45:49'),
(70, 73, 1, 10, '1', 10, '2024-10-27 16:46:14', '2024-10-27 16:46:14'),
(71, 73, 2, 10, '4', 40, '2024-10-27 16:46:14', '2024-10-27 16:46:14'),
(72, 74, 1, 10, '1', 10, '2024-10-27 17:30:42', '2024-10-27 17:30:42'),
(73, 74, 2, 10, '4', 40, '2024-10-27 17:30:42', '2024-10-27 17:30:42'),
(74, 75, 1, 10, '1', 10, '2024-10-27 17:34:34', '2024-10-27 17:34:34'),
(75, 75, 2, 10, '4', 40, '2024-10-27 17:34:34', '2024-10-27 17:34:34'),
(76, 76, 1, 10, '1', 10, '2024-10-27 17:34:41', '2024-10-27 17:34:41'),
(77, 76, 2, 10, '4', 40, '2024-10-27 17:34:41', '2024-10-27 17:34:41'),
(78, 77, 1, 10, '1', 10, '2024-10-27 17:49:48', '2024-10-27 17:49:48'),
(79, 77, 2, 10, '4', 40, '2024-10-27 17:49:48', '2024-10-27 17:49:48'),
(80, 82, 4, 2, '2', 5, '2024-10-27 22:42:12', '2024-10-27 22:42:12'),
(81, 88, 4, 1, '3', 20, '2024-10-29 14:43:19', '2024-10-29 14:43:19'),
(82, 92, 1, 10, '2', 100, '2024-10-30 16:13:03', '2024-10-30 16:13:03'),
(83, 93, 1, 10, '2', 20, '2024-10-30 16:22:30', '2024-10-30 16:22:30'),
(84, 94, 1, 10, '2', 20, '2024-10-30 16:24:05', '2024-10-30 16:24:05'),
(85, 95, 14, 2, '1', 4.6, '2024-10-31 21:04:52', '2024-10-31 21:04:52'),
(86, 97, 14, 1, '3', 10, '2024-11-01 14:26:43', '2024-11-01 14:26:43'),
(87, 99, 4, 1, '1', 2.3, '2024-11-01 17:19:49', '2024-11-01 17:19:49'),
(88, 100, 2, 1, '1', 2, '2024-11-01 20:04:12', '2024-11-01 20:04:12'),
(89, 100, 4, 1, '1', 2.3, '2024-11-01 20:04:12', '2024-11-01 20:04:12'),
(90, 100, 19, 1, '1', 2.3, '2024-11-01 20:04:12', '2024-11-01 20:04:12'),
(91, 101, 3, 1, '2', 2.5, '2024-11-01 20:19:31', '2024-11-01 20:19:31'),
(92, 101, 6, 1, '1', 2, '2024-11-01 20:19:31', '2024-11-01 20:19:31'),
(93, 102, 11, 1, '2', 2.5, '2024-11-01 20:24:39', '2024-11-01 20:24:39'),
(94, 102, 4, 1, '1', 2.3, '2024-11-01 20:24:39', '2024-11-01 20:24:39'),
(95, 104, 2, 1, '3', 3, '2024-11-01 21:53:45', '2024-11-01 21:53:45'),
(96, 104, 6, 1, '2', 2.5, '2024-11-01 21:53:45', '2024-11-01 21:53:45'),
(97, 104, 5, 1, '2', 2.5, '2024-11-01 21:53:45', '2024-11-01 21:53:45'),
(98, 104, 4, 1, '2', 2.5, '2024-11-01 21:53:45', '2024-11-01 21:53:45'),
(99, 104, 4, 1, '1', 2.3, '2024-11-01 21:53:45', '2024-11-01 21:53:45'),
(100, 105, 6, 1, '3', 1200, '2024-11-01 21:56:28', '2024-11-01 21:56:28'),
(101, 105, 4, 1, '4', 36, '2024-11-01 21:56:28', '2024-11-01 21:56:28'),
(102, 106, 6, 1, '3', 1200, '2024-11-01 22:08:00', '2024-11-01 22:08:00'),
(103, 107, 2, 1, '1', 2, '2024-11-01 22:11:43', '2024-11-01 22:11:43'),
(104, 107, 4, 1, '1', 2.3, '2024-11-01 22:11:43', '2024-11-01 22:11:43'),
(105, 107, 6, 1, '3', 1200, '2024-11-01 22:11:43', '2024-11-01 22:11:43'),
(106, 108, 5, 1, '4', 4, '2024-11-02 15:03:49', '2024-11-02 15:03:49'),
(107, 109, 5, 1, '4', 4, '2024-11-02 17:02:28', '2024-11-02 17:02:28'),
(108, 110, 5, 1, '1', 2.3, '2024-11-02 17:08:50', '2024-11-02 17:08:50'),
(109, 110, 5, 1, '2', 2.5, '2024-11-02 17:08:50', '2024-11-02 17:08:50'),
(110, 111, 2, 1, '3', 3, '2024-11-04 19:12:59', '2024-11-04 19:12:59'),
(111, 111, 5, 1, '1', 2.3, '2024-11-04 19:12:59', '2024-11-04 19:12:59'),
(112, 112, 5, 1, '1', 2.3, '2024-11-08 14:15:36', '2024-11-08 14:15:36'),
(113, 113, 11, 1, '2', 2.5, '2024-11-08 14:20:05', '2024-11-08 14:20:05'),
(114, 113, 5, 1, '2', 2.5, '2024-11-08 14:20:05', '2024-11-08 14:20:05'),
(115, 113, 6, 1, '3', 1200, '2024-11-08 14:20:05', '2024-11-08 14:20:05'),
(116, 114, 6, 1, '4', 1, '2024-11-08 14:22:25', '2024-11-08 14:22:25'),
(117, 115, 4, 1, '1', 2.3, '2024-11-08 15:10:05', '2024-11-08 15:10:05'),
(118, 115, 5, 1, '1', 2.3, '2024-11-08 15:10:05', '2024-11-08 15:10:05'),
(119, 115, 6, 1, '3', 1200, '2024-11-08 15:10:05', '2024-11-08 15:10:05'),
(120, 116, 4, 1, '4', 36, '2024-11-08 15:14:18', '2024-11-08 15:14:18'),
(121, 116, 5, 1, '4', 4, '2024-11-08 15:14:18', '2024-11-08 15:14:18'),
(122, 116, 6, 1, '3', 1200, '2024-11-08 15:14:18', '2024-11-08 15:14:18'),
(123, 120, 1, 1, '1', 9, '2024-11-17 20:33:45', '2024-11-17 20:33:45'),
(124, 120, 2, 1, '2', 2.3, '2024-11-17 20:33:45', '2024-11-17 20:33:45'),
(125, 120, 5, 1, '2', 2.5, '2024-11-17 20:33:45', '2024-11-17 20:33:45'),
(126, 120, 16, 1, '3', 10, '2024-11-17 20:33:45', '2024-11-17 20:33:45'),
(127, 121, 1, 7, '4', 28, '2024-11-17 21:40:36', '2024-11-17 21:40:36'),
(128, 121, 2, 45, '4', 135, '2024-11-17 21:40:36', '2024-11-17 21:40:36'),
(129, 122, 34, 1, '3', 2, '2024-11-19 15:25:57', '2024-11-19 15:25:57'),
(130, 122, 31, 2, '2', 4, '2024-11-19 15:25:57', '2024-11-19 15:25:57'),
(131, 122, 3, 6, '4', 60, '2024-11-19 15:25:57', '2024-11-19 15:25:57'),
(132, 124, 2, 1, '4', 3, '2024-11-19 15:41:55', '2024-11-19 15:41:55'),
(133, 124, 31, 1, '2', 2, '2024-11-19 15:41:55', '2024-11-19 15:41:55'),
(146, 139, 1, 2, '1', 18, '2024-11-22 01:35:14', '2024-11-22 01:35:14'),
(147, 139, 14, 1, '2', 2.5, '2024-11-22 01:35:14', '2024-11-22 01:35:14'),
(148, 145, 1, 3, '4', 12, '2024-11-23 20:47:42', '2024-11-23 20:47:42'),
(149, 145, 4, 1, '2', 2.5, '2024-11-23 20:47:42', '2024-11-23 20:47:42'),
(150, 145, 14, 3, '2', 7.5, '2024-11-23 20:47:42', '2024-11-23 20:47:42'),
(151, 146, 2, 2, '3', 6, '2024-12-28 12:31:11', '2024-12-28 12:31:11'),
(152, 146, 3, 1, '2', 2.5, '2024-12-28 12:31:11', '2024-12-28 12:31:11'),
(153, 147, 3, 10, '4', 100, '2024-12-28 12:36:14', '2024-12-28 12:36:14'),
(154, 148, 3, 10, '4', 100, '2024-12-28 12:36:54', '2024-12-28 12:36:54'),
(155, 149, 3, 10, '4', 100, '2024-12-28 12:40:06', '2024-12-28 12:40:06'),
(156, 155, 27, 2, '2', 300, '2024-12-28 13:43:51', '2024-12-28 13:43:51'),
(157, 156, 27, 2, '1', 160, '2024-12-28 13:45:33', '2024-12-28 13:45:33'),
(158, 160, 1, 10, '1', 90, '2024-12-28 14:40:38', '2024-12-28 14:40:38'),
(166, 168, 1, 25, '4', 100, '2024-12-31 12:57:49', '2024-12-31 12:57:49'),
(167, 170, 3, 17, '4', 170, '2024-12-31 14:01:33', '2024-12-31 14:01:33'),
(168, 171, 17, 11, '3', 110, '2025-01-07 15:09:30', '2025-01-07 15:09:30'),
(169, 172, 3, 5, '4', 50, '2025-01-07 16:38:18', '2025-01-07 16:38:18');

-- --------------------------------------------------------

--
-- Table structure for table `order_offers`
--

CREATE TABLE IF NOT EXISTS `order_offers` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `offer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `order_id` bigint(20) UNSIGNED DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `total_cost` double DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_offers`
--

INSERT INTO `order_offers` (`id`, `offer_id`, `order_id`, `quantity`, `total_cost`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 4, 32, 10, 100, NULL, '2024-08-02 11:59:43', '2024-08-02 12:00:31'),
(2, 4, 45, 1, 202, NULL, '2024-10-24 12:57:54', '2024-10-24 12:57:54'),
(3, 4, 46, 1, 202, NULL, '2024-10-24 12:58:57', '2024-10-24 12:58:57'),
(4, 4, 47, 1, 202, NULL, '2024-10-24 13:00:19', '2024-10-24 13:00:19'),
(5, 4, 48, 1, 202, NULL, '2024-10-24 13:29:16', '2024-10-24 13:29:16'),
(6, 4, 49, 1, 202, NULL, '2024-10-24 13:35:13', '2024-10-24 13:35:13'),
(7, 4, 50, 1, 202, NULL, '2024-10-24 14:11:45', '2024-10-24 14:11:45'),
(8, 4, 51, 1, 202, NULL, '2024-10-24 14:14:47', '2024-10-24 14:14:47'),
(9, 4, 52, 1, 202, NULL, '2024-10-24 14:15:05', '2024-10-24 14:15:05'),
(10, 4, 56, 1, 202, NULL, '2024-10-24 14:40:57', '2024-10-24 14:40:57'),
(11, 4, 57, 1, 202, NULL, '2024-10-25 13:05:12', '2024-10-25 13:05:12'),
(12, 4, 58, 1, 202, NULL, '2024-10-25 13:06:42', '2024-10-25 13:06:42'),
(13, 4, 59, 1, 202, NULL, '2024-10-27 16:11:06', '2024-10-27 16:11:06'),
(14, 4, 60, 1, 202, NULL, '2024-10-27 16:15:50', '2024-10-27 16:15:50'),
(15, 4, 61, 1, 202, NULL, '2024-10-27 16:25:31', '2024-10-27 16:25:31'),
(16, 4, 62, 1, 202, NULL, '2024-10-27 16:26:08', '2024-10-27 16:26:08'),
(17, 4, 63, 1, 202, NULL, '2024-10-27 16:30:54', '2024-10-27 16:30:54'),
(18, 4, 66, 1, 202, NULL, '2024-10-27 16:36:42', '2024-10-27 16:36:42'),
(20, 4, 68, 1, 202, NULL, '2024-10-27 16:40:29', '2024-10-27 16:40:29'),
(21, 4, 69, 1, 202, NULL, '2024-10-27 16:42:20', '2024-10-27 16:42:20'),
(22, 4, 70, 1, 202, NULL, '2024-10-27 16:43:47', '2024-10-27 16:43:47'),
(23, 4, 71, 1, 202, NULL, '2024-10-27 16:45:05', '2024-10-27 16:45:05'),
(24, 4, 72, 1, 202, NULL, '2024-10-27 16:45:49', '2024-10-27 16:45:49'),
(25, 4, 73, 1, 202, NULL, '2024-10-27 16:46:14', '2024-10-27 16:46:14'),
(26, 4, 74, 1, 202, NULL, '2024-10-27 17:30:42', '2024-10-27 17:30:42'),
(27, 4, 75, 1, 202, NULL, '2024-10-27 17:34:34', '2024-10-27 17:34:34'),
(28, 4, 76, 1, 202, NULL, '2024-10-27 17:34:41', '2024-10-27 17:34:41'),
(29, 4, 77, 1, 202, NULL, '2024-10-27 17:49:48', '2024-10-27 17:49:48'),
(30, 4, 78, 1, 202, NULL, '2024-10-27 17:52:08', '2024-10-27 17:52:08'),
(31, 4, 79, 1, 202, NULL, '2024-10-27 18:27:31', '2024-10-27 18:27:31'),
(32, 4, 80, 1, 202, NULL, '2024-10-27 19:25:07', '2024-10-27 19:25:07'),
(33, 6, 81, 2, 18.6, NULL, '2024-10-27 22:27:52', '2024-10-27 22:27:52'),
(35, 4, 91, 1, 202, NULL, '2024-10-30 11:18:16', '2024-10-31 17:30:20'),
(36, 6, 95, 3, 48.9, NULL, '2024-10-31 21:04:52', '2024-10-31 21:04:52'),
(37, 6, 97, 1, 16.3, NULL, '2024-11-01 14:26:43', '2024-11-01 14:26:43'),
(38, 7, 103, 1, 61, NULL, '2024-11-01 21:41:36', '2024-11-01 21:41:36'),
(39, 4, 104, 1, 43, NULL, '2024-11-01 21:53:45', '2024-11-01 21:53:45'),
(40, 7, 104, 4, 244, NULL, '2024-11-01 21:53:45', '2024-11-01 21:53:45'),
(41, 4, 107, 1, 43, NULL, '2024-11-01 22:11:43', '2024-11-01 22:11:43'),
(42, 4, 108, 1, 43, NULL, '2024-11-02 15:03:49', '2024-11-02 15:03:49'),
(43, 4, 109, 1, 43, NULL, '2024-11-02 17:02:28', '2024-11-02 17:02:28'),
(44, 6, 111, 1, 16.3, NULL, '2024-11-04 19:12:59', '2024-11-04 19:12:59'),
(45, 5, 111, 1, 30, NULL, '2024-11-04 19:12:59', '2024-11-04 19:12:59'),
(46, 5, 112, 2, 60, NULL, '2024-11-08 14:15:36', '2024-11-08 14:15:36'),
(47, 6, 113, 1, 16.3, NULL, '2024-11-08 14:20:05', '2024-11-08 14:20:05'),
(48, 36, 113, 1, 22, NULL, '2024-11-08 14:20:05', '2024-11-08 14:20:05'),
(49, 7, 113, 1, 61, NULL, '2024-11-08 14:20:05', '2024-11-08 14:20:05'),
(50, 7, 115, 1, 61, NULL, '2024-11-08 15:10:05', '2024-11-08 15:10:05'),
(51, 6, 116, 1, 16.3, NULL, '2024-11-08 15:14:18', '2024-11-08 15:14:18'),
(52, 7, 116, 1, 61, NULL, '2024-11-08 15:14:18', '2024-11-08 15:14:18'),
(53, 6, 117, 2, 32.6, NULL, '2024-11-16 18:31:59', '2024-11-16 18:31:59'),
(54, 5, 118, 11, 528, NULL, '2024-11-16 18:44:02', '2024-11-16 18:44:02'),
(55, 7, 118, 10, 637, NULL, '2024-11-16 18:44:02', '2024-11-16 18:44:02'),
(56, 5, 119, 1, 48, NULL, '2024-11-16 19:29:51', '2024-11-16 19:29:51'),
(57, 4, 124, 2, 87.8, NULL, '2024-11-19 15:41:55', '2024-11-19 15:41:55'),
(58, 4, 125, 3, 131.7, NULL, '2024-11-19 15:43:07', '2024-11-19 15:43:07'),
(59, 4, 126, 1, 43.9, NULL, '2024-11-19 15:45:01', '2024-11-19 15:45:01'),
(60, 4, 127, 1, 43.9, NULL, '2024-11-19 15:48:05', '2024-11-19 15:48:05'),
(67, 4, 139, 1, 43.9, NULL, '2024-11-22 01:35:14', '2024-11-22 01:35:14'),
(68, 4, 146, 1, 43.9, NULL, '2024-12-28 12:31:11', '2024-12-28 12:31:11'),
(69, 36, 146, 2, 44, NULL, '2024-12-28 12:31:11', '2024-12-28 12:31:11'),
(70, 4, 157, 3, 131.7, NULL, '2024-12-28 13:49:05', '2024-12-28 13:49:05'),
(71, 4, 158, 3, 131.7, NULL, '2024-12-28 13:49:35', '2024-12-28 13:49:35'),
(72, 5, 159, 2, 96, NULL, '2024-12-28 14:03:09', '2024-12-28 14:03:09'),
(73, 4, 169, 6, 263.4, NULL, '2024-12-31 13:45:03', '2024-12-31 13:45:03'),
(74, 4, 170, 1, 43.9, NULL, '2024-12-31 14:01:33', '2024-12-31 14:01:33'),
(75, 4, 173, 3, 131.7, NULL, '2025-01-07 16:43:45', '2025-01-07 16:43:45');

-- --------------------------------------------------------

--
-- Table structure for table `order_point_transfers`
--

CREATE TABLE IF NOT EXISTS `order_point_transfers` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` bigint(20) UNSIGNED NOT NULL,
  `points` int(11) NOT NULL,
  `transfer_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_deducted` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `customer_id` (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_point_transfers`
--

INSERT INTO `order_point_transfers` (`id`, `order_id`, `customer_id`, `points`, `transfer_date`, `is_deducted`, `created_at`, `updated_at`) VALUES
(3, 170, 51, 220, '2024-12-31 13:01:33', 1, '2024-12-31 14:01:33', '2024-12-31 14:52:12'),
(4, 171, 51, 110, '2025-01-07 14:09:30', 1, '2025-01-07 15:09:30', '2025-01-07 15:09:30');

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE IF NOT EXISTS `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `reset_password_tokens`
--

CREATE TABLE IF NOT EXISTS `reset_password_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `expired_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `reset_password_tokens`
--

INSERT INTO `reset_password_tokens` (`id`, `email`, `token`, `expired_at`, `created_at`, `updated_at`) VALUES
(25, 'eng.ahmedkamal357@gmail.com', '158ec3cc-5524-49b7-b187-df36c307b5b5', '2024-07-17 18:18:02', '2024-07-17 17:18:02', '2024-07-17 17:18:02');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE IF NOT EXISTS `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE IF NOT EXISTS `settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `tax` decimal(8,2) DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `phone1` varchar(20) DEFAULT NULL,
  `phone2` varchar(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `name`, `city`, `address`, `tax`, `logo`, `email`, `phone1`, `phone2`, `created_at`, `updated_at`) VALUES
(1, 'sam', 'eGYPT', 'test', 8.00, 'logo/1736673413.png', 'ebtesam132015@gmail.com', '201210626537', '201030621099', '2024-11-18 18:39:33', '2025-01-12 11:17:19');

-- --------------------------------------------------------

--
-- Table structure for table `system_balance`
--

CREATE TABLE IF NOT EXISTS `system_balance` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `balance` decimal(10,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `system_balance`
--

INSERT INTO `system_balance` (`id`, `balance`, `created_at`, `updated_at`) VALUES
(1, 84517.06, '2024-10-30 11:18:16', '2025-01-07 16:38:00');

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE IF NOT EXISTS `transactions` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `customer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `order_id` bigint(20) UNSIGNED DEFAULT NULL,
  `payment_method` enum('cashed','VisaMasterCard','Unpaid') DEFAULT 'Unpaid',
  `amount` double NOT NULL,
  `InvoiceId` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=143 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`id`, `customer_id`, `order_id`, `payment_method`, `amount`, `InvoiceId`, `created_at`, `updated_at`) VALUES
(1, 8, 5, 'cashed', 0, NULL, '2024-07-06 11:44:10', '2024-07-06 11:44:10'),
(2, 8, 6, 'cashed', 1640, NULL, '2024-07-06 11:48:17', '2024-07-06 11:48:17'),
(3, 8, 7, 'Unpaid', 1640, NULL, '2024-07-06 11:49:29', '2024-07-06 11:49:29'),
(4, 8, 8, 'Unpaid', 1640, NULL, '2024-07-06 11:55:54', '2024-07-06 11:55:54'),
(5, 8, 9, 'Unpaid', 1640, NULL, '2024-07-06 12:00:09', '2024-07-06 12:00:09'),
(6, 8, 10, 'Unpaid', 1640, NULL, '2024-07-06 12:48:11', '2024-07-06 12:48:11'),
(7, 8, 14, 'Unpaid', 1640, NULL, '2024-07-06 12:54:00', '2024-07-06 12:54:00'),
(8, 8, 15, 'VisaMasterCard', 1640, 4107361, '2024-07-06 12:54:52', '2024-07-06 13:21:56'),
(9, 8, 17, 'VisaMasterCard', 1640, 4107417, '2024-07-06 13:14:03', '2024-07-06 13:17:29'),
(10, 8, 18, 'Unpaid', 1640, 4107438, '2024-07-06 13:22:07', '2024-07-06 13:22:07'),
(11, 8, 19, 'VisaMasterCard', 1640, 4108981, '2024-07-07 06:12:04', '2024-07-07 06:12:52'),
(12, 8, 20, 'Unpaid', 1640, 4110626, '2024-07-07 17:01:57', '2024-07-07 17:01:57'),
(13, 8, 21, 'Unpaid', 1640, 4110632, '2024-07-07 17:14:39', '2024-07-07 17:14:39'),
(14, 8, 22, 'Unpaid', 1640, 4110643, '2024-07-07 17:38:29', '2024-07-07 17:38:29'),
(15, 8, 23, 'Unpaid', 1640, 4110644, '2024-07-07 17:38:34', '2024-07-07 17:38:34'),
(16, 8, 24, 'cashed', 8, NULL, '2024-07-08 05:47:21', '2024-07-08 05:47:21'),
(17, 8, 25, 'VisaMasterCard', 1, 4111801, '2024-07-08 05:51:01', '2024-07-08 05:51:50'),
(18, 8, 26, 'Unpaid', 1, 4111841, '2024-07-08 05:56:38', '2024-07-08 05:56:38'),
(19, 8, 27, 'Unpaid', 2, 4111846, '2024-07-08 05:57:25', '2024-07-08 05:57:25'),
(20, 8, 28, 'cashed', 8, NULL, '2024-07-08 08:55:16', '2024-07-08 08:55:16'),
(21, 8, 29, 'Unpaid', 7, 4112690, '2024-07-08 08:59:00', '2024-07-08 08:59:00'),
(22, 8, 30, 'Unpaid', 1, 4112697, '2024-07-08 09:00:21', '2024-07-08 09:00:21'),
(23, 51, 32, 'cashed', 1640, NULL, '2024-08-02 11:59:43', '2024-08-02 11:59:43'),
(24, 51, 33, 'cashed', 1640, NULL, '2024-08-06 20:05:34', '2024-08-06 20:05:34'),
(25, 51, 34, 'cashed', 1640, NULL, '2024-08-06 20:07:54', '2024-08-06 20:07:54'),
(26, 51, 35, 'Unpaid', 1640, 4250927, '2024-08-06 20:08:37', '2024-08-06 20:08:37'),
(27, 8, 42, 'cashed', 10, NULL, '2024-10-24 12:53:32', '2024-10-24 12:53:32'),
(28, 8, 45, 'cashed', 222, NULL, '2024-10-24 12:57:54', '2024-10-24 12:57:54'),
(29, 12, 46, 'cashed', 222, NULL, '2024-10-24 12:58:57', '2024-10-24 12:58:57'),
(30, 12, 47, 'cashed', 232, NULL, '2024-10-24 13:00:19', '2024-10-24 13:00:19'),
(31, 12, 48, 'cashed', 252, NULL, '2024-10-24 13:29:16', '2024-10-24 13:29:16'),
(32, 13, 49, 'cashed', 262, NULL, '2024-10-24 13:35:13', '2024-10-24 13:35:13'),
(33, 13, 50, 'cashed', 262, NULL, '2024-10-24 14:11:45', '2024-10-24 14:11:45'),
(34, 13, 51, 'cashed', 262, NULL, '2024-10-24 14:14:47', '2024-10-24 14:14:47'),
(35, 13, 52, 'cashed', 262, NULL, '2024-10-24 14:15:05', '2024-10-24 14:15:05'),
(36, 13, 53, 'cashed', 262, NULL, '2024-10-24 14:15:17', '2024-10-24 14:15:17'),
(37, 13, 54, 'cashed', 262, NULL, '2024-10-24 14:18:37', '2024-10-24 14:18:37'),
(38, 8, 55, 'cashed', 4, NULL, '2024-10-24 14:19:21', '2024-10-24 14:19:21'),
(39, 13, 56, 'cashed', 262, NULL, '2024-10-24 14:40:57', '2024-10-24 14:40:57'),
(40, 13, 57, 'cashed', 262, NULL, '2024-10-25 13:05:12', '2024-10-25 13:05:12'),
(41, 13, 58, 'cashed', 262, NULL, '2024-10-25 13:06:42', '2024-10-25 13:06:42'),
(42, 13, 59, 'cashed', 262.34, NULL, '2024-10-27 16:11:06', '2024-10-27 16:11:06'),
(43, 13, 60, 'cashed', 262.34, NULL, '2024-10-27 16:15:50', '2024-10-27 16:15:50'),
(44, 13, 61, 'cashed', 262.34, NULL, '2024-10-27 16:25:31', '2024-10-27 16:25:31'),
(45, 13, 62, 'cashed', 262.34, NULL, '2024-10-27 16:26:08', '2024-10-27 16:26:08'),
(46, 13, 63, 'cashed', 262.34, NULL, '2024-10-27 16:30:54', '2024-10-27 16:30:54'),
(47, 13, 66, 'cashed', 262.34, NULL, '2024-10-27 16:36:42', '2024-10-27 16:36:42'),
(48, 13, 68, 'cashed', 262.34, NULL, '2024-10-27 16:40:29', '2024-10-27 16:40:29'),
(49, 13, 69, 'cashed', 262.34, NULL, '2024-10-27 16:42:20', '2024-10-27 16:42:20'),
(50, 13, 70, 'cashed', 262.34, NULL, '2024-10-27 16:43:47', '2024-10-27 16:43:47'),
(51, 13, 71, 'cashed', 262.34, NULL, '2024-10-27 16:45:05', '2024-10-27 16:45:05'),
(52, 13, 72, 'cashed', 262.34, NULL, '2024-10-27 16:45:49', '2024-10-27 16:45:49'),
(53, 13, 73, 'cashed', 262.34, NULL, '2024-10-27 16:46:14', '2024-10-27 16:46:14'),
(54, 13, 74, 'cashed', 262.34, NULL, '2024-10-27 17:30:42', '2024-10-27 17:30:42'),
(55, 13, 75, 'cashed', 262.34, NULL, '2024-10-27 17:34:34', '2024-10-27 17:34:34'),
(56, 13, 76, 'cashed', 262.34, NULL, '2024-10-27 17:34:41', '2024-10-27 17:34:41'),
(57, 13, 77, 'cashed', 262.34, NULL, '2024-10-27 17:49:48', '2024-10-27 17:49:48'),
(58, 13, 78, 'cashed', 262.34, NULL, '2024-10-27 17:52:08', '2024-10-27 17:52:08'),
(59, 13, 79, 'cashed', 262.34, NULL, '2024-10-27 18:27:31', '2024-10-27 18:27:31'),
(60, 13, 80, 'cashed', 262.34, NULL, '2024-10-27 19:25:07', '2024-10-27 19:25:07'),
(61, 10, 81, 'cashed', 30.55, NULL, '2024-10-27 22:27:52', '2024-10-27 22:27:52'),
(62, 10, 82, 'cashed', 10.26, NULL, '2024-10-27 22:42:12', '2024-10-27 22:42:12'),
(63, 11, 83, 'cashed', 2.85, NULL, '2024-10-27 22:48:18', '2024-10-27 22:48:18'),
(64, 10, 84, 'cashed', 14.25, NULL, '2024-10-28 15:14:01', '2024-10-28 15:14:01'),
(65, 10, 85, 'cashed', 14.85, NULL, '2024-10-28 15:18:41', '2024-10-28 15:18:41'),
(66, 8, 86, 'cashed', 2.85, NULL, '2024-10-28 15:36:13', '2024-10-28 15:36:13'),
(67, 10, 87, 'cashed', 18.84, NULL, '2024-10-28 15:40:16', '2024-10-28 15:40:16'),
(68, 8, 88, 'cashed', 25.08, NULL, '2024-10-29 14:43:19', '2024-10-29 14:43:19'),
(70, 13, 90, 'cashed', 262.34, NULL, '2024-10-30 11:18:16', '2024-10-30 11:18:16'),
(71, 51, 91, 'cashed', 1640, NULL, '2024-10-30 11:22:34', '2024-10-30 11:22:34'),
(72, 51, 92, 'cashed', 1640, NULL, '2024-10-30 16:13:03', '2024-10-30 16:13:03'),
(73, 51, 93, 'cashed', 114, NULL, '2024-10-30 16:22:30', '2024-10-30 16:22:30'),
(74, 51, 94, 'cashed', 193.8, NULL, '2024-10-30 16:24:05', '2024-10-30 16:24:05'),
(75, 8, 95, 'cashed', 76.38, NULL, '2024-10-31 21:04:52', '2024-10-31 21:04:52'),
(76, 8, 96, 'cashed', 18.01, NULL, '2024-11-01 14:24:30', '2024-11-01 14:24:30'),
(77, 53, 97, 'cashed', 51.64, NULL, '2024-11-01 14:26:43', '2024-11-01 14:26:43'),
(78, 10, 98, 'cashed', 4.56, NULL, '2024-11-01 15:38:30', '2024-11-01 15:38:30'),
(79, 10, 99, 'cashed', 18.58, NULL, '2024-11-01 17:19:49', '2024-11-01 17:19:49'),
(80, 8, 100, 'cashed', 21.2, NULL, '2024-11-01 20:04:12', '2024-11-01 20:04:12'),
(81, 51, 101, 'cashed', 11.97, NULL, '2024-11-01 20:19:31', '2024-11-01 20:19:31'),
(82, 10, 102, 'cashed', 49.98, NULL, '2024-11-01 20:24:39', '2024-11-01 20:24:39'),
(83, 51, 103, 'cashed', 69.54, NULL, '2024-11-01 21:41:36', '2024-11-01 21:41:36'),
(84, 51, 104, 'cashed', 348.61, NULL, '2024-11-01 21:53:45', '2024-11-01 21:53:45'),
(85, 11, 105, 'cashed', 1411.32, NULL, '2024-11-01 21:56:28', '2024-11-01 21:56:28'),
(86, 51, 106, 'cashed', 1368, NULL, '2024-11-01 22:08:00', '2024-11-01 22:08:00'),
(87, 51, 107, 'cashed', 1421.92, NULL, '2024-11-01 22:11:43', '2024-11-01 22:11:43'),
(88, 10, 108, 'cashed', 64.87, NULL, '2024-11-02 15:03:49', '2024-11-02 15:03:49'),
(89, 51, 109, 'cashed', 60.31, NULL, '2024-11-02 17:02:28', '2024-11-02 17:02:28'),
(90, 51, 110, 'cashed', 10.03, NULL, '2024-11-02 17:08:50', '2024-11-02 17:08:50'),
(91, 51, 111, 'cashed', 70.11, NULL, '2024-11-04 19:12:59', '2024-11-04 19:12:59'),
(92, 51, 112, 'cashed', 95.87, NULL, '2024-11-08 14:15:36', '2024-11-08 14:15:36'),
(93, 55, 113, 'cashed', 1497.05, NULL, '2024-11-08 14:20:05', '2024-11-08 14:20:05'),
(94, 10, 114, 'cashed', 66.63, NULL, '2024-11-08 14:22:25', '2024-11-08 14:22:25'),
(95, 11, 115, 'cashed', 1452.82, NULL, '2024-11-08 15:10:05', '2024-11-08 15:10:05'),
(96, 10, 116, 'cashed', 1508.45, NULL, '2024-11-08 15:14:18', '2024-11-08 15:14:18'),
(97, 51, 117, 'cashed', 37.16, NULL, '2024-11-16 18:31:59', '2024-11-16 18:31:59'),
(98, 51, 118, 'cashed', 1372.76, NULL, '2024-11-16 18:44:02', '2024-11-16 18:44:02'),
(99, 8, 119, 'cashed', 50.16, NULL, '2024-11-16 19:29:51', '2024-11-16 19:29:51'),
(100, 51, 120, 'cashed', 40.58, NULL, '2024-11-17 20:33:45', '2024-11-17 20:33:45'),
(101, 58, 121, 'cashed', 190.95, NULL, '2024-11-17 21:40:36', '2024-11-17 21:40:36'),
(102, 51, 122, 'cashed', 1504.5, NULL, '2024-11-19 15:25:57', '2024-11-19 15:25:57'),
(103, 51, 123, 'cashed', 24600, NULL, '2024-11-19 15:29:36', '2024-11-19 15:29:36'),
(104, 51, 124, 'cashed', 1392, NULL, '2024-11-19 15:41:55', '2024-11-19 15:41:55'),
(105, 51, 125, 'cashed', 1975.5, NULL, '2024-11-19 15:43:07', '2024-11-19 15:43:07'),
(106, 51, 126, 'cashed', 658.5, NULL, '2024-11-19 15:45:01', '2024-11-19 15:45:01'),
(107, 51, 127, 'cashed', 47.41, NULL, '2024-11-19 15:48:05', '2024-11-19 15:48:05'),
(108, 51, 139, 'cashed', 86.94, NULL, '2024-11-22 01:35:14', '2024-11-22 01:35:14'),
(109, 51, 140, 'cashed', 9.8, NULL, '2024-11-22 22:05:20', '2024-11-22 22:05:20'),
(110, 51, 141, 'cashed', 9.8, NULL, '2024-11-22 22:09:47', '2024-11-22 22:09:47'),
(111, 51, 142, 'cashed', 10.4, NULL, '2024-11-22 22:10:39', '2024-11-22 22:10:39'),
(112, 51, 143, 'cashed', 98, NULL, '2024-11-22 22:19:38', '2024-11-22 22:19:38'),
(113, 51, 144, 'cashed', 108, NULL, '2024-11-22 22:22:12', '2024-11-22 22:22:12'),
(114, 51, 145, 'cashed', 41.9, NULL, '2024-11-23 20:47:42', '2024-11-23 20:47:42'),
(115, 51, 146, 'cashed', 108.32, NULL, '2024-12-28 12:31:11', '2024-12-28 12:31:11'),
(116, 51, 147, 'cashed', 108, NULL, '2024-12-28 12:36:14', '2024-12-28 12:36:14'),
(117, 51, 148, 'cashed', 108, NULL, '2024-12-28 12:36:54', '2024-12-28 12:36:54'),
(118, 51, 149, 'cashed', 108, NULL, '2024-12-28 12:40:06', '2024-12-28 12:40:06'),
(119, 11, 150, 'cashed', 21.6, NULL, '2024-12-28 13:22:24', '2024-12-28 13:22:24'),
(120, 8, 151, 'cashed', 10.8, NULL, '2024-12-28 13:24:29', '2024-12-28 13:24:29'),
(121, 52, 152, 'cashed', 10.8, NULL, '2024-12-28 13:27:57', '2024-12-28 13:27:57'),
(122, 11, 153, 'cashed', 10.8, NULL, '2024-12-28 13:35:01', '2024-12-28 13:35:01'),
(123, 11, 154, 'cashed', 10.8, NULL, '2024-12-28 13:42:21', '2024-12-28 13:42:21'),
(124, 51, 155, 'cashed', 324, NULL, '2024-12-28 13:43:51', '2024-12-28 13:43:51'),
(125, 51, 156, 'cashed', 172.8, NULL, '2024-12-28 13:45:33', '2024-12-28 13:45:33'),
(126, 51, 157, 'cashed', 142.24, NULL, '2024-12-28 13:49:05', '2024-12-28 13:49:05'),
(127, 51, 158, 'cashed', 132.24, NULL, '2024-12-28 13:49:35', '2024-12-28 13:49:35'),
(128, 52, 159, 'cashed', 129.08, NULL, '2024-12-28 14:03:09', '2024-12-28 14:03:09'),
(129, 51, 160, 'cashed', 103.4, NULL, '2024-12-28 14:40:38', '2024-12-28 14:40:38'),
(137, 51, 168, 'cashed', 98, NULL, '2024-12-31 12:57:49', '2024-12-31 12:57:49'),
(138, 51, 169, 'cashed', 264.47, NULL, '2024-12-31 13:45:03', '2024-12-31 13:45:03'),
(139, 51, 170, 'cashed', 247.89, NULL, '2024-12-31 14:01:33', '2024-12-31 14:01:33'),
(142, 51, 171, 'cashed', 107.8, NULL, '2025-01-07 15:19:17', '2025-01-07 15:19:17');

-- --------------------------------------------------------

--
-- Table structure for table `withdrawals`
--

CREATE TABLE IF NOT EXISTS `withdrawals` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `employee_id` bigint(20) UNSIGNED NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `withdrawals`
--

INSERT INTO `withdrawals` (`id`, `employee_id`, `amount`, `created_at`, `updated_at`) VALUES
(1, 1, 0.33, '2024-10-30 12:02:41', '2024-10-30 12:02:41'),
(2, 13, 0.33, '2024-10-30 12:03:08', '2024-10-30 12:03:08'),
(3, 1, 0.33, '2024-10-30 12:22:23', '2024-10-30 12:22:23'),
(4, 1, 11.00, '2024-10-30 12:37:13', '2024-10-30 12:37:13'),
(5, 1, 100.00, '2024-10-30 12:40:14', '2024-10-30 12:40:14'),
(6, 1, 100.00, '2024-10-30 12:40:44', '2024-10-30 12:40:44'),
(7, 1, 100.34, '2024-10-30 12:41:10', '2024-10-30 12:41:10'),
(8, 1, 100.34, '2024-10-30 12:41:22', '2024-10-30 12:41:22'),
(9, 1, 100.66, '2024-10-30 12:41:43', '2024-10-30 12:41:43'),
(10, 1, 341.00, '2024-10-30 12:42:01', '2024-10-30 12:42:01'),
(11, 13, 12.00, '2024-10-31 23:39:37', '2024-10-31 23:39:37'),
(12, 13, 2.00, '2024-10-31 23:40:51', '2024-10-31 23:40:51'),
(13, 13, 1.18, '2024-10-31 23:45:27', '2024-10-31 23:45:27'),
(14, 13, 0.50, '2024-10-31 23:45:49', '2024-10-31 23:45:49'),
(15, 13, 1.71, '2024-11-01 15:59:42', '2024-11-01 15:59:42'),
(16, 13, 1.78, '2024-11-01 20:07:45', '2024-11-01 20:07:45'),
(17, 13, 1.18, '2024-11-01 21:17:15', '2024-11-01 21:17:15'),
(18, 13, 60.00, '2024-11-16 18:51:47', '2024-11-16 18:51:47'),
(19, 13, 500.00, '2024-11-16 19:16:24', '2024-11-16 19:16:24'),
(20, 13, 1.64, '2025-01-06 11:12:43', '2025-01-06 11:12:43');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `customer_loyalty_points`
--
ALTER TABLE `customer_loyalty_points`
  ADD CONSTRAINT `customer_loyalty_points_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `order_point_transfers`
--
ALTER TABLE `order_point_transfers`
  ADD CONSTRAINT `order_point_transfers_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_point_transfers_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
