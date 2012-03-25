class CreateWeatherReading < ActiveRecord::Migration
  def self.up
    create_table :weather_readings do |t|
      t.integer :weather_location_id
      t.string :hour
      t.string :temp
      t.integer :precip
      t.string :wind

      t.timestamps
    end
  end

  def self.down
    drop_table :weather_readings
  end
end
