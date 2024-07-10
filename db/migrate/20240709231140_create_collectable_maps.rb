class CreateCollectableMaps < ActiveRecord::Migration[7.1]
  def change
    create_table :collectable_maps do |t|
      t.belongs_to :collectable, polymorphic: true, null: false
      t.belongs_to :collection, null: false, foreign_key: true

      t.timestamps
    end
  end
end
