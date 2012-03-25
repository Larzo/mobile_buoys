require 'rubygems'
require 'hpricot'
require 'open-uri'

class WeatherReading < ActiveRecord::Base
  belongs_to :weather_location
  
  
def self.loadFromWeb(key)
  page = 'http://www.weather.com/weather/hourbyhour/' + key
  rep_row = ['hour', 'feels-like', 'precip', 'dew-point', 'humid', 'wind']
  doc = open(page) { |f| Hpricot(f) }
  
  @list = Array.new
  
  idx = 0
  item=Hash.new
  doc.search("/html/body//table").each do |tab|
   (tab/'td.lapHourlyDataRow').each do |itm|
     item = {} if idx == 0
     puts idx
     puts item.class
     if itm.inner_html.size < 50
       txt = itm.inner_html
       case rep_row[idx]
          when 'feels-like', 'precip','dew-point'
            tok = txt.scan(/\d+/)
            txt = tok[0]
          end
       ky = rep_row[idx]
       puts rep_row[idx] + ":" + txt + " k:" + ky
       puts item.class
       item[ky] = txt
       idx += 1
       if idx >= rep_row.size
         idx = 0
         @list << item
       end  
      end
   end
 end

 @result = Array.new
 @list.each do |itm|
    rec = self.new
    rec.hour = itm['hour']
    rec.temp = itm['feels-like']
    rec.precip = itm['precip']
    rec.wind = itm['wind']    
    @result << rec
  end 
  
  puts "size:" + @result.size.to_s
  return @result

end

  
  
end
