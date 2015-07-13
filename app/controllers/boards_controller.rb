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
  end

  def delete
  end

private

  def board_params
    params.require(:board).permit(:name, :moderator_id)
  end

end