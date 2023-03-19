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

-- --------------------------------------------------------

--
-- テーブルの構造 `m_allergens`
--

CREATE TABLE `m_allergens` (
  `id` int NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '小麦、卵、えび、そばetc',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `m_allergy_information`
--

CREATE TABLE `m_allergy_information` (
  `id` int NOT NULL,
  `allergen_id` int DEFAULT NULL,
  `menu_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `m_menus`
--

CREATE TABLE `m_menus` (
  `id` int NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'はな,わだつみ,玉子,いなりetc',
  `menu_number` int DEFAULT NULL COMMENT 'セットメニューの商品番号',
  `excluding_tax` int DEFAULT NULL COMMENT '税抜き価格',
  `menu_type` int DEFAULT NULL,
  `take_out_flg` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `m_sushi_materials`
--

CREATE TABLE `m_sushi_materials` (
  `id` int NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '玉子,いなり,えび,まぐろetc',
  `menu_id` int DEFAULT NULL,
  `sushi_piece` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_customers`
--

CREATE TABLE `t_customers` (
  `id` int NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_order_details`
--

CREATE TABLE `t_order_details` (
  `id` int NOT NULL,
  `order_id` int NOT NULL,
  `menu_id` int NOT NULL,
  `order_quantity` int NOT NULL,
  `wasabi_flg` tinyint(1) DEFAULT NULL,
  `shari_size_type` int DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_ordres`
--

CREATE TABLE `t_ordres` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `order_date` datetime NOT NULL,
  `comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `consumption_tax_rate` decimal(10,2) NOT NULL,
  `is_paid` tinyint(1) NOT NULL,
  `total_amount_excluding_tax` decimal(10,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- ダンプしたテーブルのインデックス
--

--
-- テーブルのインデックス `m_allergens`
--
ALTER TABLE `m_allergens`
  ADD PRIMARY KEY (`id`);

--
-- テーブルのインデックス `m_allergy_information`
--
ALTER TABLE `m_allergy_information`
  ADD PRIMARY KEY (`id`);

--
-- テーブルのインデックス `m_menus`
--
ALTER TABLE `m_menus`
  ADD PRIMARY KEY (`id`);

--
-- テーブルのインデックス `m_sushi_materials`
--
ALTER TABLE `m_sushi_materials`
  ADD PRIMARY KEY (`id`);

--
-- テーブルのインデックス `t_customers`
--
ALTER TABLE `t_customers`
  ADD PRIMARY KEY (`id`);

--
-- テーブルのインデックス `t_order_details`
--
ALTER TABLE `t_order_details`
  ADD PRIMARY KEY (`id`);

--
-- テーブルのインデックス `t_ordres`
--
ALTER TABLE `t_ordres`
  ADD PRIMARY KEY (`id`);

--
-- ダンプしたテーブルの AUTO_INCREMENT
--

--
-- テーブルの AUTO_INCREMENT `m_allergens`
--
ALTER TABLE `m_allergens`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `m_allergy_information`
--
ALTER TABLE `m_allergy_information`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `m_menus`
--
ALTER TABLE `m_menus`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `m_sushi_materials`
--
ALTER TABLE `m_sushi_materials`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `t_customers`
--
ALTER TABLE `t_customers`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `t_order_details`
--
ALTER TABLE `t_order_details`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `t_ordres`
--
ALTER TABLE `t_ordres`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
