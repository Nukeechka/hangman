# frozen_string_literal: true

# class ComputerHost
class ComputerHost
  def word_checker(secret_word, guessed_letter)
    correct_position = []
    secret_word.split('').each_with_index do |letter, index|
      correct_position.push(index) if letter == guessed_letter
    end
    {
      correct_position: correct_position,
      guessed_letter: guessed_letter
    }
  end
end
