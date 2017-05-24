class Person < ApplicationRecord
  include Fae::BaseModelConcern

  def fae_display_field
    name
  end

  has_fae_image :actor_image
  
  belongs_to :imdb

end
