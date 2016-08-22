class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user, only: [:destroy]

  def create
    @question = Question.find(params[:question_id])
    answer = @question.answers.new(answer_params)
    answer.user = current_user

    if answer.save
      flash[:notice] = "Answer saved successfully."
      redirect_to [@question.topic, @question]
    else
      flash[:alert] = "Answer failed to save."
      redirect_to [@question.topic, @question]
    end
  end

  def destroy
    @question = Question.find(params[:question_id])
    answer = Answer.find(params[:id])

    if answer.destroy
      flash[:notice] = "Answer was deleted successfully."
      redirect_to [@question.topic, @question]
    else
      flash[:alert] = "Answer couldn't be deleted. Try again."
      redirect_to [@question.topic, @question]
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end

  def authorize_user
    answer = Answer.find(params[:id])
    unless current_user == answer.user || current_user.admin?
      flash[:alert] = "You do not have permission to delete this answer."
      redirect_to [answer.question.topic, answer.question]
    end
  end
end
