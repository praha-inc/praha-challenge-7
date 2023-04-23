<?php

/**
 * 確認用のファイルなのでレビューは不要です。
 * 自分の確認用なので変数名結構適当です。
 */

include __DIR__ . '/../../../app/common.php';
require_once APP_ROOT . '/app/DbModeling/Slack.php';

use DbModeling\Slack;

$results = [];

$slack = new Slack();

$users = $slack->getUsers();
$workspaces = $slack->getWorkspaces();

// praha2を表示
$workspace = array_values(array_filter($workspaces, function($wk) {
    return $wk['name'] === 'praha2';
}))[0];

// praha2のチャンネルを取得
$channels = $slack->getChannels($workspace['id']);

// ユーザー、チャンネル対応の表を表示するための配列
$usersChannelsTables = [];
foreach ($users as $user) {
    $usersChannelsTables[$user['name']] = [];
    foreach ($channels as $channel) {
        $usersChannelsTables[$user['name']][$channel['name']] = false;
    }
}

// generalチャンネルを表示
try {
    $generalChannel = $slack->getChannel('general', $workspace['id']);
    $generalMessages = $slack->getMessages($generalChannel['id'], $slack->getGeneralChannelAccessibleUsers());
} catch (\Exception $e) {
    $generalMessagesError = $e->getMessage();
}

// 特定のユーザーを格納する（所属しているチャンネル、所属していないチャンネルの表示チェックのため）
// MEMO: 確認のUI用なので仮で変数名つけてます。
$tmpUser1Id = '';
$tmpUser2Id = '';

foreach ($users as $user) {

    // ユーザーid
    $userId = $user['id'];

    // ユーザーがどのチャンネルに参加しているか
    $userChannels = $slack->getUserChannels($userId);

    // ユーザーとチャンネルの一覧表を作成
    foreach ($userChannels as $userChannel) {
        foreach ($usersChannelsTables[$user['name']] as $channelName => &$bool) {
            if ($channelName === $userChannel['c_name']) $bool = true;
        }
        unset($bool);
    }

    // 検索結果
    $search1 = $slack->searchMessagesAndThreadMessages($userId, '来週');
    $search2 = $slack->searchMessagesAndThreadMessages($userId, 'PHP');
    $search3 = $slack->searchMessagesAndThreadMessages($userId, 'Vue.js');

    // 各ユーザーの詳細表示
    $results[] = [
        'name' => $user['name'],
        'id' => $user['id'],
        'channels' => array_map(function($channel) {
            return $channel['c_name'];
        }, $userChannels),
        'search1' => $search1,
        'search2' => $search2,
        'search3' => $search3,
    ];


    // MEMO: 確認のUI用
    if ($user['name'] === 'Rina Suzuki') {
        $tmpUser1Id = $user['id'];
    } else if ($user['name'] === 'Sora Kato') {
        $tmpUser2Id = $user['id'];
    }
}

$team1Channel = $slack->getChannel('team-1', $workspace['id']);
$team2Channel = $slack->getChannel('team-2', $workspace['id']);

try {
    $team1Messages = $slack->getMessages($team1Channel['id'], $tmpUser1Id);
} catch (\Exception $e) {
    $team1MessagesError = $e->getMessage();
}
try {
    $team2Messages1 = $slack->getMessages($team2Channel['id'], $tmpUser1Id);
} catch (\Exception $e) {
    $team2MessagesError1 = $e->getMessage();
}
try {
    $team2Messages2 = $slack->getMessages($team2Channel['id'], $tmpUser2Id);
} catch (\Exception $e) {
    $team2MessagesError2 = $e->getMessage();
}

// 各ユーザーのチームチャンネルの情報を格納
$teamMessages = [
    'case1' => [
        'title' => 'Rina Suzuki が team-1 チャンネルを表示した場合',
        'messages' => $team1Messages ?? [],
        'error' => $team1MessagesError ?? '',
    ],
    'case2' => [
        'title' => 'Rina Suzuki が team-2 チャンネルを表示した場合（UI上では表示されないのでできないですが、SQL文的に）',
        'messages' => $team2Messages1 ?? [],
        'error' => $team2MessagesError1 ?? '',
    ],
    'case3' => [
        'title' => 'Sora Kato が team-2 チャンネルを表示した場合',
        'messages' => $team2Messages2 ?? [],
        'error' => $team2MessagesError2 ?? '',
    ],
];

