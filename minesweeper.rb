class Board
  attr_reader :grid
  def initialize(grid = Array.new(9) { Array.new(9) })
    @grid = grid
    @bomb_count = 0
    populate_board

  end

  def populate_board
    grid.each_with_index do |row, row_indx|
      row.each_index do |square|
        tile = Tile.new(self)
        grid[row_indx][square] = tile
      end
    end
    populate_bombs
  end

  # def [](row, col)
  #  @grid[row][col]
  # end


  def populate_bombs
    num_bombs = rand(1..40)
    num_bombs.times do
      rand_x = rand(0...grid.length)
      rand_y = rand(0...grid.length)
      tile = grid[rand_x][rand_y]
      until (tile.bomb == false)
        rand_x = rand(0...grid.length)
        rand_y = rand(0...grid.length)
        tile = grid[rand_x][rand_y]
      end

      tile.bomb = true

    end
    @bomb_count = num_bombs
  end

  # def bomb_count
  #   count = 0
  #   grid.each_with_index do |row, row_indx|
  #     row.each_index do |square|
  #       tile = grid[row_indx][square]
  #       count += 1 if tile.bomb
  #     end
  #   end
  #   count
  # end

  def get_adjacent_positions(pos)
    #pos = [2, 3]
  end



end

class Tile
  MOVES = [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1],
            [1, -1], [1, 0], [1, 1]]

  attr_accessor :bomb, :revealed, :flagged
  attr_reader :board

  def initialize(board)
    @board = board
    @bomb = false
    @revealed = false
    @flagged = false
  end

  def reveal
    self.revealed = true
  end

  def neighbors
    my_position = find_grid_position
    valid_moves(my_position)
  end

  def find_grid_position
    board.grid.each_with_index do |row, row_idx|
      column_number = row.index(self)
      if column_number
        return [row_idx, column_number]
      end
    end
    nil
  end

  #Return the valid moves from position based on MOVES array
  def valid_moves(position)
    moves = []
    MOVES.each do |move|
      new_pos1 = move[0] + position[0]
      new_pos2 = move[1] + position[1]
      pos = [new_pos1, new_pos2]
      if pos.min >= 0 && pos.max < 9
        moves << pos
      end
    end
    moves
  end

  def neighbor_bomb_count

  end




end
