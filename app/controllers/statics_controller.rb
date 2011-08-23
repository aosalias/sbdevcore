class StaticsController < ApplicationController
  def show
    @index = Index.find_by_name(params[:page])
    render "indices/index"
  end
end
