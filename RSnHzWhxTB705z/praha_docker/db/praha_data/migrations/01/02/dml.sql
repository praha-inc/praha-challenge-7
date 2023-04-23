-- DBを選択
USE praha_slack;

-- ユーザーを挿入
INSERT INTO users (id, name) VALUES
('6e50e1b8-68c7-4f54-9f7e-8b4d99b32f14', 'Yuka Nakamura'),
('eeb130bb-ccdb-4a12-b19e-98e0302b430a', 'Rina Suzuki'),
('85dc3b05-3d37-49f3-97c9-0d9fcb5a6a57', 'Takumi Tanaka'),
('f0cb2f79-9bf9-456e-b74c-1c65412be1df', 'Mio Saito'),
('3dcaad1f-656a-4f81-9651-7ea2a17e54b7', 'Sora Kato');

-- ワークスペースを挿入
INSERT INTO workspaces (id, name) VALUES
('30d925c9-9e92-47e8-bc47-75de0e21c93b', 'praha1'),
('c7c12e0d-9e9e-4c8c-b6d1-b6c4a4e4f008', 'praha2');
