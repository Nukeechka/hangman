# frozen_string_literal: true

# class DisplayerBlanks
class DisplayerBlanks
  def initialize(size)
    @blank = Array.new(size, '_')
  end

  def show_blanks
    @blank.each do |letter|
      print "#{letter} "
    end
    puts
  end

  attr_accessor :blank
end
