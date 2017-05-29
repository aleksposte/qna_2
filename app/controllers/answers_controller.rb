class AnswersController < ApplicationController
  before_action :load_question
  def new
    @answer = @question.answers.new
  end

  def create
    @answer = @question.answers.create(answer_params)
    if @answer.save
      flash[:notice] = 'Ответ создан'
      redirect_to question_path(@question)

    else
      flash[:alert] = 'Ответ не создан'
      render :new
    end
  end

  private
  def load_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end

end