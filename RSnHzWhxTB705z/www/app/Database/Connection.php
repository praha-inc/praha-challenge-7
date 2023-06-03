<?php
// レビュー不要です。
namespace Database;

abstract class Connection
{
    // ローカルでのみ実行するので、プログラム内に記入しています。
    private const DB_USER = 'root';
    private const DB_PASS = 'praha_root';

    private $db_name;

    protected $pdo;

    public function __construct($db_name)
    {

        $this->db_name = $db_name;

        try {

            $dsn = 'mysql:host=praha_db;dbname=' . $this->db_name . ';';
            $this->pdo = new \PDO($dsn, self::DB_USER, self::DB_PASS);

        } catch (\PDOException $e) {
            echo $e->getMessage();
        }

    }

    public function getPdo()
    {
        return $this->pdo;
    }

}
