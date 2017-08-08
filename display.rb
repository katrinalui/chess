require 'colorize'
require_relative 'board'
require_relative 'cursor'
require_relative 'piece'
require "byebug"

class Display

  DISPLAY = {
    null: "   ",
    piece: " P "
  }.freeze

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0, 0], board)
  end

  def render
    rows = @board.grid.map.with_index do |row,i|
      row.map.with_index do |piece, j|
        str = DISPLAY[piece.type.to_sym]
        if (i + j).even?
          str.colorize(:color => :white, :background => :black)
        else
          str.colorize(:color => :black, :background => :white)
        end
      end
    end

    row, col = @cursor.cursor_pos
    cursor_str = rows[row][col]
    rows[row][col] = cursor_str.colorize(:background => :yellow)
    rows.each { |row| puts row.join("") }
  end

  def color
    @cursor.selected ? :red : :black
  end

  def display_board
    while true
      system("clear")
      render
      @cursor.get_input
    end
  end
end

b = Board.new
d = Display.new(b)
d.display_board
