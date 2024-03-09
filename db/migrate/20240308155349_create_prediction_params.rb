class CreatePredictionParams < ActiveRecord::Migration[7.1]
  def change
    create_table :prediction_params do |t|
      t.string :name, null: false
      t.integer :param_type, null: false
      t.text :description, null: false
      t.jsonb :possible_values

      t.index :name, unique: true

      t.belongs_to :ml_model, null: false

      t.timestamps
    end
  end
end
