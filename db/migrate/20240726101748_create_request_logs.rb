class CreateRequestLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :request_logs do |t|
      t.belongs_to :account, null: true, foreign_key: true
      t.belongs_to :user, null: true, foreign_key: true

      t.string :action, null: false
      t.string :controller, null: false
      t.string :full_url, null: false
      t.string :user_email

      t.jsonb :extra_params

      t.timestamps
    end
  end
end
