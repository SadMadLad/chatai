class CreateAccounts < ActiveRecord::Migration[7.1]
  def change
    create_table :accounts do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :username, null: false

      t.integer :role, null: false, default: 0

      t.datetime :latest_message_at

      t.belongs_to :user, null: false, foreign_key: true

      t.index :username, unique: true

      t.timestamps
    end
  end
end
