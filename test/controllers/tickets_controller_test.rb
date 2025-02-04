require "test_helper"

class TicketsControllerTest < ActionDispatch::IntegrationTest
  test "should get view" do
    get ticket_view_url(id: 1)
    assert_response :found
  end
end
