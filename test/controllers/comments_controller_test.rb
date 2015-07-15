require 'test_helper'
require 'pry'

class CommentsControllerTest < ActionController::TestCase

  def test_user_can_create_comment
    u = create(:user)
    sign_in u
    new_post = create(:post)
    
    post :create, post_id: new_post.id, board_id: new_post.board.id, comment: { author_id: u, body: "Test Comment" }
    
    comment = Comment.last

    assert_equal 1, Comment.count
    assert_equal 302, response.status
    assert_includes "Test Comment", comment.body
  end

#Test Admin Can Act On Other's Comment

#Test User Can Act On Their Own Comment

#Test User Can Not Act On Other's Comment

end