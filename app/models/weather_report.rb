class WeatherReport < ApplicationRecord
  MUST_PRESENT_FIELDS = %i[name region country latitude longitude temperature wind_kph].freeze

  validates *MUST_PRESENT_FIELDS, presence: true
end
