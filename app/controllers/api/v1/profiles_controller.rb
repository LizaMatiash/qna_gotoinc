class Api::V1::ProfilesController < Api::V1::BaseController

  def me
    render json: current_resource_owner
  end

  def exept_me
    render json: exept_current_resource_owner
  end

  protected

  def exept_current_resource_owner
    @current_resource_owner ||= User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
    @exept_current_resource_owner ||= User.all.except(@current_resource_owner)
  end
end
