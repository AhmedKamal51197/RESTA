-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3307
-- Generation Time: Jul 06, 2024 at 08:49 PM
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
-- Database: `scan_food`
--

-- --------------------------------------------------------

--
-- Table structure for table `addons`
--

CREATE TABLE `addons` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `category_id` bigint(20) UNSIGNED DEFAULT NULL,
  `cost` double NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `type` enum('vegetarian','non-vegetarian') NOT NULL DEFAULT 'vegetarian',
  `image` varchar(255) NOT NULL,
  `status` tinyint(1) NOT NULL COMMENT 'true = active , false = inactive',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `addons`
--

INSERT INTO `addons` (`id`, `name`, `category_id`, `cost`, `description`, `type`, `image`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Ice Mocha', 13, 1.5, 'Dark, rich espresso lies in wait under a smoothed and stretched', 'vegetarian', 'addons/PemWoX8xkf87G6uGSk8aacAeWGaFJCDh7sU6xqpZ.jpg', 1, '2024-06-27 15:55:01', '2024-06-27 15:55:01'),
(2, 'Ice Latte', 13, 1.9, 'Dark, rich espresso lies in wait under a smoothed and stretched', 'vegetarian', 'addons/kA7Lamt634BThr9WoMi2Smoyd1D1fA6qMrTV0dDe.jpeg', 1, '2024-06-27 15:57:21', '2024-06-27 15:57:21'),
(3, 'Frappucccino', 13, 2, 'Dark, rich espresso lies in wait under a smoothed and stretched', 'vegetarian', 'addons/75ncLkEDDKcvTnSYJR2g0HlPpOLVJjN5EHEfIirT.jpg', 1, '2024-06-27 15:59:28', '2024-06-27 15:59:28'),
(4, 'Frabie', 13, 2.5, 'Dark, rich espresso lies in wait under a smoothed and stretched', 'vegetarian', 'addons/VM7gszVlfregI2RPuRj5DKxv4Kgc3OI9TWZMhxKF.jpg', 0, '2024-06-27 16:00:48', '2024-06-27 16:27:49'),
(5, 'Frabie test', 11, 2, 'Dark, rich espresso lies in wait under a smoothed and stretched', 'vegetarian', 'addons/UOY5bwchqgvaKF95eeL3iREW1pQjFwoyIgllE6Av.jpg', 1, '2024-06-27 16:05:11', '2024-06-27 16:05:11'),
(7, 'Frabie test\'s', 13, 2, 'Dark, rich espresso lies in wait under a smoothed and stretched', 'vegetarian', 'addons/DQSS6CQV7Im28ivyRwNrGdwYGvQD63uxYmnqWSA9.jpg', 1, '2024-06-27 16:26:57', '2024-06-27 16:26:57'),
(8, 'Cappuccino', 12, 2, 'Victorian Inn Mocha Hot Cappuccino 2 lb. Bag EACH', 'vegetarian', 'addons/QbOKgEjnxrDYOCofzoYqR18kjlf3HxQd4kE5D8mM.jpg', 1, '2024-06-27 17:19:29', '2024-06-27 17:19:29'),
(9, 'Cafe Latte', 12, 2.3, 'Victorian Inn Mocha Hot Cappuccino 2 lb. Bag EACH', 'vegetarian', 'addons/uhZn5hFaDqBnlfAVYcgv2vmgkuZdiBl6pbbkHLhV.jpg', 1, '2024-06-27 17:21:24', '2024-06-27 17:21:24'),
(10, 'Mohcha latte', 12, 2.3, 'Victorian Inn Mocha Hot Cappuccino 2 lb. Bag EACH', 'vegetarian', 'addons/CDrdW9ry8Va5Q0YGL40ry5ke7pe6ky6ueMICGxCL.jpg', 0, '2024-06-27 17:23:36', '2024-06-27 17:23:36'),
(11, 'Soda Can', 11, 1, 'Victorian Inn Mocha Hot Cappuccino 2 lb. Bag EACH', 'vegetarian', 'addons/8WygOThujOmQaqR9kU6mKk36LvBeJzjviLX34WPv.jpeg', 1, '2024-06-27 18:59:41', '2024-06-27 18:59:41'),
(12, 'Soda  Bottle', 11, 1, 'Victorian Inn Mocha Hot Cappuccino 2 lb. Bag EACH', 'vegetarian', 'addons/lbnuhNZ1rdeL7MncJj4HKxCco90BsfRQWPrHBjN4.jpg', 1, '2024-06-27 19:00:30', '2024-06-27 19:00:30');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `description`, `image`, `created_at`, `updated_at`) VALUES
(1, 'Appetizers', 'LMIV - Allergen - i). Contains cereals and products thereof containing gluten. ii). Wheat.', 'categories/dInkh8Sn08xidlcTCsVlbVLPT4XCkAam9wpJkENE.jpg', '2024-06-27 15:04:25', '2024-06-27 15:11:04'),
(2, 'Flame Grill Burgers', 'LMIV - Allergen - i). Contains cereals and products thereof containing gluten. ii). Wheat.', 'categories/8LtudJIK4Q7cBMefpVhh23eWbml0lMDnSx6xC2NG.jpg', '2024-06-27 15:13:33', '2024-06-27 15:13:33'),
(3, 'Veggie & Plant Based Burgers', 'LMIV - Allergen - i). Contains cereals and products thereof containing gluten. ii). Wheat.', 'categories/FzCnZiER3wsrUiz3YiojP22MyUf7BxgQ4qiDG8QA.jpg', '2024-06-27 15:16:35', '2024-06-27 15:16:35'),
(4, 'Sandwich From The Grill', 'Sweet and tangy BBQ Chicken Sandwiches made with juicy slow cooke..', 'categories/gqSc4lx53OhluEs4rYCWF2SFq7IQWhTd0xoD7otY.jpg', '2024-06-27 15:20:46', '2024-06-27 15:20:46'),
(5, 'Hot Chicken Entrees', 'Sweet and tangy BBQ Chicken Sandwiches made with juicy slow cooke..', 'categories/QLiH5PkZ3vJuow0ThKBOhzsYV688zQvCouKbKhkA.jpg', '2024-06-27 15:22:08', '2024-06-27 15:22:08'),
(6, 'Beef Entrees', 'Sweet and tangy BBQ Chicken Sandwiches made with juicy slow cooke..', 'categories/E5kONaoPh2IbGVpgMvHo8R4f2JylaK4VzgdUpzZS.jpg', '2024-06-27 15:23:56', '2024-06-27 15:23:56'),
(7, 'Seafood Entrees', 'Sweet and tangy BBQ Chicken Sandwiches made with juicy slow cooke..', 'categories/ipTXvwTpntym9Q11x1jsCt95QasLIApM8b9NeetC.jpg', '2024-06-27 15:24:51', '2024-06-27 15:24:51'),
(8, 'House Special Salads', 'Sweet and tangy BBQ Chicken Sandwiches made with juicy slow cooke..', 'categories/NhaZQ8A2rgj6yfMEbj63sFgOG40LQZPCH9Iy1NrS.jpg', '2024-06-27 15:26:01', '2024-06-27 15:26:01'),
(9, 'Zoop Soups', 'Sweet and tangy BBQ Chicken Sandwiches made with juicy slow cooke..', 'categories/jNwt7qtMEghKDdrY1NuCMfwZhEwsiiWslRsJzRVH.jpg', '2024-06-27 15:27:41', '2024-06-27 15:27:41'),
(10, 'Side Orders', 'Sweet and tangy BBQ Chicken Sandwiches made with juicy slow cooke..', 'categories/OMWxiTO9hfLcRqobASRscwcHrAqS1FOt5JPsfNwb.jpg', '2024-06-27 15:28:57', '2024-06-27 15:28:57'),
(11, 'Beverages', 'Sweet and tangy BBQ Chicken Sandwiches made with juicy slow cooke..', 'categories/x973C2Ckcx6DusN4xkqHj2LJRx4pt1rOJdWPd2pM.jpg', '2024-06-27 15:29:59', '2024-06-27 15:29:59'),
(12, 'Hot Drinks', 'Sweet and tangy BBQ Chicken Sandwiches made with juicy slow cooke..', 'categories/v4SNzZw1DPp0mbVYN4x3yYmQTYS74F8brWTxOiHE.jpg', '2024-06-27 15:31:28', '2024-06-27 17:16:13'),
(13, 'Iced Drinks', 'Sweet and tangy BBQ Chicken Sandwiches made with juicy slow cooke..', 'categories/xMiLSTD6wEDK4PL6SRy9yqUpKhI4DdIB9iZOqfcv.jpg', '2024-06-27 15:32:11', '2024-06-27 15:51:05');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT 'true = active , false =inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`id`, `name`, `email`, `phone`, `password`, `email_verified_at`, `status`, `created_at`, `updated_at`) VALUES
(8, 'ali', 'eng.ahmedkamal357@gmail.com', '010554488545', '$2y$10$vja59NgShDmQk07zbd6My.b5YGvQ/TKHBDPmrTV6PFvKKoIof9lS6', '2024-07-04 08:53:09', 1, '2024-06-04 15:26:32', '2024-06-13 12:35:39'),
(10, 'aahmed', 'sonbaty1937@gmail.com', '01066056996125', '$2y$10$55eWKYgsveJHBUZeoqWlyekVf7Zf7M0GMg38mwHPIXsNHeqS3wyNK', NULL, 0, '2024-06-04 15:31:48', '2024-06-04 15:31:48'),
(11, 'aahmed', 'sonbaty193s7@gmail.com', '01066056996125', '$2y$10$8BC3GLpdh81mXOVLCgfTae6vZRYsyANGAsOk2iZ1yDhbggbXIWnIq', NULL, 0, '2024-06-04 15:46:26', '2024-06-04 15:46:26'),
(12, 'aahmed', 'sonbaty193ds7@gmail.com', '01066056996125', '$2y$10$LARlU4WkG0fjJNGrCs/9eepg8nyBWWrp1x5MAGRoPFBglriPkrfse', NULL, 0, '2024-06-04 15:47:29', '2024-06-04 15:47:29'),
(13, 'aahmed', 'sonbatyx193ds7@gmail.com', '01066056996125', '$2y$10$gDtpuNtzQeJ7bLyGVNOSE.6IQj9/I.iVWtbE3ZujZK5tTOOGyGoDG', NULL, 0, '2024-06-04 15:51:47', '2024-06-04 15:51:47'),
(14, 'aahmed', 'sonbatyx193sds7@gmail.com', '01066056996125', '$2y$10$zGTCqCW6qrxHMEUUvPQiNeuKKRUVlYAWHCAkNovD8K/ugiP7ZZiTC', NULL, 0, '2024-06-04 15:54:06', '2024-06-04 15:54:06'),
(15, 'aahmed', 'sonbatyx1s93sds7@gmail.com', '01066056996125', '$2y$10$3dVeo.L3/oqiR/Bu/5GMw.sxFlzcPhyEKr3OJmHnMPfKNpPMWnPeG', NULL, 0, '2024-06-04 16:09:43', '2024-06-04 16:09:43'),
(16, 'aahmed', 'sonbatyx1s93sdss7@gmail.com', '01066056996125', '$2y$10$Zdj0V1fGtJ/rj6EggaGe2elOQSxJ/T/L5TpffBygxqP7Z8UVEeT4m', NULL, 0, '2024-06-04 16:14:58', '2024-06-04 16:14:58'),
(17, 'aahmed', 'son@gmail.com', '01066056996125', '$2y$10$e.kGGhWogKn0uQcnmsNXm.9Nw.0uNlw8GT.4Qq0CBWfkr/ozIhovW', NULL, 0, '2024-06-04 16:21:03', '2024-06-04 16:21:03'),
(18, 'aahmed', 'sons@gmail.com', '01066056996125', '$2y$10$gOUoJn0fmsmg6Vmm1QNPzOAZ9mapW9x4N7sIvZfzyaX04vHgOlZ9e', NULL, 0, '2024-06-04 16:24:55', '2024-06-04 16:24:55'),
(19, 'aahmed', 'sonss@gmail.com', '01066056996125', '$2y$10$jAlJe2Hss7wOFAoEJXYKSO2oZh8fQgDo4MDAUS9X27bLJYkXP.qWS', NULL, 0, '2024-06-04 16:30:44', '2024-06-04 16:30:44'),
(20, 'aahmed', 'sonsds@gmail.com', '01066056996125', '$2y$10$S8bN7.pBGzzNkan4BYiVdeuU6FRozP5ip/kw3j4ee.4.YmnoFijl2', NULL, 0, '2024-06-04 16:36:27', '2024-06-04 16:36:27'),
(21, 'aahmed', 'sosnsds@gmail.com', '01066056996125', '$2y$10$O3Yspbky67TUouvjbT3DgeZ/RXl4.V10yVC5n6mWOSO1//V6H48fa', NULL, 0, '2024-06-04 16:43:37', '2024-06-04 16:43:37'),
(22, 'aahmed', 'sosnsdds@gmail.com', '01066056996125', '$2y$10$d2dvnuWfyXp6mZMOXt/WC.UWJGzTh1fNqO.Vav7QOu1OyyexKCyei', NULL, 0, '2024-06-04 16:46:31', '2024-06-04 16:46:31'),
(23, 'aahmed', 'sosnpsdds@gmail.com', '01066056996125', '$2y$10$oY1elak1SeqT0jJzegqQpOVhLSjZkSAPu1pTF9eRjZjBsZI6PhC2i', NULL, 0, '2024-06-04 16:59:57', '2024-06-04 16:59:57'),
(24, 'aahmed', 'sosdnpsdds@gmail.com', '01066056996125', '$2y$10$bFPd8M4P0RSEl/F9ugn9f.A/C3BocQx5HovwRBh6gEvYuLT9NPqMC', NULL, 0, '2024-06-04 17:00:23', '2024-06-04 17:00:23'),
(25, 'aahmed', 'sosdnpsdsds@gmail.com', '01066056996125', '$2y$10$X58kwsaqseLBUQUm1IEAaeq80JFi0rD9S4Cp9Ma7lZUdcRABfBr1.', NULL, 0, '2024-06-04 17:03:05', '2024-06-04 17:03:05'),
(26, 'aahmed', 'sosdnpssdsds@gmail.com', '01066056996125', '$2y$10$mN/jQl091N/XOpNtzKte2OAU2GBkFx6v.nkmbz8VzBbYaKNnpa7Qu', NULL, 0, '2024-06-04 17:21:20', '2024-06-04 17:21:20'),
(27, 'aahmed', 'sosdnpssdssds@gmail.com', '01066056996125', '$2y$10$WWexRZbj.OtDj5H4JAG4ZuS1GOgGz5Y/7jbc102Vy6eg5Xm4OWEY.', NULL, 0, '2024-06-04 17:34:43', '2024-06-04 17:34:43'),
(28, 'aahmed', 'sosdnpssdsssds@gmail.com', '01066056996125', '$2y$10$zkLWYOaF7i61rA9YBqnFL.wUFw1brfYOFRhAS.gDNU3auBmFLFrwK', NULL, 0, '2024-06-04 17:38:12', '2024-06-04 17:38:12'),
(30, 'aahmed', 'eng.ahmedkamal3s57@gmail.com', '01066056996125', '$2y$10$TD31E4oBuPZLAwFmBnleZOHdjuQ1Vdzz6zoZhRvdtOcKrWdwqqepa', '2024-06-05 09:19:28', 0, '2024-06-04 17:50:11', '2024-06-05 09:19:28'),
(31, 'aahmed', '7e27d1fb76@emailcbox.pro', '01066056996125', '$2y$10$yZL8d4xjvmzyTNl/YHP8Ue0SnsU5cWwAaF0Uo/TDsJpu1A83H89Ja', NULL, 0, '2024-06-07 10:53:14', '2024-06-07 10:53:14'),
(32, 'aahmed', 'd3499f9a76@emailcbox.pro', '01066056996125', '$2y$10$bCkeuzEZuaSkAbm.NsqqNeCRd/.lSlRmPcWWYXmOI62g7vDZhK0CW', NULL, 0, '2024-06-07 12:39:35', '2024-06-07 12:39:35'),
(33, 'aahmed', 'e850f489a3@emailcbox.pro', '01066056996125', '$2y$10$dTVMqj8rv3nEkr3QkvaAiehfMWY.EEpWZEPfmVEDySzy4IffnnFRC', NULL, 0, '2024-06-07 12:45:41', '2024-06-07 12:45:41'),
(35, 'aahmed', 'asamtabrahym870@gmail.com', '01066056996125', '$2y$10$ZN0yySWuAjcDVKALsZVCxe/PJ7dJuqibYAVR2rCmYeQ6VkLyHBSpq', NULL, 0, '2024-06-08 10:35:06', '2024-06-08 10:35:06'),
(39, 'aahmed', 'mostafaesam300@gmail.com', '01066056996125', '$2y$10$6T2uJT/JrZy.TJaUvJAXR.m.jRG4Iggc7h4MAfwQ9QDhPV2CrbPFi', NULL, 0, '2024-06-08 12:29:41', '2024-06-08 12:29:41');

