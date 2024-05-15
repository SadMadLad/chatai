json.chat do
  json.id @chat.id
  json.chat_title @chat.chat_title
  json.chat_description @chat.chat_description
  json.photo_url @chat.photo.attached? ? url_for(@chat.photo) : nil
end

json.messages @messages do |message|
  json.id message.id
  json.content message.content
  json.created_at message.created_at.strftime("%Y-%m-%d %H:%M:%S")
  json.sender message.account.full_name
end
