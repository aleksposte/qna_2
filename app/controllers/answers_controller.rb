class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_question
  before_action :load_answer, only: [:destroy]

  def create
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    if @answer.save
      flash[:notice] = 'Your answer successfully created.'
    else
      flash[:alert] = 'Your answer has an error.'
    end
  end

  def update
    @answer.update(answer_params) if current_user.author_of?(@answer)
  end

  def destroy
    if current_user.author_of? @answer
      @answer.destroy
    else
      flash[:alert] =  "Your can`t delete others answer"
    end
    redirect_to @answer.question
  end

  def set_best_answer
    if current_user.author_of?(@question)
       @answer.set_best_answer
       flash[:notice] = "You've set the best answer"
    else
       flash[:alert] = "You're not allowed to set the best answer for this question"
    end
  end

  private

  def load_question
    @question = Question.find(params[:question_id])
  end

  def load_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body, attachments_attributes: [:id, :file, :_destroy])
  end
end
