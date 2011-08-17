class GalleriesController < ApplicationController
  uses_tiny_mce :only => [:new, :edit]
  before_filter :authenticate_admin!, :except => [:index, :show]
  before_filter :get_index, :only => [:index]

  def index
    @galleries = Gallery.all
  end
  
  def show
    @gallery = Gallery.find(params[:id])
    @index = @gallery.index
    @photo = @gallery.photos.first
  end
  
  def new
    @gallery = Gallery.new
    @gallery.build_index
  end
  
  def create
    @gallery = Gallery.new(params[:gallery])
    if @gallery.save
      flash[:notice] = "Successfully created gallery."
      redirect_to @gallery
    else
      render :action => 'new'
    end
  end
  
  def edit
    @gallery = Gallery.find(params[:id])
  end
  
  def update
    @gallery = Gallery.find(params[:id])
    if @gallery.update_attributes(params[:gallery])
      flash[:notice] = "Successfully updated gallery."
      redirect_to @gallery
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @gallery = Gallery.find(params[:id])
    @gallery.destroy
    flash[:notice] = "Successfully destroyed gallery."
    redirect_to galleries_url
  end
end
