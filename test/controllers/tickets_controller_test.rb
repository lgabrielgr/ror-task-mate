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
end