-- --------------------------------------------------------

--
-- Table structure for table `diningtables`
--

CREATE TABLE `diningtables` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `floor` int(11) NOT NULL,
  `size` int(11) NOT NULL,
  `num` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT 'true = active , false = inactive',
  `qr_code` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `diningtables`
--

INSERT INTO `diningtables` (`id`, `floor`, `size`, `num`, `status`, `qr_code`, `created_at`, `updated_at`) VALUES
(1, 1, 3, 1, 1, NULL, '2024-07-04 08:59:44', NULL),
(2, 2, 5, 1, 1, 'storage/qr_codes/qrcode_2_1720086538.png', '2024-07-04 06:48:58', '2024-07-04 06:48:58'),
(3, 2, 5, 2, 1, NULL, '2024-07-04 07:42:01', '2024-07-04 07:42:01'),
(4, 2, 5, 3, 1, NULL, '2024-07-04 07:44:51', '2024-07-04 07:44:51'),
(5, 2, 5, 4, 1, NULL, '2024-07-04 07:49:17', '2024-07-04 07:49:17');

-- --------------------------------------------------------

--
-- Table structure for table `email_verification_tokens`
--

CREATE TABLE `email_verification_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `expired_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
(55, 'eng.ahmedkamal357@gmail.com', '59d11e20-e198-4976-973e-2d12bef5818b', '2024-06-13 13:28:48', '2024-06-13 12:28:48', '2024-06-13 12:28:48');

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `Role` int(11) NOT NULL DEFAULT 3,
  `phone` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `identity_card` varchar(255) DEFAULT NULL,
  `status` tinyint(1) DEFAULT 1 COMMENT 'true = active  , false = inactive'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `employees`
