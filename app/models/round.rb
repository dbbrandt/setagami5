class Round < ApplicationRecord
  include Fae::BaseModelConcern

  def fae_display_field
    name
  end

  def percent_correct
    answered > 0 ? (calc_correct * 100) / answered : 0
  end

  def percent_complete
    100 * answered / total
  end

  def incorrect_count
    return 0 unless incorrect
    incorrect.split("&").size
  end

  def calc_correct
    answers.where(correct: true).count
  end

  has_many :answers

end
