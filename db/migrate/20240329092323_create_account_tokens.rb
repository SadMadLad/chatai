class CreateAccountTokens < ActiveRecord::Migration[7.1]
  def change
    enable_extension 'pgcrypto'

    create_table :account_tokens do |t|
      t.belongs_to :account, null: false, foreign_key: true
      t.integer :scope, null: false

      t.index [:account_id, :scope], unique: true

      t.timestamps
    end
  end
end
