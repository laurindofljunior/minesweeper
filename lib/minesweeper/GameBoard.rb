require_relative './ConfigDefault'

class GameBoard

  attr_reader :mineBoard, :visibleBoard, :height, :width, :bombs

  def initialize(height, width, bombs)
    @height=height.to_i
    @width=width.to_i
    @bombs=bombs.to_i
    @bombsUsed=bombs.to_i
    @totalCells = @height * @width
    @minesArray = Array.new()
    # puts @height.to_s + " | " + @width.to_s + " | " + @bombs.to_s  + " | " + @totalCells.to_s
    @visibleBoard = createGrid
    # @mineBoard = createGridWithMines(@visibleBoard)
    @mineBoard = createGridWithMines(Array.new(@height) { Array.new(@width, ConfigDefault::HIDDEN_CELL) })
    # @visibleBoard = @mineBoard
  end

  def createGrid
    Array.new(@height) { Array.new(@width, ConfigDefault::HIDDEN_CELL) }
  end

  def createGridWithMines(nested_array)
    generateMinesArray
    @count = 0
    mine_array = nested_array.map do |array|
      array.map  do |cell|
        getCellValue
      end
    end
    mine_array
  end

  private

  def getCellValue
    @count = @count + 1
    if (@minesArray.include? @count)
      ConfigDefault::MINE
    else
      ConfigDefault::HIDDEN_CELL
    end
  end

  def generateMinesArray
    loop do
      bombPosition = generateRandomNumber
      if not @minesArray.include? bombPosition
        @minesArray.push(bombPosition)
        @bombsUsed = @bombsUsed - 1
      end
      break if @bombsUsed == 0
    end
  end

  def generateRandomNumber
    Random.new.rand(1...(@totalCells))
  end

end
