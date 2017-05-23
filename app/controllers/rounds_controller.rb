class RoundsController < ApplicationController
  def index
    @items = Round.all
  end

  def new
    round = Round.new
    round.correct = 0
    round.answered = 0
    quiz = []
    # Convert the array of People to an array of id's
    Person.all.shuffle.each { |p| quiz << p.id }
    round.total = quiz.size
    round.quiz = quiz.join('&')
    round.name = "Round #{round.id}"
    round.save
    cookies[:round] = round.id
    redirect_to people_path
  end

end
