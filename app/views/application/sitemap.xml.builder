xml.instruct!

xml.urlset "xmlns" => "http://www.google.com/schemas/sitemap/0.84" do
  xml.url do
    xml.loc         root_url
    xml.lastmod     w3c_date(Time.now)
    xml.changefreq  "weekly"
    xml.priority    1.0
  end
end