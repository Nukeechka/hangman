# frozen_string_literal: true

# class Hangman
class Hangman
  MAX_ATTEMPTS = 6

  def initialize
    @dictionary = load_dictionary
    @secret_word = choose_word
    @attempts_left = MAX_ATTEMPTS
    @guessed_letters = []
    @incorrect_letters = []
  end

  def load_dictionary
    File.readlines('../google-10000-english-no-swears.txt').map(&:chomp)
  end

  def choose_word
    @dictionary.select { |word| word.length.between?(5, 12) }.sample.downcase
  end

  def display_status
    word_display = @secret_word.chars.map { |char| @guessed_letters.include?(char) ? char : '_' }.join(' ')
    puts "Secret word: #{word_display}"
    puts "Wrong letters: #{@incorrect_letters.join(', ')}"
    puts "Remaining attempts: #{@attempts_left}"
  end

  def guess_letter # rubocop:disable Metrics/MethodLength
    print 'Enter a letter or command (save for saving): '
    input = gets.chomp.downcase

    if input == 'save'
      save_game
    elsif input.match?(/^[a-z]$/)
      if @guessed_letters.include?(input) || @incorrect_letters.include?(input)
        puts 'You entered this letter already'
      elsif @secret_word.include?(input)
        @guessed_letters << input
      else
        @incorrect_letters << input
        @attempts_left -= 1
      end
    else
      puts 'Invalid input. Enter one letter.'
    end
  end

  def game_over?
    @attempts_left.zero? || @secret_word.chars.all? { |char| @guessed_letters.include?(char) }
  end

  def save_game
    File.open('saved_game.marshal', 'wb') do |file|
      file.write(Marshal.dump(self))
    end
    puts 'Game saved!'
    exit
  end

  def self.load_game
    if File.exist?('saved_game.marshal')
      File.open('saved_game.marshal', 'rb') do |file|
        Marshal.load(file) # rubocop:disable Security/MarshalLoad
      end
    else
      puts 'Not saved game!'
      nil
    end
  end

  def play
    until game_over?
      display_status
      guess_letter
    end

    if @attempts_left.zero?
      puts "You lost! Secret word was: #{@secret_word}"
    else
      puts "Well done! You guess a secret word: #{@secret_word}"
    end
  end
end

def main_menu # rubocop:disable Metrics/MethodLength
  puts 'Welcome to a game Hangman!'
  puts '1. New game'
  puts '2. Load save'

  choice = gets.chomp

  case choice
  when '1'
    game = Hangman.new
  when '2'
    game = Hangman.load_game
    game ||= Hangman.new
  else
    puts 'Incorrect choice.'
    return main_menu
  end

  game.play
end

main_menu
