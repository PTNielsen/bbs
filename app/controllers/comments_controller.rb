class CommentsController < ApplicationController

  def new
    @comment = Comment.new
    @post = Post.find params[:post_id]
    authorize! :create, @comment
  end

  def create
    @comment = Comment.new(create_comment_params)
    @post = Post.find params[:post_id]
    @board = Board.find params[:board_id]
    authorize! :create, @comment
    if @comment.save
      redirect_to board_post_path(@board, @post, current_user), notice: "Comment posted"
      binding.pry
      CommentMailer.comment_made(@post, current_user).deliver_later
    else
      render :new, notice: "Comment failed to be saved"
    end
  end

  def edit
    @comment = Comment.find params[:id]
    authorize! :update, @comment
  end

  def update
    @comment = Comment.find params[:id]
    @post = Post.find params[:post_id]
    @board = Board.find params[:board_id]
    authorize! :update, @comment

    @comment.update(edit_comment_params)
    if @comment.save
      redirect_to board_post_path(@board, @post), notice: "Comment has been updated"
    else
      redirect_to board_post_path(@board, @post), notice: "Error occured while updating comment"
    end
  end

  def destroy
    @comment = Comment.find params[:id]
    @post = Post.find params[:post_id]
    @board = Board.find params[:board_id]
    authorize! :destroy, @comment

    @comment.destroy
    redirect_to board_post_path(@board, @post), notice: "Comment has been deleted"
  end

private

  def create_comment_params
    params.require(:comment).permit(:body, :author_id, :post_id)
  end

  def edit_comment_params
    params.require(:comment).permit(:body)
  end

end