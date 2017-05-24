module Admin
  class PeopleController < Fae::BaseController

    private

    def build_assets
      @item.build_actor_image if @item.actor_image.blank?
    end
  end
end
