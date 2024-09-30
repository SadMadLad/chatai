class CreateCountryNewsHeadlines < ActiveRecord::Migration[7.2]
  def change
    create_table :country_news_headlines do |t|
      t.string :country_name, null: false
      t.string :country_alpha2, null: false

      t.text :associated_link
      t.text :description, null: false
      t.text :headline, null: false

      t.timestamps
    end
  end
end
