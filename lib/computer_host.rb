# frozen_string_literal: true

require_relative 'alphabet'
# class ComputerHost
class ComputerHost
  include Alphabet

  def word_checker(secret_word, guessed_letter)
    correct_position = -1
    secret_word.split('').each_with_index do |letter, index|
      correct_position = index if letter == guessed_letter
    end
    {
      correct_position: correct_position,
      guessed_letter: guessed_letter
    }
  end
end
