module News
  class CountryGoogleNewsRssJob < ApplicationJob
    def perform(countries: Country.all)
      countries.each do |country|
        country_name = country.iso_short_name
        country_alpha2 = country.alpha2

        news_items = News::GoogleNewsRssJob.new.perform(country_name)
        news_items.map! { |item| item.merge(country_alpha2:, country_name:) }

        CountryNewsHeadline.create(news_items)
      end
    end
  end
end
