CREATE TABLE `document` (
  `id` int PRIMARY KEY NOT NULL,
  `content` text,
  `editDate` datetime NOT NULL,
  `editUser` nvarchar(30) NOT NULL,
  `directoryId` int NOT NULL
);

CREATE TABLE `directory` (
  `id` int PRIMARY KEY NOT NULL,
  `name` nvarchar(200) NOT NULL,
  `editDate` datetime NOT NULL,
  `editUser` nvarchar(30) NOT NULL
);

CREATE TABLE `directoryClosureTable` (
  `parentDirectoryId` int NOT NULL,
  `childDirectoryId` int NOT NULL
);

CREATE TABLE `user` (
  `id` int PRIMARY KEY NOT NULL,
  `name` nvarchar(100) NOT NULL
);

ALTER TABLE `document` ADD FOREIGN KEY (`editUser`) REFERENCES `user` (`id`);

ALTER TABLE `document` ADD FOREIGN KEY (`directoryId`) REFERENCES `directory` (`id`);

ALTER TABLE `directoryClosureTable` ADD FOREIGN KEY (`parentDirectoryId`) REFERENCES `directory` (`id`);

ALTER TABLE `directoryClosureTable` ADD FOREIGN KEY (`childDirectoryId`) REFERENCES `directory` (`id`);