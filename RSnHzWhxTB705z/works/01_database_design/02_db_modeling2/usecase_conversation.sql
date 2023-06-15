-- DBを選択
USE praha_slack;

-- MEMO : 通常 created_at は手動で格納しない予定ですが、今回はユースケースとしてSELECTする上で時間差をつけたいので、手動で格納しています。 ----------------

-- generalチャンネル ----------------

# Mio Saito: こんにちは。フロントエンドとバックエンドを担当しています。よろしくお願いいたします。
# INSERT INTO messages (id, user_id, channel_id, content) VALUES
# ('5ae27bb1-8085-442f-8206-49ec17bd4f8d', 'f0cb2f79-9bf9-456e-b74c-1c65412be1df', '0eef0129-3b18-47d3-9f01-44dc2e682670', 'こんにちは。フロントエンドとバックエンドを担当しています。よろしくお願いいたします。');
INSERT INTO messages (id, user_id, channel_id, content, created_at) VALUES
('5ae27bb1-8085-442f-8206-49ec17bd4f8d', 'f0cb2f79-9bf9-456e-b74c-1c65412be1df', '0eef0129-3b18-47d3-9f01-44dc2e682670', 'こんにちは。フロントエンドとバックエンドを担当しています。よろしくお願いいたします。', now() - 1000);

#   Mio Saito: 経験のある言語はJavaScriptとJavaとPHPです。
# INSERT INTO thread_messages (id, user_id, message_id, content) VALUES
# ('3f0b87ae-0bbd-4a92-8dd3-e0e004bfb708', 'f0cb2f79-9bf9-456e-b74c-1c65412be1df', '5ae27bb1-8085-442f-8206-49ec17bd4f8d', '経験のある言語はJavaScriptとJavaとPHPです。');
INSERT INTO thread_messages (id, user_id, message_id, content, created_at) VALUES
('3f0b87ae-0bbd-4a92-8dd3-e0e004bfb708', 'f0cb2f79-9bf9-456e-b74c-1c65412be1df', '5ae27bb1-8085-442f-8206-49ec17bd4f8d', '経験のある言語はJavaScriptとJavaとPHPです。', now() - 900);

#   Yuka Nakamura: 私もJavaを経験しました。
# INSERT INTO thread_messages (id, user_id, message_id, content) VALUES
# ('01c2dffa-921e-4108-82f4-eb202d0102d3', '6e50e1b8-68c7-4f54-9f7e-8b4d99b32f14', '5ae27bb1-8085-442f-8206-49ec17bd4f8d', 'Yuka Nakamura: 私もJavaを経験しました。');
INSERT INTO thread_messages (id, user_id, message_id, content, created_at) VALUES
('01c2dffa-921e-4108-82f4-eb202d0102d3', '6e50e1b8-68c7-4f54-9f7e-8b4d99b32f14', '5ae27bb1-8085-442f-8206-49ec17bd4f8d', 'Yuka Nakamura: 私もJavaを経験しました。', now() - 800);

# Rina Suzuki: こんにちは。フロントエンドを担当しています。よろしくお願いいたします。
# INSERT INTO messages (id, user_id, channel_id, content) VALUES
# ('9b8268fc-1bb2-47b6-bafa-1b1e9e932e61', 'eeb130bb-ccdb-4a12-b19e-98e0302b430a', '0eef0129-3b18-47d3-9f01-44dc2e682670', 'こんにちは。フロントエンドを担当しています。よろしくお願いいたします。');
INSERT INTO messages (id, user_id, channel_id, content, created_at) VALUES
('9b8268fc-1bb2-47b6-bafa-1b1e9e932e61', 'eeb130bb-ccdb-4a12-b19e-98e0302b430a', '0eef0129-3b18-47d3-9f01-44dc2e682670', 'こんにちは。フロントエンドを担当しています。よろしくお願いいたします。', now() - 700);

