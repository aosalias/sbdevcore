class TextsController < ApplicationController
  before_filter :authenticate_admin!
  def index
    @texts = Text.all
  end
  
  def show
    @text = Text.find(params[:id])
  end
  
  def new
    @index = Index.find(params[:index_id])
    @text = @index.texts.build(:priority => ((@index.texts.first.lowest_priority + 1) rescue 0))
    render :layout => false
  end
  
  def create
    @text = @owner.texts.build(params[:text])
    if @owner.save
      flash[:notice] = "Successfully created text."
      redirect_to :back
    else
      render :action => 'new'
    end
  end
  
  def edit
    @text = Text.find(params[:id])
    render :layout => false
  end
  
  def update
    @text = Text.find(params[:id])
    if @text.update_attributes(params[:text])
      flash[:notice] = "Successfully updated text."
      redirect_to :back
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @text = Text.find(params[:id])
    @text.destroy
    flash[:notice] = "Successfully destroyed text."
    redirect_to :back
  end
end
