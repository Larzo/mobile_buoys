class RegionsController < ApplicationController
  
  def index
    @regions = Region.all
    respond_to do |format|
      format.json 
      format.html
    end
  end
  
end
