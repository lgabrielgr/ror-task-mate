class CommentNotificationJob < ApplicationJob
  queue_as :default

  def perform(user, comment, action)
    Rails.logger.info("Sending comment notification to #{user.email} for comment #{comment.id} related to action #{action}")
    case action
    when :created
      CommentMailer.comment_created(user, comment).deliver_later
    when :edited
      CommentMailer.comment_updated(user, comment).deliver_later
    else
      Rails.logger.error("Unknown action for comment notification job: #{action}")
    end
  end
end
