# frozen_string_literal: true

# class ComputerHost
class ComputerHost
  def word_checker(secret_word, guessing)
    if secret_word == guessing
      full_word_checker(guessing)
    else
      letter_checker(secret_word, guessing)
    end
  end

  def letter_checker(secret_word, guessing)
    correct_position = []
    secret_word.split('').each_with_index do |letter, index|
      correct_position.push(index) if letter == guessing
    end
    {
      correct_position: correct_position,
      guessed: guessing,
      word: false
    }
  end

  def full_word_checker(guessing)
    {
      guessed: guessing,
      word: true
    }
  end
end
