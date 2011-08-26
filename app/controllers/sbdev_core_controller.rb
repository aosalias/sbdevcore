class SbdevCoreController < InheritedResources::Base
  protect_from_forgery

  respond_to :html, :js

  before_filter :authenticate_admin!, :except => [:show, :index]
  before_filter :get_index, :only => [:index]

  layout "application"

  def create
    create! do |format|
      format.html { redirect_to :back }
    end
  end

  def update
    update! do |format|
      format.html { redirect_to :back }
    end
  end

  def destroy
    destroy! do |format|
      format.html { redirect_to :back }
    end
  end

  private

  def get_index
    @index = Index.find_by_name(controller_name)
  end
end
