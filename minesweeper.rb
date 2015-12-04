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

  def [](row, col)
   @grid[row][col]
  end


  def populate_bombs
    num_bombs = rand(1..70)
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

  def flag
    self.flagged = true
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
    adjacent_bomb_count = 0
    neighbors.each do |neighbor|
      tile = board.grid[neighbor[0]][neighbor[1]]
      if tile.bomb
        adjacent_bomb_count += 1
      end
    end

    adjacent_bomb_count
  end

end


class Game
  attr_reader :board

  def initialize(name, board = Board.new)
    @player_name = name
    @board = board
  end

  def play
    over? = validate_move
    play until over?

  end


  def get_move
    puts "Please enter a move in the form X Y"
    pos = gets.chomp.split(" ").map { |num| num.to_i  }
    puts "Would you like to flag this square? (Y/N)"
    flag = gets.chomp
    flag = (flag == "Y") ? true : false
    [pos, flag]
  end


  def validate_move
    position, flag = get_move
    tile = board.grid[position[0]][position[1]]

    #user selected a bomb, game over
    if(tile.bomb)
      puts "Game Over!"
      # board.display(true)
      return true
    elsif flag
      tile.flag = (tile.flag) ? false : true
      return false
    #User selects a tile already revealed (do nothing)
    elsif tile.revealed
      return false
    else
      reveal_neighbors(tile)
      won?
    end
  end
  

  def reveal_neighbors(tile)
    neighbor_positions = tile.neighbors
    neighbor_nodes = neighbor_positions.map! { |n| board.grid[n[0]][n[1]]  }
    if neighbor_nodes.any? { |n| n.bomb  }
      return tile.reveal
    end

    neighbor_nodes.each do |neighbor|
      reveal_neighbors(neighbor)
    end
  end












end
