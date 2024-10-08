# frozen_string_literal: true

# class RandomWordChoice
class RandomWordChoice
  def random_word
    lines = File.readlines('../google-10000-english-no-swears.txt')
    lines
      .map(&:chomp)
      .filter { |line| line.size >= 5 && line.size <= 12 }.sample
  end
end