?>
<!doctype html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
<!--    <link rel="stylesheet" href="/css/normalize.css">-->
    <style>
        ul {
            padding-left: 0;
        }
        li {
            list-style: none;
        }
    </style>
</head>
<body>

<div>

    <h2>基本情報</h2>

    <h3>ワークスペース一覧</h3>
    <ul>
        <?php foreach ($workspaces as $workspace) { ?>
            <li><?= $workspace['name'] ?></li>
        <?php } ?>
    </ul>

    <p style="margin-top: 40px;">以下はすべてワークスペース「praha2」のものとします。</p>

    <div style="display: flex;">

        <div>
            <h3>ユーザー一覧</h3>
            <ul>
                <?php foreach ($users as $user) { ?>
                    <li><?= $user['name'] ?></li>
                <?php } ?>
            </ul>
        </div>
        <div style="margin-left: 80px;">
            <h3>チャンネル一覧</h3>
            <ul>
                <?php foreach ($channels as $channel) { ?>
                    <li><?= $channel['name'] ?></li>
                <?php } ?>
            </ul>
        </div>

    </div>

    <div>
        <h3>ユーザー、チャンネル対応</h3>
        <?php
        $isFirst = true;
        foreach ($usersChannelsTables as $userName => $channels) {
        ?>

            <?php
            if ($isFirst) {
                $colTitles = array_keys($channels);
                $isFirst = false;
            ?>

            <div style="display: flex;">
                <p style="margin: 0; width: 160px;"></p>
                <div style="display: flex;">
                    <?php foreach ($colTitles as $colTitle) { ?>
                        <p style="display: flex; justify-content:center; margin: 0; width: 80px;"><?= $colTitle ?></p>
                    <?php } ?>
                </div>
            </div>

            <?php
            }
            ?>

            <div style="display: flex;">
                <p style="margin: 0; width: 160px;"><?= $userName ?></p>
                <div style="display: flex;">
                    <?php foreach ($channels as $channel) { ?>
                        <p style="display: flex; justify-content:center; margin: 0; width: 80px;"><?= $channel ? '○' : '×' ?></p>
                    <?php } ?>
                </div>
            </div>

            <?php } ?>
    </div>

</div>


<hr style="margin: 40px 0;">

<div>
    <h2>general の表示</h2>
    <p>※インデントなしはチャンネルへのメッセージ</p>
    <p>※インデントありは、直前のメッセージへのスレッドメッセージ</p>
    <ul>
        <?php foreach ($generalMessages as $generalMessage) { ?>
            <li style="margin-top: 40px;">
                <ul>
                    <li>投稿ID : <?= h($generalMessage['id']); ?></li>
                    <li>投稿者名 : <?= h($generalMessage['userName']); ?></li>
                    <li>投稿内容 : <?= h($generalMessage['content']); ?></li>
                    <li>投稿日時 : <?= h($generalMessage['created_at']); ?></li>
                    <li>編集日時 : <?= h($generalMessage['updated_at']); ?></li>
                    <?php if (count($generalMessage['thread_messages']) > 0) { ?>

                        <ul style="margin: 12px 0 0 40px;">
                            <?php foreach ($generalMessage['thread_messages'] as $thread_message) { ?>
                                <li style="margin-top: 12px;">
                                    <ul>
                                        <li>投稿ID : <?= h($thread_message['id']); ?></li>
                                        <li>投稿者名 : <?= h($thread_message['userName']); ?></li>
                                        <li>投稿内容 : <?= h($thread_message['content']); ?></li>
                                        <li>投稿日時 : <?= h($thread_message['created_at']); ?></li>
                                        <li>編集日時 : <?= h($thread_message['updated_at']); ?></li>
                                    </ul>
                                </li>
                            <?php } ?>
                        </ul>

                    <?php } ?>
                </ul>
            </li>
        <?php } ?>
    </ul>
</div>

<hr style="margin: 40px 0;">

