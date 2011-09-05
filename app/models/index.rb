class Index < ActiveRecord::Base
  attr_accessible :name, :title, :page_title, :keywords, :page_description, :texts_attributes, :photos_attributes, :videos_attributes, :downloadables_attributes, :gallery_attributes

  delegate :asset, :to => :"photos.first", :allow_nil => true
  alias_method :photo, :asset

  before_validation :default_name

  extend FriendlyId
  friendly_id :name, :use => :slugged

  include ActsAsPrioritizable
  acts_as_prioritizable("owner", "indices")
  default_scope :order => 'priority ASC'
  after_initialize do
    self.priority ||= lowest_priority + 1
  end

  has_many :indices, :as => :owner, :dependent => :destroy
  belongs_to :owner, :polymorphic => true

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

  validates_presence_of :title

  def assets
    (texts + photos + videos + downloadables).sort_by{|a| a.priority || 99}
  end

  def default_name
    self.name ||= self.title.tableize
  end
end
