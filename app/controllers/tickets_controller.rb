class TicketsController < ApplicationController
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
    set_ticket
    authorize @ticket, :view?
    @team = @ticket.team
  end

  def edit
    set_ticket
    authorize @ticket, :edit?
    @assignees = @ticket.team.members
  end

  def update
    set_ticket
    authorize @ticket, :update?
    if @ticket.update(ticket_params)
      redirect_to ticket_view_path(@ticket)
    else
      render "edit"
    end
  end

  def new
    set_team
    @ticket = Ticket.new(team: @team)
    authorize @ticket, :new?
  end

  def create
    set_team
    @ticket = Ticket.new(ticket_params)
    @ticket.team = @team
    authorize @ticket, :create?
    @ticket.creator = current_user
    if @ticket.save
      redirect_to team_tickets_path(@team)
    else
      render "new"
    end
  end

  def destroy
    set_ticket
    authorize @ticket, :destroy?
    @ticket.destroy
    redirect_to team_tickets_path(@ticket.team)
  end

  private

  def set_ticket
    @ticket = Ticket.find(params[:id])
  end

  def set_team
    @team = Team.find(params[:team_id])
  end

  def ticket_params
    params.require(:ticket).permit(:assignee_id, :priority, :status, :due_date, :title, :description)
  end
end
