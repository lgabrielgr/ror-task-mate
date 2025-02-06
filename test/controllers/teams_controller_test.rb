require "test_helper"

class TeamsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "should get team info and tickets" do
    sign_in users(:one)
    team = teams(:one)
    get team_tickets_url(team_id: team.id)
    assert_response :success
    assert_not_nil assigns(:tickets)
  end

  test "should redirect if user cannot see team tickets" do
    sign_in users(:two) # Assuming users(:two) cannot see team tickets
    team = teams(:two)
    get team_tickets_url(team_id: team.id)
    assert_redirected_to root_path
  end

  test "should log warning and redirect if team does not exist" do
    sign_in users(:one)
    get team_tickets_url(team_id: -1)
    assert_redirected_to root_path
  end
end
