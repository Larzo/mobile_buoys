class CreateStationJoins < ActiveRecord::Migration
  def self.up
    create_table :station_joins do |t|
      t.integer :station_id
      t.integer :profile_id
      t.integer :region_id
      t.timestamps
    end
  end

  def self.down
    drop_table :station_joins
  end
end
