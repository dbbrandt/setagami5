class Round < ApplicationRecord
  include Fae::BaseModelConcern

  def fae_display_field
    name
  end

  def ratio
    @answered > 0 ? (@correct * 100) / @answered : 100
  end

end
