class Asset < ActiveRecord::Base
  attr_accessible :title, :asset, :asset_file_name, :asset_content_type, :asset_file_size, :owner_id, :owner_type, :klass, :author, :remote_id, :remote_type, :description
  belongs_to :owner, :polymorphic => true

#  include ActsAsPrioritizable
#  acts_as_prioritizable("owner","assets")

  def name
    title.nil? ? "" : title
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
