class IndicesController < SbdevCoreController
  before_filter :authenticate_admin!, :only => [:index]
end
