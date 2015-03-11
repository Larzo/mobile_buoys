class ProfilesController < ApplicationController
  
  def index
    @profiles = Profile.all
    respond_to do |format|
      format.json
      format.html
    end
  end
  
end
