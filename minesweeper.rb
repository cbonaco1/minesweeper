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

  # def [](row, col)
  #  @grid[row][col]
  # end


  def populate_bombs
    num_bombs = rand(1..40)
    4.times do
      pos = [rand(0...grid.length), rand(0...grid.length)]
      current_tile = @grid[pos[0]][pos[1]]
      current_tile.bomb = true
    end
  end

  def bomb_count
    count = 0
    grid.each_with_index do |row, row_indx|
      row.each_index do |square|
        tile = grid[row_indx][square]
        count += 1 if tile.bomb
      end
    end
    count
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
