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
    puts @height.to_s + " | " + @width.to_s + " | " + @bombs.to_s  + " | " + @totalCells.to_s
    @visibleBoard = generate_clean_grid
    @mineBoard = generate_grid_with_mines(@visibleBoard)
  end

  def generate_clean_grid
    Array.new(@height) { Array.new(@width, ConfigDefault::HIDDEN_CELL) }
  end

  def generate_grid_with_mines(nested_array)
    generateMinesArray
    @count = 0
    mine_array = nested_array.map do |array|
      array.map  do |cell|
        # puts "count: " + count.to_s
        # set_cell_status(generateRandomNumber) ? ConfigDefault::MINE : ConfigDefault::HIDDEN_CELL
        # puts "@minesArray.include? count ? " + (@minesArray.include? count).to_s
        # @minesArray.include? count ? ConfigDefault::MINE : ConfigDefault::HIDDEN_CELL
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

    # minesArray.include? bombPosition
    # sharks.include? "Tiger"
  end

  def generateRandomNumber
    Random.new.rand(1...(@totalCells))
  end

  def set_cell_status(randomNumber)
    # mine_cutoff_point = @totalCells
    # randomNumber > mine_cutoff_point


    # puts "randomNumber: " + randomNumber.to_s
    if (@bombsUsed > 0)
      @bombsUsed = @bombsUsed - 1
      true
    else
      false
    end
  end

end
