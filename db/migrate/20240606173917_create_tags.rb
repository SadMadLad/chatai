class CreateTags < ActiveRecord::Migration[7.1]
  def change
    create_table :tags do |t|
      t.string :tag, null: false

      t.index :tag, unique: true

      t.timestamps
    end
  end
end
