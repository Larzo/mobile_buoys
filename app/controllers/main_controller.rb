

class MainController < ApplicationController

  layout :determine_layout
  before_filter :set_regions
  helper :main
  after_filter :cors_set_access_control_headers

  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    headers['Access-Control-Allow-Headers'] = '*'
    headers['Access-Control-Max-Age'] = "1728000"
  end
  

  # site home page
  def index
    @region = ""
    @region_msg = "all regions"
    @profiles = Profile.all 
  end

  def regions
    @regions = Region.all
    render :json => @regions
  end

  # display a region such as east coast, west coast etc
  def region
    if id = params[:id]
      @region = Region.find(id)
    else
      # named urls for cell phones are better as bookmarks
      name = params[:region].gsub(/_/," ") # .make_caps
      # LJG !!! fix this hack
      name = name.split.map(&:capitalize).join(' ')
      @region = Region.find_by_name(name)
    end 
    @profiles = @region.profiles
 
    respond_to do |format|
      format.json {render :json => @profiles}
      format.html
    end
 
    @region_msg = "region:#{@region.name}"
  end
  
# select * from profiles pf, station_joins sj, stations st, readings rd 
# where pf.name = 'NH' and pf.id = sj.profile_id and sj.station_id = st.id and 
# rd.station_id = st.id

  def get_readings
    res = []	  
    @prof.stations.each do |station|
      reading = {}
      reading[:name] = station.name
      reading[:id] = station.number
      reading[:readings] = station.readings
      res << reading.dup
    end
    res
  end	  

  def show_profile_by_id
    id = params[:id]
    @prof = Profile.find(id)
    @name = @prof.name
    render_profile
  end	  

  # show buoy reports for a profile such as for new england etc
  def show_profile
    puts 'in show:' + @regions.inspect
    @name = params[:name]
    @name = @name.gsub(/_/,' ') # .make_caps
    @prof = Profile.where(name: @name).first
    render_profile
  end



  # wave model forcast
  def forcast
    @profiles = Profile.find(:all)
    @region = params[:region]
    @region_msg = "wave models: #{@region}"
  end



  def show_surfcast
    name = params[:name]
    name = name.gsub(/-/,' ')
    @prof = Profile.find(:first,
      :conditions => ["name = :name",{:name => name}])

    if @prof
      @msg = "Profile: #{name}"
      @prof.getSurfcasts()
    else
      @msg = "Profile for '#{name}' was not found"
    end    
  end



  def show_full_surfcast
    #puts "called here"
    station = params[:station]
    @show_period = (params[:period]) ? true : false

    @station = Station.find(:first,
      :conditions => ["number = :number",{:number => station}])

#puts "after"

    if @station 
      @msg = "Station: #{@station.name}"
      #puts "get"
      @station.getSurfcasts()
    else
      @msg = "Station #{station} was not found"  
    end  

  end 
  
  private
  
  def render_profile
    @centered_text = false
  
    puts 'in render: reg=' + @regions.inspect
    if @prof	
        @msg = "Profile: #{@name}"
        # make sure buoy reports are current
        @prof.getReadings()
        respond_to do |format|
          format.json { render json: get_readings }
          format.html { render 'show_profile' }
        end	
    else
      @msg = "Profile for '#{@name}' was not found"
      render 'show_profile'
    end    	  
  end	  

end
