require 'hpricot'
require 'open-uri'



class Reading < ActiveRecord::Base
  belongs_to :station

  # parse the latest reading from the buoy page
  
  def parse(page)

    hdr = %w{ WDIR WSPD GST WVHT DPD PRES PTDY ATMP WTMP SAL VIS CHILL MWD}

    doc = Hpricot(open(page))  #{ |f| Hpricot(f) }
    tidx = 0

    doc.search("/html/body//table").each do |tab|
     
      # an error ocurred here which was invalid UTF-8 byte sequence
      begin         
        if (mat = /Conditions at \S+ as of.*\((.*)\)/.match(tab.inner_html))
          self.timeof_conditions = mat[1]
        end
        rescue
      end
      readings = false
      fldName = "";
      if tidx == 4
        (tab/'td').each do |data|
          if readings
   #        puts data.inner_html
            setField(fldName, data.inner_html)
            readings = false
          end
          begin
            if mat = /^.*\(([A-Z]+)\)/.match(data.inner_html)
              # matched a header column of the form
              # <td>Wave Height (WVHT):</td>
              # save the field name, 
              # the next td element will have the value
              if hdr.any? {|itm| itm == mat[1]}
                readings = true
                fldName = mat[1]
              end
            end
            rescue
          end
        end 
      end # if tidx = 4
      tidx += 1
    end # doc.search
  end

  def setField(fldName, val)
    if fldName == 'WDIR'    
      if (mat = /(.*)\(.*\)/.match(val))
        self.wdir = mat[1]
      end
    elsif ['WSPD','WVHT','DPD', 'PRES', 'ATMP',
          'WTMP','MWD' ].include?(fldName)
      self.send (fldName.downcase + '=').to_sym, val      
    end
  end

end