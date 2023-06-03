--
-- テーブルの構造 `Document`
--

DROP TABLE IF EXISTS `Document`;
CREATE TABLE `Document` (
  `ID` bigint(20) NOT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `Path` varchar(255) DEFAULT NULL,
  `CreateAt` date DEFAULT current_timestamp(),
  `UpdateAt` date DEFAULT NULL,
  `DocumentType` enum('FILE','DIRECTORY') NOT NULL,
  `CreateUserId` bigint(20) NOT NULL,
  `UpdateUserId` bigint(20) NOT NULL,
  `Order` int(11) NOT NULL DEFAULT 0 COMMENT '同フォルダ内での並び替え順'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- テーブルのデータのダンプ `Document`
--

INSERT INTO `Document` (`ID`, `Name`, `Path`, `CreateAt`, `UpdateAt`, `DocumentType`, `CreateUserId`, `UpdateUserId`, `Order`) VALUES
(1, 'Root', '/1/', '2023-04-19', '2023-04-19', 'DIRECTORY', 1, 1, 1),
(2, '旅行', '/1/2/', '2023-04-19', '2023-04-19', 'DIRECTORY', 1, 1, 1),
(3, '料理', '/1/3/', '2023-04-19', '2023-04-19', 'DIRECTORY', 1, 1, 2),
(4, '京都旅行記.txt', '/1/2/', '2023-04-19', '2023-04-19', 'FILE', 1, 1, 1),
(5, '北海道観光案内.pdf', '/1/2/', '2023-04-19', '2023-04-19', 'FILE', 1, 1, 2),
(6, '趣味', '/1/6/', '2023-04-19', '2023-04-19', 'DIRECTORY', 1, 1, 1),
(7, 'カレーレシピ.docx', '/1/3/', '2023-04-19', '2023-04-19', 'FILE', 1, 1, 1),
(8, '和食の作り方.pdf', '/1/3/', '2023-04-19', '2023-04-19', 'FILE', 1, 1, 2),
(9, 'アウトドア', '/1/6/9/', '2023-04-19', '2023-04-19', 'DIRECTORY', 1, 1, 2),
(10, 'キャンプ場一覧.xlsx', '/1/6/9/', '2023-04-19', '2023-04-19', 'FILE', 1, 1, 1),
(11, '登山道マップ.pdf', '/1/6/9/', '2023-04-19', '2023-04-19', 'FILE', 1, 1, 2),
(12, '仕事', '/1/12/', '2023-04-19', '2023-04-19', 'DIRECTORY', 1, 1, 2),
(13, 'プロジェクト計画.docx', '/1/12/', '2023-04-19', '2023-04-19', 'FILE', 1, 1, 1);
-- --------------------------------------------------------

--
-- テーブルの構造 `User`
--

DROP TABLE IF EXISTS `User`;
CREATE TABLE `User` (
  `ID` bigint(20) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Email` varchar(255) DEFAULT NULL,
  `Password` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- テーブルのデータのダンプ `User`
--

INSERT INTO `User` (`ID`, `Name`, `Email`, `Password`) VALUES
(1, '平川知秀', 'sutefu23@gmail.com', 'xxxxxxxxxxxxxxxxxxxxxx'),
(2, '田中秀樹', 'tanaka@gmail.com', 'xxxxxxxxxxxxxxxxxxxxxx');

-- --------------------------------------------------------

--
-- テーブルの構造 `UserPermittedDocument`
--

DROP TABLE IF EXISTS `UserPermittedDocument`;
CREATE TABLE `UserPermittedDocument` (
  `UserId` bigint(20) NOT NULL,
  `DocumentId` bigint(20) NOT NULL,
  `Permission` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '0:NotPermitted, 4: ReadOnly , 6: Writable, 7: Excutable'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- テーブルのデータのダンプ `UserPermittedDocument`
--

INSERT INTO `UserPermittedDocument` (`UserId`, `DocumentId`, `Permission`) VALUES
(1, 1, 6),
(1, 2, 6),
(1, 3, 6),
(1, 4, 6),
(1, 5, 6),
(1, 6, 6),
(1, 7, 6),
(1, 8, 6),
(1, 9, 6),
(1, 10, 6),
(1, 11, 6),
(1, 12, 6),
(1, 13, 6),
(2, 2, 6),
(2, 3, 6),
(2, 4, 6),
(2, 5, 6),
(2, 6, 6),
(2, 7, 6),
(2, 8, 6),
(2, 9, 6),
(2, 10, 4),
(2, 11, 4);

--
-- ダンプしたテーブルのインデックス
--

--
-- テーブルのインデックス `Document`
--
ALTER TABLE `Document`
  ADD PRIMARY KEY (`ID`);

--
-- テーブルのインデックス `User`
--
ALTER TABLE `User`
  ADD PRIMARY KEY (`ID`);

--
-- テーブルのインデックス `UserPermittedDocument`
--
ALTER TABLE `UserPermittedDocument`
  ADD KEY `UserId` (`UserId`),
  ADD KEY `DocumentId` (`DocumentId`);

--
-- ダンプしたテーブルの AUTO_INCREMENT
--

--
-- テーブルの AUTO_INCREMENT `Document`
--
ALTER TABLE `Document`
  MODIFY `ID` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- テーブルの AUTO_INCREMENT `User`
--
ALTER TABLE `User`
  MODIFY `ID` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- ダンプしたテーブルの制約
--

--
-- テーブルの制約 `UserPermittedDocument`
--
ALTER TABLE `UserPermittedDocument`
  ADD CONSTRAINT `UserPermittedDocument_ibfk_1` FOREIGN KEY (`UserId`) REFERENCES `User` (`ID`),
  ADD CONSTRAINT `UserPermittedDocument_ibfk_2` FOREIGN KEY (`DocumentId`) REFERENCES `Document` (`ID`) ON DELETE CASCADE;
COMMIT;