#   Rina Suzuki: 経験のあるフレームワークはVue.jsです。
# INSERT INTO thread_messages (id, user_id, message_id, content) VALUES
# ('1ad436b5-ef37-4f82-9d8d-8595597d69e8', 'eeb130bb-ccdb-4a12-b19e-98e0302b430a', '9b8268fc-1bb2-47b6-bafa-1b1e9e932e61', '経験のあるフレームワークはVue.jsです。');
INSERT INTO thread_messages (id, user_id, message_id, content, created_at) VALUES
('1ad436b5-ef37-4f82-9d8d-8595597d69e8', 'eeb130bb-ccdb-4a12-b19e-98e0302b430a', '9b8268fc-1bb2-47b6-bafa-1b1e9e932e61', '経験のあるフレームワークはVue.jsです。', now() - 600);

# Takumi Tanaka: こんにちは。バックエンドを担当しています。よろしくお願いいたします。
# INSERT INTO messages (id, user_id, channel_id, content) VALUES
# ('16ccd9fe-08e0-460b-a81c-4be37c1638d0', '85dc3b05-3d37-49f3-97c9-0d9fcb5a6a57', '0eef0129-3b18-47d3-9f01-44dc2e682670', 'こんにちは。バックエンドを担当しています。よろしくお願いいたします。');
INSERT INTO messages (id, user_id, channel_id, content, created_at) VALUES
('16ccd9fe-08e0-460b-a81c-4be37c1638d0', '85dc3b05-3d37-49f3-97c9-0d9fcb5a6a57', '0eef0129-3b18-47d3-9f01-44dc2e682670', 'こんにちは。バックエンドを担当しています。よろしくお願いいたします。', now() - 500);

#   Takumi Tanaka: 経験のある言語はPHPです。
# INSERT INTO thread_messages (id, user_id, message_id, content) VALUES
# ('9cc7851d-37a7-47ed-92dd-daad3ca12e18', '85dc3b05-3d37-49f3-97c9-0d9fcb5a6a57', '16ccd9fe-08e0-460b-a81c-4be37c1638d0', '経験のある言語はPHPです。');
INSERT INTO thread_messages (id, user_id, message_id, content, created_at) VALUES
('9cc7851d-37a7-47ed-92dd-daad3ca12e18', '85dc3b05-3d37-49f3-97c9-0d9fcb5a6a57', '16ccd9fe-08e0-460b-a81c-4be37c1638d0', '経験のある言語はPHPです。', now() - 400);


# Sora Kato: こんにちは。フロントエンドを担当しています。よろしくお願いいたします。
# INSERT INTO messages (id, user_id, channel_id, content) VALUES
# ('7aecbe13-d17c-4566-9025-f4e6ea46c28e', '3dcaad1f-656a-4f81-9651-7ea2a17e54b7', '0eef0129-3b18-47d3-9f01-44dc2e682670', 'こんにちは。フロントエンドを担当しています。よろしくお願いいたします。');
INSERT INTO messages (id, user_id, channel_id, content, created_at) VALUES
('7aecbe13-d17c-4566-9025-f4e6ea46c28e', '3dcaad1f-656a-4f81-9651-7ea2a17e54b7', '0eef0129-3b18-47d3-9f01-44dc2e682670', 'こんにちは。フロントエンドを担当しています。よろしくお願いいたします。', now() - 300);

# Yuka Nakamura: こんにちは。バックエンドを担当しています。よろしくお願いいたします。
# INSERT INTO messages (id, user_id, channel_id, content) VALUES
# ('bcc918de-3c14-4057-8b0d-22c7e1dbf020', '6e50e1b8-68c7-4f54-9f7e-8b4d99b32f14', '0eef0129-3b18-47d3-9f01-44dc2e682670', 'こんにちは。バックエンドを担当しています。よろしくお願いいたします。');
INSERT INTO messages (id, user_id, channel_id, content, created_at) VALUES
('bcc918de-3c14-4057-8b0d-22c7e1dbf020', '6e50e1b8-68c7-4f54-9f7e-8b4d99b32f14', '0eef0129-3b18-47d3-9f01-44dc2e682670', 'こんにちは。バックエンドを担当しています。よろしくお願いいたします。', now() - 200);


