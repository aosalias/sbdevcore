class Downloadable < ActiveRecord::Base
  belongs_to :index
  attr_accessible :name, :description, :asset, :asset_file_name, :asset_content_type, :asset_file_size, :owner_id, :owner_type

  include ActsAsPrioritizable
  acts_as_prioritizable("index", "assets")

  has_attached_file :asset,
    :storage => :s3,
    :s3_credentials => Rails.root.join("config", "s3.yml"),
    :bucket => APP_CONFIG[:bucket_name],
    :path => "/downloadables/#{Rails.env}/:id/:filename"

  before_post_process :transliterate_file_name

  def thumb
    asset.url(:thumb)
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
end
