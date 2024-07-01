class CreateRatings < ActiveRecord::Migration[7.1]
  def change
    create_table :ratings do |t|
      t.references :rateable, polymorphic: true, null: false
      t.integer :rating, null: false, default: 0
      t.belongs_to :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
