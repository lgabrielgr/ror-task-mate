require "test_helper"

class TicketMailerTest < ActionMailer::TestCase
  test "ticket_updated" do
    user = users(:one)
    ticket = tickets(:one)
    mail = TicketMailer.ticket_updated(user, ticket)

    assert_emails 1 do
      mail.deliver_now
    end

    assert_equal [ "no-reply@taskmate.com" ], mail.from
    assert_equal [ user.email ], mail.to
    assert_equal "Ticket Updated", mail.subject
    assert_match "Ticket Updated", mail.body.encoded
  end
end
