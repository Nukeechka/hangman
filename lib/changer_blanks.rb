# frozen_string_literal: true

# class ChangerBlanks
class ChangerBlanks
  def changes_blanks(displayer_blanks, changes)
    displayer_blanks.blank[changes[:correct_position]] = changes[:guessed_letter]
  end
end
