
# move admin functionality to angular

class AdminController < ApplicationController
  layout :set_layout
  
  def set_layout
    'bootstrap'
  end
  
  def index
    @heading = "Offshore Buoy Administration"
    
  end

end