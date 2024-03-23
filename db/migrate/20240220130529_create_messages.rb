class CreateMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :messages do |t|
      t.text :body, null: false
      t.integer :role, null: false, default: 0

      t.belongs_to :chat, null: false, foreign_key: true
      t.belongs_to :account, null: true, foreign_key: true

      t.timestamps
    end
  end
end
