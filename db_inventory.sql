-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 27, 2022 at 05:06 AM
-- Server version: 10.4.22-MariaDB
-- PHP Version: 7.4.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_inventory`
--

-- --------------------------------------------------------

--
-- Table structure for table `barang`
--

CREATE TABLE `barang` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `kategori_id` int(11) NOT NULL,
  `nama_barang` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `gambar` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `stok` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT '0',
  `kode_barang` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `harga_jual` int(11) DEFAULT NULL,
  `terjuals_id` int(11) DEFAULT NULL,
  `barang_ins_id` int(11) DEFAULT NULL,
  `size` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `barang`
--

INSERT INTO `barang` (`id`, `kategori_id`, `nama_barang`, `gambar`, `stok`, `kode_barang`, `harga_jual`, `terjuals_id`, `barang_ins_id`, `size`, `created_at`, `updated_at`) VALUES
(1, 1, 'kemeja wibu', '1652700971bj.jpg', '15', 'MWD0001', 140000, NULL, NULL, 'M', '2022-05-16 04:36:11', '2022-05-16 04:36:11');

-- --------------------------------------------------------

--
-- Table structure for table `barang_ins`
--

CREATE TABLE `barang_ins` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `supplier_id` int(11) NOT NULL,
  `barang_id` int(11) NOT NULL,
  `harga_beli` int(11) NOT NULL,
  `jumlah` int(11) NOT NULL,
  `total_harga` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `barang_ins`
--

INSERT INTO `barang_ins` (`id`, `supplier_id`, `barang_id`, `harga_beli`, `jumlah`, `total_harga`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 120000, 10, 1200000, '2022-05-16 04:38:08', '2022-05-16 04:38:08');

--
-- Triggers `barang_ins`
--
DELIMITER $$
CREATE TRIGGER `barang_in` BEFORE INSERT ON `barang_ins` FOR EACH ROW BEGIN
                UPDATE barang SET stok=stok+NEW.jumlah
                WHERE id = NEW.barang_id;
            END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `barang_update` AFTER UPDATE ON `barang_ins` FOR EACH ROW BEGIN
            UPDATE barang SET stok=stok+NEW.jumlah-OLD.jumlah
            WHERE id = NEW.barang_id;
        END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `kategori`
--

CREATE TABLE `kategori` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nama_kategori` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `kategori`
--

INSERT INTO `kategori` (`id`, `nama_kategori`, `created_at`, `updated_at`) VALUES
(1, 'kemeja', '2022-05-16 04:31:55', '2022-05-16 04:32:34'),
(2, 'Kaos', '2022-05-26 19:00:27', '2022-05-26 19:00:27');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2022_05_16_110421_create_users_table', 1),
(2, '2022_05_16_110541_create_password_resets_table', 1),
(3, '2022_05_16_110611_create_kategori_table', 1),
(4, '2022_05_16_110707_create_stoks_table', 1),
(5, '2022_05_16_110753_create_barang_table', 1),
(6, '2022_05_16_110813_create_barang_ins_table', 1),
(7, '2022_05_16_110831_create_terjuals_table', 1),
(8, '2022_05_16_110856_trigger_barang', 1),
(9, '2022_05_16_110903_trigger_terjual', 1),
(10, '2022_05_16_110929_create_suppliers_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `stoks`
--

CREATE TABLE `stoks` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `barang_id` bigint(20) UNSIGNED NOT NULL,
  `barang_in_id` bigint(20) UNSIGNED NOT NULL,
  `harga_beli` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `harga_jual` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `stok` int(11) DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE `suppliers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `kode_supplier` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama_supplier` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `no_wa` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `suppliers`
--

INSERT INTO `suppliers` (`id`, `kode_supplier`, `nama_supplier`, `no_wa`, `created_at`, `updated_at`) VALUES
(1, 'SP0001', 'butik a', '0888888888', '2022-05-16 04:31:26', '2022-05-16 04:32:46');

-- --------------------------------------------------------

--
-- Table structure for table `terjuals`
--

CREATE TABLE `terjuals` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `barang_id` int(11) NOT NULL,
  `qty` int(11) NOT NULL,
  `inv` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lokasi` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_harga` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `terjuals`
--

INSERT INTO `terjuals` (`id`, `barang_id`, `qty`, `inv`, `lokasi`, `total_harga`, `created_at`, `updated_at`) VALUES
(1, 1, 2, 'INV/00001', 'Shopee', 280000, '2022-05-16 04:39:22', '2022-05-16 04:39:22'),
(2, 1, 1, 'INV/00002', 'Lainya', 140000, '2022-05-16 04:48:59', '2022-05-16 04:48:59'),
(3, 1, 7, 'INV/00003', 'Shopee', 980000, '2022-05-26 19:01:26', '2022-05-26 19:01:26'),
(4, 1, 5, 'INV/00004', 'Facebook', 700000, '2022-05-26 19:40:12', '2022-05-26 19:40:12');

--
-- Triggers `terjuals`
--
DELIMITER $$
CREATE TRIGGER `terjual` AFTER INSERT ON `terjuals` FOR EACH ROW BEGIN
                UPDATE barang SET stok=stok-NEW.qty
                WHERE id = NEW.barang_id;
            END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `terjual_update` AFTER UPDATE ON `terjuals` FOR EACH ROW BEGIN
            UPDATE barang SET stok=stok-NEW.qty+OLD.qty
            WHERE id = NEW.barang_id;
        END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'admin@gmail.com', NULL, '$2y$10$cP4xi1CXHd5SSYzy6j2Fm.oArhM0dCQjnyDrHp1s/to.dYDveuG1i', NULL, '2022-05-16 20:32:27', '2022-05-16 20:32:27');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `barang`
--
ALTER TABLE `barang`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `barang_ins`
--
ALTER TABLE `barang_ins`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `kategori`
--
ALTER TABLE `kategori`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `stoks`
--
ALTER TABLE `stoks`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `terjuals`
--
ALTER TABLE `terjuals`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `barang`
--
ALTER TABLE `barang`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `barang_ins`
--
ALTER TABLE `barang_ins`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `kategori`
--
ALTER TABLE `kategori`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `stoks`
--
ALTER TABLE `stoks`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `terjuals`
--
ALTER TABLE `terjuals`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
