class Gallery < ActiveRecord::Base
  attr_accessible :title
  belongs_to :index

  has_many :indices, :as => :owner, :dependent => :destroy

  accepts_nested_attributes_for :indices, :allow_destroy => true

  def name
    title.downcase.gsub(" ", "_")
  end
end
