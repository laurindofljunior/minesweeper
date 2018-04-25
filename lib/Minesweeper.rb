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
    play_turn while @game.still_playing?
    if @game.lost?
      @view.showGameOverMessage
    elsif @game.victory?
      @view.clearView
      winning_board = @view.showWinningBoard(@board.visibleBoard)
      @view.showGameBoard(winning_board)
      @view.showWinnerMessage
    end
  end

  private

  def play_turn
    @view.clearView
    # @view.showGameBoard(@board.mineBoard)
    @view.showGameBoard(@board.visibleBoard)

    x_coord = enterXGuess
    y_coord = enterYGuess
    guess = CoordinatePair.new(x_coord, y_coord)

    if @game.isMine?(guess)
      @game.gameLost = true
      @game.reveal_guess(guess, @board.visibleBoard)
      @view.clearView
      @view.showGameBoard(@board.visibleBoard)
      @view.showMineMessage
    else
      @game.reveal_guess(guess, @board.visibleBoard)
    end
  end

  def enterXGuess
    loop do
      guess = @view.promptXInput
      break guess if @game.isGuessXValid?(guess)
      @view.showWrongInputMessage('X',@board.width)
    end
  end

  def enterYGuess
    loop do
      guess = @view.promptYInput
      break guess if @game.isGuessYValid?(guess)
      @view.showWrongInputMessage('Y',@board.height)
    end
  end
end
Minesweeper.new(ARGV[0], ARGV[1], ARGV[2]).play
