class TicketsController < ApplicationController
  include Constants, SetTeam, SetTicket

  TICKET_PRIORITY_OPTIONS_FOR_SELECTION = {
    TICKET_LOW_PRIORITY => TICKET_LOW_PRIORITY_NAME,
    TICKET_MEDIUM_PRIORITY => TICKET_MEDIUM_PRIORITY_NAME,
    TICKET_HIGH_PRIORITY => TICKET_HIGH_PRIORITY_NAME
  }

  TICKET_STATUS_OPTIONS_FOR_SELECTION = {
    TICKET_TO_DO_STATUS => TICKET_TO_DO_STATUS_NAME,
    TICKET_IN_PROGRESS_STATUS => TICKET_IN_PROGRESS_STATUS_NAME,
    TICKET_REVIEW_STATUS => TICKET_REVIEW_STATUS_NAME,
    TICKET_DONE_STATUS => TICKET_DONE_STATUS_NAME
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
      send_ticket_update_notification
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
      TicketNotificationJob.perform_later(@ticket.assignee, @ticket, :assigned)
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

  def send_ticket_update_notification
    if @ticket.previous_changes.include?(:assignee_id)
      TicketNotificationJob.perform_later(@ticket.assignee, @ticket, :assigned)
    else
      TicketNotificationJob.perform_later(@ticket.assignee, @ticket, :updated)
    end
  end

  def ticket_params
    params.require(:ticket).permit(:assignee_id, :priority, :status, :due_date, :title, :description, :code_identifier)
  end
end
