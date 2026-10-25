-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 25, 2026 at 02:44 PM
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
-- Database: `sembark_url_shortener`
--

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `companies`
--

CREATE TABLE `companies` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `companies`
--

INSERT INTO `companies` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Sudhir Company Limited', '2026-10-23 13:59:42', '2026-10-23 13:59:42'),
(2, 'Dhung co..', '2026-10-23 22:50:36', '2026-10-23 22:50:36');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `invitations`
--

CREATE TABLE `invitations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `company_id` bigint(20) UNSIGNED NOT NULL,
  `invited_by` bigint(20) UNSIGNED NOT NULL,
  `email` varchar(255) NOT NULL,
  `role` varchar(255) NOT NULL,
  `token_hash` varchar(64) NOT NULL,
  `expires_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `accepted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `invitations`
--

INSERT INTO `invitations` (`id`, `company_id`, `invited_by`, `email`, `role`, `token_hash`, `expires_at`, `accepted_at`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'sudhir@yopmail.com', 'admin', 'bff5664f8958f0b4ed05744858833c06732a37449b879ca3bb5888401e41c8f4', '2026-10-23 19:32:15', '2026-10-23 14:02:15', '2026-10-23 13:59:42', '2026-10-23 14:02:15'),
(2, 2, 1, 'dhung@yopmail.com', 'admin', '3859adb1ffd9694880034665c4ad2ae8acb2b69eb9b5efdab87443034edb71b3', '2026-10-24 04:36:26', '2026-10-23 23:06:26', '2026-10-23 22:50:36', '2026-10-23 23:06:26'),
(3, 2, 3, 'somnath@yopmail.com', 'member', 'e743c9b10489317a3a21a95b9ba65858fa8e7b07fac34454e7033f18208bcca8', '2026-10-24 05:10:18', '2026-10-23 23:40:18', '2026-10-23 23:39:28', '2026-10-23 23:40:18'),
(4, 2, 3, 'bookdipo@yopmail.com', 'admin', 'a13ae1eb59b75ae4d9fec2b623603a5ca26cab3ef78ac9348fb85b8cd86db77c', '2026-10-24 06:18:04', '2026-10-24 00:48:04', '2026-10-24 00:47:20', '2026-10-24 00:48:04'),
(5, 2, 3, 'sikhasempo@yopmail.com', 'member', 'f0874508da0f30f8efe702c70ed7845dc3353e28e96eb12874dbe8fc5d1a4892', '2026-10-24 06:20:02', '2026-10-24 00:50:02', '2026-10-24 00:49:16', '2026-10-24 00:50:02');

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
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
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2026_10_23_112314_create_companies_table', 2),
(5, '2026_10_23_112330_create_invitations_table', 2),
(6, '2026_10_23_112353_create_short_urls_table', 2),
(7, '2026_10_23_114146_add_company_id_and_role_to_users_table', 2);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
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
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('fLR8wMk9FgFSv4mCV8aP67tog831JFEdT5wgZ8RF', 6, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoidzNFdjhYQXZIY3pqYmNnSkkwcGxsZVg2T0F2ZTFIQkhDR09VcGEzSyI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzI6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9zL0FjdVNqa3BMIjtzOjU6InJvdXRlIjtzOjE4OiJzaG9ydHVybHMucmVkaXJlY3QiO31zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aTo2O3M6MTc6InBhc3N3b3JkX2hhc2hfd2ViIjtzOjY0OiJmMDhlNjJhOTdhNGFhNmUzODY1ZTNjYTVmMDE5NmQxNDI4YzMxM2UzODYwZTZiNzA3YWUxOTM5N2E5MWJlODg2Ijt9', 1792822860),
('rviccTznroNOgwYchPsqCqP272TGmYvfsZm4hJlB', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTThrRVVxSnhETm1OeG43ODdpZTl0Zk1PQzVQVXhzUmhXOTlIYURwUiI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7czo1OiJyb3V0ZSI7Tjt9fQ==', 1792822879),
('YqWg915MTotxR18m0AO0cF2VcjAj7HBo2OLyD30s', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', 'YTo2OntzOjY6Il90b2tlbiI7czo0MDoicU92bE5RUVZLWkMxeXp5R1o4eXBndzVWbjg0Rkc0TGx1WGd0dFdUWSI7czozOiJ1cmwiO2E6MDp7fXM6OToiX3ByZXZpb3VzIjthOjI6e3M6MzoidXJsIjtzOjMxOiJodHRwOi8vMTI3LjAuMC4xOjgwMDAvZGFzaGJvYXJkIjtzOjU6InJvdXRlIjtzOjk6ImRhc2hib2FyZCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjE7czoxNzoicGFzc3dvcmRfaGFzaF93ZWIiO3M6NjQ6IjZmMmYwMDcwMDRkNWJiYjgyNWNkZTY3MTJkZGVjODdlZTczZmU3ZjYzMzkzNTg3NjdlNGU3ZTM4NmE5Njg4YjYiO30=', 1792822572);

-- --------------------------------------------------------

--
-- Table structure for table `short_urls`
--

CREATE TABLE `short_urls` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `company_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `original_url` text NOT NULL,
  `code` varchar(12) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `short_urls`
