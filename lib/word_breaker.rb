# frozen_string_literal: true

require_relative 'alphabet'

# class WordBreaker
class WordBreaker
  @@entered_letters = [] # rubocop:disable Style/ClassVars
  include Alphabet

  def guess_letter # rubocop:disable Metrics/MethodLength
    begin # rubocop:disable Style/RedundantBegin
      guess = gets.chomp
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
end
