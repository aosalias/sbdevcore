class Photo < ActiveRecord::Base
  belongs_to :index
  attr_accessible :name, :description, :asset, :asset_file_name, :asset_content_type, :asset_file_size, :klass

  validates_presence_of :name, :asset

  include ActsAsPrioritizable
  acts_as_prioritizable("index", "assets")

  after_initialize :defaults

  has_attached_file :asset,
    :styles => {
      :original => "1000>",
      :medium => "400>",
      :thumb => "200>"
    },
    :storage => :s3,
    :s3_credentials => "#{Rails.root}/config/s3.yml",
    :bucket => APP_CONFIG[:bucket_name],
    :path => "/photos/#{Rails.env}/:id/:style_:filename",
    :default_url => "/photos/default/:style_missing.jpg",
    :convert_options => {:all => "-auto-orient"}

  before_post_process :transliterate_file_name

  def thumb
    asset.url(:thumb)
  end

  def klass
    read_attribute(:klass).nil? ? "" : read_attribute(:klass)
  end

  def which?
    case klass
      when "center" then return :original
      when "left" then return :medium
      when "right" then return :medium
      when "thumb" then return :thumb 
    end
  end

  def transliterate(str)
    s = Iconv.iconv('ascii//ignore//translit', 'utf-8', str).to_s
    s.downcase!
    s.gsub!(/'/, '')
    s.gsub!(/[^A-Za-z0-9]+/, ' ')
    s.strip!
    s.gsub!(/\ +/, '-')
    s
  end

  def transliterate_file_name
    extension = File.extname(asset_file_name).gsub(/^\.+/, '')
    filename = asset_file_name.gsub(/\.#{extension}$/, '')
    self.asset.instance_write(:file_name, "#{transliterate(filename)}.#{transliterate(extension)}")
  end

  def defaults
    self.klass ||= "center"
  end
end
