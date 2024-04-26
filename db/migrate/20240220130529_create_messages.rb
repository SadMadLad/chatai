class CreateMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :messages do |t|
      t.belongs_to :account, null: true, foreign_key: true
      t.belongs_to :chat, null: false, foreign_key: true

      t.integer :role, null: false, default: 0

      t.text :content, null: false

      t.timestamps
    end
  end
end
