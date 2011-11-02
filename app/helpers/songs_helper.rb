module SongsHelper

  # Return a wave image
  def audioimage
    base_title = "Ruby on Rails Tutorial Sample App"
    if @audio.imageprocessed == false
      asset_path "std_audioimage.png"
    else
      asset_path @audioimage_path
    end
  end 

end
