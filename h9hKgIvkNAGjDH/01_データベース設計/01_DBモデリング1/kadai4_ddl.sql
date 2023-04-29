-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- ホスト: mysql-server
-- 生成日時: 2023 年 3 月 30 日 08:54
-- サーバのバージョン： 8.0.31
-- PHP のバージョン: 8.1.15

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- データベース: `my_test1`
--

-- --------------------------------------------------------

--
-- テーブルの構造 `m_allergens`
--

CREATE TABLE `m_allergens` (
  `id` bigint NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '小麦、卵、えび、そばetc',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `m_allergy_information`
--

CREATE TABLE `m_allergy_information` (
  `id` bigint NOT NULL,
  `menu_id` int NOT NULL,
  `allergen_id` int DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `m_menus`
--

CREATE TABLE `m_menus` (
  `id` bigint NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'はな,わだつみ,玉子,いなりetc',
  `menu_number` int DEFAULT NULL COMMENT 'セットメニューの商品番号',
  `excluding_tax` int NOT NULL COMMENT '税抜き価格',
  `parent_category_id` int NOT NULL,
  `sub_category_id` int NOT NULL,
  `can_take_out_flg` tinyint(1) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `m_parent_categories`
--

CREATE TABLE `m_parent_categories` (
  `id` bigint NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'セットメニュー、お好みすしetc',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `m_sub_categories`
--

CREATE TABLE `m_sub_categories` (
  `id` bigint NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '盛り込み、にぎり、一皿 100円、一皿 180円etc',
  `parent_category_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `m_sushi_materials`
--

CREATE TABLE `m_sushi_materials` (
  `id` bigint NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '玉子,いなり,えび,まぐろetc',
  `menu_id` int NOT NULL,
  `sushi_piece` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_customers`
--

CREATE TABLE `t_customers` (
  `id` bigint NOT NULL,
  `name` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_orders`
--

CREATE TABLE `t_orders` (
  `id` bigint NOT NULL,
  `user_id` int NOT NULL,
  `order_number` int NOT NULL,
  `order_date` datetime NOT NULL,
  `is_paid` tinyint(1) NOT NULL,
  `is_reserved_for_pickup` tinyint(1) NOT NULL,
  `receiving_item_time` datetime DEFAULT NULL,
  `comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `consumption_tax_rate` decimal(10,2) DEFAULT NULL,
  `total_amount_excluding_tax` decimal(10,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- テーブルの構造 `t_order_details`
--

CREATE TABLE `t_order_details` (
  `id` bigint NOT NULL,
  `order_id` int NOT NULL,
  `menu_id` int NOT NULL,
  `order_quantity` int NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `wasabi_flg` tinyint(1) DEFAULT NULL,
  `shari_size_type` int DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
-- テーブルのインデックス `m_parent_categories`
--
ALTER TABLE `m_parent_categories`
  ADD PRIMARY KEY (`id`);

--
-- テーブルのインデックス `m_sub_categories`
--
ALTER TABLE `m_sub_categories`
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
-- テーブルのインデックス `t_orders`
--
ALTER TABLE `t_orders`
  ADD PRIMARY KEY (`id`);

--
-- テーブルのインデックス `t_order_details`
--
ALTER TABLE `t_order_details`
  ADD PRIMARY KEY (`id`);

--
-- ダンプしたテーブルの AUTO_INCREMENT
--

--
-- テーブルの AUTO_INCREMENT `m_allergens`
--
ALTER TABLE `m_allergens`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `m_allergy_information`
--
ALTER TABLE `m_allergy_information`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `m_menus`
--
ALTER TABLE `m_menus`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `m_parent_categories`
--
ALTER TABLE `m_parent_categories`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `m_sub_categories`
--
ALTER TABLE `m_sub_categories`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `m_sushi_materials`
--
ALTER TABLE `m_sushi_materials`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `t_customers`
--
ALTER TABLE `t_customers`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `t_orders`
--
ALTER TABLE `t_orders`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `t_order_details`
--
ALTER TABLE `t_order_details`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
