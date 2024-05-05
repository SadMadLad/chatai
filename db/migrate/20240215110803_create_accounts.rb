class CreateAccounts < ActiveRecord::Migration[7.1]
  def change
    create_table :accounts do |t|
      t.belongs_to :user, null: false, foreign_key: true

      t.boolean :active_at_chatai, null: false, default: false
      t.boolean :active_at_frontend, null: false, default: false

      t.integer :role, null: false, default: 0

      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :username, null: false

      t.datetime :latest_message_at

      t.index :username, unique: true

      t.timestamps
    end
  end
end
