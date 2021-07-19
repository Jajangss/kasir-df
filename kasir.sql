-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 14 Jul 2021 pada 08.57
-- Versi server: 10.4.11-MariaDB
-- Versi PHP: 7.2.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `kasir`
--

DELIMITER $$
--
-- Prosedur
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `reduce_stock` (`transaction_detail_id` INT)  BEGIN
                UPDATE items
                SET stock=stock - item_quantity(transaction_detail_id)
                WHERE id=item_id(transaction_detail_id);
            END$$

--
-- Fungsi
--
CREATE DEFINER=`root`@`localhost` FUNCTION `item_id` (`transaction_detail_id` INT) RETURNS INT(11) BEGIN
                DECLARE id_item INT;
                SET id_item = (SELECT item_id FROM transaction_details WHERE id=transaction_detail_id);
                RETURN id_item;
            END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `item_quantity` (`transaction_detail_id` INT) RETURNS INT(11) BEGIN
                DECLARE qty INT;
                SET qty = (SELECT quantity FROM transaction_details WHERE id=transaction_detail_id);
                RETURN qty;
            END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `carts`
--

CREATE TABLE `carts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `item_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `items`
--

CREATE TABLE `items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `item_category_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` bigint(20) UNSIGNED NOT NULL,
  `stock` bigint(20) UNSIGNED NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `items`
--

INSERT INTO `items` (`id`, `item_category_id`, `name`, `price`, `stock`, `image`, `created_at`, `updated_at`) VALUES
(1, 3, 'Spidol', 3000, 52, 'image/lmao.jpg', NULL, NULL),
(2, 1, 'Coca Cola', 3500, 51, 'image/1.jfif', NULL, NULL),
(3, 2, 'kopi', 50000, 2, 'image/1626244974_5eddede57b1b7272478964.jpg', '2021-07-13 23:42:54', '2021-07-13 23:42:54');

-- --------------------------------------------------------

--
-- Struktur dari tabel `item_categories`
--

CREATE TABLE `item_categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `item_categories`
--

INSERT INTO `item_categories` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Makanan', '2021-07-02 12:47:40', '2021-07-02 12:47:40'),
(2, 'Minuman', '2021-07-02 12:47:40', '2021-07-02 12:47:40'),
(3, 'Alat Tulis', '2021-07-02 12:47:40', '2021-07-02 12:47:40'),
(4, 'Alat Dapur', '2021-07-02 12:47:40', '2021-07-02 12:47:40'),
(5, 'Pembersih', '2021-07-02 12:47:40', '2021-07-02 12:47:40');

-- --------------------------------------------------------

--
-- Struktur dari tabel `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2021_07_02_193255_create_item_categories_table', 1),
(5, '2021_07_02_193401_create_items_table', 1),
(6, '2021_07_02_193442_create_carts_table', 1),
(7, '2021_07_02_193524_create_transactions_table', 1),
(8, '2021_07_02_193615_create_transaction_details_table', 1),
(9, '2021_07_02_193805_item_id_function', 1),
(10, '2021_07_02_193839_item_quantity_function', 1),
(11, '2021_07_02_193912_reduce_stock_item_procedure', 1),
(12, '2021_07_02_193943_item_stock_trigger', 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `transactions`
--

CREATE TABLE `transactions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `total` bigint(20) UNSIGNED NOT NULL,
  `pay_total` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `transactions`
--

INSERT INTO `transactions` (`id`, `user_id`, `total`, `pay_total`, `created_at`, `updated_at`) VALUES
(1, 1, 3000, 3000, '2021-07-02 14:03:39', '2021-07-02 14:03:39'),
(2, 1, 9500, 9500, '2021-07-02 14:07:09', '2021-07-02 14:07:09'),
(3, 1, 3500, 3500, '2021-07-02 15:10:36', '2021-07-02 15:10:36'),
(4, 1, 6500, 6500, '2021-07-03 02:28:56', '2021-07-03 02:28:56'),
(5, 1, 3500, 6000, '2021-07-13 03:55:26', '2021-07-13 03:55:26'),
(6, 1, 3000, 4000, '2021-07-13 04:01:09', '2021-07-13 04:01:09'),
(7, 1, 3000, 3000, '2021-07-13 04:06:54', '2021-07-13 04:06:54'),
(8, 1, 3500, 5000, '2021-07-13 04:11:50', '2021-07-13 04:11:50'),
(9, 1, 3500, 6000, '2021-07-13 04:19:45', '2021-07-13 04:19:45'),
(10, 1, 3000, 6000, '2021-07-13 05:16:04', '2021-07-13 05:16:04'),
(11, 1, 3500, 7000, '2021-07-13 05:41:00', '2021-07-13 05:41:00'),
(12, 1, 3500, 7000, '2021-07-13 05:43:40', '2021-07-13 05:43:40'),
(13, 1, 7000, 8500, '2021-07-13 07:38:11', '2021-07-13 07:38:11'),
(14, 1, 3000, 6000, '2021-07-13 07:39:59', '2021-07-13 07:39:59'),
(15, 1, 3000, 6000, '2021-07-13 07:46:42', '2021-07-13 07:46:42'),
(16, 1, 0, 33, '2021-07-13 08:39:50', '2021-07-13 08:39:50'),
(17, 1, 50000, 100000, '2021-07-13 23:44:01', '2021-07-13 23:44:01');

