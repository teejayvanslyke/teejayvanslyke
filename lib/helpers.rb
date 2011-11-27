include Nanoc3::Helpers::Rendering
include Nanoc3::Helpers::Blogging
include Nanoc3::Helpers::Capturing

require 'pismo'

def share_url(url)
  pismo = Pismo[url]
  %{<div class="share_url">
    <div class="title"><a href="#{url}">#{pismo.title}</a></div>
    <div class="description">#{pismo.description}</div>
    <div class="thumbnail"><img src="#{thumbnail_for_url(url)}"/></div>
    </div>}
end

def thumbnail_for_url(url)
  pismo = Pismo[url]
  images = pismo.doc.css('img')
  images.first['src']
end

