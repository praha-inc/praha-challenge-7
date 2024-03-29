INSERT INTO User (id, name, display_name, email, password)
VALUES (
    null,
    '平川知秀',
    'ユーザー1',
    'hirakawa@test.com',
    'xxxxxxxxxxxxxxxxxxxxxx'
  ),
  (
    null,
    '田中秀樹',
    'ユーザー2',
    'tanaka@gmail.com',
    'xxxxxxxxxxxxxxxxxxxxxx'
  ),
  (
    null,
    '佐藤正雄',
    'ユーザー3',
    'tanaka@gmail.com',
    'xxxxxxxxxxxxxxxxxxxxxx'
  ),
  (
    null,
    '秋山信二',
    'ユーザー4',
    'tanaka@gmail.com',
    'xxxxxxxxxxxxxxxxxxxxxx'
  );
INSERT INTO WorkSpace (id, name)
VALUES (null, 'お仕事ワークスペース'),
  (null, '趣味色々ワークスペース');
INSERT INTO WorkSpaceMember (workspace_id, member_user_id)
VALUES (1, 1),
  (1, 2),
  (1, 4),
  (2, 1),
  (2, 3);
INSERT INTO Channel (id, name, workspace_id)
VALUES (null, 'お仕事相談', 1),
  (null, '会議', 1),
  (null, 'プロジェクトX', 1),
  (null, '公園でテニスしませんか', 2),
  (null, '朝の散歩', 2),
  (null, '茶道愛好会', 2);

INSERT INTO ChannelMember (channel_id, member_user_id)
VALUES (1, 1),
  (1, 2),
  (2, 1),
  (2, 3),
  (3, 1),
  (3, 4),
  (4, 1),
  (4, 2),
  (5, 1),
  (6, 1),
  (6, 3);
INSERT INTO Message (
    id,
    content,
    user_id,
    parent_message_id,
    post_datetime,
    channel_id
  )
VALUES (
    1,
    'こんにちは。転職しようと思ってます。',
    1,
    1,
    now(),
    1
  ),
  (
    2,
    'そうなんですね。頑張ってください。',
    2,
    1,
    now(),
    1
  ),
  (
    3,
    '会議は次は何時ですか？',
    1,
    3,
    now(),
    2
  ),
  (
    4,
    '自分で調べてください。',
    2,
    3,
    now(),
    2
  ),
  (
    5,
    '今度の日曜日公園でテニスしませんか。',
    1,
    5,
    now(),
    4
  ),
  (
    6,
    'いいですね。いつにしますか？',
    4,
    5,
    now(),
    4
  ),
  (
    7,
    '今度の茶道は欠席します。',
    1,
    7,
    now(),
    6
  ),
  (
    8,
    'そうですか？どうしてですか？',
    3,
    7,
    now(),
    6
  ),
  (
    9,
    '茶道に興味がなくなりました。',
    1,
    7,
    now(),
    6
  );