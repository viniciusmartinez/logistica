class DataeleDescritor < ActiveRecord::Base
   establish_connection Rails.configuration.database_configuration["intranet"]
   set_table_name 'intranet.dataele_descritores'
   set_primary_key 'chave'
end
