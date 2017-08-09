require 'colorize'
require_relative 'board'
require_relative 'cursor'
require_relative 'piece'
require "byebug"

class Display

  attr_reader :cursor

  DISPLAY = {
    null: "  ",
    pawn: "♟ ",
    king: "♚ ",
    queen: "♛ ",
    rook: "♜ ",
    bishop: "♝ ",
    knight: "♞ "
  }.freeze

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0, 0], board)
  end

  def render
    rows = @board.grid.map.with_index do |row,i|
      row.map.with_index do |piece, j|
        str = DISPLAY[piece.symbol]
        if (i + j).even? && piece.color == :black
          str.colorize(:color => :black, :background => :gray)
        elsif (i + j).even? && piece.color == :red
          str.colorize(:color => :red, :background => :gray)
        elsif (i + j).odd? && piece.color == :black
          str.colorize(:color => :black, :background => :white)
        elsif (i + j).odd? && piece.color == :red
          str.colorize(:color => :red, :background => :white)
        elsif (i + j).even?
          str.colorize(:background => :gray)
        else
          str.colorize(:background => :white)
        end
      end
    end

    row, col = @cursor.cursor_pos
    cursor_str = rows[row][col]
    rows[row][col] = cursor_str.colorize(:background => :yellow)
    if @cursor.selected
      s_row, s_col = @cursor.selected_pos
      selected_str = rows[s_row][s_col]
      rows[s_row][s_col] = selected_str.colorize(:background => :green)
    end
    rows.each { |row| puts row.join("") }
  end

  def display_board
    while true
      system("clear")
      render
      @cursor.get_input
    end
  end
end

if $0 == __FILE__
  board = Board.new
  display = Display.new(board)
  display.display_board
end
