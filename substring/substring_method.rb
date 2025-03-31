# frozen_string_literal: true

# The Substring method by Johan Núñez Rodríguez
class SubstringMethod
  def initialize(dictionary)
    @dictionary = dictionary
  end

  def get(string)
    words = {}
    array_from_string = convert_string_to_array(string)

    @dictionary.each do |word|
      possible_word = create_possible_word(word, array_from_string)
      words[possible_word] = words[possible_word].to_i + 1 if @dictionary.include?(possible_word)
    end
    words
  end

  private

  def convert_string_to_array(string)
    string.split('').map(&:downcase)
  end

  def create_possible_word(word, array_from_string)
    possible_word = ''
    array_from_word = convert_string_to_array(word)
    array_from_word.each do |letter|
      array_from_string.include?(letter) ? possible_word += letter : ''
    end
    possible_word
  end
end

substring = SubstringMethod.new(%w[below down go going horn how howdy it i low own part partner sit])

puts substring.get('below')
# expected value: {"below"=>1, "low"=>1}
puts substring.get('its')
# expected value: {"i"=>2, "it"=>1, "sit"=>1}
puts substring.get("Howdy partner, sit down! How's it going?")
# expected value: {"down"=>1, "go"=>1, "going"=>1, "horn"=>1, "how"=>1, "howdy"=>1, "it"=>1, "i"=>1, "own"=>1, "part"=>1, "partner"=>1, "sit"=>1 }