-- // generalチャンネル ----------------

--  team-1チャンネル ----------------

# Rina Suzuki: Mio Saitoさんはどのフロントエンドフレームワークの経験がありますか？
# INSERT INTO messages (id, user_id, channel_id, content) VALUES
# ('fedccbb4-61fa-49b2-8a78-746aa2aea950', 'eeb130bb-ccdb-4a12-b19e-98e0302b430a', '0cc0c065-7b70-4b1c-81d6-47a54bfa9986', 'Mio Saitoさんはどのフロントエンドフレームワークの経験がありますか？');
INSERT INTO messages (id, user_id, channel_id, content, created_at) VALUES
('fedccbb4-61fa-49b2-8a78-746aa2aea950', 'eeb130bb-ccdb-4a12-b19e-98e0302b430a', '0cc0c065-7b70-4b1c-81d6-47a54bfa9986', 'Mio Saitoさんはどのフロントエンドフレームワークの経験がありますか？', now() - 20);

# Mio Saito: Vue.jsです。
# INSERT INTO messages (id, user_id, channel_id, content) VALUES
# ('9402a81c-990d-4979-98fa-5053c4e72948', 'f0cb2f79-9bf9-456e-b74c-1c65412be1df', '0cc0c065-7b70-4b1c-81d6-47a54bfa9986', 'Vue.jsです。');
INSERT INTO messages (id, user_id, channel_id, content, created_at) VALUES
('9402a81c-990d-4979-98fa-5053c4e72948', 'f0cb2f79-9bf9-456e-b74c-1c65412be1df', '0cc0c065-7b70-4b1c-81d6-47a54bfa9986', 'Vue.jsです。', now() - 19);

# Rina Suzuki: ではフロントのフレームワークはVue.jsでよさそうですね。
# INSERT INTO messages (id, user_id, channel_id, content) VALUES
# ('ba3fe68c-801b-49e2-9a8b-f55a2e9e9ea5', 'eeb130bb-ccdb-4a12-b19e-98e0302b430a', '0cc0c065-7b70-4b1c-81d6-47a54bfa9986', 'ではフロントのフレームワークはVue.jsでよさそうですね。');
INSERT INTO messages (id, user_id, channel_id, content, created_at) VALUES
('ba3fe68c-801b-49e2-9a8b-f55a2e9e9ea5', 'eeb130bb-ccdb-4a12-b19e-98e0302b430a', '0cc0c065-7b70-4b1c-81d6-47a54bfa9986', 'ではフロントのフレームワークはVue.jsでよさそうですね。', now() - 18);

# Takumi Tanaka: こんにちは。来週から参加させていただきます。
# INSERT INTO messages (id, user_id, channel_id, content) VALUES
# ('7f4ba5f6-0a66-4c00-89c4-7dead9df835e', '85dc3b05-3d37-49f3-97c9-0d9fcb5a6a57', '0cc0c065-7b70-4b1c-81d6-47a54bfa9986', 'こんにちは。来週から参加させていただきます。');
INSERT INTO messages (id, user_id, channel_id, content, created_at) VALUES
('7f4ba5f6-0a66-4c00-89c4-7dead9df835e', '85dc3b05-3d37-49f3-97c9-0d9fcb5a6a57', '0cc0c065-7b70-4b1c-81d6-47a54bfa9986', 'こんにちは。来週から参加させていただきます。', now() - 17);

