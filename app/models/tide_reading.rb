require 'rubygems'
require 'hpricot'
require 'open-uri'


class TideReading < ActiveRecord::Base
  belongs_to :weather_location
  
  
  def self.loadFromWeb(key)

    page = 'http://tbone.biol.sc.edu/tide/tideshow.cgi?site=' + key + '&units=f'
    doc = open(page) { |f| Hpricot(f) }

    rec_list = Array.new

    doc.search("/html/body//pre").each do |pre|  
      data = pre.inner_html.split(/\n/)
   
      data.each do |line|
        if (line =~ /^\d\d\d\d-\d\d-\d\d/)
          mat = line.match /^(\d+-\d+-\d+)\s+(\d+:\d+\s+\S+)\s+(.*)/
          if mat
            size = ""
            day = mat[1]
            hour = mat[2]
            event = mat[3]
            ev_mat = event.match(/^(-?\d+.\d+\s+feet)\s+(.*)/)
            if ev_mat
              size = ev_mat[1]
              event = ev_mat[2]
            end
            rec = self.new
            rec.day = day
            rec.hour = hour
            rec.event = event
            rec.size = size
            rec_list << rec
          end  
        end  
      end
    end

    return rec_list
  end    
  
end