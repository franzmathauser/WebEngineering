module ApplicationHelper
  
  def logo
    image_tag("logo.png", :alt => "LOGO!!!", :class => "round")
  end

  def title
    base_title = "WaveCloud"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
  
end
