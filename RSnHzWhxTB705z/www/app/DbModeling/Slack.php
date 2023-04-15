<?php
// レビュー不要です。

namespace DbModeling;

require_once __DIR__ . '/../Database/Connection.php';

use Database\Connection;

class Slack extends Connection
{

    private const DB_NAME = 'praha_slack';

    private const GENERAL_CHANNEL_ACCESSIBLE_USERS = 'ALL';

    public function __construct()
    {
        parent::__construct(self::DB_NAME);
    }

    public function getGeneralChannelAccessibleUsers()
    {
        return self::GENERAL_CHANNEL_ACCESSIBLE_USERS;
    }

    /**
     * 全ユーザーを取得
     * @return array
     */
    public function getUsers()
    {
        $sql = '
SELECT * FROM users
ORDER BY name
';
        $stmt = $this->pdo->prepare($sql);
        $stmt->execute();
        return $stmt->fetchAll(\PDO::FETCH_ASSOC);
    }

    /**
     * 全ワークスペースを取得
     * @return array
     */
    public function getWorkspaces()
    {
        $sql = '
SELECT * FROM workspaces WHERE is_deleted = 0
ORDER BY name
';
        $placeholders = [

        ];
        return $this->getRecords($sql, $placeholders);
    }

    /**
     * 指定のワークスペースから全チャンネルを取得
     * @param string $workspaceId
     * @return array
     */
    public function getChannels($workspaceId)
    {
        $sql = '
SELECT * FROM channels 
WHERE workspace_id = :workspace_id
AND is_deleted = 0
ORDER BY name
';
        $placeholders = [
            ':workspace_id' => $workspaceId
        ];
        return $this->getRecords($sql, $placeholders);
    }

    /**
     * チャンネル名から特定のチャンネル情報を取得
     * @param string $channelName
     * @param string $workspaceId
     * @return mixed
     */
    public function getChannel($channelName, $workspaceId)
    {
        $sql = '
SELECT * FROM channels
WHERE workspace_id = :workspace_id
AND name = :name 
AND is_deleted = 0
';
        $placeholders = [
            ':workspace_id' => $workspaceId,
            ':name' => $channelName
        ];
        return $this->getRecords($sql, $placeholders)[0];
    }

    /**
     * あるユーザーが参加している全チャンネルを取得
     * @param string $userId
     * @return array
     */
    public function getUserChannels($userId)
    {
        $sql = '
SELECT 
       c.id AS c_id, 
       c.name AS c_name, 
       c.created_at AS c_created_at, 
       c.updated_at AS c_updated_at, 
       uc.user_id AS uc_user_id, 
       uc.created_at AS uc_created_at, 
       uc.updated_at AS uc_updated_at 
FROM channels AS c
LEFT JOIN users_channels AS uc
    ON c.id = uc.channel_id
WHERE uc.user_id = :user_id
AND c.is_deleted = 0
AND uc.is_deleted = 0
ORDER BY c.name
    ';
        $placeholders = [
            ':user_id' => $userId
        ];

        return $this->getRecords($sql, $placeholders);
    }

    /**
     * ある特定のチャンネルの全メッセージを取得
     * （スレッドメッセージも合わせて取得して返す）
     * @param string $channelId
     * @param string $userId
     * @return array
     * @throws \Exception
     */
    public function getMessages($channelId, $userId)
    {

        if (!($this->isAccessible($channelId, $userId))) throw new \Exception('ユーザーがチャンネルに所属していません。');

        $sql = '
SELECT m.*, u.name AS userName, c.name as channelName FROM messages AS m
LEFT JOIN users AS u
    ON m.user_id = u.id
LEFT JOIN channels AS c
    ON m.channel_id = c.id
WHERE m.channel_id = :channel_id
AND m.is_deleted = 0
ORDER BY m.created_at
    ';
        $placeholders = [
            ':channel_id' => $channelId
        ];

        $messages = $this->getRecords($sql, $placeholders);

        foreach ($messages as &$message) {
            $message['thread_messages'] = $this->getThreadMessages($message['id']);
        }
        unset($message);

        return $messages;
    }

    /**
     * 検索処理
     * @param string $userId
     * @param string $content
     * @return array
     */
    public function searchMessagesAndThreadMessages($userId, $content)
    {

        $channels = $this->getUserChannels($userId);

        $messageResults = $this->searchMessages($channels, $content);
        $threadMessageResults = $this->searchThreadMessages($userId, $channels, $content);

        $searchResults = array_merge($messageResults, $threadMessageResults);

        $sortKeyCreatedAt = [];
        foreach ($searchResults as $searchResult) {
            $sortKeyCreatedAt[] = $searchResult['created_at'];
        }
        array_multisort($sortKeyCreatedAt, SORT_DESC, $searchResults);

        return $searchResults;
    }

