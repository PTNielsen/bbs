class CommentsController < ApplicationController

  def new
    @comment = Comment.new
    @post = Post.find_by_id params[:post_id]
  end

  def create
    @comment = Comment.new(comment_params)
    @post = Post.find_by_id params[:post_id]
    @board = Board.find_by_id params[:board_id]
    if @comment.save
      redirect_to board_post_path(@board, @post), notice: "Comment posted"
    else
      render :new, notice: "Comment failed to be saved"
    end
  end

  def edit
  end

  def delete
  end

private

  def comment_params
    params.require(:comment).permit(:body, :author_id, :post_id)
  end

end