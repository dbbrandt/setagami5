require 'fuzzystringmatch'

class RoundsController < ApplicationController

  @@size = 100

  @@correct_percent = 0.85

  @@jarow = FuzzyStringMatch::JaroWinkler.create( :native )

  def index
    @items = Round.order(id: :desc).all
  end

  def show
    @round = Round.find(params[:id])
    @person = Person.find(@round.quiz.split("&").first)
    @incorrect_list = incorrect_list(@round.incorrect)
  end

  def new
    @round = Round.new
    @round.correct = 0
    @round.answered = 0
    size = params[:size]? params[:size] : @@size
    @round.total = size
    @round.name = "Round #{Round.count+1}"
    # Convert the array of People to an array of id's
    @round.quiz = Person.all.shuffle[0..size-1].map(&:id).join('&')
    @round.save

    redirect_to @round
  end
  
  def update
    #find or create the current round
    @round = Round.find(params[:id])
    person = Person.find(@round.quiz.split("&").first)

    answer = params[:actor_name]
    score = check_answer?(answer, person.name)
    correct = score >= @@correct_percent
    @round.answers.build(answer: answer, correct_answer: person.name, score: score, correct: correct)

    percent = (score * 100).round(2)
    #update the list of incorrect answers
    if correct
      @round.correct += 1
      flash[:correct] = "Correct! (#{percent}%) #{answer} for #{person.name} "
      msg_type = :correct
    else
      # Incorrect is stored as a string concatenation of person ids
      add_incorrect!(@round, person)
      flash_type = params[:skip]? 'Skipped':'Incorrect'
      flash[:incorrect] = "#{flash_type}: (#{percent}%)#{answer} for #{person.name}"
    end

    @round.answered += 1
    @round.save

    if next_person
      redirect_to @round
    else
      redirect_to :index
    end
  end

  def next_person
    return true unless @round.quiz

    quiz = @round.quiz.split("&")

    more = true

    # Delete the current person from the array so the next person will be first on subsequent calls
    if (quiz.second)
      quiz.delete(quiz.first)
      @round.quiz = quiz.join("&")
    else
      quiz.delete(quiz.first)
      more = false
    end
    @round.save

    return more
  end

  def check_answer?(answered, actual)
    match = (normalize_string(answered) == normalize_string(actual))
    match ? 1 : fuzzy_match(answered, actual)
  end

  def fuzzy_match(answered, actual)
    @@jarow.getDistance( answered, actual).round(3)
  end

  private

  def normalize_string(str)
    str.downcase.gsub(/\s+/, "")
  end

  def incorrect_list(str)
    return unless str
    list = []
    ids = str.split("&") 
    ids.each { |person_id|
      list << Person.find(person_id)
    }
    list.sort_by! {|p| p.last_name }
  end

  def add_incorrect!(round, person)
    return unless round && person

    if round.incorrect.nil?
      round.incorrect = person.id
    else
      round.incorrect += "&#{person.id}" if person.id
    end
  end
end
