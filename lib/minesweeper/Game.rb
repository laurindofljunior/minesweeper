require_relative './ConfigDefault'
require_relative './GameBoard'
require_relative './Coordinate'

class Game

  attr_reader :gameBoard
  attr_accessor :gameLost

  def initialize(height, width, bombs)
    @height=height.to_s.empty? ? ConfigDefault::HEIGHT : height
    @width=width.to_s.empty? ? ConfigDefault::WIDTH : width
    @bombs=bombs.to_s.empty? ? ConfigDefault::BOMBS : bombs
    @gameBoard = GameBoard.new(@height,@width,@bombs)
    @gameLost = false
    @emptyCells = []
  end

  def victory?
    untouched_cells = @gameBoard.visibleBoard.flatten.count(ConfigDefault::HIDDEN_CELL)
    number_of_mines = @gameBoard.mineBoard.flatten.count(ConfigDefault::MINE)
    untouched_cells == number_of_mines
  end

  def still_playing?
    !(victory? || lost?)
  end

  def lost?
    @gameLost
  end

  # def guess_valid?(input)
  #   number?(input) && number_in_range?(input)
  # end

  def isGuessXValid?(input)
    number?(input) && input.to_i.between?(1, @gameBoard.width)
  end

  def isGuessYValid?(input)
    number?(input) && input.to_i.between?(1, @gameBoard.height)
  end

  def isMine?(guess)
    coordinates = axis_adjusted_coordinates(guess)

    @gameBoard.mineBoard[coordinates.y][coordinates.x] == ConfigDefault::MINE
  end

  def reveal_guess(guess, board)
    coordinates = axis_adjusted_coordinates(guess)
    number = number_of_surrounding_mines(coordinates)

    if isMine?(guess)
      board[coordinates.y][coordinates.x] = ConfigDefault::MINE
    elsif number == 0
      board[coordinates.y][coordinates.x] = ConfigDefault::EMPTY_CELL
      @emptyCells.push(coordinates)
      show_empty_neighbours(coordinates)
    else
      board[coordinates.y][coordinates.x] = number
    end
  end

  private

  def axis_adjusted_coordinates(guess)
    x_value = guess.x - 1
    y_value = @gameBoard.height - (guess.y) # because counting from bottom rather than top
    return CoordinatePair.new(x_value, y_value)
  end

  def number_of_surrounding_mines(guess)
    cell_coords = get_surrounding_cell_coords(guess)
    cell_values = get_surrounding_cell_values(cell_coords)
    cell_values.count(ConfigDefault::MINE)
  end

  def get_surrounding_cell_values(array_of_cell_coords)
    cell_values = []

    array_of_cell_coords.each do |cell|
      cell_values.push(@gameBoard.mineBoard[cell.y][cell.x])
    end

    return cell_values
  end

  def get_surrounding_cell_coords(coordinates)
    surrounding_cell_coords = []

    if coordinates.y >= 1                                                                 # up
      surrounding_cell_coords.push(CoordinatePair.new(coordinates.x, coordinates.y - 1))
    end

    if coordinates.y < @gameBoard.height - 1                                          # down
      surrounding_cell_coords.push(CoordinatePair.new(coordinates.x, coordinates.y + 1))
    end

    if coordinates.x >= 1                                                                 # left
      surrounding_cell_coords.push(CoordinatePair.new(coordinates.x - 1, coordinates.y))
    end

    if coordinates.x < @gameBoard.width - 1                                          # right
      surrounding_cell_coords.push(CoordinatePair.new(coordinates.x + 1, coordinates.y))
    end

    if coordinates.y >= 1 && coordinates.x >= 1                                                 # top left
      surrounding_cell_coords.push(CoordinatePair.new(coordinates.x - 1, coordinates.y - 1))
    end

    if coordinates.y < @gameBoard.height - 1 && coordinates.x >= 1                          # bottom left
      surrounding_cell_coords.push(CoordinatePair.new(coordinates.x - 1, coordinates.y + 1))
    end

    if coordinates.y >= 1 && coordinates.x < @gameBoard.width - 1                          # top right
      surrounding_cell_coords.push(CoordinatePair.new(coordinates.x + 1, coordinates.y - 1))
    end

    if coordinates.y < @gameBoard.height - 1 && coordinates.x < @gameBoard.width - 1   # bottom right
      surrounding_cell_coords.push(CoordinatePair.new(coordinates.x + 1, coordinates.y + 1))
    end

    return surrounding_cell_coords
  end

  def show_empty_neighbours(cell)
    neighbour_cells = get_surrounding_cell_coords(cell)

    neighbour_cells.each do |cell|
      if @emptyCells.include?(cell)
        next
      end

      reveal_neighbours_on_board(cell)
    end
  end

  def reveal_neighbours_on_board(cell)
    cell_value = number_of_surrounding_mines(cell)

    if cell_value == 0
      @emptyCells.push(cell)
      @gameBoard.visibleBoard[cell.y][cell.x] = ConfigDefault::EMPTY_CELL
      show_empty_neighbours(cell)
    else
      @gameBoard.visibleBoard[cell.y][cell.x] = cell_value
    end
  end

  def number?(input)
    input.to_i != 0
  end

  def number_in_range?(input)
    input.to_i.between?(1, ConfigDefault::BOARD_SIZE)
  end
end
