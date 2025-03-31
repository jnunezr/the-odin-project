# frozen_string_literal: true

# The Caesar Cipher encrypt and decrypt by Johan Núñez Rodríguez
class CaesarCipher
  ALPHABET_UPPERCASE = ('A'..'Z').to_a
  ALPHABET_LOWERCASE = ('a'..'z').to_a

  def initialize(key)
    @key = key
  end

  def encrypt(message)
    puts generate_encryption(message, 'encrypt')
  end

  def decrypt(message)
    puts generate_encryption(message, 'decrypt')
  end

  private

  def generate_encryption(message, type = 'encrypt')
    return 'Invalid message type, must be a string' unless message.is_a?(String)

    encrypted_message = ''

    message.split('').each do |letter|
      encrypted_message += if ALPHABET_LOWERCASE.include?(letter)
                             encrypted_letter(letter, ALPHABET_LOWERCASE, type)
                           elsif ALPHABET_UPPERCASE.include?(letter)
                             encrypted_letter(letter, ALPHABET_UPPERCASE, type)
                           else
                             letter
                           end
    end

    encrypted_message
  end

  def encrypted_letter(letter, alphabet, type = 'encrypt')
    letter_index = alphabet.find_index(letter)
    encrypted_index = if type == 'encrypt'
                        (letter_index + @key) % alphabet.length
                      else
                        (letter_index - @key) % alphabet.length
                      end
    alphabet[encrypted_index]
  end
end

cipher = CaesarCipher.new(5)
cipher.encrypt(['Encrypting this message'])
cipher.encrypt(234_243)

cipher.encrypt('Encrypting this message')
cipher.decrypt('Jshwduynsl ymnx rjxxflj')
