class AnswersController < ApplicationController

  def index
    if params[:round_id]
      @round = Round.find(params[:round_id])
      @items = @round.answers
    else
      @items = Answer.all
      end
  end
  
end
