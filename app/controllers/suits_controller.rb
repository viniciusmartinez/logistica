class SuitsController < ApplicationController
  # GET /suits
  def index
    @suits = Suit.all
    @pendentes = Suit.pendentes
    @deferidos = Suit.deferidos
    @indeferidos = Suit.indeferidos
    @em_atendimento = Suit.em_atendimento
    @atendidos = Suit.atendidos
    @cancelados = Suit.cancelados
  end

  # GET /suits/1
  def show
    @suit = Suit.find(params[:id])
  end

  # GET /suits/new
  def new
    @suit = Suit.new
    @suit.protocol = Protocol.new
    
    @suit.status_decisao = StatusPedido::pendente
    @suit.status_atendimento = StatusPedido::em_atendimento
  end

  # GET /suits/1/edit
  def edit
    @suit = Suit.find(params[:id])
  end

  # POST /suits
  def create
    # coloca no padrao se nao for "deferido" de inicio
    #params[:suit][:status_atendimento] = StatusPedido.em_atendimento if params[:suit][:status_decisao] != StatusPedido.deferido
    #if params[:suit][:status_decisao] != StatusPedido.deferido
    #  params[:suit][:status_atendimento] = StatusPedido.em_atendimento
    #end
    
    @suit = Suit.new(params[:suit])
    
    protocol = Protocol.where("numero = ? AND data = ?", @suit.protocol.numero, @suit.protocol.data).first
    if protocol
      @suit.protocol = protocol
    end
   
      @suit.save ? redirect_to(@suit, :notice => 'Pedido criado com sucesso.') : render(:action => "new")
  end

  # PUT /suits/1
  def update
    @suit = Suit.find(params[:id])

    # pega data dos atributos    
    d = Date.new(params[:suit][:protocol_attributes]['data(1i)'].to_i, params[:suit][:protocol_attributes]['data(2i)'].to_i, params[:suit][:protocol_attributes]['data(3i)'].to_i )
    
    # se mudou número ou data do protocolo
    if params[:suit][:protocol_attributes][:numero] != @suit.protocol.numero or @suit.protocol.data != d
      
      # se existe protocolo colocado
      protocol = Protocol.where("numero = ? AND data = ?", params[:suit][:protocol_attributes][:numero], d).first
      if protocol
        # poe o existente      
        params[:suit][:protocol_id] = protocol.id
        params[:suit][:protocol_attributes] = @suit.protocol.attributes # ?
      end
    end 
      
    # atualiza
    @suit.update_attributes(params[:suit]) ?
      redirect_to(@suit, :notice => 'Pedido atualizado com sucesso.') :
      render(:action => "edit")
  end

  # DELETE /suits/1
  def destroy
    @suit = Suit.find(params[:id])
    @suit.destroy

    redirect_to(suits_url)
  end
end
