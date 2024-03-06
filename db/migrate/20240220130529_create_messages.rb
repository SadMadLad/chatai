class CreateMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :messages do |t|
      t.belongs_to :chat, null: false, foreign_key: true
      t.belongs_to :account, null: false, foreign_key: true

      t.text :body, null: false

      t.timestamps
    end
  end
end
