class CreateCollections < ActiveRecord::Migration[7.1]
  def change
    create_table :collections do |t|
      t.belongs_to :account, null: false, foreign_key: true

      t.boolean :public, null: false, default: true

      t.integer :collectable_maps_count, null: false, default: 0

      t.string :title, null: false

      t.text :description

      t.timestamps
    end
  end
end
