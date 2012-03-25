

class String
  # capitalize each word in a string
  def make_caps
    self.split(" ").each{|word| word.capitalize!}.join(' ')
  end
end


class ApplicationController < ActionController::Base
  protect_from_forgery



private

# check that one or any of a series of records has expired, that is that the
# based on the creation date, any of the records are older than one hour
# if so, delete those records and return true indicating that records where deleted
#
# this is currently used for weather and tide info only

  def expired_check(recs)
  
    del = false
    recs.each do |r|
      created_at = r.created_at
      expire = created_at + 3600
     
      if Time.now > expire
       del = true
       r.destroy
      end
    end
    return del
  
  end  
  
  # the layout depends on if the access is from a cell phone or
  # regular browser. 
  
  def determine_layout
  # layout = 'main'
    layout = 'ondieting_blue'
    # regions are used in the layout
    @regions = Region.find(:all)

    @web_browser = true
    if (mobile_browser)
      layout = 'main_mobile'  
      @web_browser = false
      headers['Content-Type'] = 'text/vnd.wap.wml; charset=iso-8859-1'    
    end        
    
    return layout
  end
  
  # return true if we think the client is a cell phone
  
  def mobile_browser
    mobile = false
    firefox = false
    ie = false;
    # puts request.env['HTTP_USER_AGENT']
    if mat = /\s*Mozilla\/\d+\.\d+\s*\(Windows.*\s*Firefox/.match(request.env['HTTP_USER_AGENT'])
      firefox = true
      # puts "FIREFOX \n"
    end  
    if mat = /\s*Mozilla\/\d+\.\d+\s*\(.*MSIE.*Windows/.match(request.env['HTTP_USER_AGENT'])
      ie = true
      # puts "IE \n"
    end
  
    if (!ie && !firefox)
      logger.info('CELL ACCESS') 
    else
      logger.info('BROWSER ACCESS')
    end    
    # use ?wml=1 in url to test on valaidation sites etc
    if ((!ie && !firefox) || params[:wml])
      mobile = true      
    end
    return mobile
  end
  


end
