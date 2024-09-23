class CreateRawTexts < ActiveRecord::Migration[7.2]
  def change
    create_table :raw_texts do |t|
      t.boolean :needs_separator, null: false, default: false

      t.string :becomes_into
      t.string :record_identifier, null: false
      t.string :separator

      t.text :raw_text, null: false

      t.timestamps
    end
  end
end
