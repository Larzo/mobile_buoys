module MainHelper

  def station_info(station)
    station_str = station.name
    if @web_browser
      station_str ||= station.description      
    end
    station_str.to_s + " (" + station.number.to_s + ")"    
  end


end
