-- DBを選択
USE praha_slack;

-- ワークスペース ----------------

-- 全ユーザーがワークスペース「praha1」に参加
INSERT INTO users_workspaces (id, user_id, workspace_id) VALUES
('1323f8e3-9b01-4f0e-85f8-67f25678df62', 'f0cb2f79-9bf9-456e-b74c-1c65412be1df', '30d925c9-9e92-47e8-bc47-75de0e21c93b'),
('39a29cc4-4ce4-4b44-98e7-f2d8c1d7f07e', 'eeb130bb-ccdb-4a12-b19e-98e0302b430a', '30d925c9-9e92-47e8-bc47-75de0e21c93b'),
('9a1544d1-0a7b-4be6-b1f6-ffed2c0827ee', '3dcaad1f-656a-4f81-9651-7ea2a17e54b7', '30d925c9-9e92-47e8-bc47-75de0e21c93b'),
('2a136a97-3a3d-4b75-8b95-19b31c18e7e6', '85dc3b05-3d37-49f3-97c9-0d9fcb5a6a57', '30d925c9-9e92-47e8-bc47-75de0e21c93b'),
('5f5b5f5d-bd5c-40c2-b921-6f52e3f1b6d8', '6e50e1b8-68c7-4f54-9f7e-8b4d99b32f14', '30d925c9-9e92-47e8-bc47-75de0e21c93b');

-- ユーザー「Mio Saito」がワークスペース「praha1」から脱退
UPDATE users_workspaces SET is_deleted = 1
WHERE user_id = 'f0cb2f79-9bf9-456e-b74c-1c65412be1df'
AND workspace_id = '30d925c9-9e92-47e8-bc47-75de0e21c93b';

-- 全ユーザーがワークスペース「praha2」に参加
INSERT INTO users_workspaces (id, user_id, workspace_id) VALUES
('50e91ef2-10a7-4c8b-94e6-ba5f0fbf6e20', 'f0cb2f79-9bf9-456e-b74c-1c65412be1df', 'c7c12e0d-9e9e-4c8c-b6d1-b6c4a4e4f008'),
('9da6c98d-7bb5-466c-b6f7-08f16c6d4115', 'eeb130bb-ccdb-4a12-b19e-98e0302b430a', 'c7c12e0d-9e9e-4c8c-b6d1-b6c4a4e4f008'),
('65d83f9d-5d0f-4250-a2c5-5ca3e3c720d5', '3dcaad1f-656a-4f81-9651-7ea2a17e54b7', 'c7c12e0d-9e9e-4c8c-b6d1-b6c4a4e4f008'),
('2e9dc9d3-3f1e-4e16-9307-83c156aad899', '85dc3b05-3d37-49f3-97c9-0d9fcb5a6a57', 'c7c12e0d-9e9e-4c8c-b6d1-b6c4a4e4f008'),
('c4fc4a7d-c4e1-4d90-9868-22252b1dd109', '6e50e1b8-68c7-4f54-9f7e-8b4d99b32f14', 'c7c12e0d-9e9e-4c8c-b6d1-b6c4a4e4f008');

-- // ワークスペース ----------------


-- チャンネル ----------------
-- 全操作ワークスペース「praha2」で実行されたものとする

-- ユーザー「Mio Saito」がチャンネル「general」を作成
INSERT INTO channels (id, workspace_id, name) VALUES
('0eef0129-3b18-47d3-9f01-44dc2e682670', 'c7c12e0d-9e9e-4c8c-b6d1-b6c4a4e4f008', 'general');
INSERT INTO users_channels (id, user_id, channel_id) VALUES
('c17bca10-f6ec-4026-8db6-d36d6eef44d9', 'f0cb2f79-9bf9-456e-b74c-1c65412be1df', '0eef0129-3b18-47d3-9f01-44dc2e682670');

