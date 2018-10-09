class WelcomeController < ApplicationController
  def index
    @top_page_cover_images = TopPageCoverImage.all.order_by_order_num_asc
    @top_page_cover_tagline = TopPageCoverTagline.first
    @top_page_discovery_images = TopPageDiscoveryImage.all.order_by_order_num_asc
    @top_page_belt_image = TopPageBeltImage.first
  end
end
