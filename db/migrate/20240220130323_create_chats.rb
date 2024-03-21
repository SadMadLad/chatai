class CreateChats < ActiveRecord::Migration[7.1]
  def change
    create_table :chats do |t|
      t.integer :chat_type, null: false, default: 0
      t.datetime :latest_message_at, null: false, default: -> { 'CURRENT_TIMESTAMP' }
      t.string :group_title

      t.timestamps
    end
  end
end
