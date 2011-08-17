class PhotosController < ApplicationController
  before_filter :authenticate_admin!, :except => [:show, :overlay]
  def index
    @photos = Photo.all
  end
  
  def show
    @photo = Photo.find(params[:id])
    render :layout => false
  end
  
  def new
    @index = Index.find(params[:index_id])
    @photo = @index.photos.build(:priority => ((@index.assets.first.lowest_priority + 1) rescue 0))
    render :layout => false
  end
  
  def create
    @photo = Photo.new(params[:photo])
    if @photo.save
      flash[:notice] = "Successfully created photo."
      redirect_to :back
    else
      render :action => 'new'
    end
  end
  
  def edit
    @photo = Photo.find(params[:id])
    render :layout => false
  end
  
  def update
    @photo = Photo.find(params[:id])
    if @photo.update_attributes(params[:photo])
      flash[:notice] = "Successfully updated photo."
      redirect_to :back
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    flash[:notice] = "Successfully destroyed photo."
    redirect_to :back
  end
end
