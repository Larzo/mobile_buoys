class AddWavePeriod < ActiveRecord::Migration
  def self.up
    add_column :surfcasts, :period, :float
  end

  def self.down
    remove_column :surfcasts, :period
  end
end
