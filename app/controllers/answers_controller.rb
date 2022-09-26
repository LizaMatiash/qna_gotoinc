class AnswersController < ApplicationController
  before_action :authenticate_user!
  after_action :publish_answer, only: [:create]

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(answer_params)
    @answer.user_id = current_user.id
    @answer.position = 2
    @answer.save
    @comment = @answer.comments.new

  end

  def update
    @answer = Answer.find(params[:id])
    @answer.update(answer_params)
    @question = @answer.question
    @answers = Answer.where(question_id: @question)
    @answers = @answers.order(position: :asc)
  end

  def position
    @answer = Answer.find(params[:id])
    @question = @answer.question
    @answers = Answer.where(question_id: @question)
    @answers.each do |ans|
      if ans.position == 1
        ans.position = 2
        ans.save
      end
    end
    @answer.position = 1
    @answer.save
    @answers = @answers.order(position: :asc)
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

  def publish_answer
   return if @answer.errors.any?
   gon.question_id = @answer.question_id
   gon.user_id = current_user.id
   gon.question_owner_id = @answer.question.user_id
   @files = []
   @answer.attachments.each do |file|
     @files << {name: file.filename.to_s, url: url_for(file), id: file.id}

   end
   ActionCable.server.broadcast(
     "question_#{@question.id}",
     {
       type: 'answer',
       answer: @answer,
       files: @files,
       rating: @answer.rating()
     }
   )
 end


  def answer_params
    params.require(:answer).permit(:body, attachments_attributes: [:file])

  end

end
