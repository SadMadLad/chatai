class CreateWeatherReports < ActiveRecord::Migration[7.1]
  def change
    create_table :weather_reports do |t|
      t.string :name, null: false
      t.string :region, null: false
      t.string :country, null: false
      t.float :latitude, null: false
      t.float :longitude, null: false
      t.string :timezone_id
      t.bigint :localtime_epoch
      t.datetime :localtime
      t.bigint :last_updated_epoch
      t.datetime :last_updated
      t.float :temperature, null: false
      t.string :condition_text
      t.float :wind_kph, null: false
      t.float :wind_degree
      t.string :wind_direction
      t.float :pressure_mb
      t.float :precip_mm
      t.float :humidity
      t.float :cloud
      t.float :feels_like_temperature
      t.float :vis_km
      t.float :uv
      t.float :gust_kph

      t.timestamps
    end
  end
end
