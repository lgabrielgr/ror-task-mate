require "test_helper"

class TicketsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "should get view if user is assigned to team" do
    sign_in users(:one)
    get ticket_view_url(id: 1)
    assert_response :success
  end

  test "should redirect to root if ticket not found" do
    sign_in users(:one)
    get ticket_view_url(id: -1)
    assert_redirected_to root_path
  end

  test "should redirect to root if user cannot see ticket" do
    sign_in users(:two)
    get ticket_view_url(id: 4)
    assert_redirected_to root_path
  end

  test "should get edit if user is assigned to team" do
    sign_in users(:one)
    get ticket_edit_url(id: 1)
    assert_response :success
  end

  test "should redirect to root if user cannot see and edit ticket" do
    sign_in users(:two)
    get ticket_edit_url(id: 4)
    assert_redirected_to root_path
  end

  test "should update ticket if user is assigned to team" do
    sign_in users(:one)
    patch ticket_url(id: 1), params: { ticket: { title: "Updated Title", description: "Updated Description" } }
    assert_redirected_to ticket_view_path(id: 1)
  end


  test "should get new ticket form" do
    sign_in users(:one)
    get new_ticket_url(team_id: teams(:one).id)
    assert_response :success
  end

  test "should create ticket" do
    sign_in users(:one)
    assert_difference("Ticket.count") do
      post team_tickets_url(team_id: teams(:one).id), params: { ticket: { title: "New Ticket", description: "New Description", priority: Ticket::TICKET_LOW_PRIORITY, status: Ticket::TICKET_TO_DO_STATUS } }
    end
    assert_redirected_to team_tickets_path(teams(:one))
  end

  test "should redirect user to root if user is not assigned to team" do
    sign_in users(:three)
    get new_ticket_url(team_id: teams(:one).id)
    assert_redirected_to root_path
  end
end
