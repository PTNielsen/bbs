class CommentsController < ApplicationController

  def new
    @comment = Comment.new
    @post = Post.find params[:post_id]
    authorize! :create, @comment
  end

  def create
    @comment = Comment.new(comment_params)
    @post = Post.find params[:post_id]
    @board = Board.find params[:board_id]
    authorize! :create, @comment
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