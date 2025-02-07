class TicketsController < ApplicationController
  before_action :authorize_user, only: [ :view, :edit ]

  def view
    @ticket = Ticket.find(params[:id])
    @team = @ticket.team
  end

  def edit
    @ticket = Ticket.find(params[:id])
  end

  def update
    @ticket = Ticket.find(params[:id])
    if @ticket.update(ticket_params)
      redirect_to ticket_view_path(@ticket)
    else
      render "edit"
    end
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

  def ticket_params
    params.require(:ticket).permit(:title, :description)
  end
end
