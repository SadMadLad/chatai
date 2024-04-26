class CreateSubreddits < ActiveRecord::Migration[7.1]
  def change
    create_table :subreddits do |t|
      t.integer :subreddit_subscribers

      t.string :subreddit, null: false
      t.string :subreddit_url, null: false

      t.datetime :latest_scraped_at

      t.index :subreddit, unique: true
      t.index :subreddit_url, unique: true

      t.timestamps
    end
  end
end