#   Mio Saito: よろしくお願いいたします。Takumi TanakaはPHPの経験があるんですよね？
# INSERT INTO thread_messages (id, user_id, message_id, content) VALUES
# ('f8e74a91-4fce-4268-85b6-91c0e0fdd747', 'f0cb2f79-9bf9-456e-b74c-1c65412be1df', '7f4ba5f6-0a66-4c00-89c4-7dead9df835e', 'よろしくお願いいたします。Takumi TanakaはPHPの経験があるんですよね？');
INSERT INTO thread_messages (id, user_id, message_id, content, created_at) VALUES
('f8e74a91-4fce-4268-85b6-91c0e0fdd747', 'f0cb2f79-9bf9-456e-b74c-1c65412be1df', '7f4ba5f6-0a66-4c00-89c4-7dead9df835e', 'よろしくお願いいたします。Takumi TanakaはPHPの経験があるんですよね？', now() - 16);

#   Takumi Tanaka: はい。
# INSERT INTO thread_messages (id, user_id, message_id, content) VALUES
# ('b5ef0a49-f197-4e8a-822d-12540f58dd4f', '85dc3b05-3d37-49f3-97c9-0d9fcb5a6a57', '7f4ba5f6-0a66-4c00-89c4-7dead9df835e', 'はい。');
INSERT INTO thread_messages (id, user_id, message_id, content, created_at) VALUES
('b5ef0a49-f197-4e8a-822d-12540f58dd4f', '85dc3b05-3d37-49f3-97c9-0d9fcb5a6a57', '7f4ba5f6-0a66-4c00-89c4-7dead9df835e', 'はい。', now() - 15);

#   Mio Saito: ではバックエンドはPHPで作りましょう。
# INSERT INTO thread_messages (id, user_id, message_id, content) VALUES
# ('22df1d2b-7454-4c1b-b313-87de6083a87f', 'f0cb2f79-9bf9-456e-b74c-1c65412be1df', '7f4ba5f6-0a66-4c00-89c4-7dead9df835e', 'ではバックエンドはPHPで作りましょう。');
INSERT INTO thread_messages (id, user_id, message_id, content, created_at) VALUES
('22df1d2b-7454-4c1b-b313-87de6083a87f', 'f0cb2f79-9bf9-456e-b74c-1c65412be1df', '7f4ba5f6-0a66-4c00-89c4-7dead9df835e', 'ではバックエンドはPHPで作りましょう。', now() - 14);

-- // team-1チャンネル ----------------

--  team-2チャンネル ----------------

# Mio Saito: team-1はVue.jsとPHPでつくることになりました。
# INSERT INTO messages (id, user_id, channel_id, content) VALUES
# ('525fa633-31d9-435a-97d0-8ec983bea651', 'f0cb2f79-9bf9-456e-b74c-1c65412be1df', 'd8b1394a-4c7f-4a37-81d1-57d80ce23108', 'team-1はVue.jsとPHPでつくることになりました。');
INSERT INTO messages (id, user_id, channel_id, content, created_at) VALUES
('525fa633-31d9-435a-97d0-8ec983bea651', 'f0cb2f79-9bf9-456e-b74c-1c65412be1df', 'd8b1394a-4c7f-4a37-81d1-57d80ce23108', 'team-1はVue.jsとPHPでつくることになりました。', now() - 13);

# Sora Kato: わたしもVue.jsを使ったことがあるので、team-2もVue.jsにしましょう。
# INSERT INTO messages (id, user_id, channel_id, content) VALUES
# ('25f479da-6610-4e3b-a814-c91e99c9c561', '3dcaad1f-656a-4f81-9651-7ea2a17e54b7', 'd8b1394a-4c7f-4a37-81d1-57d80ce23108', 'わたしもVue.jsを使ったことがあるので、team-2もVue.jsにしましょう。');
INSERT INTO messages (id, user_id, channel_id, content, created_at) VALUES
('25f479da-6610-4e3b-a814-c91e99c9c561', '3dcaad1f-656a-4f81-9651-7ea2a17e54b7', 'd8b1394a-4c7f-4a37-81d1-57d80ce23108', 'わたしもVue.jsを使ったことがあるので、team-2もVue.jsにしましょう。', now() - 12);

