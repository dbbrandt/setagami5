class Round < ApplicationRecord
  include Fae::BaseModelConcern

  def fae_display_field
    name
  end

  def percent_correct
    answers.size > 0 ? (correct_count * 100) / answers.size : 0
  end

  def percent_complete
    100 * answers.size / total
  end

  def incorrect_count
    answers.select {|a| a.correct == false}.count
  end

  def correct_count
    answers.select {|a| a.correct == true}.count
  end

  has_many :answers, :dependent => :destroy

end
