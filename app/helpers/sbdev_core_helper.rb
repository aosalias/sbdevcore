# These helper methods can be called in your template to set variables to be used in the layout
# This module should be included in all views globally,
# to do so you may need to add this line to your ApplicationController
#   helper :layout
module SbdevCoreHelper
  def render_seo(index)
    content_for(:title, index.try("page_title"))
    content_for(:keywords, index.try("keywords"))
    content_for(:page_description, index.try("page_description"))
  end
end
