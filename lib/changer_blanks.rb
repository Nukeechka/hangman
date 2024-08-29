# frozen_string_literal: true

# class ChangerBlanks
class ChangerBlanks
  def changes_blanks(displayer_blanks, changes)
    return if changes[:correct_position] == -1

    displayer_blanks.blank[changes[:correct_position]] = changes[:guessed_letter]
  end
end
