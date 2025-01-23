require "test_helper"

class ApplicationControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "redirects to login when user is not authenticated" do
    get root_path
    assert_redirected_to new_user_session_path
  end

  test "allows access to authenticated user" do
    sign_in users(:one)
    get root_path
    assert_response :success
  end
end
