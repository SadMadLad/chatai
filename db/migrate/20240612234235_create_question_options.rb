class CreateQuestionOptions < ActiveRecord::Migration[7.1]
  def change
    create_table :question_options do |t|
      t.belongs_to :question, null: false, foreign_key: true

      t.boolean :correct, null: false, default: false
      
      t.text :option_text, null: false

      t.timestamps
    end
  end
end
