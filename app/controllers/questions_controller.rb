class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: %i[new edit update destroy create]
  before_action :load_question, only: %i[show edit update destroy]
  before_action :build_answer, only: %i[show]
  after_action :publish_question, only: [:create]

  respond_to :html

  def index
    respond_with(@questions = Question.all)
  end

  def show
    respond_with @question
  end

  def new
    respond_with (@question = Question.new)
  end

  def edit
  end

  def create
    @question = Question.new(questions_params)
    @question.user_id = current_user.id
    flash[:notice] = 'Your question successfully created.' if @question.save
    respond_with @question
  end

  def update
    @question.update(questions_params)
    respond_with @question
  end

  def destroy
    if current_user.id == @question.user_id
      flash[:notice] = 'Your question successfully destroyed.'
      respond_with(@question.destroy)
    else
      redirect_to questions_path, notice: 'Your can`t destroy not your question.'
    end
  end

  protected

  def build_answer
    @answers = @question.answers.order(position: :asc)
    @answer = Answer.new
    @comment = @answer.comments.new
    @vote = Vote.new
  end

  def publish_question
    return if @question.errors.any?
    ActionCable.server.broadcast 'questions',
     { id: @question.id, title: @question.title, body: @question.body }
  end

  def load_question
    @question = Question.find(params[:id])
    gon.question_id = @question.id
    gon.user_id = current_user.id if current_user
    gon.question_owner_id = @question.user_id
  end

  def questions_params
    params.require(:question).permit(:title, :body, attachments_attributes: [:file])
  end

end
