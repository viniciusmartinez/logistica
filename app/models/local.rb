class Local < ActiveRecord::Base
   #establish_connection Rails.configuration.database_configuration["teste2"]
   #set_table_name 'admcad.local_votacao'
   
   # outros atributos possiveis
   
   #set_primary_key 'ns_id'
   #set_column_prefix 'ns_'
   
   # esse eh para bancos sem primary key
   #attr_accessor :username
   #before_validation_on_create 'self.id = @username'
   ## this is the only thing I really don't understand; why is this necessary?
   #def username_before_type_cast; end
   
   # fim outros atributos possiveis

end
