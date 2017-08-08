require_relative 'board'

class Game
  def initialize
    @board = Board.new
    @display = Display.new(@board)
  end

  def play
    @display.display_board
    @board.move_piece(start_pos, end_pos)
  end
end

if $PROGRAM_NAME == __FILE__
  game = Game.new
  game.play
end
