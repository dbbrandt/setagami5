class RoundsController < ApplicationController

  @@size = 2

  def index
    @items = Round.all
  end

  def show
    @round = Round.find(params[:id])
    @person = Person.find(@round.quiz.split("&").first)
    @incorrect_list = get_incorrect_list
  end

  def new
    @round = Round.new
    @round.correct = 0
    @round.answered = 0
    @round.total = @@size
    @round.name = "Round #{Round.count+1}"
    people = []
    # Convert the array of People to an array of id's
    Person.all.limit(@@size).shuffle.each { |p| people << p.id }
    @round.quiz = people.join('&')
    @round.save

    redirect_to @round
  end
  
  def update
    #find or create the current round
    @round = Round.find(params[:id])
    person = Person.find(@round.quiz.split("&").first)

    done = false

    # don't accept answers after the quiz is completed
    unless @round.answered >= @round.total
      #update the list of incorrect answers
      incorrect_list = @round.incorrect.nil? ? [] : @round.incorrect.split("&")
      if check_answer?(params[:actor_name], person)
        @round.correct += 1
      else
        incorrect_list << person.id
      end

      @round.incorrect = incorrect_list.uniq.join("&")
      @round.answered += 1
      @round.save

      done = next_person
      
      redirect_to @round unless done
    else
      done = true
    end

    redirect_to :index if done
  end

  def get_incorrect_list
    return nil unless @round.incorrect
    incorrect = @round.incorrect.split("&")
    incorrect_list = []
    incorrect.each { |id|
      incorrect_list << Person.find(id)
    }
    incorrect_list.sort_by! {|p| p.last_name }
  end

  def next_person
    done = false

    #get the next entry (first of the array)
    quiz = @round.quiz.split("&")
    #delete from the array so the next person will be first on subsequent calls
    #save the quiz in the database
    #Leave one person in the quiz so the last page continues to display correctly
    if (quiz.second)
      quiz.delete(quiz.first)
      @round.quiz = quiz.join("&")
    else
      done = true
    end
    @round.save
    
    return done
  end

  def check_answer?(answered, actual)
    result = (answered == actual.name)
    result
  end


end
