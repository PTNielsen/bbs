class PostsController < ApplicationController

  def show
    @post = Post.find_by_id params[:id]
  end

  def new
    @post = Post.new
    @board = Board.find_by_id params[:board_id]
  end

  def create
    @post = Post.new(create_post_params)
    @board = Board.find_by_id params[:board_id]
    if @post.save
      redirect_to @board, notice: "Post created"
    else
      render :new, notice: "Post failed to be created"
    end
  end

  def edit
  end

  def delete
  end

private

  def create_post_params
    params.require(:post).permit(:title, :body, :author_id, :board_id)
  end

  def show_post_params
  end

end