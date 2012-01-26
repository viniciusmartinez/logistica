class SurveyProcess < ActiveRecord::Base
   establish_connection Rails.configuration.database_configuration["intranet"]
   set_table_name 'intranet.dataele_vistorias'
   #set_primary_key 'id'
end
