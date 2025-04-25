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

      return selected_player.print_win if @game_board.winner?(selected_player.symbol)
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

  def print_turn_error(errors)
    puts "There was an error: \n"
    puts errors.join("\n")
    puts "\n"
  end
end
