require 'colorize'
require_relative './ConfigDefault'

class TerminalView
  def initialize(game)
    @game = game
  end
  def printWelcomeMessage()
    puts "Created game with " + @game.gameBoard.height.to_s + " x " + @game.gameBoard.width.to_s + "."
    puts "This game contains " + @game.gameBoard.bombs.to_s + " bombs."
  end

  def showGameBoard(board)
    puts
    puts
    puts " " + "⌜                          ⌝".white.on_blue
    puts " " + "       CAMP💣 MINAD💣       ".white.on_blue
    puts " " + "⌞                          ⌟".white.on_blue
    puts
    puts showFormatedGameBoard(board)
    puts
  end

  def showWinningBoard(board)
    flag_mines_board = board.map do |array|
      array.map do |cell|
        if cell == ConfigDefault::HIDDEN_CELL
          cell = ConfigDefault::MINE_FLAG
        else
          cell
        end
      end
    end
    return flag_mines_board
  end

  def showFormatedGameBoard(board_as_nested_array)
    formatedArray = Array.new
    firstLine = lastLine = ""
    board_as_nested_array.map do |row|
      firstLine = "       "
      row.each_with_index {|val, index|
        firstLine = firstLine + ".." + " "
      }
      firstLine = firstLine + "..\n"
      lastLine = ""+firstLine
      formatedArray.push(firstLine)
      break
    end

    countLine = 0
    maxHeight = @game.gameBoard.height.to_i

    board_as_nested_array.map do |row|
      lineIndex = maxHeight - countLine.to_i
      line = "  " + ("%02d" % lineIndex) + "   :"
      countLine = countLine + 1
      row.each_with_index {|val, index|
        line = line + decodeVal(val) + " "
      }
      line = line + ":\n"
      formatedArray.push(line)
    end




    # formatedArray.push(lastLine.gsub! '..', '¨¨')

    lastLine = "        "
    (1..@game.gameBoard.width).each do |i|
       lastLine = lastLine + ("%02d" % i) + " "
    end

    # lastLine = ""+firstLine
    formatedArray.push(firstLine)
    formatedArray.push("")
    formatedArray.push(lastLine)

    formatedArray

  end

  def decodeVal(val)
    if (val.is_a? Integer)
      " " + (val.to_s).light_blue
    else
      if val == ConfigDefault::EMPTY_CELL
        (val.to_s).light_black
      else
        if val == ConfigDefault::MINE
          (val.to_s).light_red
        else
          if val == ConfigDefault::MINE_FLAG
            (val.to_s).light_green
          else
            (val.to_s).light_white
          end
        end
      end
    end

  end

  def promptInput(coordinate, maxValue)
    puts "Informe um valor para a coordenada '" + coordinate + "' (de 1 à " + maxValue.to_s + "): "
    STDIN.gets.chomp.to_i
  end

  def promptXInput
    promptInput("X",@game.gameBoard.width.to_s)
  end

  def promptYInput
    promptInput("Y",@game.gameBoard.height.to_s)
  end

  def print_wrong_input_message
    puts "Please enter a number in the range 1-#{GameBoard::BOARD_SIZE}"
  end

  def showWrongInputMessage(coordinate, maxValue)
    puts "Por favor, informe um valor numérico para a coordenada '" + coordinate + "' de 1 à " + maxValue.to_s + "!"
    STDIN.gets.chomp.to_i
  end


  def clearView
		system("clear")
	end

  def showMineMessage
    puts "  " + "             BOOM! Você está morto!             ".light_black.on_white
  end

  def showGameOverMessage
    puts "  " + "                        ".light_white.on_red + "                        ".light_black.on_white
    puts "  " + "    💣 GAME OVER 💣     ".light_white.on_red + "           😵           ".light_red.on_white
    puts "  " + "                        ".light_white.on_red + "                        ".light_black.on_white
  end

  def showWinnerMessage
    puts "  " + "         Parabéns! Você venceu o jogo!          ".light_black.on_yellow
    puts "  " + "                        ".light_yellow.on_black + "                        ".light_black.on_yellow
    puts "  " + "         🏆🏆🏆         ".light_yellow.on_black + "           😄           ".light_black.on_yellow
    puts "  " + "                        ".light_yellow.on_black + "                        ".light_black.on_yellow
    puts ""
  end
end
