class AlbumPage < Nanoc3::Filter

  identifier :album_page

  def run(filename, params={})
    p filename
    return filename
  end

end
