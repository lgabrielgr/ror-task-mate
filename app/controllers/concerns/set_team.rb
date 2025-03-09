module SetTeam
  extend ActiveSupport::Concern

  private

  def set_team
    @team = Team.find(params[:team_id])
  rescue ActiveRecord::RecordNotFound
    @team = Team.find_by!(code_identifier: params[:team_id].upcase)
  end
end
