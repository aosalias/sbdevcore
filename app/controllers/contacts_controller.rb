class ContactsController < SbdevCoreController
  before_filter :authenticate_admin!, :except => [:new, :create]
  before_filter :get_index, :only => :new
end
