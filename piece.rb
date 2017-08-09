require 'singleton'
require_relative 'board'

class Piece
  attr_reader :symbol, :color

  def initialize(board, current_pos, color)
    @board = board
    @current_pos = current_pos
    @color = color
  end

  def symbol
    name = self.class.to_s
    name.downcase.to_sym
  end
end

module SlidingPiece
  def moves
    dirs = move_dirs
    moves = []
    dirs.each do |dir|
      possible_pos = @current_pos
      while @board.on_board?(possible_pos)
        [possible_pos[0] + dir[0], possible_pos[1] + dir[1]]
        move = [possible_pos[0] + dir[0], possible_pos[1] + dir[1]]
        moves << move if @board.on_board?(move)
        possible_pos = move
      end
    end
    moves
  end
end

module SteppingPiece
  def moves
    dirs = move_dirs
    moves = []
    dirs.each do |dir|
      moves << [@current_pos[0] + dir[0], @current_pos[1] + dir[1]]
    end

    moves
  end
end

class Bishop < Piece #diagonal piece
  include SlidingPiece

  def move_dirs
    [[-1, -1], [1, 1], [-1, 1], [1, -1]]
  end
end

class Queen < Piece #combo of rook and bishop
  include SlidingPiece

  def move_dirs
    [[-1, -1], [1, 1], [-1, 1], [1, -1], [-1, 0], [1, 0], [0, 1], [0, -1]]
  end
end

class Rook < Piece #straight up and down/ left and right
  include SlidingPiece

  def move_dirs
    [[-1, 0], [1, 0], [0, 1], [0, -1]]
  end
end

class Pawn < Piece

end

class Knight < Piece
  include SteppingPiece

  def move_dirs
    [[-2, -1], [-2, 1], [-1, -2], [-1, 2], [ 1, -2], [ 1, 2], [ 2, -1], [ 2, 1]]
  end
end

class King < Piece
  include SteppingPiece

  def move_dirs
    [[-1, -1], [1, 1], [-1, 1], [1, -1], [-1, 0], [1, 0], [0, 1], [0, -1]]
  end
end

class Null < Piece
  include Singleton

  def initialize
    @color = :default
  end
end
