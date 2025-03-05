require "test_helper"

class TeamTest < ActiveSupport::TestCase
  test "should has a owner" do
    team = teams(:one)
    assert team.owner_id == 1
    assert team.owner.email == "leo@test.com"
  end

  test "should has members" do
    team = teams(:one)
    assert team.members.count == 2
    assert team.members.map(&:email).include?("leo@test.com")
    assert team.members.map(&:email).include?("leito@test.com")

    team = teams(:two)
    assert team.members.count == 2
    assert team.members.map(&:email).include?("leo@test.com")
    assert team.members.map(&:email).include?("chuck.norris@test.com")
  end

  test "should has tickets" do
    team = teams(:one)
    assert team.tickets.count == 3
    assert team.tickets.map(&:title).include?("Ticket 1")
    assert team.tickets.map(&:title).include?("Ticket 2")
  end

  test "should verify if a user is a team member" do
    team = teams(:one)
    assert team.is_team_member?(users(:one))
    assert team.is_team_member?(users(:two))
    assert_not team.is_team_member?(users(:three))
  end

  test "should upcase code_identifier before save" do
    team = Team.new(name: "Test Team", code_identifier: "abcd", owner: users(:one), creator: users(:one))
    team.save
    assert_equal "ABCD", team.code_identifier
  end
end
