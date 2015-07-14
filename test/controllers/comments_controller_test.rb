require 'test_helper'
require 'pry'

class CommentsControllerTest < ActionController::TestCase

  def test_user_can_create_comment
    u = create(:user)
    new_post = create(:post)
    
    post :create, comment: { author_id: u.id, post_id: new_post.id, board_id: new_post.board.id, body: "Test Comment" }
    binding.pry
    assert_equal 1, Comment.count
    assert_includes "Comment 1", comment.body
  end

#Test Admin Can Act On Other's Comment

#Test User Can Act On Their Own Comment

#Test User Can Not Act On Other's Comment

end