-- --------------------------------------------------------

--
-- Struktur dari tabel `transaction_details`
--

CREATE TABLE `transaction_details` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `transaction_id` bigint(20) UNSIGNED NOT NULL,
  `item_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` bigint(20) UNSIGNED NOT NULL,
  `subtotal` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `transaction_details`
--

INSERT INTO `transaction_details` (`id`, `transaction_id`, `item_id`, `quantity`, `subtotal`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, 3000, '2021-07-02 14:03:40', '2021-07-02 14:03:40'),
(2, 2, 1, 2, 6000, '2021-07-02 14:07:09', '2021-07-02 14:07:09'),
(3, 2, 2, 1, 3500, '2021-07-02 14:07:09', '2021-07-02 14:07:09'),
(4, 3, 2, 1, 3500, '2021-07-02 15:10:36', '2021-07-02 15:10:36'),
(5, 4, 2, 1, 3500, '2021-07-03 02:28:57', '2021-07-03 02:28:57'),
(6, 4, 1, 1, 3000, '2021-07-03 02:28:57', '2021-07-03 02:28:57'),
(7, 5, 2, 1, 3500, '2021-07-13 03:55:27', '2021-07-13 03:55:27'),
(8, 6, 1, 1, 3000, '2021-07-13 04:01:09', '2021-07-13 04:01:09'),
(9, 7, 1, 1, 3000, '2021-07-13 04:06:54', '2021-07-13 04:06:54'),
(10, 8, 2, 1, 3500, '2021-07-13 04:11:50', '2021-07-13 04:11:50'),
(11, 9, 2, 1, 3500, '2021-07-13 04:19:45', '2021-07-13 04:19:45'),
(12, 10, 1, 1, 3000, '2021-07-13 05:16:04', '2021-07-13 05:16:04'),
(13, 11, 2, 1, 3500, '2021-07-13 05:41:00', '2021-07-13 05:41:00'),
(14, 13, 2, 2, 7000, '2021-07-13 07:38:11', '2021-07-13 07:38:11'),
(15, 14, 1, 1, 3000, '2021-07-13 07:39:59', '2021-07-13 07:39:59'),
(16, 17, 3, 1, 50000, '2021-07-13 23:44:01', '2021-07-13 23:44:01');

--
-- Trigger `transaction_details`
--
DELIMITER $$
CREATE TRIGGER `item_stock_trigger` AFTER INSERT ON `transaction_details` FOR EACH ROW BEGIN
                CALL reduce_stock(NEW.id);
            END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'rikako@gmail.com', NULL, '$2y$10$AVvpLwce5rXOoWBOrnFVI.IhqFaAUIQln9sIPdQJD3VtWpk0pkjYG', NULL, '2021-07-02 13:16:43', '2021-07-02 13:16:43');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `carts`
--
ALTER TABLE `carts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `carts_item_id_foreign` (`item_id`);

--
-- Indeks untuk tabel `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `items_item_category_id_foreign` (`item_category_id`);

--
-- Indeks untuk tabel `item_categories`
--
ALTER TABLE `item_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indeks untuk tabel `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transactions_user_id_foreign` (`user_id`);

--
-- Indeks untuk tabel `transaction_details`
--
ALTER TABLE `transaction_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transaction_details_transaction_id_foreign` (`transaction_id`),
  ADD KEY `transaction_details_item_id_foreign` (`item_id`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `carts`
--
ALTER TABLE `carts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT untuk tabel `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `items`
--
ALTER TABLE `items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `item_categories`
--
ALTER TABLE `item_categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT untuk tabel `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT untuk tabel `transaction_details`
--
ALTER TABLE `transaction_details`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `carts`
--
ALTER TABLE `carts`
  ADD CONSTRAINT `carts_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `items`
--
ALTER TABLE `items`
  ADD CONSTRAINT `items_item_category_id_foreign` FOREIGN KEY (`item_category_id`) REFERENCES `item_categories` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `transactions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `transaction_details`
--
ALTER TABLE `transaction_details`
  ADD CONSTRAINT `transaction_details_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `transaction_details_transaction_id_foreign` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
