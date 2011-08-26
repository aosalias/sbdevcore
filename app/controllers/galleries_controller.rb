class GalleriesController < SbdevCoreController
  before_filter :authenticate_admin!
  skip_before_filter :get_index
  belongs_to :index, :optional => true
end
