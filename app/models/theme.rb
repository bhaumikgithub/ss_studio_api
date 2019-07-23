class Theme < ApplicationRecord
	serialize :color_theme
  store_accessor :color_theme, :header_links, :normal_links, :footer_links, :title_color, :normal_text_color, :header_background, :body_background, :footer_background, :bullet_icon_color, :image_overlay_font_color, :header_title_color, :hover_header_link, :active_header_link
  belongs_to :user
end