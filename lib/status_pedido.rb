class StatusPedido
  DECISAO = { :Pendente => 0, :Deferido => 1, :Indeferido => 2 }
  ATENDIMENTO = { "Em Atendimento" => 0, :Atendido => 1, :Cancelado => 2 }

  def self.status_decisao(valor)
    DECISAO.key(valor)
  end

  def self.statuses_decisao
    DECISAO.keys
  end

  def self.numero_status_decisao(status)
    DECISAO[status]
  end
  
  def self.pendente
    DECISAO[:Pendente]
  end
  
  def self.deferido
    DECISAO[:Deferido]
  end
  
  def self.indeferido
    DECISAO[:Indeferido]
  end
  
  def self.a_atender?(numero)
    numero == DECISAO[:Deferido]
  end
  
  def self.status_atendimento(valor)
    ATENDIMENTO.key(valor)
  end
  
  def self.statuses_atendimento
    ATENDIMENTO.keys
  end
  
  def self.numero_status_atendimento(status)
    ATENDIMENTO[status]
  end
  
  def self.em_atendimento
    ATENDIMENTO["Em Atendimento"]
  end
  
  def self.atendido
    ATENDIMENTO[:Atendido]
  end
  
  def self.cancelado
    ATENDIMENTO[:Cancelado]
  end 

end

#Item::AVAILABLE_STATUS # => { :unkwnown => 0, :medical => 3 }
#Item.statuses # => [:medical, :unkwnown]
#Item.status_value(:medical) # => 3