--

INSERT INTO `employees` (`id`, `name`, `Role`, `phone`, `email`, `password`, `created_at`, `updated_at`, `identity_card`, `status`) VALUES
(1, 'hosam', 1, '01066056969', 'ahmed@gmail.com', '$2y$10$2WJkOKMdxs.nLhKNfkCmBucbsSwX1gFXRvbwMC7wcCnhBWB/9Kiwa', NULL, NULL, '22152554', 1),
(7, 'tarek', 2, '01021122115', 'tarek@gmail.com', '$2y$10$1PZ0R/Kh3hBOFy7iFVqpYuI7bBmnICu7rxkPNlk368zMKyXNa75.K', '2024-06-11 02:50:08', '2024-06-11 05:48:05', '12451548', 1),
(9, 'Ahmed Kamal', 1, '01021122115', 'ahmed.ka51197@gmail.com', '$2y$10$LEVSUBnxgFjWZCzgVkZ.z.tzGd8sC2OVhla5JZbqe1s2yBqemMneO', '2024-06-13 08:55:40', '2024-06-13 09:21:06', '12451559', 1),
(10, 'Rady', 1, '010211221', 'ahmed.ka5117@gmail.com', '$2y$10$h3NOVW5Axp0SuJaQEM2dre/RHmyMEnb840RnXYRbH5PCT5Xuap0Pu', '2024-06-28 09:47:09', '2024-06-28 09:47:09', '1245156', 1),
(11, 'RadyMohamed', 1, '010211221', 'rady.ka5117@gmail.com', '$2y$10$we2VZKcvK9Aog4njdr0Ae.LPKjTpr2vCXLA1mZdOloa5x5IDyj83a', '2024-06-28 09:49:16', '2024-06-28 09:49:16', '12451567', 1),
(12, 'asser', 1, '010211221', 'asser@gmail.com', '$2y$10$XGCw3yHy6ndWRvuia1Q6RuYnQz/vXrCA.RPEJgf0yBcDmylcslbiu', '2024-06-28 10:04:10', '2024-06-28 10:23:35', '12451554', 1);