-- ユーザー「Mio Saito」がチャンネル「question」を作成
INSERT INTO channels (id, workspace_id, name) VALUES
('3a8803cc-3083-41b9-9b18-1b13dc7d236e', 'c7c12e0d-9e9e-4c8c-b6d1-b6c4a4e4f008', 'question');
INSERT INTO users_channels (id, user_id, channel_id) VALUES
('e8db2b17-6b57-462c-b7b6-bff33e9157a2', 'f0cb2f79-9bf9-456e-b74c-1c65412be1df', '3a8803cc-3083-41b9-9b18-1b13dc7d236e');

-- ユーザー「Mio Saito」がチャンネル「review」を作成
INSERT INTO channels (id, workspace_id, name) VALUES
('38e4c77b-ec8b-4a4e-a85d-10a1142e8f52', 'c7c12e0d-9e9e-4c8c-b6d1-b6c4a4e4f008', 'review');
INSERT INTO users_channels (id, user_id, channel_id) VALUES
('9dc9b8db-68f7-4f13-af56-320ab8fbbce1', 'f0cb2f79-9bf9-456e-b74c-1c65412be1df', '38e4c77b-ec8b-4a4e-a85d-10a1142e8f52');

-- ユーザー「Mio Saito」がチャンネル「team-1」を作成
INSERT INTO channels (id, workspace_id, name) VALUES
('0cc0c065-7b70-4b1c-81d6-47a54bfa9986', 'c7c12e0d-9e9e-4c8c-b6d1-b6c4a4e4f008', 'team-1');
INSERT INTO users_channels (id, user_id, channel_id) VALUES
('05fa60a7-9e91-4a7a-8284-2e4f3edc07e7', 'f0cb2f79-9bf9-456e-b74c-1c65412be1df', '0cc0c065-7b70-4b1c-81d6-47a54bfa9986');

-- ユーザー「Mio Saito」がチャンネル「team-2」を作成
INSERT INTO channels (id, workspace_id, name) VALUES
('d8b1394a-4c7f-4a37-81d1-57d80ce23108', 'c7c12e0d-9e9e-4c8c-b6d1-b6c4a4e4f008', 'team-2');
INSERT INTO users_channels (id, user_id, channel_id) VALUES
('10cfa7cb-f9fb-4c56-ae30-0502be4aa3d8', 'f0cb2f79-9bf9-456e-b74c-1c65412be1df', 'd8b1394a-4c7f-4a37-81d1-57d80ce23108');


-- 「Mio Saito」以外の全ユーザーがチャンネル「general」に参加
INSERT INTO users_channels (id, user_id, channel_id) VALUES
('2dc65c0d-4f57-4f19-9a39-fdcfaed400a3', 'eeb130bb-ccdb-4a12-b19e-98e0302b430a', '0eef0129-3b18-47d3-9f01-44dc2e682670'),
('b3c9516b-c2ba-4a6c-a2b2-e9d9d6308a55', '3dcaad1f-656a-4f81-9651-7ea2a17e54b7', '0eef0129-3b18-47d3-9f01-44dc2e682670'),
('c31c86f1-4f16-4b4d-98c5-d1e56d9b5a5f', '85dc3b05-3d37-49f3-97c9-0d9fcb5a6a57', '0eef0129-3b18-47d3-9f01-44dc2e682670'),
('221e2312-651f-4871-bf97-bca90d04b3dc', '6e50e1b8-68c7-4f54-9f7e-8b4d99b32f14', '0eef0129-3b18-47d3-9f01-44dc2e682670');



-- ユーザー「Rina Suzuki」がチャンネル「question」に参加
INSERT INTO users_channels (id, user_id, channel_id) VALUES
('3ca7689e-647f-49f5-bd05-bcf5e5b80f8b', 'eeb130bb-ccdb-4a12-b19e-98e0302b430a', '3a8803cc-3083-41b9-9b18-1b13dc7d236e');


