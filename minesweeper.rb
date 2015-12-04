class Board

  MOVES = [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1],
            [1, -1], [1, 0], [1, 1]]

  attr_reader :grid
  def initialize(grid = Array.new(9) { Array.new(9) })
    @grid = grid
  end

  def populate_board
    grid.each_with_index do |row, row_indx|
      row.each_index do |square|
        tile = Tile.new(self)
        grid[row_indx][square] = tile
      end
    end

  end

  def populate_bombs
    num_bombs = rand(1..40)
    num_bombs.times {}
  end

  def get_adjacent_positions(pos)
    #pos = [2, 3]
  end



end

class Tile
  attr_accessor :bomb, :revealed, :flagged
  attr_reader :board

  def initialize(board)
    @board = board
    @bomb = false
    @revealed = false
    @flagged = false
  end


end