-- --------------------------------------------------------

--
-- Table structure for table `extras`
--

CREATE TABLE `extras` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `category_id` bigint(20) UNSIGNED DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `type` enum('vegetarian','non-vegetarian') NOT NULL DEFAULT 'vegetarian',
  `cost` double NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `extras`
--

INSERT INTO `extras` (`id`, `name`, `category_id`, `description`, `image`, `status`, `type`, `cost`, `created_at`, `updated_at`) VALUES
(1, 'Onion Rings', 10, 'Serve with mayo and green chili sauce.', 'extras/3qZpDTa0ydMxZH6xOUdLZWw435M9gOAHN8JVSVOs.jpg', 1, 'vegetarian', 2, '2024-06-27 18:30:45', '2024-06-27 18:30:45'),
(2, 'Baked Potato', 10, 'Serve with mayo and green chili sauce.', 'extras/bLBI60Ki5i7mu0AeWLm0M0wAG0ytDsdvm8ln3ejw.jpg', 1, 'vegetarian', 2, '2024-06-27 18:33:21', '2024-06-27 18:33:21'),
(3, 'French Fries', 10, 'Serve with mayo and green chili sauce.', 'extras/cYKzBV8DWALLS6q2iWqcoOc249Qo6bTbmhlZbZWF.jpg', 1, 'vegetarian', 2, '2024-06-27 18:34:22', '2024-06-27 18:34:22'),
(4, 'Hot & Sour Soup', 9, 'Serve with mayo and green chili sauce.', 'extras/LzdnjThwlZqlNDwEeulrsJWFI1eYObkXqfhrHwfN.jpg', 1, 'vegetarian', 2, '2024-06-27 18:35:36', '2024-06-27 18:45:09'),
(5, 'Chicken Noodles Soup', 9, 'Serve with mayo and green chili sauce.', 'extras/pxBAzZAgM8XGVWb7N7v5BzxWR1YY7EZHYq36uX9M.jpg', 1, 'non-vegetarian', 2, '2024-06-27 18:36:49', '2024-06-27 18:45:14'),
(6, 'Wonton Soup', 9, 'Serve with mayo and green chili sauce.', 'extras/Gq9Lb00PBZqF7nq3qD0LDBL6e2QJanG0bSIwZKW8.jpg', 1, 'non-vegetarian', 2.3, '2024-06-27 18:37:40', '2024-06-27 18:45:19'),
(7, 'Fresh Tuna Salad', 8, 'Serve with mayo and green chili sauce.', 'extras/D3IqOBHrsJzknPxzXD8OG8QPrtzTAoMQB53jrpxW.jpg', 1, 'non-vegetarian', 4, '2024-06-27 18:38:35', '2024-06-27 18:44:08'),
(8, 'Roasted Salmon Salad', 8, 'Serve with mayo and green chili sauce.', 'extras/dkLJ21AVbxaXr7d98evbt0EmVVpC0b6Kz1EhPGvf.jpg', 1, 'non-vegetarian', 4, '2024-06-27 18:39:47', '2024-06-27 18:44:18'),
(9, 'Classic Caesar Salad', 8, 'Serve with mayo and green chili sauce.', 'extras/PZOgPSWs9feFQphepr8w8e6bA4uKATkX2tV6pqWF.jpg', 1, 'vegetarian', 1.2, '2024-06-27 18:40:59', '2024-06-27 18:40:59'),
(10, 'Poached Pear Salad', 8, 'Serve with mayo and green chili sauce.', 'extras/vE5KWi0CRpXI8VlFvtJxXw4YAj7omm9Anh4uLh2Y.jpeg', 1, 'vegetarian', 1.2, '2024-06-27 18:41:49', '2024-06-27 18:41:49');

