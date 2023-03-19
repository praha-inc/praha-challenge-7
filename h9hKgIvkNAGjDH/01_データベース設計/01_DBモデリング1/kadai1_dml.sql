-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- ホスト: mysqldb
-- 生成日時: 2023 年 3 月 18 日 00:32
-- サーバのバージョン： 8.0.32
-- PHP のバージョン: 8.1.15

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- データベース: `my_testdb`
--

--
-- テーブルのデータのダンプ `m_allergens`
--

INSERT INTO `m_allergens` (`id`, `name`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, '卵', NULL, NULL, NULL),
(2, '小麦', NULL, NULL, NULL),
(3, '豚肉', NULL, NULL, NULL),
(4, '乳', NULL, NULL, NULL),
(5, 'えび', NULL, NULL, NULL),
(6, 'かに', NULL, NULL, NULL),
(7, 'い か', NULL, NULL, NULL),
(8, 'いくら', NULL, NULL, NULL);

--
-- テーブルのデータのダンプ `m_allergy_information`
--

INSERT INTO `m_allergy_information` (`id`, `allergen_id`, `menu_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 5, 1, NULL, NULL, NULL),
(2, 5, 1, NULL, NULL, NULL),
(3, 6, 1, NULL, NULL, NULL),
(4, 7, 6, NULL, NULL, NULL);

--
-- テーブルのデータのダンプ `m_menus`
--

INSERT INTO `m_menus` (`id`, `name`, `menu_number`, `excluding_tax`, `menu_type`, `take_out_flg`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'はな', 1, 8650, 1, 1, NULL, NULL, NULL),
(2, 'わだつみ', 2, 5680, 1, 1, NULL, NULL, NULL),
(3, 'えび', NULL, 100, 2, NULL, NULL, NULL, NULL),
(4, 'いくら', NULL, 100, 2, 1, NULL, NULL, NULL),
(5, 'たい', NULL, 180, 2, 1, NULL, NULL, NULL),
(6, 'いか', NULL, 220, 2, 1, NULL, NULL, NULL);

--
-- テーブルのデータのダンプ `m_sushi_materials`
--

INSERT INTO `m_sushi_materials` (`id`, `name`, `menu_id`, `sushi_piece`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'えび', 3, 2, NULL, NULL, NULL),
(2, 'いくら', 4, 2, NULL, NULL, NULL),
(3, 'えび', 5, 2, NULL, NULL, NULL),
(4, '生サーモン', 5, 2, NULL, NULL, NULL),
(5, '生サーモン', 1, 6, NULL, NULL, NULL),
(6, '生サーモン', 2, 4, NULL, NULL, NULL),
(7, 'えび', 1, 4, NULL, NULL, NULL),
(8, 'まぐろ', 1, 6, NULL, NULL, NULL);

--
-- テーブルのデータのダンプ `t_customers`
--

INSERT INTO `t_customers` (`id`, `name`, `phone`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, '佐藤たける', '012345678', NULL, NULL, NULL),
(2, '鈴木すず', '9876543254', NULL, NULL, NULL),
(3, '木村しゅん', '0123987654', NULL, NULL, NULL);

--
-- テーブルのデータのダンプ `t_order_details`
--

INSERT INTO `t_order_details` (`id`, `order_id`, `menu_id`, `order_quantity`, `wasabi_flg`, `shari_size_type`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 2, 2, NULL, NULL, '2023-03-18 00:31:01', '2023-03-18 00:31:01', NULL),
(2, 1, 3, 1, 1, 1, '2023-03-18 00:31:01', '2023-03-18 00:31:01', NULL),
(3, 1, 6, 2, 0, 1, '2023-03-18 00:31:28', '2023-03-18 00:31:28', NULL),
(4, 1, 6, 2, 1, 1, '2023-03-18 00:31:28', '2023-03-18 00:31:28', NULL),
(5, 2, 1, 1, NULL, NULL, '2023-03-18 00:31:45', '2023-03-18 00:31:45', NULL);

--
-- テーブルのデータのダンプ `t_ordres`
--

INSERT INTO `t_ordres` (`id`, `user_id`, `order_date`, `comment`, `consumption_tax_rate`, `is_paid`, `total_amount_excluding_tax`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, '2023-03-18 00:27:41', 'がり多めでお願いします。', 0.10, 1, 12540.00, '2023-03-18 00:28:09', '2023-03-18 00:28:09', NULL),
(2, 2, '2023-03-18 00:27:41', NULL, 0.10, 0, 8640.00, '2023-03-18 00:28:09', '2023-03-18 00:28:09', NULL);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
