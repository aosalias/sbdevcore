class IndicesController < SbdevCoreController
  before_filter :authenticate_admin!, :only => [:index]
  nested_belongs_to :gallery, :polymorphic => true, :optional => true
end
