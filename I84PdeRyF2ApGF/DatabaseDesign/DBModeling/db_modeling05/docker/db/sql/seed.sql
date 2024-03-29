INSERT INTO modeling05.authors(id, name, email, created_at)
VALUES
  (DEFAULT, 'Kernta', 'kenta@email.com', DEFAULT);

INSERT INTO modeling05.post_article(id, posted_by, title, content, posted_at)
VALUES
  (DEFAULT, 1, 'ブログ（仮）', 'AIに何か書いてもらう', DEFAULT),
  (DEFAULT, 1, 'ブログ', '今度は自分で書こう', DEFAULT);

INSERT INTO modeling05.articles(id, post_article_id)
VALUES
  (DEFAULT, 1),
  (DEFAULT, 2);

INSERT INTO modeling05.edit_article(id, article_id, edited_by, title, content, edited_at)
VALUES
  (DEFAULT, 1, 1, 'AI生成文章Ver.1', '夏の日差しはまぶしく、心地よい風が吹き抜ける季節。緑豊かな公園で子供たちが笑顔で駆け回り、家族連れがピクニックを楽しんでいる光景が目に浮かびます。そんな風景を見ると、心が和みます。人々が自然と触れ合い、笑顔があふれる光景は、生活の喧騒から一時逃れ、穏やかな時間を過ごす機会です。夏はさまざまなイベントや祭りも開催されます。花火大会の華やかな光と音楽に包まれる瞬間は、心を躍らせます。屋台のにぎやかな賑わいや、夜空に舞う打ち上げ花火の美しさに、子供から大人まで、誰もが感動します。また、夏の暑さを忘れるような爽快な水遊びも楽しめます。プールや川、海で泳ぐことで、身体をリフレッシュさせると同時に、心もリフレッシュできます。水しぶきを浴びながら笑顔で遊ぶ姿は、夏の楽しさを象徴しています。そして、夏は旅行に出かける絶好のシーズンでもあります。新たな場所や文化に触れることで、視野が広がります。美しい景色や美味しい食べ物に出会い、思い出に残る旅行をすることは、人生の豊かさを感じる瞬間です。このブログでは、人々が自然と触れ合い、笑顔があふれる光景や、花火や水遊びなどの楽しいイベント、そして旅行の魅力を伝えることができます。夏は心地よい季節であり、思い出に残る素晴らしい時間を過ごせる季節です。', DEFAULT),
  (DEFAULT, 1, 1, 'AI生成文章Ver.2', '夏の日差しはまぶしく、心地よい風が吹き抜ける季節ニャ。緑豊かな公園で子供たちが笑顔で駆け回り、家族連れがピクニックを楽しんでいる光景が目に浮かびますニャ。そんな風景を見ると、心が和みますニャ。人々が自然と触れ合い、笑顔があふれる光景は、生活の喧騒から一時逃れ、穏やかな時間を過ごす機会ニャです。夏はさまざまなイベントや祭りも開催されますニャ。花火大会の華やかな光と音楽に包まれる瞬間は、心を躍らせますニャ。屋台のにぎやかな賑わいや、夜空に舞う打ち上げ花火の美しさに、子供から大人まで、誰もが感動しますニャ。また、夏の暑さを忘れるような爽快な水遊びも楽しめますニャ。プールや川、海で泳ぐことで、身体をリフレッシュさせると同時に、心もリフレッシュできますニャ。水しぶきを浴びながら笑顔で遊ぶ姿は、夏の楽しさを象徴していますニャ。そして、夏は旅行に出かける絶好のシーズンでもありますニャ。新たな場所や文化に触れることで、視野が広がりますニャ。美しい景色や美味しい食べ物に出会い、思い出に残る旅行をすることは、人生の豊かさを感じる瞬間ですニャ。このブログでは、人々が自然と触れ合い、笑顔があふれる光景や、花火や水遊びなどの楽しいイベント、そして旅行の魅力を伝えることができますニャ。夏は心地よい季節であり、思い出に残る素晴らしい時間を過ごせる季節ですニャ。', DEFAULT),
  (DEFAULT, 1, 1, 'AI生成文章Ver.3', '夏の日差しはまぶしく、心地よい風が吹き抜ける季節ワン！緑豊かな公園で子供たちが笑顔で駆け回り、家族連れがピクニックを楽しんでいる光景が目に浮かびますワン！そんな風景を見ると、心が和みますワン！人々が自然と触れ合い、笑顔があふれる光景は、生活の喧騒から一時逃れ、穏やかな時間を過ごす機会ワンです。夏はさまざまなイベントや祭りも開催されますワン！花火大会の華やかな光と音楽に包まれる瞬間は、心を躍らせますワン！屋台のにぎやかな賑わいや、夜空に舞う打ち上げ花火の美しさに、子供から大人まで、誰もが感動しますワン！また、夏の暑さを忘れるような爽快な水遊びも楽しめますワン！プールや川、海で泳ぐことで、身体をリフレッシュさせると同時に、心もリフレッシュできますワン！水しぶきを浴びながら笑顔で遊ぶ姿は、夏の楽しさを象徴していますワン！そして、夏は旅行に出かける絶好のシーズンでもありますワン！新たな場所や文化に触れることで、視野が広がりますワン！美しい景色や美味しい食べ物に出会い、思い出に残る旅行をすることは、人生の豊かさを感じる瞬間ですワン！このブログでは、人々が自然と触れ合い、笑顔があふれる光景や、花火や水遊びなどの楽しいイベント、そして旅行の魅力を伝えることができますワン！夏は心地よい季節であり、思い出に残る素晴らしい時間を過ごせる季節ですワン！', DEFAULT);

INSERT INTO modeling05.delete_article(id, article_id, deleted_by, deleted_at)
VALUES
  (DEFAULT, 2, 1, DEFAULT);