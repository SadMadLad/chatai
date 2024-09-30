# frozen_string_literal: true

module News
  class RawCountriesNewsJob < ApplicationJob
  def perform(countries: Country.all)
    countries.each do |country|
      country_name = country.iso_short_name
      news_data = FetchNewsJob.new.perform(country_name)

      RawText.create(
        becomes_into: 'CountryNewsHeadline',
        raw_text: news_data.to_yaml,
        record_identifier: country_name
      )
    end
  end
  end
end