    /**
     * メッセージからキーワードを検索する
     * @param array $channels
     * @param string $content
     * @return array
     */
    private function searchMessages($channels, $content)
    {
        $channelConditions = [];
        foreach ($channels as $index => $channel) {
            $channelConditions[] = ':id' . $index;
        }
        $channelCondition = '(' . implode(', ', $channelConditions) . ')';

        $sql = '
SELECT 
       m.id,
       m.user_id, 
       m.channel_id, 
       m.content, 
       m.created_at, 
       m.updated_at,
       c.name AS channelName,
       u.name AS userName 
FROM messages AS m
LEFT JOIN channels AS c
    ON m.channel_id = c.id
LEFT JOIN users AS u
    ON m.user_id = u.id
WHERE m.channel_id IN ' . $channelCondition . '
AND m.is_deleted = 0 
AND m.content LIKE :content
ORDER BY m.created_at
        ';

        $placeholders = [
            ':content' => '%' . $content . '%',
        ];
        foreach ($channels as $index => $channel) {
            $placeholders[':id' . $index] = $channel['c_id'];
        }

        return $this->getRecords($sql, $placeholders);
    }

    /**
     * スレッドメッセージからキーワードを検索する
     * @param string $userId
     * @param array $channels
     * @param string $content
     * @return array
     * @throws \Exception
     */
    private function searchThreadMessages($userId, $channels, $content)
    {
        $messages = [];
        foreach ($channels as $channel) {

            $results = $this->getMessages($channel['c_id'], $userId);
            foreach ($results as $result) {
                $messages[] = $result;
            }
        }
        $messageIds = array_map(function($message) {
            return $message['id'];
        }, $messages);

        $messageConditions = [];
        foreach ($messageIds as $index => $messageId) {
            $messageConditions[] = ':id' . $index;
        }
        $messageCondition = '(' . implode(', ', $messageConditions) . ')';

        $sql = '
SELECT 
       tm.id,
       tm.user_id, 
       tm.content, 
       tm.created_at, 
       tm.updated_at,
       c.name AS channelName,
       u.name AS userName 
FROM thread_messages AS tm
LEFT JOIN messages AS m
    ON tm.message_id = m.id
LEFT JOIN channels AS c
    ON m.channel_id = c.id
LEFT JOIN users AS u
    ON tm.user_id = u.id
WHERE tm.message_id IN ' . $messageCondition . '
AND tm.is_deleted = 0 
AND tm.content LIKE :content
ORDER BY tm.created_at
        ';

        $placeholders = [
            ':content' => '%' . $content . '%',
        ];
        foreach ($channels as $index => $channel) {
            $placeholders[':id' . $index] = $channel['c_id'];
        }
        foreach ($messageIds as $index => $messageId) {
            $placeholders[':id' . $index] = $messageId;
        }

        $results = $this->getRecords($sql, $placeholders);

        return $results;
    }

    /**
     * ユーザーがチャンネルにアクセス可能かどうかを判定する
     * @param string $channelId
     * @param string $userId
     * @return bool
     */
    private function isAccessible($channelId, $userId)
    {

        if ($userId === self::GENERAL_CHANNEL_ACCESSIBLE_USERS) return true;

        $sql = '
SELECT * FROM users_channels
WHERE channel_id = :channel_id
AND user_id = :user_id
AND is_deleted = 0
        ';
        $placeholders = [
            ':channel_id' => $channelId,
            ':user_id' => $userId
        ];
        $results = $this->getRecords($sql, $placeholders);

        return count($results) > 0;
    }

    /**
     * ある特定のメッセージに紐づくスレッドメッセージを取得
     * @param string $messageId
     * @return array
     */
    private function getThreadMessages($messageId)
    {
        $sql = '
SELECT tm.*, u.name AS userName FROM thread_messages AS tm
LEFT JOIN messages AS m
    ON tm.message_id = m.id
LEFT JOIN users AS u
    ON tm.user_id = u.id
WHERE m.id = :message_id
AND m.is_deleted = 0
ORDER BY tm.created_at
    ';
        $placeholders = [
            ':message_id' => $messageId
        ];

        return $this->getRecords($sql, $placeholders);
    }

    /**
     * SQL文の実行処理
     * @param string $sql
     * @param array $placeholders
     * @return array
     */
    private function getRecords($sql, $placeholders)
    {
        $stmt = $this->pdo->prepare($sql);

        if (count($placeholders) > 0) {
            foreach ($placeholders as $key => $value) {
                $stmt->bindValue($key, $value);
            }
        }

        $stmt->execute();
        return $stmt->fetchAll(\PDO::FETCH_ASSOC);
    }



}
