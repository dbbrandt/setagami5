module Admin
  class AnswersController < Fae::BaseController

    def index
      @round = Round.find(params[:round_id]) if params[:round_id]
      @items = @round? @round.answers : Answer.all
    end
  end
end
