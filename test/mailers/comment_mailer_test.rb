require "test_helper"

class CommentMailerTest < ActionMailer::TestCase
  test "sends comment created notification" do
    user = users(:one)
    comment = comments(:one)

    email = CommentMailer.comment_created(user, comment)

    assert_emails 1 do
      email.deliver_now
    end
    assert_equal [ user.email ], email.to
    assert_equal "New comment on ticket: #{comment.ticket.title}", email.subject
  end

  test "sends comment updated notification" do
    user = users(:one)
    comment = comments(:one)

    email = CommentMailer.comment_updated(user, comment)

    assert_emails 1 do
      email.deliver_now
    end
    assert_not ActionMailer::Base.deliveries.empty?
    assert_equal [ user.email ], email.to
    assert_equal "Comment updated on ticket: #{comment.ticket.title}", email.subject
  end
end
