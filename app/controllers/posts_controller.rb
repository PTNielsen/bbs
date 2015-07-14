class PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: :show

  skip_authorization_check only: :show

  def show
    @post = Post.find params[:id]
    @comments = @post.comments.includes(:author)
    @board = Board.find params[:board_id]
    authorize! :read, @post
  end

  def new
    @post = Post.new
    @board = Board.find params[:board_id]
    authorize! :create, @post
  end

  def create
    @post = Post.new(create_post_params)
    @board = Board.find params[:board_id]
    authorize! :create, @post
    if @post.save
      redirect_to @board, notice: "Post created"
    else
      render :new, notice: "Post failed to be created"
    end
  end

  def edit
    @post = Post.find params[:id]
    authorize! :update, @post
  end

  def update
    @post = Post.find params[:id]
    authorize! :update, @post
    @board = Board.find params[:board_id]
    @post.update(edit_post_params)

    redirect_to board_post_path(@board, @post), notice: "Post information updated"
  end

  def destroy
    @post = Post.find params[:id]
    authorize! :destroy, @post
    @board = Board.find params[:board_id]
    @post.delete

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