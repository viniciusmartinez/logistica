class Suit < ActiveRecord::Base
  belongs_to :protocol
  accepts_nested_attributes_for :protocol
  has_many :suit_status_changes

  validates_presence_of :protocol, :entidade, :representante
  
  scope :pendentes, where(:status_decisao => StatusPedido.pendente)
  scope :deferidos, where(:status_decisao => StatusPedido.deferido)
  scope :indeferidos, where(:status_decisao => StatusPedido.indeferido)
  scope :em_atendimento, where("status_decisao = ? AND status_atendimento = ?", StatusPedido.deferido, StatusPedido.em_atendimento)
  scope :atendidos, where("status_decisao = ? AND status_atendimento = ?", StatusPedido.deferido, StatusPedido.atendido)
  scope :cancelados, where("status_decisao = ? AND status_atendimento = ?", StatusPedido.deferido, StatusPedido.cancelado)
  
  def sera_atendido?
    StatusPedido::a_atender? status_decisao
  end
  
  def pendente?
    status_decisao == StatusPedido.pendente
  end
  
  def deferido?
    status_decisao == StatusPedido.deferido
  end
  
  def indeferido?
    status_decisao == StatusPedido.indeferido
  end
  
  def em_atendimento?
    deferido? and status_atendimento == StatusPedido.em_atendimento
  end

  def atendido?
    deferido? and status_atendimento == StatusPedido.atendido
  end

  def cancelado?
    deferido? and status_atendimento == StatusPedido.cancelado
  end

end
