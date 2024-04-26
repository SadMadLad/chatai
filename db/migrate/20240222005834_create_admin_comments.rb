class CreateAdminComments < ActiveRecord::Migration[7.1]
  def change
    create_table :admin_comments do |t|
      t.belongs_to :admin_commentable, polymorphic: true, null: false
      t.belongs_to :commenter, null: false

      t.text :body, null: false

      t.timestamps
    end
  end
end
