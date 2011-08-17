# These helper methods can be called in your template to set variables to be used in the layout
# This module should be included in all views globally,
# to do so you may need to add this line to your ApplicationController
#   helper :layout
module LayoutHelper
  def title(page_title)
    @content_for_title = page_title.to_s
  end

  def keywords(keywords)
    @content_for_keywords = keywords
  end

  def description(description)
    @content_for_description = description
  end
  
  def render_side_section(section)
    content_for(:side_section) {
      render :partial => 'application/side_section', :locals => {:section => section}
    }
  end
  
  def render_seo(index)
    title index.page_title unless index.page_title.blank?
    keywords index.keywords unless index.keywords.blank?
    description index.page_description unless index.page_description.blank?
  end
  
  def stylesheet(*args)
    content_for(:head) { stylesheet_link_tag(*args) }
  end
  
  def javascript(*args)
    content_for(:head) { javascript_include_tag(*args) }
  end
end
