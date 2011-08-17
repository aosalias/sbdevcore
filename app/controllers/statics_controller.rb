class StaticsController < ApplicationController
  def show
    @index = Index.find_by_name(params[:page])
    render "indices/show"
  end
end
