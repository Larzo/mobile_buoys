class AddWavemodelColumn < ActiveRecord::Migration
  def self.up
  add_column :profiles, :wave_models, :string, :limit => 45
  add_column :stations, :wave_model, :string, :limit => 20
  end

  def self.down
  remove_column :profiles, :wave_models
  remove_column :stations, :wave_model
  end
end
