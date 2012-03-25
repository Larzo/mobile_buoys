class CreateDatabase < ActiveRecord::Migration
  def self.up
  
  
  create_table :stations do |t|
    t.column :number, :string, :limit => 30
    t.column :name, :string, :limit => 40
    t.column :area, :string, :limit => 2
    t.column :weight, :string, :limit => 2
  end
  


  create_table :profiles do |t|
    t.column :name, :string, :limit => 30
  end
  
  end
  
  def self.down
  drop_table :stations
  drop_table :profiles
  end
end
