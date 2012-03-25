class CreateWeatherLocations < ActiveRecord::Migration
  def self.up
    create_table :weather_locations do |t|
      t.string :name
      t.string :key

      t.timestamps
    end
  end

  def self.down
    drop_table :weather_locations
  end
end
