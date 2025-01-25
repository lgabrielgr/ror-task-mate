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
end
