# frozen_string_literal: true

json.array! @chats do |chat|
  json.id chat.id

  json.chat_description chat.chat_description
  json.chat_title chat.chat_title
  json.messages_count chat.messages.length
  json.photo_url rails_blob_url(chat.photo) if chat.photo.attached?
end
