class ElectoralUnit < ActiveRecord::Base
   belongs_to :election
   belongs_to :city
   belongs_to :zone
end
