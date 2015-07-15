require 'test_helper'
require 'pry'

class CommentsControllerTest < ActionController::TestCase
  
  def create_comment
    @u = create(:user)
    sign_in @u
    @new_post = create(:post)

    post :create, board_id: @new_post.board.id, post_id: @new_post.id, comment: { author_id: @u.id, body: "Test Comment" }
  end

  def sign_out_and_clear_cached_currents!
    sign_out @u
    # This is how cancan wants us to reset the `current_ability`, used by `authorize!`
    @controller.instance_variable_set :@current_user, nil
    @controller.instance_variable_set :@current_ability, nil
  end

  def test_user_can_create_comment
    create_comment
    
    comment = Comment.last

    assert_equal 1, Comment.count
    assert_equal 302, response.status
    assert_includes "Test Comment", comment.body
  end

  def test_admin_can_edit_others_comments
    create_comment

    before_edit = Comment.last

    assert_equal 1, Comment.count
    assert_equal 302, response.status
    assert_includes "Test Comment", before_edit.body

    a = create(:user, admin: true)
    sign_in a

    patch :update, board_id: @new_post.board.id, post_id: @new_post.id, id: before_edit.id, comment: { body: "Updated" }

    after_edit = Comment.last

    assert_equal 1, Comment.count
    assert_equal 302, response.status
    assert_includes "Updated", after_edit.body
  end

  def test_admin_can_delete_others_comments
    create_comment

    comment = Comment.last

    assert_equal 1, Comment.count
    assert_equal 302, response.status
    assert_includes "Test Comment", comment.body

    a = create(:user, admin: true)
    sign_in a

    delete :destroy, board_id: @new_post.board.id, post_id: @new_post.id, id: comment.id

    assert_equal 0, Comment.count
    assert_equal 302, response.status
  end

  def test_user_can_edit_own_comments
    create_comment

    before_edit = Comment.last

    assert_equal 1, Comment.count
    assert_equal 302, response.status
    assert_includes "Test Comment", before_edit.body

    patch :update, board_id: @new_post.board.id, post_id: @new_post.id, id: before_edit.id, comment: { body: "Updated" }

    after_edit = Comment.last

    assert_equal 1, Comment.count
    assert_equal 302, response.status
    assert_includes "Updated", after_edit.body
  end

  def test_user_can_delete_own_comments
    create_comment

    comment = Comment.last

    assert_equal 1, Comment.count
    assert_equal 302, response.status
    assert_includes "Test Comment", comment.body

    delete :destroy, board_id: @new_post.board.id, post_id: @new_post.id, id: comment.id

    assert_equal 0, Comment.count
    assert_equal 302, response.status
  end

  def test_user_can_not_edit_others_comments
    create_comment
    sign_out_and_clear_cached_currents!

    before_edit = Comment.last

    assert_equal 1, Comment.count
    assert_equal 302, response.status
    assert_equal "Test Comment", before_edit.body

    a = create(:user)
    sign_in a

    request.env["HTTP_REFERER"] = "/"

    patch :update, board_id: @new_post.board.id, post_id: @new_post.id, id: before_edit.id, comment: { body: "Updated" }

    after_edit = Comment.last

    assert_equal 1, Comment.count
    assert_equal 302, response.status
    assert_equal "Test Comment", after_edit.body
    assert_equal "/", response.redirect_url
  end

  def test_user_can_not_delete_others_comments
    create_comment
    sign_out_and_clear_cached_currents!  

    comment = Comment.last

    assert_equal 1, Comment.count
    assert_equal 302, response.status
    assert_includes "Test Comment", comment.body

    a = create(:user)
    sign_in a

    request.env["HTTP_REFERER"] = "/"

    delete :destroy, board_id: @new_post.board.id, post_id: @new_post.id, id: comment.id

    assert_equal 1, Comment.count
    assert_equal 302, response.status
    assert_equal "/", response.redirect_url
  end

end