class CreateQuizzes < ActiveRecord::Migration[7.1]
  def change
    create_table :quizzes do |t|
      t.belongs_to :account, null: true, foreign_key: true

      t.boolean :published, null: false, default: false
      t.boolean :timed, null: false, default: false

      t.integer :collectable_maps_count, null: false, default: 0
      t.integer :favorites_count, null: false, default: 0
      t.integer :questions_count, null: false, default: 0
      t.integer :quiz_undertakings_count, null: false, default: 0
      t.integer :ratings_count, null: false, default: 0
      t.integer :timer
      t.integer :total_score, null: false, default: 0
      t.integer :total_rating, null: false, default: 0

      t.string :title, null: false

      t.text :description, null: false

      t.datetime :latest_taken_at

      t.timestamps
    end
  end
end
