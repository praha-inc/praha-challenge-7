CREATE TABLE `order` (
  `id` int PRIMARY KEY,
  `ordererId` int NOT NULL,
  `date` datetime,
  `status` int NOT NULL,
  `totalorderCount` int NOT NULL,
  `amount` decimal(9,0)
);

CREATE TABLE `orderDetail` (
  `orderDetailId` int PRIMARY KEY,
  `orderId` int NOT NULL,
  `productId` int NOT NULL,
  `isWasabi` boolean NOT NULL,
  `size` int NOT NULL
);

CREATE TABLE `product` (
  `id` int PRIMARY KEY,
  `name` varchar(100) UNIQUE NOT NULL,
  `price` decimal(5,0) NOT NULL,
  `productTypeId` int NOT NULL
);

CREATE TABLE `orderer` (
  `id` int PRIMARY KEY,
  `name` varchar(100) NOT NULL,
  `phoneNumber` varchar(20)
);

CREATE TABLE `size` (
  `id` int PRIMARY KEY,
  `name` varchar(20) UNIQUE NOT NULL
);

CREATE TABLE `productType` (
  `id` int PRIMARY KEY,
  `description` varchar(200) UNIQUE NOT NULL
);

CREATE TABLE `tax` (
  `id` int PRIMARY KEY,
  `fromDate` datetime UNIQUE NOT NULL,
  `toDate` datetime UNIQUE NOT NULL,
  `tax` decimal(3,2)
);

ALTER TABLE `order` ADD FOREIGN KEY (`ordererId`) REFERENCES `orderer` (`id`);

ALTER TABLE `orderDetail` ADD FOREIGN KEY (`orderId`) REFERENCES `order` (`id`);

ALTER TABLE `orderDetail` ADD FOREIGN KEY (`productId`) REFERENCES `product` (`id`);

ALTER TABLE `orderDetail` ADD FOREIGN KEY (`size`) REFERENCES `size` (`id`);

ALTER TABLE `product` ADD FOREIGN KEY (`productTypeId`) REFERENCES `productType` (`id`);
