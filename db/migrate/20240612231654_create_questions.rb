class CreateQuestions < ActiveRecord::Migration[7.1]
  def change
    create_table :questions do |t|
      t.belongs_to :quiz, null: false, foreign_key: true
      
      t.boolean :multiple_answers, null: false, default: false
      
      t.text :question_text, null: false

      t.timestamps
    end
  end
end
