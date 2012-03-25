class AddLocation2station < ActiveRecord::Migration
  def self.up
    add_column :stations, :geo_location, :string
  end

  def self.down
  end
end
