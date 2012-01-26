class DataelePlace < ActiveRecord::Base
   establish_connection Rails.configuration.database_configuration["intranet"]
   set_table_name 'intranet.dataele_local'
   set_primary_keys 'zona', 'munic_id', 'num_local', 'id_vistoria'
   
   def self.por_zona_municipio_local(zona,municipio,local)
      where("zona = #{zona}").where("munic_id = #{municipio}").where("num_local = #{local}").order("id_vistoria")
   end
end
