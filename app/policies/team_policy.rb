class TeamPolicy
  def initialize(user, team)
    @user = user
    @team = team
  end

  def edit?
    is_admin_or_team_owner?
  end

  def update?
    is_admin_or_team_owner?
  end

  def create?
    @user.admin?
  end

  def destroy?
    is_admin_or_team_owner?
  end

  private

  def is_admin_or_team_owner?
    @user.admin? || @team.owner == @user
  end
end
