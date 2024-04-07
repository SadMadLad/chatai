class WeatherReportJob < ApplicationJob
  MAPPER = {
    name: %i[location name],
    region: %i[location region],
    country: %i[location country],
    latitude: %i[location lat],
    longitude: %i[location lon],
    timezone_id: %i[location tz_id],
    localtime_epoch: %i[location localtime_epoch],
    localtime: %i[location localtime],
    last_updated_epoch: %i[current last_updated_epoch],
    last_updated: %i[current last_updated],
    temperature: %i[current temp_c],
    condition_text: %i[current condition text],
    wind_kph: %i[current wind_kph],
    wind_degree: %i[current wind_degree],
    wind_direction: %i[current wind_dir],
    pressure_mb: %i[current pressure_mb],
    precip_mm: %i[current precip_mm],
    humidity: %i[current humidity],
    cloud: %i[current cloud],
    feels_like_temperature: %i[current feelslike_c],
    vis_km: %i[current vis_km],
    uv: %i[current uv],
    gust_kph: %i[current gust_kph]
  }.freeze
  
  def perform(scope: :current, location: 'Lahore')
    weather_response = Clients::WeatherApiClient.new.query_weather(scope, location)
    weather_response = JSON.parse(weather_response.body)
    weather_response = ResponseModelParser.new(weather_response, MAPPER).parse

    weather_report = WeatherReport.new(weather_response)
    weather_report.save
  end
end
