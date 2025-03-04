class CommentMailer < ApplicationMailer
  def comment_created(user, comment)
    send_notification(comment, user, "New comment on ticket: #{comment.ticket.title}")
  end

  def comment_updated(user, comment)
    send_notification(comment, user, "Comment updated on ticket: #{comment.ticket.title}")
  end

  private

  def send_notification(comment, user, subject)
    @user = user
    @comment = comment
    @ticket = comment.ticket
    mail(to: @user.email, subject: subject)
  end
end
