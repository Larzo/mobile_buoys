class CreateTideInfo < ActiveRecord::Migration
  
  def self.up
    create_table :tide_readings do |t|
      t.integer :weather_location_id
      t.string :day
      t.string :hour
      t.string :event
      t.string :size

      t.timestamps
    end
  end

  def self.down
    drop_table :tide_readings
  end

end
