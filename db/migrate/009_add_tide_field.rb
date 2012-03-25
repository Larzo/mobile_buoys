class AddTideField < ActiveRecord::Migration
  def self.up
    add_column :weather_locations, :tide_key, :string
  end

  def self.down
    remove_column :weather_locations, :tide_key
  end
end
