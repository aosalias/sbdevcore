class PhotosController < SbdevCoreController
  before_filter :authenticate_admin!, :except => :show
  skip_before_filter :get_index
  belongs_to :index, :optional => true
end
