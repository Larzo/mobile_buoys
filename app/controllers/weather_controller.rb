class WeatherController < ApplicationController
  
  layout :determine_layout

 private
 
  def get_weather(name)
    name = name.gsub(/-/,' ')
    weath = WeatherLocation.find(:first,
    :conditions => ["name = :name",{:name => name}])
    return weath
  end  
  
  public
  
  def index
    @recs = WeatherLocation.find(:all)
  end 
  
  def show_tides
    @weath = get_weather(params[:name])
    del = expired_check(@weath.tide_readings)

     if (@weath.tide_readings.size == 0) || del       
       @weath.tide_readings = TideReading.loadFromWeb(@weath.tide_key)
    end  
  end  
  
  def show_weather
    @weath = get_weather(params[:name])
   
    del = expired_check(@weath.weather_readings)
      
    if (@weath.weather_readings.size == 0) || del
      @weath.weather_readings = WeatherReading.loadFromWeb(@weath.key)
    end  
  end  
  
  
end
