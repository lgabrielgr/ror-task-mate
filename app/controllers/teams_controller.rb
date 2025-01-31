class TeamsController < ApplicationController
  def tickets
    @team = Team.find(params[:team_id])
    @tickets = @team.tickets
    @tickets_to_do = @tickets.where(status: 0)
    @tickets_in_progress = @tickets.where(status: 1)
    @tickets_review = @tickets.where(status: 2)
    @tickets_done = @tickets.where(status: 3)
  end
end