-- --------------------------------------------------------

--
-- Table structure for table `meals`
--

CREATE TABLE `meals` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `type` enum('vegetarian','non-vegetarian') NOT NULL,
  `status` tinyint(1) NOT NULL COMMENT 'true = active , flase = inactive',
  `image` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `meals`
--

INSERT INTO `meals` (`id`, `category_id`, `name`, `description`, `type`, `status`, `image`, `created_at`, `updated_at`) VALUES
(1, 1, 'Chicken Dumplings', 'With a side of fried rice or supreme soy noodles, and steamed', 'vegetarian', 1, 'meals/yrz6APSccLVQu2yFcw7bx44CUmib9vs8YpIlyDVW.jpeg', '2024-06-27 16:43:27', '2024-06-27 16:43:27'),
(2, 1, 'Vegetable Dumplings', 'With a side of fried rice or supreme soy noodles, and steamed', 'non-vegetarian', 1, 'meals/d7LUdwRQv3CjKoM1HsKG8lF14W2enug8rC4JXQIY.jpg', '2024-06-27 16:47:19', '2024-06-27 16:47:19'),
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
(15, 5, 'Kung Pao Chicken', 'With a side of fried rice or supreme soy noodles, and steamed', 'non-vegetarian', 1, 'meals/0vceb3p0pNd3eyBrc6N29aTr37KrL3I6GD2ZEbux.jpg', '2024-06-27 17:43:53', '2024-06-27 17:43:53'),
(16, 6, 'Beef With Broccoli', 'With a side of fried rice or supreme soy noodles, and steamed', 'non-vegetarian', 1, 'meals/hnIlwMCd2fatSDgTsCRNJCI57xKlarSq1jQ0NW0w.jpg', '2024-06-27 17:47:08', '2024-06-27 17:47:08'),
(17, 6, 'Szechuan Beef', 'With a side of fried rice or supreme soy noodles, and steamed', 'non-vegetarian', 1, 'meals/4ONHgzP0ObJsjlT0dJAhRRNnQJb3vgRUPEDJ0oi6.jpg', '2024-06-27 17:47:21', '2024-06-27 17:47:21'),
(18, 7, 'Kung Pao Squid', 'With a side of fried rice or supreme soy noodles, and steamed', 'non-vegetarian', 1, 'meals/xpLBiweObuuH77mt9ci0icl1FcdMOdPKUgrct4fq.jpeg', '2024-06-27 17:49:22', '2024-06-27 17:49:22'),
(19, 7, 'Shrimp With Broccoli', 'With a side of fried rice or supreme soy noodles, and steamed', 'non-vegetarian', 1, 'meals/ZNfUR6sALsHsCUAHE2bs4T8C0a4jaAJlOmgymUvw.jpeg', '2024-06-27 17:50:15', '2024-06-27 17:50:15');

-- --------------------------------------------------------

--
-- Table structure for table `meals_size_cost`
--

CREATE TABLE `meals_size_cost` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `meal_id` bigint(20) UNSIGNED NOT NULL,
  `size` int(11) DEFAULT NULL COMMENT '1=SMALL, 2=Medium, 3=BIG, 4=FAMILY',
  `cost` double NOT NULL,
  `number_of_pieces` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `meals_size_cost`
--

