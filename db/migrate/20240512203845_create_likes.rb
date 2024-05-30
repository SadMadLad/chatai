class CreateLikes < ActiveRecord::Migration[7.1]
  def change
    create_table :likes do |t|
      t.belongs_to :account, null: false, foreign_key: true
      t.references :likeable, polymorphic: true, null: false

      t.index %i[account_id likeable_id likeable_type], unique: true

      t.timestamps
    end
  end
end
