-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3307
-- Generation Time: Jun 09, 2024 at 10:31 AM
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
-- Database: `restaurant`
--

-- --------------------------------------------------------

--
-- Table structure for table `addons`
--

CREATE TABLE `addons` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `cost` double NOT NULL,
  `size` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
(1, 'Test', 'test_description', NULL, '2024-06-06 10:51:59', '2024-06-06 10:51:59'),
(2, 'Test2', 'test_description', NULL, '2024-06-06 10:55:17', '2024-06-06 10:55:17'),
(3, 'Checken', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s', NULL, '2024-06-06 12:24:05', '2024-06-06 12:24:05'),
(4, 'Pizza', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s', NULL, '2024-06-06 12:24:43', '2024-06-06 12:24:43'),
(5, 'Burger', 'update description', NULL, '2024-06-06 12:24:58', '2024-06-06 12:28:53'),
(7, 'soup', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s', NULL, '2024-06-06 12:25:56', '2024-06-06 12:25:56');

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
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`id`, `name`, `email`, `phone`, `password`, `email_verified_at`, `created_at`, `updated_at`) VALUES
(8, 'aahmed', 'ahmed@gmail.com', '01066056996125', '$2y$10$8CNqzAd0J7o/dwv4dGx8meW1GhHizi4hYWd6gflMbvlK7VrTE5/EW', NULL, '2024-06-04 15:26:32', '2024-06-04 15:26:32'),
(9, 'aahmed', 'ahmed@gmail.com', '01066056996125', '$2y$10$7.QR22xM1oC8lpAV5923veAWP21hwZrskelqXUdmd/EsAvVJmYp1u', NULL, '2024-06-04 15:31:22', '2024-06-04 15:31:22'),
(10, 'aahmed', 'sonbaty1937@gmail.com', '01066056996125', '$2y$10$55eWKYgsveJHBUZeoqWlyekVf7Zf7M0GMg38mwHPIXsNHeqS3wyNK', NULL, '2024-06-04 15:31:48', '2024-06-04 15:31:48'),
(11, 'aahmed', 'sonbaty193s7@gmail.com', '01066056996125', '$2y$10$8BC3GLpdh81mXOVLCgfTae6vZRYsyANGAsOk2iZ1yDhbggbXIWnIq', NULL, '2024-06-04 15:46:26', '2024-06-04 15:46:26'),
(12, 'aahmed', 'sonbaty193ds7@gmail.com', '01066056996125', '$2y$10$LARlU4WkG0fjJNGrCs/9eepg8nyBWWrp1x5MAGRoPFBglriPkrfse', NULL, '2024-06-04 15:47:29', '2024-06-04 15:47:29'),
(13, 'aahmed', 'sonbatyx193ds7@gmail.com', '01066056996125', '$2y$10$gDtpuNtzQeJ7bLyGVNOSE.6IQj9/I.iVWtbE3ZujZK5tTOOGyGoDG', NULL, '2024-06-04 15:51:47', '2024-06-04 15:51:47'),
(14, 'aahmed', 'sonbatyx193sds7@gmail.com', '01066056996125', '$2y$10$zGTCqCW6qrxHMEUUvPQiNeuKKRUVlYAWHCAkNovD8K/ugiP7ZZiTC', NULL, '2024-06-04 15:54:06', '2024-06-04 15:54:06'),
(15, 'aahmed', 'sonbatyx1s93sds7@gmail.com', '01066056996125', '$2y$10$3dVeo.L3/oqiR/Bu/5GMw.sxFlzcPhyEKr3OJmHnMPfKNpPMWnPeG', NULL, '2024-06-04 16:09:43', '2024-06-04 16:09:43'),
(16, 'aahmed', 'sonbatyx1s93sdss7@gmail.com', '01066056996125', '$2y$10$Zdj0V1fGtJ/rj6EggaGe2elOQSxJ/T/L5TpffBygxqP7Z8UVEeT4m', NULL, '2024-06-04 16:14:58', '2024-06-04 16:14:58'),
(17, 'aahmed', 'son@gmail.com', '01066056996125', '$2y$10$e.kGGhWogKn0uQcnmsNXm.9Nw.0uNlw8GT.4Qq0CBWfkr/ozIhovW', NULL, '2024-06-04 16:21:03', '2024-06-04 16:21:03'),
(18, 'aahmed', 'sons@gmail.com', '01066056996125', '$2y$10$gOUoJn0fmsmg6Vmm1QNPzOAZ9mapW9x4N7sIvZfzyaX04vHgOlZ9e', NULL, '2024-06-04 16:24:55', '2024-06-04 16:24:55'),
(19, 'aahmed', 'sonss@gmail.com', '01066056996125', '$2y$10$jAlJe2Hss7wOFAoEJXYKSO2oZh8fQgDo4MDAUS9X27bLJYkXP.qWS', NULL, '2024-06-04 16:30:44', '2024-06-04 16:30:44'),
(20, 'aahmed', 'sonsds@gmail.com', '01066056996125', '$2y$10$S8bN7.pBGzzNkan4BYiVdeuU6FRozP5ip/kw3j4ee.4.YmnoFijl2', NULL, '2024-06-04 16:36:27', '2024-06-04 16:36:27'),
(21, 'aahmed', 'sosnsds@gmail.com', '01066056996125', '$2y$10$O3Yspbky67TUouvjbT3DgeZ/RXl4.V10yVC5n6mWOSO1//V6H48fa', NULL, '2024-06-04 16:43:37', '2024-06-04 16:43:37'),
(22, 'aahmed', 'sosnsdds@gmail.com', '01066056996125', '$2y$10$d2dvnuWfyXp6mZMOXt/WC.UWJGzTh1fNqO.Vav7QOu1OyyexKCyei', NULL, '2024-06-04 16:46:31', '2024-06-04 16:46:31'),
(23, 'aahmed', 'sosnpsdds@gmail.com', '01066056996125', '$2y$10$oY1elak1SeqT0jJzegqQpOVhLSjZkSAPu1pTF9eRjZjBsZI6PhC2i', NULL, '2024-06-04 16:59:57', '2024-06-04 16:59:57'),
(24, 'aahmed', 'sosdnpsdds@gmail.com', '01066056996125', '$2y$10$bFPd8M4P0RSEl/F9ugn9f.A/C3BocQx5HovwRBh6gEvYuLT9NPqMC', NULL, '2024-06-04 17:00:23', '2024-06-04 17:00:23'),
(25, 'aahmed', 'sosdnpsdsds@gmail.com', '01066056996125', '$2y$10$X58kwsaqseLBUQUm1IEAaeq80JFi0rD9S4Cp9Ma7lZUdcRABfBr1.', NULL, '2024-06-04 17:03:05', '2024-06-04 17:03:05'),
(26, 'aahmed', 'sosdnpssdsds@gmail.com', '01066056996125', '$2y$10$mN/jQl091N/XOpNtzKte2OAU2GBkFx6v.nkmbz8VzBbYaKNnpa7Qu', NULL, '2024-06-04 17:21:20', '2024-06-04 17:21:20'),
(27, 'aahmed', 'sosdnpssdssds@gmail.com', '01066056996125', '$2y$10$WWexRZbj.OtDj5H4JAG4ZuS1GOgGz5Y/7jbc102Vy6eg5Xm4OWEY.', NULL, '2024-06-04 17:34:43', '2024-06-04 17:34:43'),
(28, 'aahmed', 'sosdnpssdsssds@gmail.com', '01066056996125', '$2y$10$zkLWYOaF7i61rA9YBqnFL.wUFw1brfYOFRhAS.gDNU3auBmFLFrwK', NULL, '2024-06-04 17:38:12', '2024-06-04 17:38:12'),
(30, 'aahmed', 'eng.ahmedkamal3s57@gmail.com', '01066056996125', '$2y$10$TD31E4oBuPZLAwFmBnleZOHdjuQ1Vdzz6zoZhRvdtOcKrWdwqqepa', '2024-06-05 09:19:28', '2024-06-04 17:50:11', '2024-06-05 09:19:28'),
(31, 'aahmed', '7e27d1fb76@emailcbox.pro', '01066056996125', '$2y$10$yZL8d4xjvmzyTNl/YHP8Ue0SnsU5cWwAaF0Uo/TDsJpu1A83H89Ja', NULL, '2024-06-07 10:53:14', '2024-06-07 10:53:14'),
(32, 'aahmed', 'd3499f9a76@emailcbox.pro', '01066056996125', '$2y$10$bCkeuzEZuaSkAbm.NsqqNeCRd/.lSlRmPcWWYXmOI62g7vDZhK0CW', NULL, '2024-06-07 12:39:35', '2024-06-07 12:39:35'),
(33, 'aahmed', 'e850f489a3@emailcbox.pro', '01066056996125', '$2y$10$dTVMqj8rv3nEkr3QkvaAiehfMWY.EEpWZEPfmVEDySzy4IffnnFRC', NULL, '2024-06-07 12:45:41', '2024-06-07 12:45:41'),
(35, 'aahmed', 'asamtabrahym870@gmail.com', '01066056996125', '$2y$10$ZN0yySWuAjcDVKALsZVCxe/PJ7dJuqibYAVR2rCmYeQ6VkLyHBSpq', NULL, '2024-06-08 10:35:06', '2024-06-08 10:35:06'),
(39, 'aahmed', 'mostafaesam300@gmail.com', '01066056996125', '$2y$10$6T2uJT/JrZy.TJaUvJAXR.m.jRG4Iggc7h4MAfwQ9QDhPV2CrbPFi', NULL, '2024-06-08 12:29:41', '2024-06-08 12:29:41'),
(41, 'aahmed', 'eng.ahmedkamal357@gmail.com', '01066056996125', '$2y$10$rtBcv6rFE8tCrx.zYG.dyOc1Z3yyrxsK2.CohJPjFwUwyGNWzYh/m', '2024-06-08 18:33:13', '2024-06-08 18:32:05', '2024-06-08 18:33:13');

-- --------------------------------------------------------

--
-- Table structure for table `customer_reset_password_tokens`
--

CREATE TABLE `customer_reset_password_tokens` (
  `token_id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` bigint(20) UNSIGNED NOT NULL,
  `token` varchar(255) NOT NULL,
  `expiration` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `diningtables`
--

CREATE TABLE `diningtables` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `floor` int(11) NOT NULL,
  `size` int(11) NOT NULL,
  `num` int(11) NOT NULL,
  `status` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
(39, 'mostafaesam300@gmail.com', '576de3df-8ba2-4598-9e8d-10747ff483f4', '2024-06-08 13:29:41', '2024-06-08 12:29:41', '2024-06-08 12:29:41');

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `is_admin` tinyint(1) NOT NULL DEFAULT 0,
  `phone` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `identity_card` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `employees`
--

INSERT INTO `employees` (`id`, `name`, `is_admin`, `phone`, `email`, `password`, `created_at`, `updated_at`, `identity_card`) VALUES
(1, 'hosam', 1, '01066056969', 'ahmed@gmail.com', '$2y$10$2WJkOKMdxs.nLhKNfkCmBucbsSwX1gFXRvbwMC7wcCnhBWB/9Kiwa', NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `employee_reset_password_tokens`
--

CREATE TABLE `employee_reset_password_tokens` (
  `token_id` bigint(20) UNSIGNED NOT NULL,
  `employee_id` bigint(20) UNSIGNED NOT NULL,
  `token` varchar(255) NOT NULL,
  `expiration` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `meals`
--

CREATE TABLE `meals` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `size` varchar(255) NOT NULL,
  `cost` double NOT NULL,
  `type` enum('vegetarian','non-vegetarian') NOT NULL,
  `description` text NOT NULL,
  `image` varchar(255) NOT NULL,
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `meals`
--

INSERT INTO `meals` (`id`, `name`, `size`, `cost`, `type`, `description`, `image`, `category_id`, `created_at`, `updated_at`) VALUES
(1, 'Margarita', 'Big', 105, 'vegetarian', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem', 'meals/eVToMJzFOxM1OQ7HDcKLj4j9SyMNBL41pnZiN6ZT.jpeg', 4, '2024-06-06 12:32:19', '2024-06-06 12:32:19'),
(2, 'Margarita', 'small', 50, 'vegetarian', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem', 'meals/tTfRRzaooH5dqfISNz51DIA9grPPQTQDfbbVf5k7.jpeg', 4, '2024-06-06 12:32:52', '2024-06-06 12:32:52'),
(4, 'Margarita', 'large', 55, 'non-vegetarian', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem', 'meals/Oxue8UHDFZdGhubJFDsOnl8fkMjTdDuAhy4Xxtwq.jpeg', 5, '2024-06-06 12:34:30', '2024-06-06 12:34:30'),
(5, 'Margarita', 'large', 100, 'non-vegetarian', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem', 'meals/aXeozt7XyFqmlEQftqOXJYq2kxFhupnNeo932eIv.jpeg', 5, '2024-06-06 12:34:56', '2024-06-06 12:34:56'),
(6, 'Margarita', 'large', 100, 'non-vegetarian', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem', 'meals/cg7NOQEZyXs2wLf7jq4hKaGh6kPwzEiwyDPHe3OS.jpg', 5, '2024-06-06 12:35:10', '2024-06-06 12:35:10'),
(7, 'Margarita', 'large', 100, 'non-vegetarian', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem', 'meals/WZUpISt5auZWittm0MHCiSZ19RiCbUqbqcj2pr5x.jpeg', 1, '2024-06-06 12:36:40', '2024-06-06 12:36:40'),
(8, 'Margarita', 'xlarge', 120, 'non-vegetarian', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem', 'meals/w1jlJGgUNxslJO8iA6XDOvFXQHJZSbVtqTMRy3Ue.jpeg', 1, '2024-06-06 12:37:06', '2024-06-06 12:37:06');

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
  `quantity` int(11) NOT NULL,
  `total_cost` double NOT NULL,
  `customer_id` bigint(20) UNSIGNED NOT NULL,
  `DiningTable_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `order_addons`
--

CREATE TABLE `order_addons` (
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `addon_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `order_meals`
--

CREATE TABLE `order_meals` (
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `meal_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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

--
-- Indexes for dumped tables
--

--
-- Indexes for table `addons`
--
ALTER TABLE `addons`
  ADD PRIMARY KEY (`id`);

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
-- Indexes for table `customer_reset_password_tokens`
--
ALTER TABLE `customer_reset_password_tokens`
  ADD PRIMARY KEY (`token_id`),
  ADD UNIQUE KEY `token` (`token`),
  ADD KEY `customer_id` (`customer_id`);

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
-- Indexes for table `employee_reset_password_tokens`
--
ALTER TABLE `employee_reset_password_tokens`
  ADD PRIMARY KEY (`token_id`),
  ADD UNIQUE KEY `token` (`token`),
  ADD KEY `employee_id` (`employee_id`);

--
-- Indexes for table `meals`
--
ALTER TABLE `meals`
  ADD PRIMARY KEY (`id`),
  ADD KEY `meals_category_id_foreign` (`category_id`);

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
  ADD KEY `orders_diningtable_id_foreign` (`DiningTable_id`);

--
-- Indexes for table `order_addons`
--
ALTER TABLE `order_addons`
  ADD PRIMARY KEY (`order_id`,`addon_id`),
  ADD KEY `order_addons_addon_id_foreign` (`addon_id`);

--
-- Indexes for table `order_meals`
--
ALTER TABLE `order_meals`
  ADD PRIMARY KEY (`meal_id`,`order_id`),
  ADD KEY `order_meals_order_id_foreign` (`order_id`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `addons`
--
ALTER TABLE `addons`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT for table `customer_reset_password_tokens`
--
ALTER TABLE `customer_reset_password_tokens`
  MODIFY `token_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `diningtables`
--
ALTER TABLE `diningtables`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `email_verification_tokens`
--
ALTER TABLE `email_verification_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `employee_reset_password_tokens`
--
ALTER TABLE `employee_reset_password_tokens`
  MODIFY `token_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `meals`
--
ALTER TABLE `meals`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `customer_reset_password_tokens`
--
ALTER TABLE `customer_reset_password_tokens`
  ADD CONSTRAINT `customer_reset_password_tokens_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `employee_reset_password_tokens`
--
ALTER TABLE `employee_reset_password_tokens`
  ADD CONSTRAINT `employee_reset_password_tokens_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `meals`
--
ALTER TABLE `meals`
  ADD CONSTRAINT `meals_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

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
  ADD CONSTRAINT `orders_diningtable_id_foreign` FOREIGN KEY (`DiningTable_id`) REFERENCES `diningtables` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `order_addons`
--
ALTER TABLE `order_addons`
  ADD CONSTRAINT `order_addons_addon_id_foreign` FOREIGN KEY (`addon_id`) REFERENCES `addons` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `order_addons_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `order_meals`
--
ALTER TABLE `order_meals`
  ADD CONSTRAINT `order_meals_meal_id_foreign` FOREIGN KEY (`meal_id`) REFERENCES `meals` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `order_meals_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
