require "test_helper"

class TeamTest < ActiveSupport::TestCase
  test "team has a owner" do
    team = teams(:one)
    assert team.owner_id == 1
    assert team.owner.email == "leo@test.com"
  end

  test "team has members" do
    team = teams(:one)
    assert team.members.count == 2
    assert team.members.map(&:email).include?("leo@test.com")
    assert team.members.map(&:email).include?("leito@test.com")

    team = teams(:two)
    assert team.members.count == 2
    assert team.members.map(&:email).include?("leo@test.com")
    assert team.members.map(&:email).include?("chuck.norris@test.com")
  end
end
