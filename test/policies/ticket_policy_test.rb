require "test_helper"

class TicketPolicyTest < ActiveSupport::TestCase
  test "user_can_view_ticket" do
    user = users(:one)
    ticket = tickets(:one)
    assert TicketPolicy.new(user, ticket).view?
  end

  test "user_cannot_view_ticket" do
    user = users(:two)
    ticket = tickets(:four)
    assert_not TicketPolicy.new(user, ticket).view?
  end

  test "user_can_edit_ticket" do
    user = users(:one)
    ticket = tickets(:one)
    assert TicketPolicy.new(user, ticket).edit?
  end

  test "user_cannot_edit_ticket" do
    user = users(:two)
    ticket = tickets(:four)
    assert_not TicketPolicy.new(user, ticket).edit?
  end

  test "user_can_update_ticket" do
    user = users(:one)
    ticket = tickets(:one)
    assert TicketPolicy.new(user, ticket).update?
  end

  test "user_cannot_update_ticket" do
    user = users(:two)
    ticket = tickets(:four)
    assert_not TicketPolicy.new(user, ticket).update?
  end

  test "user_can_create_ticket" do
    user = users(:one)
    ticket = Ticket.new(team: teams(:one))
    assert TicketPolicy.new(user, ticket).create?
  end

  test "user_cannot_create_ticket" do
    user = users(:two)
    ticket = Ticket.new(team: teams(:two))
    assert_not TicketPolicy.new(user, ticket).create?
  end
end
