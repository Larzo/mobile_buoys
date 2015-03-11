class StationsController < ApplicationController
  
  def index
    @stations = Station.all
    respond_to do |format|
      format.json 
      format.html
    end
  end
  
end
