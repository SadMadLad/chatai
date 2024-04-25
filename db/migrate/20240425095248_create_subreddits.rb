class CreateSubreddits < ActiveRecord::Migration[7.1]
  def change
    create_table :subreddits do |t|
      t.string :subreddit, null: false
      t.string :subreddit_url, null: false
      t.integer :subreddit_subscribers
      t.datetime :latest_scraped_at

      t.timestamps
    end
  end
end