--

INSERT INTO `short_urls` (`id`, `company_id`, `user_id`, `original_url`, `code`, `created_at`, `updated_at`) VALUES
(1, 2, 3, 'https://www.google.com.', 'e6PriGmt', '2026-10-23 23:41:34', '2026-10-23 23:41:34'),
(2, 2, 4, 'https://www.itsolutionstuff.com/', 'rAaKe3TM', '2026-10-24 00:12:03', '2026-10-24 00:12:03'),
(3, 2, 5, 'https://www.youtube.com/', 'tXx046QI', '2026-10-24 00:48:25', '2026-10-24 00:48:25'),
(4, 2, 6, 'https://gemini.google.com/app?hl=en-IN', 'AcuSjkpL', '2026-10-24 00:50:48', '2026-10-24 00:50:48');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `company_id` bigint(20) UNSIGNED DEFAULT NULL,
  `role` varchar(255) NOT NULL DEFAULT 'member' COMMENT 'Roles: super_admin, admin, member'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`, `company_id`, `role`) VALUES
(1, 'Super Admin', 'superadmin@yopmail.com', NULL, '$2y$12$n4Y40HWy5ZxHshxxCFSJde9mmK6EikAH9eZav3D/S3B5ZJe0P4PIy', 'fulr3m82jmw0e4V8i0idWEGpPxRCLLC79I5RPGjhT05ZmzCbgVszqzOAooND', '2026-10-23 12:25:44', '2026-10-23 12:25:44', NULL, 'superadmin'),
(2, 'sudhir@yopmail.com', 'sudhir@yopmail.com', NULL, '$2y$12$FlAL06xeVeOSGAbbhedrqeXU5BypxamLe.DB0OffEvPfRDPasFDLe', NULL, '2026-10-23 14:02:15', '2026-10-23 14:02:15', 1, 'admin'),
(3, 'dhung@yopmail.com', 'dhung@yopmail.com', NULL, '$2y$12$GeoKOAvxfE1wGiVLROjyquYZwoxf3dmuIeSnAn8JOfTyd/MD3jrza', 'LKbuRaUrfNMNqtVp8U6MHQOL0H3Uqr45PluZ7QPFfdB6r5tIfGUWiR3FyoxG', '2026-10-23 23:06:26', '2026-10-23 23:06:26', 2, 'admin'),
(4, 'somnath sing', 'somnath@yopmail.com', NULL, '$2y$12$LyTebwlAISsOTOOW0q9o7uVFmFPyhYiSfr5jfGsDXV113y7GVd1bK', NULL, '2026-10-23 23:40:18', '2026-10-23 23:40:18', 2, 'member'),
(5, 'Radhe book dipo', 'bookdipo@yopmail.com', NULL, '$2y$12$U8TcTZmQYVF28KacdLIn1uy2HU9ZNZVEF6n0o/ztg8ISMi7H8gXmC', NULL, '2026-10-24 00:48:04', '2026-10-24 00:48:04', 2, 'admin'),
(6, 'sikha sempo', 'sikhasempo@yopmail.com', NULL, '$2y$12$zEXtD6sV3aq9PQY7LwdiUOs9XKDC2h..Sht9p/v2KrAQI8IYhnrvK', NULL, '2026-10-24 00:50:02', '2026-10-24 00:50:02', 2, 'member');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_expiration_index` (`expiration`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_locks_expiration_index` (`expiration`);

--
-- Indexes for table `companies`
--
ALTER TABLE `companies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `invitations`
--
ALTER TABLE `invitations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `invitations_token_hash_unique` (`token_hash`),
  ADD KEY `invitations_company_id_foreign` (`company_id`),
  ADD KEY `invitations_invited_by_foreign` (`invited_by`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `short_urls`
--
ALTER TABLE `short_urls`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `short_urls_code_unique` (`code`),
  ADD KEY `short_urls_user_id_foreign` (`user_id`),
  ADD KEY `short_urls_company_id_user_id_index` (`company_id`,`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD KEY `users_company_id_foreign` (`company_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `companies`
--
ALTER TABLE `companies`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `invitations`
--
ALTER TABLE `invitations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `short_urls`
--
ALTER TABLE `short_urls`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `invitations`
--
ALTER TABLE `invitations`
  ADD CONSTRAINT `invitations_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `invitations_invited_by_foreign` FOREIGN KEY (`invited_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `short_urls`
--
ALTER TABLE `short_urls`
  ADD CONSTRAINT `short_urls_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `short_urls_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
