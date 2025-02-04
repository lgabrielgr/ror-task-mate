class TicketsController < ApplicationController
  def view
    @ticket = Ticket.find(params[:id])
    @team = @ticket.team
  end
end
