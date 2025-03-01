require "test_helper"

class TicketNotificationJobTest < ActiveJob::TestCase
  test "perform sends ticket updated email" do
    user = users(:one)
    ticket = tickets(:one)
    action = :updated

    assert_enqueued_with(job: TicketNotificationJob) do
      TicketNotificationJob.perform_later(user, ticket, action)
    end

    perform_enqueued_jobs

    assert_performed_jobs 1
  end
end
