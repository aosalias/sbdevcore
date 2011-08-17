class Video < ActiveRecord::Base
  belongs_to :index
  attr_accessible :name, :description, :index_id, :remote_id, :remote_type

  include ActsAsPrioritizable
  acts_as_prioritizable("index", "assets")

  def url
    case remote_type
      when "Youtube" then "http://www.youtube.com/v/"
      when "Facebook" then "http://www.facebook.com/v/"
    end + remote_id
  end

  def thumb
    case remote_type
      when "Youtube" then "http://img.youtube.com/vi/" + remote_id + "/1.jpg"
    end
  end
end

