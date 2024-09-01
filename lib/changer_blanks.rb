# frozen_string_literal: true

# class ChangerBlanks
class ChangerBlanks
  def changes_blanks(displayer_blanks, changes)
    return if changes[:correct_position].empty?

    changes[:correct_position].each do |index|
      displayer_blanks.blank[index] = changes[:guessed_letter]
    end
  end
end
