# frozen_string_literal: true

require 'yaml'
require_relative 'random_word_choice'
require_relative 'displayer_blanks'
require_relative 'changer_blanks'
require_relative 'computer_host'
require_relative 'word_breaker'
# class Hangman
class Hangman
  attr_accessor :chances

  def initialize(host:, word_breaker:, changer_blanks:, random_word_choice:, display_blanks:)
    @computer_host = host
    @random_word_choice = random_word_choice
    @changer_blanks = changer_blanks
    @word_breaker = word_breaker
    @word_breaker = word_breaker
    @display_blanks = display_blanks
    @chances = 8
    @secret_word = ''
  end

  def save_contoller
    return unless Dir.exist?('saves')

    puts 'Do you want load your current progress?[yes][no]'
    load_game if gets.chomp.downcase == 'yes'
  end

  def save_game
    serialized_object = YAML.dump({
                                    'chances' => @chances,
                                    'blank' => @display_blanks.blank,
                                    'secret_word' => @secret_word
                                  })
    Dir.mkdir('saves') unless Dir.exist?('saves')
    File.open('saves/save.yaml', 'w') do |file|
      file.puts serialized_object
    end
  end

  def load_game
    data = YAML.safe_load File.read('saves/save.yaml')
    @chances = data['chances']
    @display_blanks = data['blank']
  end

  def play # rubocop:disable Metrics/MethodLength,Metrics/AbcSize
    # TODO: Add opportunity to saving progress
    puts 'Game started!'
    secret_word = @random_word_choice.random_word
    save_contoller
    puts "You have #{@chances} chances to guess a secret word"
    puts 'Secret word has been chosen'
    puts "Number of letters: #{secret_word.size}"
    puts secret_word
    display_start(secret_word.size)
    @chances.times do
      puts "Remaining attempts: #{@chances}"
      puts 'Do you want save your game and exit?[yes][no]'
      if gets.chomp.downcase == 'yes'
        save_game
        return
      end
      game_contoller(secret_word)
      if check_winner?
        puts 'Well done! You win!'
        return
      else
        @chances -= 1
      end
    end
  end

  def game_contoller(secret_word)
    guess = @word_breaker.way_to_guess
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
