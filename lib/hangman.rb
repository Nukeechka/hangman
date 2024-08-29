# frozen_string_literal: true

require_relative 'random_word_choice'
require_relative 'displayer_blanks'
require_relative 'changer_blanks'
require_relative 'computer_host'
require_relative 'word_breaker'
# class Hangman
class Hangman
  def initialize(host:, word_breaker:, changer_blanks:, random_word_choice:, display_blanks:)
    @computer_host = host
    @random_word_choice = random_word_choice
    @changer_blanks = changer_blanks
    @word_breaker = word_breaker
    @word_breaker = word_breaker
    @display_blanks = display_blanks
  end

  def play
    puts 'Game started!'
    secret_word = @random_word_choice.random_word
    puts 'Secret word has been chosen'
    puts "Number of letters: #{secret_word.size}"
    puts secret_word
    display_start(secret_word.size)
    8.times do
      game_contoller(secret_word)
    end
  end

  def game_contoller(secret_word)
    guess = @word_breaker.guess_letter
    @changer_blanks.changes_blanks(@display_blanks, checker(secret_word, guess))
    @display_blanks.show_blanks
  end

  def display_start(size)
    @display_blanks.start_value(size)
    @display_blanks.show_blanks
  end

  def checker(secret_word, guess)
    @computer_host.word_checker(secret_word, guess)
  end
end

game = Hangman.new(host: ComputerHost.new, word_breaker: WordBreaker.new, changer_blanks: ChangerBlanks.new,
                   random_word_choice: RandomWordChoice.new, display_blanks: DisplayerBlanks.new)
game.play
