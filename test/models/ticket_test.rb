require "test_helper"

class TicketTest < ActiveSupport::TestCase
  test "should return human readable status" do
    assert tickets(:one).human_readable_status == "To Do"
    assert tickets(:two).human_readable_status == "In Progress"
  end

  test "should return assignee name" do
    assert tickets(:one).assignee_name == "Leo (leo@test.com)"
    assert tickets(:two).assignee_name == "Leito (leito@test.com)"

    ticket_unassigned = Ticket.create(title: "New Ticket", team: teams(:one), assignee: nil)
    assert ticket_unassigned.assignee_name == "Unassigned"
  end

  test "should validate title presence" do
    ticket = Ticket.new(title: nil, team: teams(:one))
    assert_not ticket.valid?
    assert ticket.errors[:title].include?("can't be blank")
  end

  test "should validate status inclusion" do
    ticket = Ticket.new(title: "New Ticket", team: teams(:one), status: 4)
    assert_not ticket.valid?
    assert ticket.errors[:status].include?("is not included in the list")
  end

  test "should return human readable priority" do
    assert tickets(:one).human_readable_priority == "Low"
    assert tickets(:two).human_readable_priority == "Medium"
    assert tickets(:three).human_readable_priority == "High"
  end

  test "should validate priority inclusion" do
    ticket = Ticket.new(title: "New Ticket", team: teams(:one), priority: 3)
    assert_not ticket.valid?
    assert ticket.errors[:priority].include?("is not included in the list")
  end

  test "should return priority emoticon" do
    assert tickets(:one).priority_emoticon == "&#x1F634;"
    assert tickets(:two).priority_emoticon == "&#x1F610;"
    assert tickets(:three).priority_emoticon == "&#x1F525;"
  end
end