INSERT INTO `meals_size_cost` (`id`, `meal_id`, `size`, `cost`, `number_of_pieces`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 2, 6, '2024-06-27 16:43:27', '2024-06-27 16:43:27'),
(2, 1, 2, 2.5, 8, '2024-06-27 16:43:27', '2024-06-27 16:43:27'),
(3, 1, 3, 3, 10, '2024-06-27 16:43:27', '2024-06-27 16:43:27'),
(4, 2, 1, 2, 4, '2024-06-27 16:47:19', '2024-06-27 16:47:19'),
(5, 2, 2, 2.5, 6, '2024-06-27 16:47:19', '2024-06-27 16:47:19'),
(6, 2, 3, 3, 8, '2024-06-27 16:47:19', '2024-06-27 16:47:19'),
(7, 3, 1, 2.3, 6, '2024-06-27 16:53:11', '2024-06-27 16:53:11'),
(8, 3, 2, 2.5, 8, '2024-06-27 16:53:11', '2024-06-27 16:53:11'),
(9, 3, 3, 10, 3, '2024-06-27 16:53:11', '2024-06-27 16:53:11'),
(10, 4, 1, 2.3, NULL, '2024-06-27 17:27:45', '2024-06-27 17:27:45'),
(11, 4, 2, 2.5, NULL, '2024-06-27 17:27:45', '2024-06-27 17:27:45'),
(12, 4, 3, 10, NULL, '2024-06-27 17:27:45', '2024-06-27 17:27:45'),
(13, 5, 1, 2.3, NULL, '2024-06-27 17:28:24', '2024-06-27 17:28:24'),
(14, 5, 2, 2.5, NULL, '2024-06-27 17:28:24', '2024-06-27 17:28:24'),
(15, 6, 1, 2.3, NULL, '2024-06-27 17:28:41', '2024-06-27 17:28:41'),
(16, 6, 2, 2.5, NULL, '2024-06-27 17:28:41', '2024-06-27 17:28:41'),
(17, 7, 1, 2.3, NULL, '2024-06-27 17:28:56', '2024-06-27 17:28:56'),
(18, 7, 2, 2.5, NULL, '2024-06-27 17:28:56', '2024-06-27 17:28:56'),
(19, 8, 1, 2.3, NULL, '2024-06-27 17:29:18', '2024-06-27 17:29:18'),
(20, 8, 2, 2.5, NULL, '2024-06-27 17:29:18', '2024-06-27 17:29:18'),
(21, 9, 1, 2.3, NULL, '2024-06-27 17:32:08', '2024-06-27 17:32:08'),
(22, 9, 2, 2.5, NULL, '2024-06-27 17:32:08', '2024-06-27 17:32:08'),
(23, 10, 1, 2.3, NULL, '2024-06-27 17:32:25', '2024-06-27 17:32:25'),
(24, 10, 2, 2.5, NULL, '2024-06-27 17:32:25', '2024-06-27 17:32:25'),
(25, 11, 1, 2.3, NULL, '2024-06-27 17:33:15', '2024-06-27 17:33:15'),
(26, 11, 2, 2.5, NULL, '2024-06-27 17:33:15', '2024-06-27 17:33:15'),
(27, 12, 1, 2.3, NULL, '2024-06-27 17:38:02', '2024-06-27 17:38:02'),
(28, 12, 2, 2.5, NULL, '2024-06-27 17:38:02', '2024-06-27 17:38:02'),
(29, 13, 1, 2.3, NULL, '2024-06-27 17:38:22', '2024-06-27 17:38:22'),
(30, 13, 2, 2.5, NULL, '2024-06-27 17:38:22', '2024-06-27 17:38:22'),
(31, 14, 1, 2.3, 6, '2024-06-27 17:43:20', '2024-06-27 17:43:20'),
(32, 14, 2, 2.5, 8, '2024-06-27 17:43:20', '2024-06-27 17:43:20'),
(33, 14, 3, 10, 3, '2024-06-27 17:43:20', '2024-06-27 17:43:20'),
(34, 15, 1, 2.3, 6, '2024-06-27 17:43:53', '2024-06-27 17:43:53'),
(35, 15, 2, 2.5, 8, '2024-06-27 17:43:53', '2024-06-27 17:43:53'),
(36, 15, 3, 10, 3, '2024-06-27 17:43:53', '2024-06-27 17:43:53'),
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
(48, 19, 3, 10, 3, '2024-06-27 17:50:15', '2024-06-27 17:50:15');

-- --------------------------------------------------------

--
-- Table structure for table `meal_extras`
--

