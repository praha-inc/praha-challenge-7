-- メンバーは検索可能
Select DISTINCTROW Message.*
from Message
  LEFT JOIN ChannelMember ON Message.channel_id = ChannelMember.channel_id
WHERE content Like "%茶道%"
  AND ChannelMember.member_user_id = 1;
-- メンバー以外は検索できない
Select DISTINCTROW Message.*
from Message
  LEFT JOIN ChannelMember ON Message.channel_id = ChannelMember.channel_id
WHERE content Like "%茶道%"
  AND ChannelMember.member_user_id = 2;

--- メインスレッドの取得
Select DISTINCTROW Message.*
from Message
  LEFT JOIN ChannelMember ON Message.channel_id = ChannelMember.channel_id
WHERE ChannelMember.member_user_id = 1
AND Message.id = Message.parent_message_id;


--- スレッドの取得(メインスレッドを選択した状態の想定)
Select DISTINCTROW Message.*
from Message
  LEFT JOIN ChannelMember ON Message.channel_id = ChannelMember.channel_id
WHERE ChannelMember.member_user_id = 1
AND Message.parent_message_id = 7;