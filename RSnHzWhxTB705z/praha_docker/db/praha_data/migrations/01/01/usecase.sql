USE praha_sushi;

# 新規顧客が電話でお好みすしを注文する場合
INSERT INTO customers (family_name, first_name, tel, app_user_id) VALUES
    ('田中', '太郎', '08012345678', NULL);
INSERT INTO orders (customer_id, channel_id, order_status_id) VALUES
    (11, 2, 1);
INSERT INTO order_details (order_id, product_id, discount_id, is_without_wasabi, is_less_rice) VALUES
    (8, 1, NULL, 0, 0),
    (8, 2, NULL, 0, 0);

# 新規顧客がアプリでお好みすしを注文する場合
INSERT INTO customers (family_name, first_name, tel, app_user_id) VALUES
    ('山田', '花子', '09098765432', 'c25fa583-6e9f-11ec-8dcd-0242ac130003');
INSERT INTO orders (customer_id, channel_id, order_status_id) VALUES
    (12, 2, 1);
INSERT INTO order_details (order_id, product_id, discount_id, is_without_wasabi, is_less_rice) VALUES
    (9, 1, NULL, 0, 0),
    (9, 2, NULL, 0, 0);

# 既存顧客が電話でお好みすしを注文する場合
INSERT INTO orders (customer_id, channel_id, order_status_id) VALUES
    (12, 2, 1);
INSERT INTO order_details (order_id, product_id, discount_id, is_without_wasabi, is_less_rice) VALUES
    (10, 1, NULL, 0, 0),
    (10, 2, NULL, 0, 0);

# 電話でお好みすし（さびぬき）を注文する場合
INSERT INTO orders (customer_id, channel_id, order_status_id) VALUES
    (12, 2, 1);
INSERT INTO order_details (order_id, product_id, discount_id, is_without_wasabi, is_less_rice) VALUES
    (11, 1, NULL, 1, 0),
    (11, 2, NULL, 1, 0);

# 電話でお好みすし（シャリ小）を注文する場合
INSERT INTO orders (customer_id, channel_id, order_status_id) VALUES
    (12, 2, 1);
INSERT INTO order_details (order_id, product_id, discount_id, is_without_wasabi, is_less_rice) VALUES
    (12, 1, NULL, 0, 1),
    (12, 2, NULL, 0, 1);

# 電話でお好みすし（さびぬき、シャリ小）を注文する場合
INSERT INTO orders (customer_id, channel_id, order_status_id) VALUES
    (12, 2, 1);
INSERT INTO order_details (order_id, product_id, discount_id, is_without_wasabi, is_less_rice) VALUES
    (13, 1, NULL, 1, 1),
    (13, 2, NULL, 1, 1);

# 電話でお好みすしと盛り込みを注文する場合
INSERT INTO orders (customer_id, channel_id, order_status_id) VALUES
    (12, 2, 1);
INSERT INTO order_details (order_id, product_id, discount_id, is_without_wasabi, is_less_rice) VALUES
    (14, 1, NULL, 1, 1),
    (14, 54, NULL, 0, 0);

# 電話で盛り込みを注文する場合
INSERT INTO orders (customer_id, channel_id, order_status_id) VALUES
    (12, 2, 1);
INSERT INTO order_details (order_id, product_id, discount_id, is_without_wasabi, is_less_rice) VALUES
    (15, 54, NULL, 0, 0);

# 電話で盛り込みを2個注文する場合
INSERT INTO orders (customer_id, channel_id, order_status_id) VALUES
    (12, 2, 1);
INSERT INTO order_details (order_id, product_id, discount_id, is_without_wasabi, is_less_rice) VALUES
    (16, 54, NULL, 1, 1),
    (16, 55, NULL, 0, 0);

# 電話でにぎりを注文する場合
INSERT INTO orders (customer_id, channel_id, order_status_id) VALUES
    (12, 2, 1);
INSERT INTO order_details (order_id, product_id, discount_id, is_without_wasabi, is_less_rice) VALUES
    (17, 60, NULL, 0, 0);

# 電話で丼を注文する場合
INSERT INTO orders (customer_id, channel_id, order_status_id) VALUES
    (12, 2, 1);
INSERT INTO order_details (order_id, product_id, discount_id, is_without_wasabi, is_less_rice) VALUES
    (18, 63, NULL, 0, 0);

# 電話で丼をランチタイムに注文する場合
INSERT INTO orders (customer_id, channel_id, order_status_id, created_at) VALUES
    (12, 2, 1, '2023-03-31 12:00:00');
INSERT INTO order_details (order_id, product_id, discount_id, is_without_wasabi, is_less_rice) VALUES
    (19, 63, 2, 0, 0);

# 電話で地元に生まれた味を注文する場合
INSERT INTO orders (customer_id, channel_id, order_status_id) VALUES
    (12, 2, 1);
INSERT INTO order_details (order_id, product_id, discount_id, is_without_wasabi, is_less_rice) VALUES
    (20, 64, NULL, 0, 0);

# 電話で地元に生まれた味（箱あり）を注文する場合
INSERT INTO orders (customer_id, channel_id, order_status_id) VALUES
    (12, 2, 1);
INSERT INTO order_details (order_id, product_id, discount_id, is_without_wasabi, is_less_rice) VALUES
    (21, 65, NULL, 0, 0);

