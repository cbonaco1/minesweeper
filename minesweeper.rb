class Board

  MOVES = [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1],
            [1, -1], [1, 0], [1, 1]]

  attr_reader :grid
  def initialize(grid = Array.new(9) { Array.new(9) })
    @grid = grid
  end

  def get_adjacent_positions(pos)
    #pos = [2, 3]

  end


end

class Tile
  attr_accessor :bomb, :revealed, :flagged
  def initialize
    @bomb = false
    @revealed = false
    @flagged = false
  end
end
