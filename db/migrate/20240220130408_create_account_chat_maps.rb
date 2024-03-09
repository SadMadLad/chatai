class CreateAccountChatMaps < ActiveRecord::Migration[7.1]
  def change
    create_table :account_chat_maps, primary_key: [:account_id, :chat_id] do |t|
      t.index [:account_id, :chat_id], unique: true

      t.belongs_to :account, null: false, foreign_key: true
      t.belongs_to :chat, null: false, foreign_key: true

      t.timestamps
    end
  end
end
