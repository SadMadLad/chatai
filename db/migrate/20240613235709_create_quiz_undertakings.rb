class CreateQuizUndertakings < ActiveRecord::Migration[7.1]
  def change
    create_table :quiz_undertakings do |t|
      t.belongs_to :account, null: false, foreign_key: true
      t.belongs_to :quiz, null: false, foreign_key: true

      t.float :score, null: false, default: 0

      t.timestamps
    end
  end
end
