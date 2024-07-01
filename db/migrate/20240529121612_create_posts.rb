class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.belongs_to :account, null: false, foreign_key: true

      t.integer :likes_count, null: false, default: 0

      t.string :title, null: false

      t.text :body, null: false

      t.timestamps
    end
  end
end
