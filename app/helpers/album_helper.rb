module AlbumHelper
   def active_class(link_path)
    current_page?(link_path) ? "active" : ""
  end
  def display_photo_count(album, photos)
    if params[:page].nil? && photos.count > 0
      "Showing 1 to " + photos.count.to_s + " from " + album.photos.count.to_s + " photos"
    else
      "Showing " + ( ( ( params[:page].to_i - 1 ) * 32 ) + 1 ).to_s + " to "  + ( ( 32 * (params[:page].to_i - 1)) + photos.count ).to_s + " from " + album.photos.count.to_s + " photos"
    end
  end
end