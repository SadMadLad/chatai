class CreateQuizzes < ActiveRecord::Migration[7.1]
  def change
    create_table :quizzes do |t|
      t.belongs_to :account, null: true, foreign_key: true

      t.integer :timer

      t.string :title, null: false
      
      t.boolean :published, null: false, default: false
      t.boolean :timed, null: false, default: false

      t.text :description, null: false

      t.timestamps
    end
  end
end
