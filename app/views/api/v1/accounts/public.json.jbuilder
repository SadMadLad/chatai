# frozen_string_literal: true

json.account do
  json.avatar_url rails_blob_url(@other_account.avatar) if @other_account.avatar.attached?
  json.name @other_account.full_name
  json.tagline @other_account.tagline
end

json.messages @latest_messages do |message|
  json.id message.id

  json.chat_title message.chat.chat_title
  json.content message.content
  json.created_at message.created_at.strftime('%Y-%m-%d %H:%M:%S')
end

json.chats @live_chats do |chat|
  json.id chat.id

  json.chat_description chat.chat_description
  json.chat_title chat.chat_title
  json.photo_url rails_blob_url(chat.photo) if chat.photo.attached?
end
