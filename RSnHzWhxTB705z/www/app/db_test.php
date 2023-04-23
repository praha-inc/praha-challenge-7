<?php
// レビュー不要です。
// 環境構築用のファイルです。

//$flg = 1;
$flg = 2;

switch ($flg) {
    case 1:
        $dbname = 'praha';
        $tablename = 'sample_table';
        break;
    case 2:
        $dbname = 'praha_sushi';
        $tablename = 'products';
        break;
    default:
        ;
}

try {
    // DB接続設定
    $dsn = 'mysql:host=praha_db;dbname=' . $dbname . ';';
    $db = new PDO($dsn, 'root', 'root');

    // SQL実行
    $sql = 'SELECT * FROM ' . $tablename . ';';
    $stmt = $db->prepare($sql);
    $stmt->execute();
    $result = $stmt->fetchAll(PDO::FETCH_ASSOC);

    // デバッグ
    var_dump($result);

} catch (PDOException $e) {
    echo $e->getMessage();
    exit;
}