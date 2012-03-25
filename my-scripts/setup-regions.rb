
# after running the scrape buoys script to populate the database,
# try to arrange some of the buoys based on their specific location

class String
  def make_caps
    self.split("_").each{|word| word.capitalize!}.join(' ')
  end
end

class RegionalSetup

  CoastalRegions = {:east_coast => {:new_england => [:me,:ma,:nh], 
                             :mid_atlantic => [:nj,:va,:nc,:sc]},
                    :west_coast => {:california => :ca,
                                    :pacific_northwest => [:wa,:or],
                                    :alaska => :ak},
                    :south_coast => {:gulf_of_mexico => [:la,:tx,:al],
                                     :caribean => [:pr, :caribbean]}                                            
            } 


  def run
    CoastalRegions.each_pair do |key,areas|
      name = key.to_s.make_caps     
      if !Region.find_by_name(name)
        region = Region.new(:name => name)      
        region.save
        p region
        areas.each_pair do |area_ky, states|
          prof_name = area_ky.to_s.make_caps
          region.create_profile_for(prof_name) do |prof|
            p prof        
            prof.find_by_state states          
          end
        end
      end
    end    
  end
  
  
  
  
end

Region.find(:all).each{|r| r.destroy}
Profile.find(:all).each{|p| p.destroy}
setup = RegionalSetup.new
setup.run
