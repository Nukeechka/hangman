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

  def play # rubocop:disable Metrics/MethodLength
    # TODO: Add opportunity to saving progress
    puts 'Game started!'
    secret_word = @random_word_choice.random_word
    puts 'You have 8 chances to guess a secret word'
    puts 'Secret word has been chosen'
    puts "Number of letters: #{secret_word.size}"
    puts secret_word
    display_start(secret_word.size)
    chances = 8
    8.times do
      puts "Remaining attempts: #{chances}"
      game_contoller(secret_word)
      if check_winner?
        puts 'Well done! You win!'
        return
      else
        chances -= 1
      end
    end
  end

  def game_contoller(secret_word)
    guess = @word_breaker.guess_letter
    @changer_blanks.changes_blanks(@display_blanks, checker(secret_word, guess))
    entered_letters
    @display_blanks.show_blanks
  end

  def check_winner?
    return true if @display_blanks.winner? == false

    false
  end

  def display_start(size)
    @display_blanks.start_value(size)
    @display_blanks.show_blanks
  end

  def checker(secret_word, guess)
    @computer_host.word_checker(secret_word, guess)
  end

  def entered_letters
    @word_breaker.entered_letters
  end
end

game = Hangman.new(host: ComputerHost.new, word_breaker: WordBreaker.new, changer_blanks: ChangerBlanks.new,
                   random_word_choice: RandomWordChoice.new, display_blanks: DisplayerBlanks.new)
game.play
