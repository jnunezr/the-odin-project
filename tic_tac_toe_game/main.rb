# frozen_string_literal: true

require_relative 'lib/game'

puts 'Please enter the name of player 1?'
name1 = gets.chomp
puts 'Please enter the name of player 2?'
name2 = gets.chomp

game = Game.new(name1, name2)
game.play
