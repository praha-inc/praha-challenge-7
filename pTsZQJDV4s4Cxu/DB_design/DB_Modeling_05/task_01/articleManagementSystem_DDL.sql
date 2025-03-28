CREATE TABLE `article` (
  `id` int PRIMARY KEY NOT NULL,
  `title` nvarchar(200) NOT NULL,
  `content` nvarchar(1000) NOT NULL
);

CREATE TABLE `articleHistory` (
  `id` int PRIMARY KEY NOT NULL,
  `articleId` int NOT NULL,
  `title` nvarchar(200) NOT NULL,
  `content` nvarchar(1000) NOT NULL,
  `updateDate` datetime
);

ALTER TABLE `articleHistory` ADD FOREIGN KEY (`articleId`) REFERENCES `article` (`id`);
