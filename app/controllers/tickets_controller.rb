class TicketsController < ApplicationController
  before_action :authorize_read_update_ticket, only: [ :view, :edit ]
  before_action :authorize_create_ticket, only: [ :new, :create ]

  TICKET_PRIORITY_OPTIONS_FOR_SELECTION = {
    Ticket::TICKET_LOW_PRIORITY => Ticket::TICKET_LOW_PRIORITY_NAME,
    Ticket::TICKET_MEDIUM_PRIORITY => Ticket::TICKET_MEDIUM_PRIORITY_NAME,
    Ticket::TICKET_HIGH_PRIORITY => Ticket::TICKET_HIGH_PRIORITY_NAME
  }

  TICKET_STATUS_OPTIONS_FOR_SELECTION = {
    Ticket::TICKET_TO_DO_STATUS => Ticket::TICKET_TO_DO_STATUS_NAME,
    Ticket::TICKET_IN_PROGRESS_STATUS => Ticket::TICKET_IN_PROGRESS_STATUS_NAME,
    Ticket::TICKET_REVIEW_STATUS => Ticket::TICKET_REVIEW_STATUS_NAME,
    Ticket::TICKET_DONE_STATUS => Ticket::TICKET_DONE_STATUS_NAME
  }

  def view
    @ticket = Ticket.find(params[:id])
    @team = @ticket.team
  end

  def edit
    @ticket = Ticket.find(params[:id])
    @assignees = @ticket.team.members
  end

  def update
    @ticket = Ticket.find(params[:id])
    if @ticket.update(ticket_params)
      redirect_to ticket_view_path(@ticket)
    else
      render "edit"
    end
  end

  def new
    @team = Team.find(params[:team_id])
    @ticket = Ticket.new
  end

  def   create
    @team = Team.find(params[:team_id])
    @ticket = Ticket.new(ticket_params)
    @ticket.team = @team
    @ticket.creator = current_user
    if @ticket.save
      redirect_to team_tickets_path(@team)
    else
      render "new"
    end
  end

  private

  def authorize_read_update_ticket
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

  def authorize_create_ticket
    begin
      @team = Team.find(params[:team_id])
      unless @team.is_team_member?(current_user)
        redirect_to root_path
      end
    rescue ActiveRecord::RecordNotFound
      Rails.logger.warn "User with id #{current_user.id} tried to access non-existent team with id #{params[:id]}"
      redirect_to root_path
    end
  end

  def ticket_params
    params.require(:ticket).permit(:assignee_id, :priority, :status, :due_date, :title, :description)
  end
end
