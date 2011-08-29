class Index < ActiveRecord::Base
  attr_accessible :name, :title, :page_title, :keywords, :page_description, :texts_attributes, :photos_attributes, :videos_attributes, :downloadables_attributes, :gallery_attributes

  has_many :indices, :as => :owner, :dependent => :destroy
  belongs_to :owner, :polymorphic => true

  extend FriendlyId
  friendly_id :name, :use => :slugged

  has_one :gallery, :dependent => :destroy

  has_many :texts, :dependent => :destroy
  has_many :photos, :dependent => :destroy
  has_many :videos, :dependent => :destroy
  has_many :downloadables, :dependent => :destroy

  accepts_nested_attributes_for :videos, :reject_if => lambda { |a| a[:remote_id].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :photos, :reject_if => lambda { |a| a[:asset].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :downloadables, :reject_if => lambda { |a| a[:asset].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :texts, :reject_if => lambda { |a| a[:content].blank?}, :allow_destroy => true

  accepts_nested_attributes_for :gallery, :allow_destroy => true

  def assets
    (texts + photos + videos + downloadables).sort_by{|a| a.priority || 99}
  end
end
