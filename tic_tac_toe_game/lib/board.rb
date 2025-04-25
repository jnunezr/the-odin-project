# frozen_string_literal: true

# game board
class Board
  # LINES = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]]
  attr_accessor :board

  def initialize
    @board = [
      [1, 2, 3],
      [4, 5, 6],
      [7, 8, 9]
    ]
    @available_positions = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  def draw
    puts "\n"
    @board.each.with_index do |row, column_index|
      row.each.with_index do |cell, row_index|
        draw_cell(row_index, cell)
      end
      puts "\n---+---+---" unless column_index == 2
    end
    puts "\n"
  end

  def update_board(position, value)
    get_position = find_position(position.to_i)
    return { success: false, errors: get_position[:errors] } if get_position[:errors].any?

    @board[get_position[:row]][get_position[:column]] = value
    @available_positions.delete(position.to_i)
    draw
    { success: true, errors: [] }
  end

  def full?
    @available_positions.empty?
  end

  private

  def draw_cell(index, cell)
    if index == 2
      print " #{cell}"
    else
      print " #{cell} |"
    end
  end

  def find_position(position)
    is_valid = validate_update(position)
    return { errors: is_valid[:errors] } unless is_valid[:success]

    @column_index = nil
    @row_index = nil
    @board.each.with_index do |row, row_index|
      @column_index = row.find_index(position)
      @row_index = row_index if @column_index
      break if @column_index
    end
    { row: @row_index, column: @column_index, errors: [] }
  end

  def validate_update(position)
    errors = []
    errors << "Invalid position, available positions: #{@available_positions.join(', ')}" unless @available_positions.include?(position)

    { errors: errors.each.with_index(1).map { |error, index| "#{index}. #{error}" }, success: errors.empty? }
  end
end
