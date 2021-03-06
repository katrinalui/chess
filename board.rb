require_relative 'piece'
require_relative 'display'

class Board

  attr_reader :grid

  SPECIAL_ROW = [
    Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook
  ]

  def initialize
    @grid = Array.new(8) { Array.new(8) }
    populate
  end

  def populate
    @grid[1].each_index do |j|
      self[[1, j]] = Pawn.new(self, [1, j], :red)
    end

    @grid[6].each_index do |j|
      self[[6, j]] = Pawn.new(self, [6, j], :black)
    end

    @grid[0].each_index do |j|
      self[[0, j]] = SPECIAL_ROW[j].new(self, [0, j], :red)
    end

    @grid[7].each_index do |j|
      self[[7, j]] = SPECIAL_ROW[j].new(self, [7, j], :black)
    end

    empty_rows = [2, 3, 4, 5]
    empty_rows.each do |i|
      @grid[i].each_index do |j|
        self[[i, j]] = Null.instance
      end
    end
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, value)
    row, col = pos
    @grid[row][col] = value
  end

  def move_piece(start_pos, end_pos)
    begin
      raise StandardError if self[start_pos].nil?
      raise ArgumentError if end_pos.any? { |el| el > 7 }
      self[start_pos], self[end_pos] = self[end_pos], self[start_pos]
      self[end_pos].current_pos = end_pos
    rescue StandardError
      puts "No piece at start position"
    rescue ArgumentError
      puts "Position is off the board"
    end
  end

  def valid_move?(piece, pos)
    return true if piece.moves.include?(pos) && self[pos].is_a?(Null)
    false
  end

  def on_board?(pos)
    return true if pos.all? { |x| x.between?(0, 7) }
    false
  end

end