# Yuka Nakamura: わたしもPHP大丈夫です。バックエンドも同じにしましょう。
# INSERT INTO messages (id, user_id, channel_id, content) VALUES
# ('3254d1df-4f76-40e1-8371-eec367b26084', '6e50e1b8-68c7-4f54-9f7e-8b4d99b32f14', 'd8b1394a-4c7f-4a37-81d1-57d80ce23108', 'わたしもPHP大丈夫です。バックエンドも同じにしましょう。');
INSERT INTO messages (id, user_id, channel_id, content, created_at) VALUES
('3254d1df-4f76-40e1-8371-eec367b26084', '6e50e1b8-68c7-4f54-9f7e-8b4d99b32f14', 'd8b1394a-4c7f-4a37-81d1-57d80ce23108', 'わたしもPHP大丈夫です。バックエンドも同じにしましょう。', now() - 11);

# Mio Saito: ではteam-2もはteam-2と同じでVue.jsとPHPですね。
# INSERT INTO messages (id, user_id, channel_id, content) VALUES
# ('b9e886b0-d80e-4863-b88f-abc121cc531f', 'f0cb2f79-9bf9-456e-b74c-1c65412be1df', 'd8b1394a-4c7f-4a37-81d1-57d80ce23108', 'ではteam-2もはteam-2と同じでVue.jsとPHPですね。');
INSERT INTO messages (id, user_id, channel_id, content, created_at) VALUES
('b9e886b0-d80e-4863-b88f-abc121cc531f', 'f0cb2f79-9bf9-456e-b74c-1c65412be1df', 'd8b1394a-4c7f-4a37-81d1-57d80ce23108', 'ではteam-2もはteam-2と同じでVue.jsとPHPですね。', now() - 10);

# Mio Saito:削除: ではteam-2もはteam-2と同じでVue.jsとPHPですね。
UPDATE messages SET is_deleted = 1 WHERE id = 'b9e886b0-d80e-4863-b88f-abc121cc531f';

# Mio Saito: ではteam-2もはteam-1と同じでVue.jsとPHPですね。
# INSERT INTO messages (id, user_id, channel_id, content) VALUES
# ('99f40697-83d7-484a-a4cd-75750e854db5', 'f0cb2f79-9bf9-456e-b74c-1c65412be1df', 'd8b1394a-4c7f-4a37-81d1-57d80ce23108', 'ではteam-2もはteam-1と同じでVue.jsとPHPですね。');
INSERT INTO messages (id, user_id, channel_id, content, created_at) VALUES
('99f40697-83d7-484a-a4cd-75750e854db5', 'f0cb2f79-9bf9-456e-b74c-1c65412be1df', 'd8b1394a-4c7f-4a37-81d1-57d80ce23108', 'ではteam-2もはteam-1と同じでVue.jsとPHPですね。', now() - 9);

# Mio Saito: よろしくおねがいします。
# INSERT INTO messages (id, user_id, channel_id, content) VALUES
# ('8198b2b9-af5f-444e-a36d-bcc4a866de1c', 'f0cb2f79-9bf9-456e-b74c-1c65412be1df', 'd8b1394a-4c7f-4a37-81d1-57d80ce23108', 'よろしくおねがいします。');
INSERT INTO messages (id, user_id, channel_id, content, created_at) VALUES
('8198b2b9-af5f-444e-a36d-bcc4a866de1c', 'f0cb2f79-9bf9-456e-b74c-1c65412be1df', 'd8b1394a-4c7f-4a37-81d1-57d80ce23108', 'よろしくおねがいします。', now() - 8);

# Mio Saito:編集: よろしくおねがいします。→よろしくお願いします。
UPDATE messages SET content = 'よろしくお願いします。' WHERE id = '8198b2b9-af5f-444e-a36d-bcc4a866de1c';

-- // team-2チャンネル ----------------
