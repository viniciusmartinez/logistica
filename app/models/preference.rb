class Preference < ActiveRecord::Base
  belongs_to :user
  
  attr_accessor :weather_location_virtual
end
