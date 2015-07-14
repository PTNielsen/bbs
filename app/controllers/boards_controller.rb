class BoardsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  skip_authorization_check only: [:index, :show]

  def index
    @boards = Board.all
  end

  def show
    @board = Board.find_by_id params[:id]
    @posts = @board.posts
    authorize! :read, @board
  end

  def new
    @board = Board.new
    authorize! :create, @board
  end

  def create
    @board = Board.new(board_params)
    authorize! :create, @board
    if @board.save
      redirect_to @board, notice: "Board created"
    else
      render :new, notice: "Board failed to be created"
    end
  end

  def edit
    @board = Board.find_by_id params[:id]
    authorize! :update, @board
  end

  def update
    @board = Board.find_by_id params[:id]
    authorize! :update, @board
    @board.update(edit_board_params)

    redirect_to @board, notice: "Board information updated"
  end

  def destroy
    @board = Board.find_by_id params[:id]
    authorize! :destroy, @board
    @board.delete[:id]

    redirect_to root_path, notice: "#{@board.name} has been deleted"
  end

private

  def create_board_params
    params.require(:board).permit(:name, :moderator_id)
  end

  def edit_board_params
    params.require(:board).permit(:name)
  end

end