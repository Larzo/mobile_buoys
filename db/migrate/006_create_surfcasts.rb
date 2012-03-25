class CreateSurfcasts < ActiveRecord::Migration
  def self.up
    create_table :surfcasts do |t|
      t.column :created_at, :timestamp
      t.column :station_id, :integer
      t.column :day, :integer
      t.column :hour, :integer
      t.column :direction, :integer
      t.column :height, :float
    end
  end

  def self.down
    drop_table :surfcasts
  end
end
