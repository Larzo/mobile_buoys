class AddStationInfo < ActiveRecord::Migration
  def self.up
    add_column :stations, 'description', :string    
  end

  def self.down
  end
end
