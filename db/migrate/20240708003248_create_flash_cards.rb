class CreateFlashCards < ActiveRecord::Migration[7.1]
  def change
    create_table :flash_cards do |t|
      t.belongs_to :account, null: true, foreign_key: true

      t.integer :card_style, null: false, default: 0

      t.string :color, null: false, default: '#84cc16'

      t.text :answer, null: false
      t.text :prompt, null: false

      t.boolean :published, null: false, default: false

      t.timestamps
    end
  end
end
