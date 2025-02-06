class TeamsController < ApplicationController
  before_action :authorize_user, only: [ :tickets ]

  def tickets
    @team = Team.find(params[:team_id])
    @tickets = @team.tickets
    @tickets_to_do = @tickets.where(status: 0)
    @tickets_in_progress = @tickets.where(status: 1)
    @tickets_review = @tickets.where(status: 2)
    @tickets_done = @tickets.where(status: 3)
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
