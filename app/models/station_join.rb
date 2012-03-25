class StationJoin < ActiveRecord::Base
  belongs_to :profile
  belongs_to :station
  belongs_to :region
end
