class Api::V1::QuestionsController < Api::V1::BaseController
  before_action :load_question, only: [:show]
  respond_to :json
  

  def index
    @questions = Question.all
    respond_with @questions
  end

  def show
    respond_with @question
  end

  def create
    @question = Question.new(questions_params)
    @question.user_id = current_resource_owner.id
    respond_with @question if @question.save
  end

  private

  def load_question
    # byebug
    @question = Question.find(params[:id])
  end

  def questions_params
    params.require(:question).permit(:title, :body, attachments_attributes: [:file])
  end
end
