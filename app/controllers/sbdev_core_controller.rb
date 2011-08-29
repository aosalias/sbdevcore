class SbdevCoreController < InheritedResources::Base
  protect_from_forgery

  respond_to :html

  before_filter :authenticate_admin!, :except => [:show, :index]
  before_filter :get_index, :only => [:index]

  layout "application"

  def show
    show!(:layout => !request.xhr?)
  end

  def new
    new!(:layout => !request.xhr?)
  end

  def create
    create!{ request.referer }
  end

  def edit
    edit!(:layout => !request.xhr?)
  end

  def update
    update!{ request.referer }
  end

  def destroy
    destroy!{ request.referer }
  end

  private

  def get_index
    @index = Index.find_by_name(controller_name)
  end
end
