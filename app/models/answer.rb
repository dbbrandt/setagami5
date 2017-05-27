class Answer < ApplicationRecord
  include Fae::BaseModelConcern

  def fae_display_field
     answer
  end

  def self.for_fae_index
    order(:id)
  end

  belongs_to :round
end
