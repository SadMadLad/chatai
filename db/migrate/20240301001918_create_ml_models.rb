class CreateMlModels < ActiveRecord::Migration[7.1]
  def change
    create_table :ml_models do |t|
      t.belongs_to :account, null: false

      t.integer :model_type, null: false

      t.string :identifier, null: false
      t.string :title, null: false

      t.text :description, null: false

      t.jsonb :parameters_with_order, null: false

      t.index :identifier, unique: true

      t.timestamps
    end
  end
end
