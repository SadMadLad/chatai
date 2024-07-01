# frozen_string_literal: true

# == Schema Information
#
# Table name: weather_reports
#
#  id                     :bigint           not null, primary key
#  cloud                  :float
#  feels_like_temperature :float
#  gust_kph               :float
#  humidity               :float
#  latitude               :float            not null
#  longitude              :float            not null
#  precip_mm              :float
#  pressure_mb            :float
#  temperature            :float            not null
#  uv                     :float
#  vis_km                 :float
#  wind_degree            :float
#  wind_kph               :float            not null
#  localtime_epoch        :bigint
#  last_updated_epoch     :bigint
#  condition_text         :string
#  country                :string           not null
#  name                   :string           not null
#  region                 :string           not null
#  timezone_id            :string
#  wind_direction         :string
#  last_updated           :datetime
#  localtime              :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Weather report of a city/location.
class WeatherReport < ApplicationRecord
  validates :name, :region, :country, :latitude, :longitude, :temperature, :wind_kph, presence: true
end
