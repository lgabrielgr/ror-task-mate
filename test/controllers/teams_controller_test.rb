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

  test "should get edit team" do
    sign_in users(:one)
    team = teams(:one)
    get team_edit_url(team_id: team.id)
    assert_response :success
    assert_not_nil assigns(:team)
  end

  test "should redirect if user cannot edit team" do
    sign_in users(:two)
    team = teams(:one)
    get team_edit_url(team_id: team.id)
    assert_redirected_to root_path
  end

  test "should get new team form" do
    sign_in users(:one)
    get new_team_url
    assert_response :success
    assert_not_nil assigns(:team)
  end

  test "should create team" do
    sign_in users(:one)
    assert_difference("Team.count") do
      post create_team_url, params: { team: { name: "New Team", description: "New Description",
                                             owner_id: users(:one).id, member_ids: [ users(:one).id ] } }
    end
    assert_redirected_to root_path
  end

  test "should redirect user to root if user is not authorized to create a team" do
    sign_in users(:two)
    get new_team_url
    assert_redirected_to root_path
  end
end
