# frozen_string_literal: true

# class DisplayerBlanks
class DisplayerBlanks
  def start_value(size)
    @blank = Array.new(size, '_')
  end

  def show_blanks
    @blank.each do |letter|
      print "#{letter} "
    end
    puts
  end

  def winner?
    @blank.any?('_')
  end

  attr_accessor :blank
end
