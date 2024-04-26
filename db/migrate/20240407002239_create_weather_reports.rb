class CreateWeatherReports < ActiveRecord::Migration[7.1]
  def change
    create_table :weather_reports do |t|
      t.float :cloud
      t.float :feels_like_temperature
      t.float :gust_kph
      t.float :humidity
      t.float :latitude, null: false
      t.float :longitude, null: false
      t.float :precip_mm
      t.float :pressure_mb
      t.float :temperature, null: false
      t.float :uv
      t.float :vis_km
      t.float :wind_degree
      t.float :wind_kph, null: false

      t.bigint :localtime_epoch
      t.bigint :last_updated_epoch

      t.string :condition_text
      t.string :country, null: false
      t.string :name, null: false
      t.string :region, null: false
      t.string :timezone_id
      t.string :wind_direction

      t.datetime :last_updated
      t.datetime :localtime

      t.timestamps
    end
  end
end
