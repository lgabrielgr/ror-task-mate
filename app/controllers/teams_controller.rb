class TeamsController < ApplicationController
  TRUNCATE_LENGTH = 22

  def tickets
    set_team
    authorize @team, :tickets?
    @tickets = @team.tickets
    @tickets_to_do = @tickets.where(status: Ticket::TICKET_TO_DO_STATUS)
    @tickets_in_progress = @tickets.where(status: Ticket::TICKET_IN_PROGRESS_STATUS)
    @tickets_review = @tickets.where(status: Ticket::TICKET_REVIEW_STATUS)
    @tickets_done = @tickets.where(status: Ticket::TICKET_DONE_STATUS)
  end

  def edit
    set_team
    authorize @team, :edit?
  end

  def update
    set_team
    authorize @team, :update?
    if @team.update(team_params)
      redirect_to root_path(@team)
    else
      render :edit
    end
  end

  def new
    @team = Team.new
    authorize @team, :create?
  end

  def create
    @team = Team.new(team_params)
    authorize @team, :create?
    @team.creator = current_user
    if @team.save
      redirect_to root_path
    else
      render
    end
  end

  private

  def set_team
    @team = Team.find(params[:team_id])
  end

  def team_params
    params.require(:team).permit(:name, :description, :owner_id, member_ids: [])
  end
end
