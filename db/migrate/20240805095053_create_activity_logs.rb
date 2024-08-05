class CreateActivityLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :activity_logs do |t|
      t.belongs_to :activity_loggable, polymorphic: true, null: false
      t.belongs_to :account, null: false, foreign_key: true

      t.string :log_text, null: false

      t.boolean :visible, null: false, default: true

      t.timestamps
    end
  end
end
