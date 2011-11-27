include Nanoc3::Helpers::Rendering
include Nanoc3::Helpers::Blogging
include Nanoc3::Helpers::Capturing

require 'pismo'

$root = File.dirname(__FILE__) + '/../'

$pismos = {}

def pismo(url)
  $pismos[url] ||= Pismo[url]
end

def share_url(url)
  pismo = pismo(url)
  %{<div class="share_url">
    <div class="thumbnail"><img src="#{thumbnail_for_url(url)}"/></div>
    <div class="title"><a href="#{url}">#{pismo.title}</a></div>
    <div class="description">#{pismo.description}</div>
    </div>}
end

def thumbnail_for_url(url)
  pismo = pismo(url)
  uri   = URI.parse(url)
  if (image_src = pismo.doc.css('link[rel=image_src]').first)
    return image_src['href']
  end
end


class Song
  attr_reader :attributes

  def method_missing(name, *args)
    return self.attributes[name.to_s]
  end

end

module Nanoc3
  class Site
    def albums
      self.items.select {|i| i[:kind] == 'album'}.sort {|a, b| b[:created_at] <=> a[:created_at]}
    end
  end
end

