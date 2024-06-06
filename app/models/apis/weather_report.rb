# frozen_string_literal: true

module Apis
  # Weather report of a city/location.
  class WeatherReport < ApplicationRecord
    validates :name, :region, :country, :latitude, :longitude, :temperature, :wind_kph, presence: true
  end
end
