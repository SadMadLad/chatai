class CreateFavorites < ActiveRecord::Migration[7.1]
  def change
    create_table :favorites do |t|
      t.belongs_to :account, null: false, foreign_key: true
      t.belongs_to :favoritable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
