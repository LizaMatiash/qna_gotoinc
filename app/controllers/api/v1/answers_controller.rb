class Api::V1::AnswersController < Api::V1::BaseController
  before_action :load_answer, only: [:show]

  def index
    @question = Question.find(params[:question_id])
    @answers = Answer.where(question_id: @question)
    respond_with @answers
  end

  def show
    respond_with @answer
  end

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(answer_params)
    @answer.user = current_resource_owner
    respond_with @answer if @answer.save
  end

  private

  def load_answer
    # byebug
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body, attachments_attributes: [:file])
  end
end
