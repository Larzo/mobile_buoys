class Region < ActiveRecord::Base
  has_many :station_joins
  has_many :profiles, :through => :station_joins  

  # for named urls
  def link_name
    self.name.gsub(/\s/,"_").downcase
  end


  # setup script calls this to associate 
  # states with profiles.
  
  def create_profile_for(profile_name)  
    prof = Profile.new(:name => profile_name)
    prof.save
    yield prof         
    self.profiles << prof
  end
  
end
