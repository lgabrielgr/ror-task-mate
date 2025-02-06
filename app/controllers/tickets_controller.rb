class TicketsController < ApplicationController
  before_action :authorize_user, only: [ :view ]

  def view
    @ticket = Ticket.find(params[:id])
    @team = @ticket.team
  end

  private

  def authorize_user
    begin
      @ticket = Ticket.find(params[:id])
      unless current_user.can_see_ticket?(@ticket)
        redirect_to root_path
      end
    rescue ActiveRecord::RecordNotFound
      Rails.logger.warn "User with id #{current_user.id} tried to access non-existent ticket with id #{params[:id]}"
      redirect_to root_path
    end
  end
end
