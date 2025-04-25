# frozen_string_literal: true

require_relative 'board'
require_relative 'player'
# game class
class Game
  attr_accessor :turn

  def initialize(player1_name = 'Player 1', player2_name = 'Player 2')
    @turn = 0
    @game_board = Board.new
    @player1 = Player.new(player1_name, 'X')
    @player2 = Player.new(player2_name, 'O')
  end

  def play
    puts 'Starting game...'
    @game_board.draw
    loop do
      return puts 'The game is ended, no one won!' if @game_board.full?

      selected_player = @turn.even? ? @player1 : @player2
      player_turn(selected_player)
      @turn += 1

      return selected_player.print_win if player_win?(selected_player.symbol)
    end
  end

  private

  def player_turn(player)
    player.print_turn
    position = gets.chomp
    puts "\n"
    valid_update = @game_board.update_board(position, player.symbol)
    unless valid_update[:success]
      @game_board.draw
      print_turn_error(valid_update[:errors]) unless valid_update[:success]
      player_turn(player)
    end
  end

  def player_win?(player_symbol)
    board = @game_board.board
    # rows
    return true if board.any? { |board_row| board_row.all? { |row_cell| row_cell == player_symbol } }
    # columns
    return true if (0..2).any? { |board_column| board.all? { |row| row[board_column] == player_symbol } }

    # diagonals
    return true if [
      [board[0][0], board[1][1], board[2][2]],
      [board[0][2], board[1][1], board[2][0]]
    ].any? { |diagonal| diagonal.all?(player_symbol) }

    false
  end

  def print_turn_error(errors)
    puts "There was an error: \n"
    puts errors.join("\n")
    puts "\n"
  end
end
