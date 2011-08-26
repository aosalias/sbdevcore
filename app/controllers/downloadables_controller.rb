class DownloadablesController < SbdevCoreController
  before_filter :authenticate_admin!, :except => :show
  skip_before_filter :get_index
  belongs_to :index, :optional => true

  def show
    show! do |format|
      format.html {send_data(@downloadable.asset.url, :filename => @downloadable.asset_file_name, :type => @downloadable.asset_content_type, :disposition => 'attachment')}
    end
  end
end
