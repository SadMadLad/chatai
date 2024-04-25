class CreateSubredditPosts < ActiveRecord::Migration[7.1]
  def change
    create_table :subreddit_posts do |t|
      t.belongs_to :subreddit, null: false, foreign_key: true
      t.string :url, null: false
      t.string :permalink, null: false
      t.bigint :created_utc, null: false
      t.text :selftext_html
      t.text :selftext
      t.string :title, null: false
      t.string :name, null: false
      t.float :upvote_ratio, null: false
      t.integer :ups, null: false
      t.string :score, null: false
      t.string :author, null: false
      t.string :author_fullname, null: false
      t.string :subreddit_name_prefixed, null: false
      t.integer :num_comments, null: false
      t.integer :subreddit_subscribers, null: false

      t.timestamps
    end
  end
end
