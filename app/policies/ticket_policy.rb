class TicketPolicy
  def initialize(user, ticket)
    @user = user
    @ticket = ticket
  end

  def view?
    can_view_edit_ticket?
  end

  def edit?
    can_view_edit_ticket?
  end

  def update?
    edit?
  end

  def create?
    can_create_ticket?
  end

  def new?
    create?
  end

  def destroy?
    create?
  end

  def can_comment?
    can_view_edit_ticket?
  end

  private

  def can_view_edit_ticket?
    @user.can_see_ticket?(@ticket) || @user.admin?
  end

  def can_create_ticket?
    @ticket.team.is_team_member?(@user) || @user.admin?
  end
end
