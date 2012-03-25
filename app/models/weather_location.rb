class WeatherLocation < ActiveRecord::Base
  has_many :weather_readings
  has_many :tide_readings
end
