class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :authorize_user, except: [:index, :show, :new, :create]

  def index
    @questions = Question.all
  end

  def show
    @question = Question.find(params[:id])
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @question = Question.new
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @question = @topic.questions.build(question_params)
    @question.user = current_user

    if @question.save
      flash[:notice] = "Question was saved successfully."
      redirect_to [@topic, @question]
    else
      flash.now[:alert] = "There was an error saving the question. Please try again."
      redirect_to :new
    end
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])
    @question.assign_attributes(question_params)

    if @question.save
      flash[:notice] = "Question was updated successfully."
      redirect_to [@question.topic, @question]
    else
      flash.now[:alert] = "There was an error updating the question. Please try again."
      redirect_to :edit
    end
  end

  def destroy
    @question = Question.find(params[:id])

    if @question.destroy
      flash[:notice] = "\"#{@question.title}\" was deleted successfully."
      redirect_to @question.topic
    else
      flash.now[:alert] = "There was an error deleting the question."
      render :show
    end
  end

  private

  def question_params
    params.require(:question).permit(:title, :body)
  end

  def authorize_user
    question = Question.find(params[:id])

    unless current_user == question.user || current_user.admin?
      flash[:alert] = "You must be an admin to do that."
      redirect_to [question.topic, question]
    end
  end
end
