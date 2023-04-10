-- Insert sample data into accounts table
INSERT INTO accounts (id, username, email, password, display_name, profile_image_url, created_at, updated_at)
VALUES
(1, '山崎', 'yamazaki@example.com', 'password_1', 'Yamazaki', 'https://example.com/images/yamazaki.jpg', '2023-04-01 10:00:00', '2023-04-01 10:00:00'),
(2, '田中', 'tanak@example.com', 'password_2', 'Tanaka', 'https://example.com/images/tanak.jpg', '2023-04-02 11:00:00', '2023-04-02 11:00:00');

-- Insert sample data into contents table
INSERT INTO contents (account_id, content_type, content_title, content_body, created_at, updated_at)
VALUES
(1, 1, '社内資料', '', '2023-04-03 12:00:00', '2023-04-03 12:00:00'),
(2, 1, 'プロジェクトA', '', '2023-04-04 13:00:00', '2023-04-04 13:00:00');

-- Insert sample data into content_histories table
INSERT INTO content_histories (account_id, content_type, content_title, content_body, created_at, updated_at, operation, operation_date)
VALUES
(NULL, 1, '社内資料', '', '2023-04-03 12:00:00', '2023-04-03 12:00:00', 'INSERT', '2023-04-03 12:00:00'),
(NULL, 1, 'プロジェクトA', '', '2023-04-04 13:00:00', '2023-04-04 13:00:00', 'INSERT', '2023-04-04 13:00:00');

-- Insert sample data into content_paths table
INSERT INTO content_paths (ancestor, descendant, depth)
VALUES
(1, 1, 0),
(2, 2, 0);