-- ユーザー「Sora Kato」がチャンネル「review」に参加
INSERT INTO users_channels (id, user_id, channel_id) VALUES
('d4e8c475-742d-4644-b3c0-b72d62544212', '3dcaad1f-656a-4f81-9651-7ea2a17e54b7', '38e4c77b-ec8b-4a4e-a85d-10a1142e8f52');
-- ユーザー「Takumi Tanaka」がチャンネル「review」に参加
INSERT INTO users_channels (id, user_id, channel_id) VALUES
('f16b2a14-2480-4352-b34d-3222a446ac02', '85dc3b05-3d37-49f3-97c9-0d9fcb5a6a57', '38e4c77b-ec8b-4a4e-a85d-10a1142e8f52');
-- ユーザー「Yuka Nakamura」がチャンネル「review」に参加
INSERT INTO users_channels (id, user_id, channel_id) VALUES
('bc42feae-820f-4230-b4e4-ad69f1995ee0', '6e50e1b8-68c7-4f54-9f7e-8b4d99b32f14', '38e4c77b-ec8b-4a4e-a85d-10a1142e8f52');


-- ユーザー「Rina Suzuki」がチャンネル「team-1」に参加
INSERT INTO users_channels (id, user_id, channel_id) VALUES
('364b20b3-efea-49b9-9bba-2d29c98b01f3', 'eeb130bb-ccdb-4a12-b19e-98e0302b430a', '0cc0c065-7b70-4b1c-81d6-47a54bfa9986');
-- ユーザー「Takumi Tanaka」がチャンネル「team-1」に参加
INSERT INTO users_channels (id, user_id, channel_id) VALUES
('ee831526-1ec1-4dbd-ae13-9a578c8cb8f3', '85dc3b05-3d37-49f3-97c9-0d9fcb5a6a57', '0cc0c065-7b70-4b1c-81d6-47a54bfa9986');
-- ユーザー「Sora Kato」がチャンネル「team-1」に参加
INSERT INTO users_channels (id, user_id, channel_id) VALUES
('e08b09d3-66c3-4e21-95d4-f2cb2d07c68c', '3dcaad1f-656a-4f81-9651-7ea2a17e54b7', '0cc0c065-7b70-4b1c-81d6-47a54bfa9986');
-- ユーザー「Yuka Nakamura」がチャンネル「team-1」に参加
INSERT INTO users_channels (id, user_id, channel_id) VALUES
('f60ad4db-7a33-40a4-8f4b-6be4aa6d0321', '6e50e1b8-68c7-4f54-9f7e-8b4d99b32f14', '0cc0c065-7b70-4b1c-81d6-47a54bfa9986');


-- ユーザー「Sora Kato」がチャンネル「team-1」から脱退
UPDATE users_channels SET is_deleted = 1
WHERE user_id = '3dcaad1f-656a-4f81-9651-7ea2a17e54b7'
AND channel_id = '0cc0c065-7b70-4b1c-81d6-47a54bfa9986';

-- ユーザー「Yuka Nakamura」がチャンネル「team-1」から脱退
UPDATE users_channels SET is_deleted = 1
WHERE user_id = '6e50e1b8-68c7-4f54-9f7e-8b4d99b32f14'
AND channel_id = '0cc0c065-7b70-4b1c-81d6-47a54bfa9986';


-- ユーザー「Sora Kato」がチャンネル「team-2」に参加
INSERT INTO users_channels (id, user_id, channel_id) VALUES
('d87c4a40-cc41-43e4-847c-f18a0a7c6e27', '3dcaad1f-656a-4f81-9651-7ea2a17e54b7', 'd8b1394a-4c7f-4a37-81d1-57d80ce23108');

-- ユーザー「Yuka Nakamura」がチャンネル「team-2」に参加
INSERT INTO users_channels (id, user_id, channel_id) VALUES
('5af2da80-b6d8-48f3-bcd5-b45d9fdfa8b4', '6e50e1b8-68c7-4f54-9f7e-8b4d99b32f14', 'd8b1394a-4c7f-4a37-81d1-57d80ce23108');

-- // チャンネル ----------------
