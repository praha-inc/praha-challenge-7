# 課題2

[プレビュー](https://www.plantuml.com/plantuml/uml/dPFVRjCm5CRl_HJHBf6s9vYcNI0an4D4XLfRfAQL6lS26gGwHbj65L4KKWHS5LRO1Xj3PLh5W3tCcTFaBKXiXxanus9NKSwVx_kTe-DDZpIwfEUs46uJXposLe0-voVlWIOGn2jMmxDS-r7F8nqNTwq-igmxUi7zkqLaTRKCv-ykiiDlY-I8lpWl__aeudiHUeh-AlDaXyTKQJe4kr9FXg-LIltfBw2NGDy0VIqI45m0Oy12O1DWGs3J8gn9rtgKXzVpjXq5ROWADpDJO0kemNvwSgPRc0YL2oRAmwZGRCpaZKur8jjijQ_cn_au1hO3x2UmCR3F0gP0aKFR3t6hqzvosbiAxJQI6hsnFcjz_Tw3ZOsRnbPfVQfqTf2ETw_cW-pZ9m5Bx4wtMHsLp2f7uyfqE_uxJgV7F9uiHqTXTX3cko_pINJzltXxcIQdGl_LrtGl0VeidOTYZA79bXtE5jzFTJQxYKd3QMc8gaW3bM4THbrqRKddm3u0EuBW389z27uiTmo62hIScCw0VW4QrIXDZUe2jnjTn_QS9rYIceKQhvda8_5CjNVk-sjhVh_Q0X9V8woMWvP_HL6dhruuaX_PwLTFqenYWbHEzV_hb94e_4-1YIBqzGKXj8dRpPxR-WC0)

```plantuml
@startuml
entity "お客さん" as m_customer {
  *お客さんID
  --
  *電話番号
  *名前
}

entity "商品" as m_item {
  *商品ID
  --
  お好みすしID
  セットメニュID
}

entity "お好みすし" as m_sushi {
  *お好みすしID
  --
  *お好みすし名
  *値段
}

entity "セットメニュ" as m_set {
  *セットメニュID
  --
  *セットメニュ名
  *値段
}

entity "お好みすし_セットメニュ_中間テーブル" as set_sushi_belonging {
  *お好みすし_セットメニュ_中間テーブルID
  --
  *お好みすしID <<FK>>
  *セットメニュID <<FK>>
}

entity "注文一覧" as t_order {
  *注文ID
  --
  *お客さんID <<FK>>
  *合計金額
  *合計皿数
  *支払い済みか
}

entity "注文詳細" as t_order_detail {
  *注文詳細ID
  --
  *注文ID <<FK>>
  *商品ID <<FK>>
  *シャリサイズID <<FK>>
  *個数
  *さびぬきか
}

entity "シャリサイズ" as m_shari_size {
  *シャリサイズID
  --
  *シャリサイズ名
}

m_customer ||..|{ t_order
t_order ||..|{ t_order_detail
t_order_detail ||..o{ m_item
m_item ||..|| m_sushi
m_item ||..|| m_set
m_sushi ||..o{ set_sushi_belonging
m_set ||..o{ set_sushi_belonging
t_order_detail ||..|| m_shari_size

@enduml
```

## 疑問点メモ

- 