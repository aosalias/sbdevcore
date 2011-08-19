class DownloadablesController < ApplicationController
  before_filter :authenticate_admin!, :except => [:show]
  OpenURI::Buffer::StringMax = 1000

  def index
    @downloadables = Downloadable.all
  end
  
  def show
    @downloadable = Downloadable.find(params[:id])
    send_data(@downloadable.asset.url, :filename => @downloadable.asset_file_name, :type => @downloadable.asset_content_type, :disposition => 'attachment')
  end
  
  def new
    @index = Index.find(params[:index_id])
    @downloadable = @index.downloadables.build(:priority => ((@index.assets.first.lowest_priority + 1) rescue 0))
    render :layout => false
  end
  
  def create
    @downloadable = Downloadable.new(params[:downloadable])
    if @downloadable.save
      flash[:notice] = "Successfully created downloadable."
      redirect_to :back
    else
      render :action => 'new'
    end
  end
  
  def edit
    @downloadable = Downloadable.find(params[:id])
    render :layout => false
  end
  
  def update
    @downloadable = Downloadable.find(params[:id])
    if @downloadable.update_attributes(params[:downloadable])
      flash[:notice] = "Successfully updated downloadable."
      redirect_to :back
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @downloadable = Downloadable.find(params[:id])
    @downloadable.destroy
    flash[:notice] = "Successfully destroyed downloadable."
    redirect_to :back
  end
end
