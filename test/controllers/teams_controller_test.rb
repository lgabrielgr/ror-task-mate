require "test_helper"

class TeamsControllerTest < ActionDispatch::IntegrationTest
  setup do
    post new_user_session_path, params: { user: { email: users(:one).email, password: "password" } }
  end

  test "should get team info and tickets" do
    team = teams(:one)
    get team_tickets_url(team_id: team.id)
    assert_response :success
    assert_not_nil assigns(:tickets)
  end
end
