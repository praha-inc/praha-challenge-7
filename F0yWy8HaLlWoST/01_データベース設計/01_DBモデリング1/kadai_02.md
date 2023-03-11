# 課題2

[プレビュー](https://www.plantuml.com/plantuml/uml/dPFVJjH05CRlvoaQBatW2GZXmfWO7w9PtGaqsMwJTdgXMvETZe7Yfd7DsZNg5GeAg8XP2HlHy327wRPlOJlJaQ4ZNd0rcVFd-tvpScOz81sVX6uFuJvno6Dh2UXpVlmUQ0RnPCdg19PhFme3uhdOjmR8ikxe1VVlLf7bvJfSlZil3hyliYF-ugo-yt7ATrBq5FrLvjaMdz16qo7ObNeoVALKw-__1de1z0tGro81yJam1Ym1jWji16o_2clIhPx68mY3JKUQj0gKcvcfi0NKS2y_FjKjJ0JbWedqC2jq6oDverEBo3PRxSlvrt8w0RO5x1UmAR3F0gP2aO-s7-AUrzzm-XiIxLQI6hqnFcjrzTw3jRMRdgtIsglosK4-tRwS3ukFdmGiiJs_gvPAPfMZiMMQ7HydnK5IRhyiTzEh--BjHPwT2ALNt_AT3EYpV9u8u959KHpE5ZzET0gxYqd7wKaOlKX3ac4DHkrkQnndm3u0EuBu5E8zY7zUxnYE6j3wRNG6z0lGj4LfQgXTs-puZXquJx0aDGirNZF9n-93QZywYbPMee6Q0f9dAwo6WwvVHP4tQFuoaeViZDJdCwEOe2Qd-l-nj4WK_gV0G97w-e0GMiVzRkZs_W00)

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