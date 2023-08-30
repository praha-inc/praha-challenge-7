# 課題4
## テーブル定義
[テーブル定義](task_04_sushi_order_ddl.sql)

## サンプルデータ登録クエリ
### 消費税(tax)
INSERT INTO `tax` (`id`, `fromDate`, `toDate`, `tax`) VALUES(1,'1989/04/01','1997/03/31',0.03);  
INSERT INTO `tax` (`id`, `fromDate`, `toDate`, `tax`) VALUES(2,'1997/04/01','2014/03/31',0.05);  
INSERT INTO `tax` (`id`, `fromDate`, `toDate`, `tax`) VALUES(3,'2014/04/01','2019/09/30',0.08);  
INSERT INTO `tax` (`id`, `fromDate`, `toDate`, `tax`) VALUES(4,'2019/10/01','9999/12/31',0.1);  
### サイズ(size)
INSERT INTO `size` (`id`, `name`) VALUES(1,'大');  
INSERT INTO `size` (`id`, `name`) VALUES(2,'小');  
### 商品区分(productType)
INSERT INTO `productType` (`id`, `description`) VALUES(1,'単品');  
INSERT INTO `productType` (`id`, `description`) VALUES(2,'セット');  
### 商品(product)
INSERT INTO `product` (`id`, `name`, `price`, `productTypeId`) VALUES(1,'玉子',100,1);  
INSERT INTO `product` (`id`, `name`, `price`, `productTypeId`) VALUES(2,'いなり',100,1);  
INSERT INTO `product` (`id`, `name`, `price`, `productTypeId`) VALUES(3,'納豆軍艦',100,1);  
INSERT INTO `product` (`id`, `name`, `price`, `productTypeId`) VALUES(4,'ツナサラダ',100,1);  
INSERT INTO `product` (`id`, `name`, `price`, `productTypeId`) VALUES(5,'コーン',100,1);  
INSERT INTO `product` (`id`, `name`, `price`, `productTypeId`) VALUES(6,'かにサラダ',100,1);  
INSERT INTO `product` (`id`, `name`, `price`, `productTypeId`) VALUES(7,'オクラ軍艦',100,1);  
INSERT INTO `product` (`id`, `name`, `price`, `productTypeId`) VALUES(8,'ゆでげそ',150,1);  
INSERT INTO `product` (`id`, `name`, `price`, `productTypeId`) VALUES(9,'とびっこ',150,1);  
INSERT INTO `product` (`id`, `name`, `price`, `productTypeId`) VALUES(10,'明太子サラダ',150,1);  
INSERT INTO `product` (`id`, `name`, `price`, `productTypeId`) VALUES(11,'いかの塩辛',150,1);  
INSERT INTO `product` (`id`, `name`, `price`, `productTypeId`) VALUES(12,'オクラ納豆',150,1);  
INSERT INTO `product` (`id`, `name`, `price`, `productTypeId`) VALUES(13,'かんぴょう巻',150,1);  
INSERT INTO `product` (`id`, `name`, `price`, `productTypeId`) VALUES(14,'なっとう巻',150,1);  
INSERT INTO `product` (`id`, `name`, `price`, `productTypeId`) VALUES(15,'かっぱ巻',150,1);  
INSERT INTO `product` (`id`, `name`, `price`, `productTypeId`) VALUES(16,'おしんこ巻',150,1);  
INSERT INTO `product` (`id`, `name`, `price`, `productTypeId`) VALUES(17,'梅しそ巻',150,1);  
INSERT INTO `product` (`id`, `name`, `price`, `productTypeId`) VALUES(18,'えび',180,1);  
INSERT INTO `product` (`id`, `name`, `price`, `productTypeId`) VALUES(19,'赤いか',180,1);  
INSERT INTO `product` (`id`, `name`, `price`, `productTypeId`) VALUES(20,'かにみそ軍艦',180,1);  
INSERT INTO `product` (`id`, `name`, `price`, `productTypeId`) VALUES(21,'生サーモン',220,1);  
INSERT INTO `product` (`id`, `name`, `price`, `productTypeId`) VALUES(22,'オニオンサーモン',220,1);  
INSERT INTO `product` (`id`, `name`, `price`, `productTypeId`) VALUES(23,'まぐろ赤身',220,1);  
INSERT INTO `product` (`id`, `name`, `price`, `productTypeId`) VALUES(24,'ゆでたこ',220,1);  
INSERT INTO `product` (`id`, `name`, `price`, `productTypeId`) VALUES(25,'あじ',260,1);  
INSERT INTO `product` (`id`, `name`, `price`, `productTypeId`) VALUES(26,'赤えび',260,1);  
INSERT INTO `product` (`id`, `name`, `price`, `productTypeId`) VALUES(27,'生たこ',260,1);  
INSERT INTO `product` (`id`, `name`, `price`, `productTypeId`) VALUES(28,'えんがわ',260,1);  
INSERT INTO `product` (`id`, `name`, `price`, `productTypeId`) VALUES(29,'炙りえんがわ',260,1);  
INSERT INTO `product` (`id`, `name`, `price`, `productTypeId`) VALUES(30,'まぐろ塩だれ焼',260,1);  
INSERT INTO `product` (`id`, `name`, `price`, `productTypeId`) VALUES(31,'焼えび',260,1);  
INSERT INTO `product` (`id`, `name`, `price`, `productTypeId`) VALUES(32,'ねぎとろ',260,1);  
INSERT INTO `product` (`id`, `name`, `price`, `productTypeId`) VALUES(33,'炙りサーモン',260,1);  
INSERT INTO `product` (`id`, `name`, `price`, `productTypeId`) VALUES(34,'鉄火巻',260,1);  
INSERT INTO `product` (`id`, `name`, `price`, `productTypeId`) VALUES(35,'まぐろワサビ巻',260,1);  
INSERT INTO `product` (`id`, `name`, `price`, `productTypeId`) VALUES(36,'いくら',360,1);  
INSERT INTO `product` (`id`, `name`, `price`, `productTypeId`) VALUES(37,'ホタテ貝',360,1);  
INSERT INTO `product` (`id`, `name`, `price`, `productTypeId`) VALUES(38,'穴子',360,1);  
INSERT INTO `product` (`id`, `name`, `price`, `productTypeId`) VALUES(39,'真鯛',360,1);  
INSERT INTO `product` (`id`, `name`, `price`, `productTypeId`) VALUES(40,'活ヒラメ',400,1);  
INSERT INTO `product` (`id`, `name`, `price`, `productTypeId`) VALUES(41,'数の子',400,1);  
INSERT INTO `product` (`id`, `name`, `price`, `productTypeId`) VALUES(42,'ずわいがに',400,1);  
INSERT INTO `product` (`id`, `name`, `price`, `productTypeId`) VALUES(43,'トロタク巻',400,1);  
INSERT INTO `product` (`id`, `name`, `price`, `productTypeId`) VALUES(44,'すじこ巻',400,1);  
INSERT INTO `product` (`id`, `name`, `price`, `productTypeId`) VALUES(45,'中トロ',460,1);  
INSERT INTO `product` (`id`, `name`, `price`, `productTypeId`) VALUES(46,'特大海老',460,1);  
INSERT INTO `product` (`id`, `name`, `price`, `productTypeId`) VALUES(47,'あなご一本すし',520,1);  
INSERT INTO `product` (`id`, `name`, `price`, `productTypeId`) VALUES(48,'まぐろづくし',520,1);  
INSERT INTO `product` (`id`, `name`, `price`, `productTypeId`) VALUES(49,'白身づくし',520,1);  
INSERT INTO `product` (`id`, `name`, `price`, `productTypeId`) VALUES(50,'うに',600,1);  
INSERT INTO `product` (`id`, `name`, `price`, `productTypeId`) VALUES(51,'インドまぐろ大トロ',600,1);  
INSERT INTO `product` (`id`, `name`, `price`, `productTypeId`) VALUES(52,'はな',8650,2);  
INSERT INTO `product` (`id`, `name`, `price`, `productTypeId`) VALUES(53,'わたつみ',5680,2);  
INSERT INTO `product` (`id`, `name`, `price`, `productTypeId`) VALUES(54,'あさなぎ',4440,2);  
INSERT INTO `product` (`id`, `name`, `price`, `productTypeId`) VALUES(55,'ゆうなぎ',3830,2);  
INSERT INTO `product` (`id`, `name`, `price`, `productTypeId`) VALUES(56,'くろしお',2830,2);  
INSERT INTO `product` (`id`, `name`, `price`, `productTypeId`) VALUES(57,'いさりび',2180,2);  
INSERT INTO `product` (`id`, `name`, `price`, `productTypeId`) VALUES(58,'みさき',1940,2);  
INSERT INTO `product` (`id`, `name`, `price`, `productTypeId`) VALUES(59,'みなと',1490,2);  
INSERT INTO `product` (`id`, `name`, `price`, `productTypeId`) VALUES(60,'しおん',1060,2);  
INSERT INTO `product` (`id`, `name`, `price`, `productTypeId`) VALUES(61,'なぎさ',800,2);  
INSERT INTO `product` (`id`, `name`, `price`, `productTypeId`) VALUES(62,'海鮮ちらし',1280,2);  
INSERT INTO `product` (`id`, `name`, `price`, `productTypeId`) VALUES(63,'鉄火丼',1000,2);  
INSERT INTO `product` (`id`, `name`, `price`, `productTypeId`) VALUES(64,'鮨八宝巻',1280,2);  
INSERT INTO `product` (`id`, `name`, `price`, `productTypeId`) VALUES(65,'鮨八宝巻 化粧箱入り',1480,2);   
### 注文者(orderer)
INSERT INTO `orderer` (`id`, `name`, `phoneNumber`) VALUES(1,'佐藤 蒼','090-1890-3453');  
INSERT INTO `orderer` (`id`, `name`, `phoneNumber`) VALUES(2,'鈴木 凪','090-3153-3132');  
INSERT INTO `orderer` (`id`, `name`, `phoneNumber`) VALUES(3,'高橋 蓮','090-9831-4528');  
INSERT INTO `orderer` (`id`, `name`, `phoneNumber`) VALUES(4,'田中 陽翔','090-4623-8098');  
### 注文(order)
INSERT INTO `order` (`id`, `ordererId`, `status`, `totalorderCount`, `amount`) VALUES(1,1,1,5,2981);  
INSERT INTO `order` (`id`, `ordererId`, `status`, `totalorderCount`, `amount`) VALUES(2,2,2,6,3190);  
INSERT INTO `order` (`id`, `ordererId`, `status`, `totalorderCount`, `amount`) VALUES(3,3,9,7,2244);  
### 注文詳細(orderDetail)

