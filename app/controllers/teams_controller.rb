class TeamsController < ApplicationController
  before_action :authorize_user, only: [ :tickets ]

  TRUNCATE_LENGTH = 22

  def tickets
    @team = Team.find(params[:team_id])
    @tickets = @team.tickets
    @tickets_to_do = @tickets.where(status: Ticket::TICKET_TO_DO_STATUS)
    @tickets_in_progress = @tickets.where(status: Ticket::TICKET_IN_PROGRESS_STATUS)
    @tickets_review = @tickets.where(status: Ticket::TICKET_REVIEW_STATUS)
    @tickets_done = @tickets.where(status: Ticket::TICKET_DONE_STATUS)
    @ticket_title_truncate_length = TRUNCATE_LENGTH
  end

  private

  def authorize_user
    begin
      @team = Team.find(params[:team_id])
      unless current_user.can_see_team_tickets?(@team)
        redirect_to root_path
      end
    rescue ActiveRecord::RecordNotFound
      Rails.logger.warn "User with id #{current_user.id} tried to access non-existent team with id #{params[:team_id]}"
      redirect_to root_path
    end
  end
end
