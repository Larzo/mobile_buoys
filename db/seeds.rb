# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

east_region = Region.create(:name => 'East Coast Buoys')
west_region = Region.create(:name => 'West Coast Buoys')

Profile.create(:name => 'Maine') do |prof|
  prof.stations << Station.create(:name => "Portland Maine", :number => "44007")
  prof.stations << Station.create(:name => "Western Maine Shelf", :number => "44030")
  prof.stations << Station.create(:name => "Georges Bank", :number => "44011")
  prof.stations << Station.create(:name => "Gulf of Maine", :number => "44005")
  prof.stations << Station.create(:name => "Central Maine Shelf", :number => "44032")
  east_region.profiles << prof
end
Profile.create(:name => 'NH') do |prof|
  prof.stations << Station.create(:name => "Portland Maine", :number => "44007")
  prof.stations << Station.create(:name => "Boston Harbor", :number => "44013")
  prof.stations << Station.create(:name => "Georges Bank", :number => "44011")
  prof.stations << Station.create(:name => "Gulf of Maine", :number => "44005")
  prof.stations << Station.create(:name => "Isle of Shoals", :number => "iosn3")
  prof.stations << Station.create(:name => "Stellwagen Bank", :number => "44029")
  east_region.profiles << prof
end
Profile.create(:name => 'Florida') do |prof|
  prof.stations << Station.create(:name => "Saint Augustine", :number => "41012")
  prof.stations << Station.create(:name => "Cape Canaveral", :number => "41009")
  prof.stations << Station.create(:name => "Canaveral East", :number => "41010")
  east_region.profiles << prof
end
Profile.create(:name => 'NE offshore') do |prof|
  prof.stations << Station.create(:name => "Georges Bank", :number => "44011")
  prof.stations << Station.create(:name => "Gulf of Maine", :number => "44005")
  prof.stations << Station.create(:name => "Nantucket", :number => "44008")
  prof.stations << Station.create(:name => "SE Cape Cod", :number => "44018")
  east_region.profiles << prof
end
Profile.create(:name => 'Hatteras') do |prof|
  prof.stations << Station.create(:name => "East of Hatteras", :number => "41001")
  prof.stations << Station.create(:name => "Diamond Shoals", :number => "41025")
  prof.stations << Station.create(:name => "Virginia Beach", :number => "44014")
  prof.stations << Station.create(:name => "Frying Pan Shoals", :number => "41013")
  east_region.profiles << prof
end
Profile.create(:name => 'Rhode Island') do |prof|
  prof.stations << Station.create(:name => "Nantucket", :number => "44008")
  prof.stations << Station.create(:name => "Long Island", :number => "44025")
  prof.stations << Station.create(:name => "Montauk", :number => "44017")
  prof.stations << Station.create(:name => "Buzzards Bay", :number => "buzm3")
  east_region.profiles << prof
end
Profile.create(:name => 'Southern CA') do |prof|
  prof.stations << Station.create(:name => "Tanner Banks", :number => "46047")
  prof.stations << Station.create(:name => "Coronado Islands", :number => "46232")
  prof.stations << Station.create(:name => "Cape San Martin", :number => "46028")
  prof.stations << Station.create(:name => "Santa Monica Basin", :number => "46025")
  prof.stations << Station.create(:name => "Santa Barbara", :number => "46054")
  west_region.profiles << prof
end

