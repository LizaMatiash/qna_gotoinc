class Api::V1::BaseController < ApplicationController
  before_action :doorkeeper_authorize!

  respond_to :json

  # def current_ability
  #   @current_ability ||= Ability.new(current_resource_owner)
  # end

  private

  def current_resource_owner
    @current_resource_owner ||= User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end
end
