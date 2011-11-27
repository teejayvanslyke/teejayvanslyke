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

module Nanoc3
  class Site
    MUSIC_PATH = "/Volumes/Hawthorne/Music\ Archive"
    def music
      Dir["#{MUSIC_PATH}/*"].map do |year|
        {
          :year => year,
          :releases => Dir["#{year}/*"].map {|release| { :title => File.basename(release), :path => release } }
        }
      end
    end
  end
end

class Song
end

class Album
  def self.all
    @all = YAML.load_file($root + 'albums.yaml')
  end

  def self.recent
    @recent = all.sort {|a, b| b['created_at'] <=> a['created_at']}
  end
end

