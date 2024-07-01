class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.belongs_to :account, null: false, foreign_key: true
      t.references :commentable, polymorphic: true, null: false

      t.integer :likes_count, null: false, default: 0

      t.text :body

      t.timestamps
    end
  end
end