CREATE TABLE `meal_extras` (
  `meal_id` bigint(20) UNSIGNED NOT NULL,
  `extra_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `meal_extras`
--

INSERT INTO `meal_extras` (`meal_id`, `extra_id`, `created_at`, `updated_at`) VALUES
(4, 2, '2024-06-27 21:50:40', '2024-06-27 21:50:40'),
(9, 1, '2024-06-27 21:51:42', '2024-06-27 21:51:42'),
(12, 4, '2024-06-27 21:51:07', '2024-06-27 21:51:07');

-- --------------------------------------------------------

--
-- Table structure for table `meal_with_addons`
--

CREATE TABLE `meal_with_addons` (
  `meal_id` bigint(20) UNSIGNED NOT NULL,
  `addon_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `meal_with_addons`
--

INSERT INTO `meal_with_addons` (`meal_id`, `addon_id`, `created_at`, `updated_at`) VALUES
(1, 2, NULL, NULL),
(8, 4, NULL, NULL),
(14, 4, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` bigint(20) UNSIGNED NOT NULL,
  `DiningTable_id` bigint(20) UNSIGNED DEFAULT NULL,
  `location_id` bigint(20) UNSIGNED DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 1 COMMENT '1 => processing 2=>out of delivery,3=>done\r\n4=>canceled\r\n',
  `notes` varchar(255) DEFAULT NULL,
  `total_cost` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `PaymentType` enum('online','cashed','Not Paid') NOT NULL DEFAULT 'Not Paid'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `customer_id`, `DiningTable_id`, `location_id`, `status`, `notes`, `total_cost`, `created_at`, `updated_at`, `PaymentType`) VALUES
(1, 8, 1, NULL, 1, NULL, 1640, '2024-07-04 06:00:10', '2024-07-04 06:00:10', 'Not Paid'),
(2, 8, 1, NULL, 1, NULL, 1640, '2024-07-06 11:40:47', '2024-07-06 11:40:47', 'Not Paid'),
(3, 8, 1, NULL, 1, NULL, 1640, '2024-07-06 11:43:00', '2024-07-06 11:43:00', 'Not Paid'),
(4, 8, 1, NULL, 1, NULL, 1640, '2024-07-06 11:43:20', '2024-07-06 11:43:20', 'Not Paid'),
(5, 8, 1, NULL, 1, NULL, 1640, '2024-07-06 11:44:10', '2024-07-06 11:44:10', 'Not Paid'),
(6, 8, 1, NULL, 1, NULL, 1640, '2024-07-06 11:48:17', '2024-07-06 11:48:17', 'Not Paid'),
(7, 8, 1, NULL, 1, NULL, 1640, '2024-07-06 11:49:29', '2024-07-06 11:49:29', 'Not Paid'),
(8, 8, 1, NULL, 1, NULL, 1640, '2024-07-06 11:55:54', '2024-07-06 11:55:54', 'Not Paid'),
(9, 8, 1, NULL, 1, NULL, 1640, '2024-07-06 12:00:09', '2024-07-06 12:00:09', 'Not Paid'),
(10, 8, 1, NULL, 1, NULL, 1640, '2024-07-06 12:48:11', '2024-07-06 12:48:11', 'Not Paid'),
(11, 8, 1, NULL, 1, NULL, 1640, '2024-07-06 12:52:51', '2024-07-06 12:52:51', 'Not Paid'),
(12, 8, 1, NULL, 1, NULL, 1640, '2024-07-06 12:53:08', '2024-07-06 12:53:08', 'Not Paid'),
(13, 8, 1, NULL, 1, NULL, 1640, '2024-07-06 12:53:32', '2024-07-06 12:53:32', 'Not Paid'),
(14, 8, 1, NULL, 1, NULL, 1640, '2024-07-06 12:54:00', '2024-07-06 12:54:00', 'Not Paid'),
(15, 8, 1, NULL, 1, NULL, 1640, '2024-07-06 12:54:52', '2024-07-06 12:54:52', 'Not Paid'),
(16, 8, 1, NULL, 1, NULL, 1640, '2024-07-06 13:13:26', '2024-07-06 13:13:26', 'Not Paid'),
(17, 8, 1, NULL, 1, NULL, 1640, '2024-07-06 13:14:02', '2024-07-06 13:14:02', 'Not Paid'),
(18, 8, 1, NULL, 1, NULL, 1640, '2024-07-06 13:22:06', '2024-07-06 13:22:06', 'Not Paid');

-- --------------------------------------------------------

--
-- Table structure for table `order_addons`
--

CREATE TABLE `order_addons` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED DEFAULT NULL,
  `addon_id` bigint(20) UNSIGNED DEFAULT NULL,
  `total_cost` double NOT NULL,
  `quantity` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
(36, 18, 2, 240, 10, '2024-07-06 13:22:06', '2024-07-06 13:22:06');

-- --------------------------------------------------------

--
-- Table structure for table `order_extras`
--

CREATE TABLE `order_extras` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `extra_id` bigint(20) UNSIGNED DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `total_cost` double NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
(18, 18, 1, 10, 150, '2024-07-06 13:22:06', '2024-07-06 13:22:06');

-- --------------------------------------------------------

--
-- Table structure for table `order_locations`
--

CREATE TABLE `order_locations` (
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

CREATE TABLE `order_meals` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `meal_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` int(11) NOT NULL,
  `total_cost` double NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `order_meals`
--

INSERT INTO `order_meals` (`id`, `order_id`, `meal_id`, `quantity`, `total_cost`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 10, 1050, '2024-07-04 06:00:10', '2024-07-04 06:00:10'),
(2, 2, 1, 10, 1050, '2024-07-06 11:40:47', '2024-07-06 11:40:47'),
(3, 3, 1, 10, 1050, '2024-07-06 11:43:00', '2024-07-06 11:43:00'),
(4, 4, 1, 10, 1050, '2024-07-06 11:43:20', '2024-07-06 11:43:20'),
(5, 5, 1, 10, 1050, '2024-07-06 11:44:10', '2024-07-06 11:44:10'),
(6, 6, 1, 10, 1050, '2024-07-06 11:48:17', '2024-07-06 11:48:17'),
(7, 7, 1, 10, 1050, '2024-07-06 11:49:29', '2024-07-06 11:49:29'),
(8, 8, 1, 10, 1050, '2024-07-06 11:55:54', '2024-07-06 11:55:54'),
(9, 9, 1, 10, 1050, '2024-07-06 12:00:09', '2024-07-06 12:00:09'),
(10, 10, 1, 10, 1050, '2024-07-06 12:48:11', '2024-07-06 12:48:11'),
(11, 11, 1, 10, 1050, '2024-07-06 12:52:51', '2024-07-06 12:52:51'),
(12, 12, 1, 10, 1050, '2024-07-06 12:53:08', '2024-07-06 12:53:08'),
(13, 13, 1, 10, 1050, '2024-07-06 12:53:32', '2024-07-06 12:53:32'),
(14, 14, 1, 10, 1050, '2024-07-06 12:54:00', '2024-07-06 12:54:00'),
(15, 15, 1, 10, 1050, '2024-07-06 12:54:52', '2024-07-06 12:54:52'),
(16, 16, 1, 10, 1050, '2024-07-06 13:13:26', '2024-07-06 13:13:26'),
(17, 17, 1, 10, 1050, '2024-07-06 13:14:02', '2024-07-06 13:14:02'),
(18, 18, 1, 10, 1050, '2024-07-06 13:22:06', '2024-07-06 13:22:06');

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `reset_password_tokens`
--

CREATE TABLE `reset_password_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `expired_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `reset_password_tokens`
--

INSERT INTO `reset_password_tokens` (`id`, `email`, `token`, `expired_at`, `created_at`, `updated_at`) VALUES
(20, 'eng.ahmedkamal357@gmail.com', 'bb4eb670-d06c-40ea-83df-fdcb955a187d', '2024-06-13 13:25:22', '2024-06-13 12:25:22', '2024-06-13 12:25:22');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `order_id` bigint(20) UNSIGNED DEFAULT NULL,
  `payment_method` enum('cashed','VisaMasterCard','Unpaid') DEFAULT 'Unpaid',
  `amount` double NOT NULL,
  `InvoiceId` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
(10, 8, 18, 'Unpaid', 1640, 4107438, '2024-07-06 13:22:07', '2024-07-06 13:22:07');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `addons`
--
ALTER TABLE `addons`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `diningtables`
--
ALTER TABLE `diningtables`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `diningtables_floor_num_unique` (`floor`,`num`);

--
-- Indexes for table `email_verification_tokens`
--
ALTER TABLE `email_verification_tokens`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `employees_email_unique` (`email`),
  ADD UNIQUE KEY `identity_card` (`identity_card`);

--
-- Indexes for table `extras`
--
ALTER TABLE `extras`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `meals`
--
ALTER TABLE `meals`
  ADD PRIMARY KEY (`id`),
  ADD KEY `meals_category_id_foreign` (`category_id`);

--
-- Indexes for table `meals_size_cost`
--
ALTER TABLE `meals_size_cost`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`),
  ADD UNIQUE KEY `unique_index` (`meal_id`,`cost`,`size`,`number_of_pieces`),
  ADD KEY `meal_id` (`meal_id`);

--
-- Indexes for table `meal_extras`
--
ALTER TABLE `meal_extras`
  ADD PRIMARY KEY (`meal_id`,`extra_id`),
  ADD KEY `extra_id` (`extra_id`);

--
-- Indexes for table `meal_with_addons`
--
ALTER TABLE `meal_with_addons`
  ADD PRIMARY KEY (`meal_id`,`addon_id`),
  ADD KEY `meal_with_addons_addon_id_foreign` (`addon_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `orders_customer_id_foreign` (`customer_id`),
  ADD KEY `orders_diningtable_id_foreign` (`DiningTable_id`),
  ADD KEY `location_id` (`location_id`);

--
-- Indexes for table `order_addons`
--
ALTER TABLE `order_addons`
  ADD PRIMARY KEY (`id`),
  ADD KEY `addon_id` (`addon_id`),
  ADD KEY `order_id` (`order_id`);

--
-- Indexes for table `order_extras`
--
ALTER TABLE `order_extras`
  ADD PRIMARY KEY (`id`),
  ADD KEY `extra_id` (`extra_id`),
  ADD KEY `order_id` (`order_id`);

--
-- Indexes for table `order_locations`
--
ALTER TABLE `order_locations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `customer_id` (`customer_id`);

--
-- Indexes for table `order_meals`
--
ALTER TABLE `order_meals`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_meals_order_id_foreign` (`order_id`),
  ADD KEY `meal_id` (`meal_id`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `reset_password_tokens`
--
ALTER TABLE `reset_password_tokens`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `order_id` (`order_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `addons`
--
ALTER TABLE `addons`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `diningtables`
--
ALTER TABLE `diningtables`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `email_verification_tokens`
--
ALTER TABLE `email_verification_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `extras`
--
ALTER TABLE `extras`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `meals`
--
ALTER TABLE `meals`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `meals_size_cost`
--
ALTER TABLE `meals_size_cost`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `order_addons`
--
ALTER TABLE `order_addons`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `order_extras`
--
ALTER TABLE `order_extras`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `order_locations`
--
ALTER TABLE `order_locations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `order_meals`
--
ALTER TABLE `order_meals`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `reset_password_tokens`
--
ALTER TABLE `reset_password_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `addons`
--
ALTER TABLE `addons`
  ADD CONSTRAINT `addons_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `extras`
--
ALTER TABLE `extras`
  ADD CONSTRAINT `extras_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `meals`
--
ALTER TABLE `meals`
  ADD CONSTRAINT `meals_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `meal_extras`
--
ALTER TABLE `meal_extras`
  ADD CONSTRAINT `meal_extras_ibfk_1` FOREIGN KEY (`meal_id`) REFERENCES `meals` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `meal_extras_ibfk_2` FOREIGN KEY (`extra_id`) REFERENCES `extras` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `meal_with_addons`
--
ALTER TABLE `meal_with_addons`
  ADD CONSTRAINT `meal_with_addons_addon_id_foreign` FOREIGN KEY (`addon_id`) REFERENCES `addons` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `meal_with_addons_meal_id_foreign` FOREIGN KEY (`meal_id`) REFERENCES `meals` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `orders_diningtable_id_foreign` FOREIGN KEY (`DiningTable_id`) REFERENCES `diningtables` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`location_id`) REFERENCES `order_locations` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `order_addons`
--
ALTER TABLE `order_addons`
  ADD CONSTRAINT `order_addons_ibfk_1` FOREIGN KEY (`addon_id`) REFERENCES `addons` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_addons_ibfk_2` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `order_extras`
--
ALTER TABLE `order_extras`
  ADD CONSTRAINT `order_extras_ibfk_1` FOREIGN KEY (`extra_id`) REFERENCES `extras` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_extras_ibfk_2` FOREIGN KEY (`extra_id`) REFERENCES `extras` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `order_extras_ibfk_3` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `order_locations`
--
ALTER TABLE `order_locations`
  ADD CONSTRAINT `order_locations_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `order_meals`
--
ALTER TABLE `order_meals`
  ADD CONSTRAINT `order_meals_ibfk_1` FOREIGN KEY (`meal_id`) REFERENCES `meals` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_meals_meal_id_foreign` FOREIGN KEY (`meal_id`) REFERENCES `meals` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `order_meals_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`),
  ADD CONSTRAINT `transactions_ibfk_2` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
