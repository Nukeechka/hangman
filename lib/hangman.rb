# frozen_string_literal: true

require_relative 'random_word_choice'
require_relative 'displayer_blanks'
require_relative 'changer_blanks'
require_relative 'computer_host'
require_relative 'word_breaker'
# class Hangman
class Hangman
  def initialize
    @computer_host = ComputerHost.new
    @random_word_choice = RandomWordChoice.new
    @changer_blanks = ChangerBlanks.new
    @word_breaker = WordBreaker.new
  end

  def play
    puts 'Game started!'
    secret_word = @random_word_choice.word
    puts 'Secret word has been chosen'
    puts "Number of letters: #{secret_word.size}"
    puts secret_word
    @display_blanks = DisplayerBlanks.new(secret_word.size)
    @display_blanks.show_blanks
    @changer_blanks.changes_blanks(@display_blanks,
                                   @computer_host.word_checker(secret_word, @word_breaker.guess_letter))
    @display_blanks.show_blanks
  end
end

game = Hangman.new
game.play
