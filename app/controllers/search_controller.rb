class SearchController < ApplicationController
  authorize_resource

  def search
    if params[:query].present?
      @results = Search.filter(params[:query], condition: params[:condition])
    else
      @results = []
    end
    respond_with @results
  end
end
