# frozen_string_literal: true

# player class
class Player
  attr_reader :name, :symbol

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
  end

  def print_turn
    puts "#{name}, plays with '#{symbol}':"
    puts 'Please enter the position of the cell you want to play:'
  end

  def print_win
    puts "\n"
    puts "#{name} wins!"
  end
end
