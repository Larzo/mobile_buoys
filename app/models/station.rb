require 'hpricot'
require 'open-uri'

class Station < ActiveRecord::Base
  has_many :station_joins  
  has_many :profiles, :through => :station_joins
  has_many :readings
  has_many :surfcasts

  def long_lat
    res = [0,0]
    if self.geo_location =~ /(\d+\.\d+)\s+(\S)\s+(\d+\.\d+)\s+(\S)\s+/
      res[0] = $3.to_f
      if $4 == "W"        
        res[0]= 0 - res[0]
      end
      
      res[1] = $1.to_f
      if $2 == 'S'
        res[1] = 0 - res[1]
      end
    end

    res
  end

  def longitude
    long_lat[0]  
  end

  def latitude
    long_lat[1]
  end
  
  # url to retrieve buoy data
  def noaa_url
    "http://www.ndbc.noaa.gov/station_page.php?station=#{self.number}";
  end
  
  # if we have both geo location and description,
  # then we have the basic info
  
  def info_complete
    self.description and self.geo_location
  end

  # this is called from the scrape_buoys script
  # to get a buoy description from each buoy web site
  
  def get_info
    doc = Hpricot(open(noaa_url))
    puts noaa_url
    if !self.description
      doc.search("h1").each do |elem|     
        desc = elem.inner_html
        # remove imbeded links in the middle of the description
        desc.gsub!(/\<a.href.*?\<\/a\>/,' ')
       
        self.description = desc
        puts self.description
        self.save
      end
    end
    if !self.geo_location
      begin
        elems = doc.search("p/b").to_a.map{|elm| elm.inner_html}
        if elems[1] == "Owned and maintained by National Data Buoy Center"
          puts elems[4]
          self.geo_location = elems[4]
          self.save
        end
        rescue
      end        
    end
    
  end

  def getReadings
    
  end

  def getSurfcasts(wave_models = "")
  # puts Time.now.to_s
    curtime = Time.now
    wave_models = "" if wave_models == nil
  
    deleted = false
    surfcasts.each do |read|
      crtime = read.created_at
      expire = crtime + 3600
      if Time.now > expire
        deleted = true
        read.destroy
      end 
    end
    self.save!
    if (self.surfcasts.size <= 0) || deleted
      forcasts = Surfcast.load_from_web(wave_models,self.number)
      forcasts.each do |f|  
        f.save!
        surfcasts << f
      end
    end
  end
  




end
