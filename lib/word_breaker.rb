# frozen_string_literal: true

require_relative 'alphabet'

# class WordBreaker
class WordBreaker
  @@entered_letters = [] # rubocop:disable Style/ClassVars
  include Alphabet

  def way_to_guess
    puts 'Enter 1 to guess letter'
    puts 'Or 2 to guess full word:'
    choice = gets.chomp.to_i
    if choice == 1
      guess_letter
    else
      guess_word
    end
  end

  def guess_letter # rubocop:disable Metrics/MethodLength
    begin # rubocop:disable Style/RedundantBegin
      guess = gets.chomp.downcase
      if Alphabet::ALPHABET.include?(guess)
        @@entered_letters << guess
      else
        continue
      end
    rescue StandardError
      puts 'Invalid entered value. Try again..'
      retry
    else
      guess
    end
  end

  def entered_letters
    puts "Entered letters: #{@@entered_letters}"
    left_letters
  end

  def left_letters
    alphabet_array = Alphabet::ALPHABET.split('')
    puts 'Left letters:'
    puts
    print alphabet_array - @@entered_letters
    puts
    puts
  end

  # TODO: Add function - guess word
  def guess_word
    guess = gets.chomp.downcase
    guess.split('').each do |letter|
      @@entered_letters << letter
    end
    guess
  end
end
