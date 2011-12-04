class SuitStatus
  STATUSES = { :Pendente => 0, :Indeferido => 1, "Em Atendimento" => 2, :Atendido => 3, :Cancelado => 4 }

  def self.status(valor)
    STATUSES.key(valor)
  end

  def self.statuses
    STATUSES.keys
  end

  def self.numero_status(status)
    STATUSES[status]
  end
  
  def self.pendente
    STATUSES[:Pendente]
  end
  
  def self.indeferido
    STATUSES[:Indeferido]
  end
  
  def self.deferido?(numero)
    numero != STATUSES[:Indeferido] and numero != STATUSES[:Pendente]
  end
  
  def self.em_atendimento
    STATUSES["Em Atendimento"]
  end
  
  def self.atendido
    STATUSES[:Atendido]
  end
  
  def self.cancelado
    STATUSES[:Cancelado]
  end 

end
