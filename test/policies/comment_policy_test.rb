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

  test "author_can_edit_comment" do
    user = users(:one)
    comment = comments(:one)
    assert CommentPolicy.new(user, comment).edit?
  end

  test "non_author_cannot_edit_comment" do
    user = users(:two)
    comment = comments(:one)
    assert_not CommentPolicy.new(user, comment).edit?
  end
end
