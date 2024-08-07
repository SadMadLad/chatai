class CreateRequestLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :request_logs do |t|
      t.belongs_to :account, null: true, foreign_key: true
      t.belongs_to :user, null: true, foreign_key: true

      t.boolean :preserve, null: false, default: false

      t.integer :status, null: false

      t.float :db_runtime, null: false
      t.float :total_runtime, null: false
      t.float :view_runtime, null: false

      t.string :remote_ip, null: false
      t.string :action, null: false
      t.string :controller, null: false
      t.string :full_url, null: false
      t.string :user_agent
      t.string :user_email

      t.jsonb :extra_params

      t.timestamps
    end
  end
end
