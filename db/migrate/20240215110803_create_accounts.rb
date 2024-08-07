class CreateAccounts < ActiveRecord::Migration[7.1]
  def change
    enable_extension 'pgcrypto'
    enable_extension 'uuid-ossp'

    create_table :accounts do |t|
      t.belongs_to :user, null: false, foreign_key: true

      t.integer :favorites_count, null: false, default: 0
      t.integer :role, null: false, default: 0

      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :username, null: false

      t.text :tagline

      t.datetime :latest_message_at

      t.index :username, unique: true

      t.timestamps
    end
  end
end
