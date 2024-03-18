# frozen_string_literal: true

PROFILE_PICS = Dir['app/assets/images/faker/*']

def generate_account_attributes(index)
  { first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, role: 0, username: "#{Random.hex}#{index}" }
end

password = 'password'

admin_account_attributes = { first_name: 'Admin', last_name: 'Admin', role: 1, username: 'admin' }
User.create(email: 'admin@admin.com', password:, account_attributes: admin_account_attributes)

super_admin_account_attributes = { first_name: 'Superadmin', last_name: 'Superadmin', role: 2, username: 'superadmin' }
User.create(email: 'superadmin@superadmin.com', password:, account_attributes: super_admin_account_attributes)

normal_users = Array.new(20) do |i|
  { email: "user@#{i}.com", password:, account_attributes: generate_account_attributes(i) }
end

User.create(normal_users)

normal_accounts = Account.where(role: :user)
normal_accounts.each do |account|
  profile_pic = PROFILE_PICS.sample
  account.avatar.attach(
    io: File.open(File.join(Rails.root, profile_pic)),
    filename: profile_pic
  )
end

# Creating Chat Messages

first_account = normal_accounts.first

n = 10
last_n_accounts = normal_accounts.last(n)

chats_accounts = last_n_accounts.map { |account| [first_account, account] }
chats_accounts.each do |accounts|
  chat = Chat.create_chat(accounts, return_chat: true)
  chat.messages.create(accounts.map { |account| { account:, body: account.full_name } })
end

4.upto 9 do |i|
  group_chat_accounts = normal_accounts.last(i) + [first_account]
  chat = Chat.create_chat(group_chat_accounts, return_chat: true)
  chat.messages.create(group_chat_accounts.map { |account| { account:, body: Faker::Movies::TheRoom.quote } })
end
