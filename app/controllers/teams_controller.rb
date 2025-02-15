class TeamsController < ApplicationController
  before_action :authorize_user, only: [ :tickets ]

  TRUNCATE_LENGTH = 22

  def tickets
    set_team
    @tickets = @team.tickets
    @tickets_to_do = @tickets.where(status: Ticket::TICKET_TO_DO_STATUS)
    @tickets_in_progress = @tickets.where(status: Ticket::TICKET_IN_PROGRESS_STATUS)
    @tickets_review = @tickets.where(status: Ticket::TICKET_REVIEW_STATUS)
    @tickets_done = @tickets.where(status: Ticket::TICKET_DONE_STATUS)
    @ticket_title_truncate_length = TRUNCATE_LENGTH
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
