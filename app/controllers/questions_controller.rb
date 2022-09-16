class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: %i[new edit update destroy create]
  before_action :load_question, only: %i[show edit update destroy]

  def index
    @questions = Question.all
  end

  def show
    @answers = @question.answers
    @answers = @answers.order(position: :asc)
    @answer = Answer.new
    @answer.attachments.build
  end

  def new
    @question = Question.new
    @question.attachments.build
  end

  def edit
  end

  def create
    @question = Question.new(questions_params)
    @question.user_id = current_user.id
    if @question.save
      redirect_to @question, notice: 'Your question successfully created.'
    else
      render :new
    end

  end

  def update
    @question.update(questions_params)
  end

  def destroy
    if current_user.id == @question.user_id
      @question.destroy
      redirect_to questions_path, notice: 'Your question successfully destroyed.'
    else
      redirect_to questions_path, notice: 'Your can`t destroy not your question.'
    end
  end

  protected

  def load_question
    @question = Question.find(params[:id])
  end

  def questions_params
    params.require(:question).permit(:title, :body, attachments_attributes: [:file])
  end

end
