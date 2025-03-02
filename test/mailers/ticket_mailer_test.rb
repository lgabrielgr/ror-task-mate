require "test_helper"

class TicketMailerTest < ActionMailer::TestCase
  test "ticket_updated" do
    user = users(:one)
    ticket = tickets(:one)
    mail = TicketMailer.ticket_updated(user, ticket)

    assert_emails 1 do
      mail.deliver_now
    end

    assert_equal [ user.email ], mail.to
    assert_match "Ticket updated", mail.subject
    assert_match "Ticket Updated", mail.body.encoded
  end

  test "ticket_assigned" do
    user = users(:one)
    ticket = tickets(:one)
    mail = TicketMailer.ticket_assigned(user, ticket)

    assert_emails 1 do
      mail.deliver_now
    end

    assert_equal [ user.email ], mail.to
    assert_match "Ticket assigned", mail.subject
    assert_match "Ticket Assigned", mail.body.encoded
  end
end
