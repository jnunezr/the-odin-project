# frozen_string_literal: true

# The Caesar Cipher encrypt and decrypt by Johan Núñez Rodríguez
class BubbleSort
  def initialize(array)
    @array = array
  end

  def sort
    @final_array = @array.dup
    resort = lambda do |array|
      array.each_with_index do |el, index|
        next_element = @final_array[index + 1]
        next if !next_element || next_element >= el

        swap_values(index, next_element, el)
        return resort.call(@final_array)
      end
      puts "sorted array: #{@final_array}"
    end
    resort.call(@final_array)
  end

  private

  def swap_values(index, next_element, element)
    @final_array[index + 1] = element
    @final_array[index] = next_element
  end
end

sorter = BubbleSort.new([4, 3, 78, 2, 0, 2])
sorter.sort # Expected output: [0, 2, 2, 3, 4, 78]

sorter2 = BubbleSort.new([15, 3, 1, 2, 14, 19])
sorter2.sort # Expected output: [1, 2, 3, 14, 15, 19]
