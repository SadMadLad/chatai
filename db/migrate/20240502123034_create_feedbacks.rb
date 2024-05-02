class CreateFeedbacks < ActiveRecord::Migration[7.1]
  def change
    create_table :feedbacks do |t|
      t.belongs_to :account, null: false, foreign_key: true

      t.integer :platform, null: false

      t.text :feedback_body, null: false

      t.timestamps
    end
  end
end
