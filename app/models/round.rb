class Round < ApplicationRecord
  include Fae::BaseModelConcern

  def fae_display_field
    name
  end

  def percent_correct
    answered > 0 ? (correct * 100) / answered : 100
  end

  def percent_complete
    100 * answered / total
  end

  def incorrect_count
    return 0 unless incorrect
    incorrect.split("&").size
  end

end
