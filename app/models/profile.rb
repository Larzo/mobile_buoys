require 'net/http'


class Profile < ActiveRecord::Base

  has_many :station_joins 
  has_many :stations, :through => :station_joins
  has_many :regions, :through => :station_joins
  #belongs_to :region, :through => :station_joins

  # this is called from the setup script.
  # it finds all of the buoys that have a 
  # description string that appears to indicate
  # it is offshore for the given state etc.
  # thus if the profile is for
  # new england, the states passed might be [:me, :ma, :nh]
  # 
  # The description string stored in the
  # buoy record came from the NOAA buoy web site
  # 
  
  
  def find_by_state(states)
    states = [states] if states.class != Array
          
    Station.find(:all).each do |station|
      states.each do |state|
      
        if state.length == 2
          state_name = state.to_s.upcase
        else
          state_name = state.to_s.capitalize
        end
  
        # we have [space, comma] <STATE> [space, period, end_of_string]    
        pat = /\s#{state_name}\s/
        pat2 = /\s#{state_name}$/
        pat3 = /,#{state_name}$/
        pat4 = /,#{state_name}\s/
        pat5 = /,#{state_name}\./
        pat6 = /\s#{state_name}\./  
        if pat.match(station.description) or 
          pat2.match(station.description) or
          pat3.match(station.description) or
          pat4.match(station.description) or
          pat5.match(station.description) or
          pat6.match(station.description)
            # puts 'found!!!'       
            self.stations << station
        end  
      end
    end
     
  end
  
  def region_id
    res = nil
    if self.regions.length > 0
      res = regions.first.id
    end
    res
  end

# name used with a named url
  def link_name
    self.name.gsub(/\s/,"_") # .downcase
  end

  # get updated reports for all associated buoys
  
  def getReadings
  
    stations.each do |buoy|
      reading = nil
      buoy.readings.each do |read|
        if (read.created_at + 3600) > Time.now
        # reading is still fairly recent
          reading = read
        else 
        # remove old readings
#        puts "DELETE READING"
          buoy.readings.delete(read)  
          read.destroy
        end  
      end
      if (!reading)
 #     puts "GET DATA FROM BUOY \n"
      
        reading = Reading.new
        reading.parse(buoy.noaa_url)
        buoy.readings << reading
      
      end
    end
  
  end



  def getSurfcasts
  
    stations.each do |buoy|
      buoy.getSurfcasts(self.wave_models)
    end    
  
  end



  def add_buoy(buoy)
   # puts "add buoy called \n";
    stations << buoy
  end

end