<div>

    <?php foreach ($teamMessages as $teamMessage) { ?>
    <div>
        <h2><?= $teamMessage['title']; ?></h2>
        <div>
            <?php if($teamMessage['error']) { ?>
                <p><?= $teamMessage['error'] ?></p>
            <?php } else { ?>
                <ul>
                    <?php foreach ($teamMessage['messages'] as $messages) { ?>
                        <li style="margin-top: 40px;">
                            <ul>
                                <li>投稿ID : <?= h($messages['id']); ?></li>
                                <li>投稿者名 : <?= h($messages['userName']); ?></li>
                                <li>投稿内容 : <?= h($messages['content']); ?></li>
                                <li>投稿日時 : <?= h($messages['created_at']); ?></li>
                                <li>編集日時 : <?= h($messages['updated_at']); ?></li>
                                <?php if (count($messages['thread_messages']) > 0) { ?>

                                    <ul style="margin: 12px 0 0 40px;">
                                        <?php foreach ($messages['thread_messages'] as $thread_message) { ?>
                                            <li style="margin-top: 12px;">
                                                <ul>
                                                    <li>投稿ID : <?= h($thread_message['id']); ?></li>
                                                    <li>投稿者名 : <?= h($thread_message['userName']); ?></li>
                                                    <li>投稿内容 : <?= h($thread_message['content']); ?></li>
                                                    <li>投稿日時 : <?= h($thread_message['created_at']); ?></li>
                                                    <li>編集日時 : <?= h($thread_message['updated_at']); ?></li>
                                                </ul>
                                            </li>
                                        <?php } ?>
                                    </ul>

                                <?php } ?>
                            </ul>
                        </li>
                    <?php } ?>
                </ul>
            <?php } ?>
        </div>
    </div>
    <?php } ?>

</div>

<hr style="margin: 40px 0;">

<div>

    <h2>各ユーザーの表示</h2>
    <ul>
        <?php foreach ($results as $result) { ?>
            <li style="margin: 40px 0 0 0;">
                <ul>
                    <li><h3>ユーザー : <?= h($result['name']); ?></h3></li>
                    <li>参加しているチャンネル一覧 : <?php foreach ($result['channels'] as $channel) { h($channel . '  '); } ?></li>
                    <li style="margin-top: 40px;">「来週」で検索 :
                        <ul style="margin-left: 40px;">
                            <?php
                            if (count($result['search1']) === 0) {
                                echo '<p>該当なし</p>';
                            } else {
                                foreach ($result['search1'] as $searchResult) {
                            ?>
                                <li style="margin-top: 12px;">
                                    <p style="margin: 0;">投稿者名 : <?= $searchResult['userName']; ?></p>
                                    <p style="margin: 0;">投稿チャンネル : <?= $searchResult['channelName']; ?></p>
                                    <p style="margin: 0;">投稿内容 : <?= $searchResult['content']; ?></p>
                                    <p style="margin: 0;">投稿日時 : <?= $searchResult['created_at']; ?></p>
                                </li>
                            <?php
                                }
                            }
                            ?>
                        </ul>
                    </li>
                    <li style="margin-top: 40px;">「PHP」で検索 :
                        <ul style="margin-left: 40px;">
                            <?php
                            if (count($result['search2']) === 0) {
                                echo '<p>該当なし</p>';
                            } else {
                                foreach ($result['search2'] as $searchResult) {
                                    ?>
                                    <li style="margin-top: 12px;">
                                        <p style="margin: 0;">投稿者名 : <?= $searchResult['userName']; ?></p>
                                        <p style="margin: 0;">投稿チャンネル : <?= $searchResult['channelName']; ?></p>
                                        <p style="margin: 0;">投稿内容 : <?= $searchResult['content']; ?></p>
                                        <p style="margin: 0;">投稿日時 : <?= $searchResult['created_at']; ?></p>
                                    </li>
                                    <?php
                                }
                            }
                            ?>
                        </ul>
                    </li>
                    <li style="margin-top: 40px;">「Vue.js」で検索 :
                        <ul style="margin-left: 40px;">
                            <?php
                            if (count($result['search3']) === 0) {
                                echo '<p>該当なし</p>';
                            } else {
                                foreach ($result['search3'] as $searchResult) {
                                    ?>
                                    <li style="margin-top: 12px;">
                                        <p style="margin: 0;">投稿者名 : <?= $searchResult['userName']; ?></p>
                                        <p style="margin: 0;">投稿チャンネル : <?= $searchResult['channelName']; ?></p>
                                        <p style="margin: 0;">投稿内容 : <?= $searchResult['content']; ?></p>
                                        <p style="margin: 0;">投稿日時 : <?= $searchResult['created_at']; ?></p>
                                    </li>
                                    <?php
                                }
                            }
                            ?>
                        </ul>
                    </li>
                </ul>
            </li>
        <?php } ?>
    </ul>

</div>

</body>
</html>

