# frozen_string_literal: true

# game board
class Board
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

  def winner?(player_symbol)
    return true if row_win?(player_symbol)

    return true if column_win?(player_symbol)

    return true if diagonal_win?(player_symbol)

    false
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

  def row_win?(player_symbol)
    board.any? { |board_row| board_row.all? { |row_cell| row_cell == player_symbol } }
  end

  def column_win?(player_symbol)
    (0..2).any? { |board_column| board.all? { |row| row[board_column] == player_symbol } }
  end

  def diagonal_win?(player_symbol)
    [
      [board[0][0], board[1][1], board[2][2]],
      [board[0][2], board[1][1], board[2][0]]
    ].any? { |diagonal| diagonal.all?(player_symbol) }
  end
end
