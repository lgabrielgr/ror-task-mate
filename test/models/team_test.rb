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
    assert team.tickets.count == 2
    assert team.tickets.map(&:title).include?("Ticket 1")
    assert team.tickets.map(&:title).include?("Ticket 2")
  end
end
