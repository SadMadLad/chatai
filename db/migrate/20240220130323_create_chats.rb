class CreateChats < ActiveRecord::Migration[7.1]
  def change
    create_table :chats do |t|
      t.integer :chat_status
      t.integer :chat_type, null: false, default: 0

      t.string :chat_title

      t.text :chat_description

      t.datetime :latest_message_at, null: false, default: -> { 'CURRENT_TIMESTAMP' }

      t.timestamps
    end
  end
end
