DROP TABLE IF EXISTS `WorkSpaceMember`;
DROP TABLE IF EXISTS `ChannelMember`;
DROP TABLE IF EXISTS `Message`;
DROP TABLE IF EXISTS `Channel`;
DROP TABLE IF EXISTS `WorkSpace`;
DROP TABLE IF EXISTS `User`;
CREATE TABLE `User` (
  `id` bigint PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255),
  `display_name` varchar(255),
  `email` varchar(255),
  `password` varchar(255)
);
CREATE TABLE `Message` (
  `id` bigint PRIMARY KEY AUTO_INCREMENT,
  `content` text,
  `user_id` bigint not null,
  `parent_message_id` bigint not null,
  `post_datetime` datetime DEFAULT (now()),
  `channel_id` bigint not null
);
CREATE TABLE `Channel` (
  `id` bigint PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255),
  `workspace_id` bigint not null
);
CREATE TABLE `ChannelMember` (
  `channel_id` bigint not null,
  `member_user_id` bigint not null
);
CREATE TABLE `WorkSpace` (
  `id` bigint PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255)
);
CREATE TABLE `WorkSpaceMember` (
  `workspace_id` bigint not null,
  `member_user_id` bigint not null
);
ALTER TABLE `Message`
ADD FOREIGN KEY (`user_id`) REFERENCES `User` (`id`);
ALTER TABLE `Message`
ADD FOREIGN KEY (`parent_message_id`) REFERENCES `Message` (`id`);
ALTER TABLE `Message`
ADD FOREIGN KEY (`channel_id`) REFERENCES `Channel` (`id`);
ALTER TABLE `Channel`
ADD FOREIGN KEY (`workspace_id`) REFERENCES `WorkSpace` (`id`);
ALTER TABLE `ChannelMember`
ADD FOREIGN KEY (`channel_id`) REFERENCES `Channel` (`id`);
ALTER TABLE `ChannelMember`
ADD FOREIGN KEY (`member_user_id`) REFERENCES `User` (`id`);
ALTER TABLE `WorkSpaceMember`
ADD FOREIGN KEY (`workspace_id`) REFERENCES `WorkSpace` (`id`);
ALTER TABLE `WorkSpaceMember`
ADD FOREIGN KEY (`member_user_id`) REFERENCES `User` (`id`);