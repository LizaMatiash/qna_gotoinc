class AttachmentsController < ApplicationController
  before_action :authenticate_user!

  def destroy
    authorize! :destroy, ActiveStorage::Attachment
    @file = Attachment.find(params[:id])
    respond_with(@file.destroy)
  end
end
