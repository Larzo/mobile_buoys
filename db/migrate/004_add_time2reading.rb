class AddTime2reading < ActiveRecord::Migration
  def self.up
  add_column :readings, :timeof_conditions, :string, :limit => 35
  end

  def self.down
  remove_column :readings, :timeof_conditions
  end
end
