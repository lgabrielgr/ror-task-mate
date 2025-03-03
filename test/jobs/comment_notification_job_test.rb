require "test_helper"

class CommentNotificationJobTest < ActiveJob::TestCase
  test "queues comment notification jobs with action created" do
    user = users(:one)
    comment = comments(:one)
    action = :created

    assert_enqueued_with(job: CommentNotificationJob) do
      CommentNotificationJob.perform_later(user, comment, action)
    end
  end

test "queues comment notification jobs with action edited" do
    user = users(:one)
    comment = comments(:one)
    action = :edited

    assert_enqueued_with(job: CommentNotificationJob) do
      CommentNotificationJob.perform_later(user, comment, action)
    end
  end
end
