require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "new_comment_renders_successfully" do
    sign_in users(:one)
    get new_comment_path(tickets(:one))
    assert_response :success
  end

  test "create_comment_redirects_on_success" do
    sign_in users(:one)
    assert_enqueued_with(job: CommentNotificationJob) do
      post create_comment_path(tickets(:one)), params: { comment: { body: "New comment" } }
    end
    assert_redirected_to ticket_view_path(tickets(:one))
  end

  test "unauthorized_user_cannot_create_comment" do
    sign_in users(:three)
    assert_no_enqueued_jobs do
      post create_comment_path(tickets(:one)), params: { comment: { body: "New comment" } }
    end
    assert_redirected_to root_path
  end

  test "unauthorized_user_cannot_access_new_comment" do
    sign_in users(:three)
    get new_comment_path(tickets(:one))
    assert_redirected_to root_path
  end

  test "update_comment_redirects_on_success" do
    sign_in users(:one)
    patch comment_path(tickets(:one), comments(:one)), params: { comment: { body: "Updated comment" } }
    assert_redirected_to ticket_view_path(tickets(:one))
  end

  test "unauthorized_user_cannot_update_comment" do
    sign_in users(:three)
    patch comment_path(tickets(:one), comments(:one)), params: { comment: { body: "Updated comment" } }
    assert_redirected_to root_path
  end
end
