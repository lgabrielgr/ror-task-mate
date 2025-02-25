class CommentPolicy
  def initialize(user, comment)
    @user = user
    @comment = comment
  end

  def new?
    @user.admin? || @comment.ticket.team.is_team_member?(@user)
  end

  def create?
    new?
  end

  def edit?
    @comment.author == @user
  end

  def update?
    edit?
  end
end
