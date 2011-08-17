class Text < ActiveRecord::Base
  belongs_to :index
  attr_accessible :content, :index_id

  include ActsAsPrioritizable
  acts_as_prioritizable("index", "assets")
end
