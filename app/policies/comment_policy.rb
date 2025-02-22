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
    puts "Comment id: #{@comment.id}, Author: #{@comment.author.friendly_name}, current_user: #{@user.friendly_name}"
    @comment.author == @user
  end
end
