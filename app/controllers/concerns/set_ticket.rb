module SetTicket
  extend ActiveSupport::Concern

  private

  def set_ticket
    @ticket = Ticket.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    @ticket = Ticket.where("UPPER(code_identifier) = ?", params[:id].upcase).take!
  end
end
