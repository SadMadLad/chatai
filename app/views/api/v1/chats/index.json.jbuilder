json.array! @chats do |chat|
  json.id chat.id
  json.title chat.chat_title
  json.photo_url url_for(chat.photo_url) if chat.photo.attached?
end
