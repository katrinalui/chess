require_relative 'piece'

class Board

  attr_reader :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) }
    populate
  end

  def populate
    starting_rows = [0, 1, 6, 7]
    starting_rows.each do |i|
      @grid[i].map! { Piece.new("piece") }
    end
    empty_rows = [2, 3, 4, 5]
    empty_rows.each do |i|
      @grid[i].map! { Piece.new("null") }
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
    rescue StandardError
      puts "No piece at start position"
    rescue ArgumentError
      puts "Position is off the board"
    end
  end

end
