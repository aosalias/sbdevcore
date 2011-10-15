class GalleriesController < SbdevCoreController
  before_filter :authenticate_admin!
  skip_before_filter :get_index
  nested_belongs_to :index, :singleton => true
end
