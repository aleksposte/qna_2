class QuestionsController < ApplicationController
  # before_action :authenticate_user!, except: [:index, :show]
  before_action :authenticate_user!
  before_action :load_question, only: [:show]

  def index
    @questions = Question.all
  end

  def show
    @answer = @question.answers.build
  end

  # def show
  #   @answer = @question.answers.new
  #   @answer.attachments.build
  # end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params.merge(user: current_user))
    if @question.save
      flash[:notice] = 'Your question was successfully created.'
      redirect_to @question
    else
      flash[:alert] = 'Your question has errors.'
      render :new
    end
  end

  def destroy
    if current_user.author_of?(@question)
      @question.destroy!
      flash[:notice] = 'Your question was successfully deleted.'
    else
      flash[:alert] = 'Your can`t delete others questions'
    end
    redirect_to questions_path
  end

  private
  def load_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end
end