require "test_helper"

class TeamPolicyTest < ActiveSupport::TestCase
  test "should allow team owner to edit team" do
    user = users(:one)
    team = teams(:one)
    assert TeamPolicy.new(user, team).edit?
  end

  test "should not allow non-owner non-admin to edit team" do
    user = users(:two)
    team = teams(:one)
    assert_not TeamPolicy.new(user, team).edit?
  end

  test "should allow admin to update team" do
    user = users(:one)
    team = teams(:one)
    assert TeamPolicy.new(user, team).update?
  end

  test "should not allow non-owner non-admin to update team" do
    user = users(:two)
    team = teams(:one)
    assert_not TeamPolicy.new(user, team).update?
  end

  test "should allow admin to create team" do
    user = users(:one)
    team = Team.new
    assert TeamPolicy.new(user, team).create?
  end

  test "should not allow non-admin to create team" do
    user = users(:two)
    team = Team.new
    assert_not TeamPolicy.new(user, team).create?
  end

  test "should allow team owner to destroy team" do
    user = users(:one)
    team = teams(:one)
    assert TeamPolicy.new(user, team).destroy?
  end

  test "should not allow non-owner non-admin to destroy team" do
    user = users(:two)
    team = teams(:one)
    assert_not TeamPolicy.new(user, team).destroy?
  end
end
