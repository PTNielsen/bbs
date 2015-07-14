class PostsController < ApplicationController

  def show
    @post = Post.find_by_id params[:id]
    @comments = @post.comments
    @board = Board.find_by_id params[:board_id]
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
    @post = Post.find_by_id params[:id]
  end

  def update
    @post = Post.find_by_id params[:id]
    @board = Board.find_by_id params[:board_id]
    @post.update(edit_post_params)

    redirect_to board_post_path(@board, @post), notice: "Post information updated"
  end

  def destroy
    @post = Post.find_by_id params[:id]
    @board = Board.find_by_id params[:board_id]
    @post.delete[:id]

    redirect_to board_path(@board), notice: "#{@post.title} has been deleted"
  end

private

  def create_post_params
    params.require(:post).permit(:title, :body, :author_id, :board_id)
  end

  def edit_post_params
    params.require(:post).permit(:title, :body)
  end

end