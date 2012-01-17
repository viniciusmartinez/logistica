class City < ActiveRecord::Base
   establish_connection Rails.configuration.database_configuration["cad"]
   set_table_name 'admcad.localidade'
   set_primary_key 'cod_objeto'
   
   has_many :places,
            :primary_key => :cod_objeto,
            :foreign_key => :cod_objeto_localidade
   
   scope :mt, where("cod_objeto_uf = ? AND situacao = ? AND nom_localidade != ?", 18,1,"OUTROS MATO GROSSO").order("#{table_name}.nom_localidade")
   
   scope :outros, where("cod_objeto_uf = ? AND situacao = ? AND nom_localidade = ?", 18,1,"OUTROS MATO GROSSO")
   
   scope :desativados, where("cod_objeto_uf = ? AND situacao = ?", 18,2)
   
   def numero
      self[:cod_localidade_tse]
   end
   
   def nome
      self[:nom_localidade]
   end
   
   def id
      self[:cod_objeto]
   end
   
   def self.nome_por_id(id)
      where("cod_objeto" => id).first.nome
   end
end
