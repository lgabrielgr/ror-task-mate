module SetTicket
  extend ActiveSupport::Concern

  private

  def set_ticket
    @ticket = Ticket.find(params[:id]) rescue Ticket.find_by!(code_identifier: params[:id].upcase)
  end
end
