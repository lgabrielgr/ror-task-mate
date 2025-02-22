require "test_helper"

class CommentPolicyTest < ActiveSupport::TestCase
  test "admin_can_create_comment" do
    user = users(:one)
    comment = Comment.new
    assert CommentPolicy.new(user, comment).create?
  end

  test "team_member_can_create_comment" do
    user = users(:two)
    ticket = tickets(:two)
    comment = Comment.new(ticket: ticket)
    assert CommentPolicy.new(user, comment).create?
  end

  test "non_team_member_cannot_create_comment" do
    user = users(:three)
    ticket = tickets(:two)
    comment = Comment.new(ticket: ticket)
    assert_not CommentPolicy.new(user, comment).create?
  end
end
