require_relative './minesweeper/Game'
require_relative './minesweeper/TerminalView'
require_relative './minesweeper/Coordinate'

class Minesweeper
  def initialize(height=10, width=10, bombs=10)
    @height = height
    @width = width
    @bombs = bombs
    @game = Game.new(@height, @width, @bombs)
    @view = TerminalView.new(@game)
    @board = @game.gameBoard
  end

  def play
    @view.printWelcomeMessage
    # @view.printGamePlayInstructions

    play_turn while @game.still_playing?

    if @game.lost?
      @view.print_game_over_message
    elsif @game.victory?
      @view.clear_screen
      winning_board = @view.show_flags_on_winning_board(@board.visibleBoard)
      @view.draw_board(winning_board)
      @view.print_win_message
    end
  end

  private

  def play_turn
    @view.clear_screen
    # @view.draw_board(@board.mineBoard)
    @view.draw_board(@board.visibleBoard)

    x_coord = enterXGuess
    y_coord = enterYGuess
    guess = CoordinatePair.new(x_coord, y_coord)

    if @game.mine?(guess)
      @game.gameLost = true
      @game.reveal_guess(guess, @board.visibleBoard)
      @view.clear_screen
      @view.draw_board(@board.visibleBoard)
      @view.print_mine_message
    else
      @game.reveal_guess(guess, @board.visibleBoard)
    end
  end

  # def enter_guess(coordinate)
  #   loop do
  #     guess = @view.prompt_user_guess(coordinate)
  #     break guess if @game.guess_valid?(guess)
  #     @view.print_wrong_input_message
  #   end
  # end

  def enterXGuess
    loop do
      guess = @view.promptXguess
      break guess if @game.isGuessXValid?(guess)
      @view.print_wrong_input_message
    end
  end

  def enterYGuess
    loop do
      guess = @view.promptYguess
      break guess if @game.isGuessYValid?(guess)
      @view.print_wrong_input_message
    end
  end
end
Minesweeper.new(ARGV[0], ARGV[1], ARGV[2]).play
