class Gallery < ActiveRecord::Base
  belongs_to :index

  has_many :indices, :as => :owner, :dependent => :destroy, :order => "priority ASC"

  accepts_nested_attributes_for :indices, :allow_destroy => true
end
