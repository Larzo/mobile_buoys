class BuoyMapController < ApplicationController
  before_filter :set_map
  # layout :determine_layout
   
  def set_map
    @buoy_map = true
    true
  end 
  
  def show_map
    prof = Profile.find(params[:id])
    @stations = prof.stations
    render :index
  end
   
  def index
    @stations = Station.find(:all)
    
  end

end
