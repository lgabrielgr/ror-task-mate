require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "friendly_name returns full name if first name is present" do
    user = User.new(first_name: "Leo", last_name: "Doe", email: "john.doe@example.com")
    assert_equal "Leo", user.friendly_name
  end

  test "friendly_name returns email if first name is not present" do
    user = User.new(first_name: nil, last_name: nil, email: "leo.doe@example.com")
    assert_equal "leo.doe@example.com", user.friendly_name
  end

  test "teams_that_i_own returns teams that the user owns" do
    user = users(:one)
    assert user.teams_that_i_own.count == 2
    assert user.teams_that_i_own.map(&:name).include?("Team Alpha")
    assert user.teams_that_i_own.map(&:name).include?("Team Beta")
  end

  test "should verify if user has teams assigned" do
    user = users(:one)
    assert user.no_teams_assigned? == false
  end

  test "should verify if user has no teams assigned" do
    user = User.create(email: "new.user@test.com", password: "password")
    assert user.no_teams_assigned? == true
  end
end
