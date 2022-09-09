class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: %i[new edit update destroy create]
  before_action :load_question, only: %i[show edit update destroy]

  def index
    @questions = Question.all
  end

  def show
    @answers = @question.answers
    @answer = Answer.new
  end

  def new
    @question = Question.new
  end

  def edit
  end

  def create
    @question = Question.new(questions_params)
    @question.user_id = current_user.id
    if @question.save
      redirect_to @question
    else
      render :new
    end

  end

  def update
    @question.update(questions_params)
    if @question.save
      redirect_to @question
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    redirect_to questions_path
  end

  protected

  def load_question
    @question = Question.find(params[:id])
  end

  def questions_params
    params.require(:question).permit(:title, :body)
  end

end
