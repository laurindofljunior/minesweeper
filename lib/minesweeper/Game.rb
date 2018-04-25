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

  def isGuessXValid?(input)
    isNumber?(input) && input.to_i.between?(1, @gameBoard.width)
  end

  def isGuessYValid?(input)
    isNumber?(input) && input.to_i.between?(1, @gameBoard.height)
  end

  def isMine?(guess)
    coordinates = axisAdjustedCoordinates(guess)

    @gameBoard.mineBoard[coordinates.y][coordinates.x] == ConfigDefault::MINE
  end

  def showNeighbours(guess, board)
    coordinates = axisAdjustedCoordinates(guess)
    number = getNumberSurroundingMines(coordinates)

    if isMine?(guess)
      board[coordinates.y][coordinates.x] = ConfigDefault::MINE
    elsif number == 0
      board[coordinates.y][coordinates.x] = ConfigDefault::EMPTY_CELL
      @emptyCells.push(coordinates)
      showEmptyNeighbours(coordinates)
    else
      board[coordinates.y][coordinates.x] = number
    end
  end

  private

  def axisAdjustedCoordinates(guess)
    x_value = guess.x - 1
    y_value = @gameBoard.height - (guess.y)
    return CoordinatePair.new(x_value, y_value)
  end

  def getNumberSurroundingMines(guess)
    cell_coords = getSurroundingCellCoords(guess)
    cell_values = getSurroundingCellValues(cell_coords)
    cell_values.count(ConfigDefault::MINE)
  end

  def getSurroundingCellValues(array_of_cell_coords)
    cell_values = []

    array_of_cell_coords.each do |cell|
      cell_values.push(@gameBoard.mineBoard[cell.y][cell.x])
    end

    return cell_values
  end

  def getSurroundingCellCoords(coordinates)
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

  def showEmptyNeighbours(cell)
    neighbour_cells = getSurroundingCellCoords(cell)

    neighbour_cells.each do |cell|
      if @emptyCells.include?(cell)
        next
      end

      revealNeighboursOnBoard(cell)
    end
  end

  def revealNeighboursOnBoard(cell)
    cell_value = getNumberSurroundingMines(cell)

    if cell_value == 0
      @emptyCells.push(cell)
      @gameBoard.visibleBoard[cell.y][cell.x] = ConfigDefault::EMPTY_CELL
      showEmptyNeighbours(cell)
    else
      @gameBoard.visibleBoard[cell.y][cell.x] = cell_value
    end
  end

  def isNumber?(input)
    input.to_i != 0
  end

end
