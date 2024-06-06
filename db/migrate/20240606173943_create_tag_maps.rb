class CreateTagMaps < ActiveRecord::Migration[7.1]
  def change
    create_table :tag_maps do |t|
      t.references :taggable, polymorphic: true, null: false
      t.belongs_to :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
