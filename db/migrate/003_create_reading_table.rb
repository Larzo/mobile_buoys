class CreateReadingTable < ActiveRecord::Migration
  def self.up
  
  create_table :readings do |t|
     t.column :created_at, :timestamp
     t.column :station_id, :integer
     t.column :wdir, :string, :limit => 20
     t.column :wspd, :string, :limit => 20
     t.column :wvht, :string, :limit => 20
     t.column :dpd, :string, :limit => 20
     t.column :apd, :string, :limit => 20
     t.column :pres, :string, :limit => 20
     t.column :ptdy, :string, :limit => 20
     t.column :atmp, :string, :limit => 20
     t.column :wtmp, :string, :limit => 20
     t.column :mwd, :string, :limit => 20
     end
  end

  def self.down
  drop_table :readings
  end
end
