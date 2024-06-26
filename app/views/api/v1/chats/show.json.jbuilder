# frozen_string_literal: true

json.chat do
  json.id @chat.id

  json.chat_title @chat.chat_title
  json.chat_description @chat.chat_description
  json.photo_url rails_blob_url(@chat.photo) if @chat.photo.attached?
end

json.messages @messages do |message|
  json.id message.id
  json.content message.content
  json.created_at message.created_at.strftime('%Y-%m-%d %H:%M:%S')
  json.sender message.account.full_name
  json.sender_username message.account.username
  json.avatar_url rails_blob_url(message.account.avatar) if message.account.avatar.attached?
end
