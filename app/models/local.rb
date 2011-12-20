class Local < ActiveRecord::Base
   establish_connection Rails.configuration.database_configuration["teste"]
end
