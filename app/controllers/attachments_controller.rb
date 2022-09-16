class AttachmentsController < ApplicationController
  before_action :authenticate_user!

  def destroy
    @file = Attachment.find(params[:id])
    # if @file.attachmentable_type == 'Answer'
    #   @answer = Answer.where(id: @file.attachmentable_id)
    #   @question = @answer.question
    # else
    #   @question = Question.where(id: @file.attachmentable_id)
    # end
    @file.destroy
    # redirect_to @question

  end

end
