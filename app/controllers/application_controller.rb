class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_option

  helper Fae::ViewHelper

  def set_option
    @option = Fae::Option.instance
  end

end
