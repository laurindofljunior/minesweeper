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

  def printGamePlayInstructions
    # puts "Since this is a command-line game, you aren't able to mark mines like in traditional minesweeper."
    # puts "The axes are arranged like this:"
    # puts
    puts board_layout.map { |elem| elem + "\n" }
    # puts
  end

  def board_layout
    [
      "   ↑",
      "10 |",
      " 9 |",
      " 8 |",
      " 7 |",
      " 6 |",
      " 5 |",
      " 4 |",
      " 3 |",
      " 2 |",
      " 1 |",
      "   + ― ― ― ― ― ― ― ― ― ― →",
      "     1 2 3 4 5 6 7 8 9 10"
    ]
  end

  def draw_board(board)
    puts "Here's the board: "
    puts
    puts format_board(board)
    puts
  end

  def show_flags_on_winning_board(board)
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

  def format_board(board_as_nested_array)
    # board_as_nested_array.map do |row|
    #     row.join(" ") + "\n"
    # end
    formatedArray = Array.new
    board_as_nested_array.map do |row|
      line = ""
      row.each_with_index {|val, index|
        line = line + decodeVal(val) + " "
      }
      line = line + "\n"
      formatedArray.push(line)
    end
    formatedArray

  end

  def decodeVal(val)
    if (val.is_a? Integer)
      (val.to_s).light_blue
    else
      if val == ConfigDefault::EMPTY_CELL
        (val.to_s).light_black
      else
        (val.to_s).light_white
      end
    end

  end
  #
  # def prompt_user_guess(coordinate)
  #   puts "Enter the #{coordinate} coordinate of your guess (1 - #{GameBoard::BOARD_SIZE}): "
  #   gets.chomp.to_i
  # end

  def promptXguess
    puts "Informe a 'X' coordinate of your guess X (1 - " + @game.gameBoard.width.to_s + "): "
    STDIN.gets.chomp.to_i
  end

  def promptYguess
    puts "Informe a 'Y' coordinate of your guess Y (1 - " + @game.gameBoard.height.to_s + "): "
    STDIN.gets.chomp.to_i
  end

  def print_wrong_input_message
    puts "Please enter a number in the range 1-#{GameBoard::BOARD_SIZE}"
  end

  def clear_screen
		system("clear")
	end

  def print_mine_message
    puts "             BOOM! Você está morto!             ".light_black.on_white
  end

  def print_game_over_message
    puts "                        ".light_white.on_red + "                        ".light_black.on_white
    puts "    💣 GAME OVER 💣     ".light_white.on_red + "           😵           ".light_black.on_white
    puts "                        ".light_white.on_red + "                        ".light_black.on_white
  end

  def print_win_message
    puts "         Parabéns! Você venceu o jogo!          ".light_white.on_yellow
    puts "                        ".light_yellow.on_black + "                        ".light_black.on_white
    puts "  🏆🏆🏆🏆🏆🏆🏆🏆🏆🏆  ".light_yellow.on_black + "           😄           ".light_black.on_white
    puts "                        ".light_yellow.on_black + "                        ".light_black.on_white
  end
end
