-- メンバーは検索可能
Select Message.*
from Message
  INNER JOIN ChannelMember ON Message.channel_id = ChannelMember.channel_id
WHERE content Like "%茶道%"
  AND ChannelMember.member_user_id = 1;
-- メンバー以外は検索できない
Select Message.*
from Message
  INNER JOIN ChannelMember ON Message.channel_id = ChannelMember.channel_id
WHERE content Like "%茶道%"
  AND ChannelMember.member_user_id = 2;