## ユースケースクエリ
### 注文情報取得
SELECT  
    oe.name AS 注文者  
   ,oe.phoneNumber AS 連絡先  
   ,o.status AS 注文ステータス  
   ,o.totalorderCount AS 注文合計数  
   ,o.amount AS 注文合計金額  
   ,p.name AS 注文商品名  
   ,format(p.price * t.tax, 0) AS 商品金額  
   ,CASE  
      WHEN od.isWasabi = true THEN 'あり'  
      WHEN od.isWasabi = false THEN 'なし'  
    END AS ワサビ有無  
   ,s.name AS サイズ  
   ,pt.description AS 商品区分  
FROM  
    `order` AS o  
    LEFT JOIN orderDetail AS od  
    ON  
        o.id = od.orderId  
    LEFT JOIN orderer AS oe  
    ON  
        o.ordererId = oe.id  
    INNER JOIN product AS p  
    ON  
        od.productId = p.id  
    LEFT JOIN tax AS t  
    ON  
        o.date BETWEEN t.fromDate AND t.toDate  
    LEFT JOIN size s  
    ON  
        od.size = s.id  
    LEFT JOIN productType AS pt  
    ON  
        p.productTypeId = pt.id  
WHERE  
    o.id = 1;  

### 支払金額
SELECT DISTINCT  
    oe.name AS 注文者  
   ,oe.phoneNumber AS 連絡先  
   ,o.status AS 注文ステータス  
   ,o.totalorderCount AS 注文合計数  
   ,o.amount AS 注文合計金額  
FROM  
    `order` AS o  
    LEFT JOIN orderDetail AS od  
    ON  
        o.id = od.orderId  
    LEFT JOIN orderer AS oe  
    ON  
        o.ordererId = oe.id  


