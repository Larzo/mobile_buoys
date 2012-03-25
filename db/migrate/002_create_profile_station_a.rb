class CreateProfileStationA < ActiveRecord::Migration
  def self.up
  
  
  create_table :profiles_stations, :id => false do |t|
    t.column :station_id, :integer, :null => false
    t.column :profile_id, :integer, :null => false
  end
  
  end

  def self.down
  drop_table :profiles_stations
  end
end
