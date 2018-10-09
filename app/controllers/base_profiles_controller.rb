class BaseProfilesController < ApplicationController
  before_action :set_profile, only: [:show]
  before_action :set_my_profile, only: [:edit, :update, :destroy]
    
  def return_listing
    if params[:listing_id].present?
      listing_id = params[:listing_id]
      if listing_id.present? && Listing.exists?(listing_id)
        session[:listing_id] = listing_id.to_i
      end
    end
    redirect_to controller: params[:controller], action: 'edit'
  end
  
  protected
    def set_my_profile
      @profile = Profile.find(current_user.profile.id)
    end

    def set_return_page_source
      if session[:listing_id].present? && Listing.exists?(session[:listing_id])
        @return_path = listing_path(session[:listing_id])
        session[:listing_id] = nil
      else
        @return_path = profile_path(@profile.id)
      end
      @return_path
    end
end
