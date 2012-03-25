
# scrape a bunch of buoys off of the NOAA website and store them in the database.

require 'hpricot'
require 'open-uri'

# the ocean buoys that have wave info seem to have numeric
# ID's and are at the top of the list. 
last_station = 91442

station_list_url = 'http://www.ndbc.noaa.gov/to_station.shtml'

# Station.find(:all).each{|st| st.destroy}

doc = Hpricot(open(station_list_url))

# stations with non numeric ID's appear to be mainly weather stations
# and generally have no wave information
pat = /station_page\.php\?station=(\d+)$/

done = false
cnt = 0
while !done
  doc.search("a").each do |link|  
    if mat = pat.match(link.attributes['href'])
      # found what looks like a buoy link 
      num = mat[1].to_i
      if !station = Station.find_by_number(num)    
        station = Station.new(:number => num)
        station.save
      end
      if !station.info_complete
        # scrape buoy description from buoy site
        station.get_info
        sleep 45 if cnt % 5 == 0        
        cnt += 1
      end
      done = true if num == last_station
    end
  end 
end
