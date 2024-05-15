json.array! @chats do |chat|
  json.id chat.id
  json.chat_description chat.chat_description
  json.chat_title chat.chat_title
  json.photo_url rails_blob_url(chat.photo) if chat.photo.attached?
end
