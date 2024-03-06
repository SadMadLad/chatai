class CreateMlModels < ActiveRecord::Migration[7.1]
  def change
    create_table :ml_models do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.jsonb :parameters, null: false
      t.jsonb :config, null: false

      t.belongs_to :account, null: false

      t.timestamps
    end
  end
end
