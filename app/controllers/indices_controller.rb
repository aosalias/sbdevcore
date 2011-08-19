class IndicesController < ApplicationController
  before_filter :authenticate_admin!, :except => [:show]

  def index
    @indices = Index.all
  end
  
  def show
    @index = Index.find(params[:id])
  end
  
  def new
    @index = Index.new
  end
  
  def create
    @index = Index.new(params[:index])
    if @index.save
      flash[:notice] = "Successfully created index."
      redirect_to :back
    else
      render :action => 'new'
    end
  end
  
  def edit
    @index = Index.find(params[:id])
  end

  def update
    @index = Index.find(params[:id])
    if @index.update_attributes(params[:index])
      flash[:notice] = "Successfully updated index."
      redirect_to :back
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @index = Index.find(params[:id])
    @index.destroy
    flash[:notice] = "Successfully destroyed index."
    redirect_to indices_url
  end
end
