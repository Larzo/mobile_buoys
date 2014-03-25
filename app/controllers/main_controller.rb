

class MainController < ApplicationController

  layout :determine_layout
  helper :main

  # site home page
  def index
    @region = ""
    @region_msg = "all regions"
    @profiles = Profile.find(:all) 
  end


  # display a region such as east coast, west coast etc
  def region
    if id = params[:id]
      @region = Region.find(id)
    else
      # named urls for cell phones are better as bookmarks
      name = params[:region].gsub(/_/," ") # .make_caps
      @region = Region.find_by_name(name)
    end 
    @profiles = @region.profiles
 
    @region_msg = "region:#{@region.name}"
  end
  

  # show buoy reports for a profile such as for new england etc
  def show_profile
    @centered_text = false
    name = params[:name]
    name = name.gsub(/_/,' ') # .make_caps
    @prof = Profile.find(:first,
      :conditions => ["name = :name",{:name => name}])

    if @prof
      @msg = "Profile: #{name}"
      # make sure buoy reports are current
      @prof.getReadings()
    else
      @msg = "Profile for '#{name}' was not found"
    end    

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

end
