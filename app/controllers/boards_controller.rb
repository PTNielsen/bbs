class BoardsController < ApplicationController

  def index
    @boards = Board.all
  end

  def show
    @board = Board.find_by_id params[:id]
    @posts = @board.posts
  end

  def new
    @board = Board.new
  end

  def create
    @board = Board.new(board_params)
    if @board.save
      redirect_to @board, notice: "Board created"
    else
      render :new, notice: "Board failed to be created"
    end
  end

  def edit
    @board = Board.find_by_id params[:id]
  end

  def update
    @board = Board.find_by_id params[:id]
    @board.update(edit_board_params)

    redirect_to @board, notice: "Board information updated"
  end

  def destroy
    @board = Board.find_by_id params[:id]
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