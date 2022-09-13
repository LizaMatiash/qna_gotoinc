class AnswersController < ApplicationController
  before_action :authenticate_user!
  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(answer_params)
    @answer.user_id = current_user.id
    # if @answer.save
    #   redirect_to @question
    # else
    #   redirect_to @question, notice: "Body can't be blank"
    # end
    @answer.save
    # redirect_to @question
  end

  def destroy
    @answer = Answer.find(params[:id])
    @question = @answer.question
    if current_user.id == @answer.user_id
      @answer.destroy
      redirect_to @question, notice: 'Your answer successfully destroyed.'
    else
      redirect_to @question, notice: 'Your can`t destroy not your question.'
    end

  end

  private
  def answer_params
    params.require(:answer).permit(:body)

  end

end
