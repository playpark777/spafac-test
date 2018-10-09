class ProfilesController < BaseProfilesController
  before_action :authenticate_user!, except: [:show]
  
  authorize_resource

  # GET /profiles/1
  # GET /profiles/1.json
  def show
    @listings = Listing.mine(@profile.user_id).order_by_updated_at_desc
    #@reviewed = Review.they_do(@profile.user_id).order_by_updated_at_desc
    @reviewed = Review.they_do(@profile.user_id).joins(:reservation).merge(Reservation.review_open?).order_by_updated_at_desc
  end

  # GET /profiles/new
  def new
    @profile = Profile.new
  end

  # POST /profiles
  # POST /profiles.json
  def create
    @profile = Profile.new(profile_params)
    respond_to do |format|
      if @profile.save
        format.html { redirect_to @profile, notice: 'Profile was successfully created.' }
        format.json { render :show, status: :created, location: @profile }
      else
        format.html { render :new }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to set_return_page_source, notice: I18n.t('alerts.profile.save.success', model: Profile.model_name.human) }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to profiles_url, notice: 'Profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def review

  end

  def introduction

  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = Profile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.require(:profile).permit(
        :id, :user_id, :first_name, :last_name, :birthday,
        :phone, :phone_verification, :location, :self_introduction,
        :school, :work, :timezone, :gender, :zipcode,
        :listing_count, :wishlist_count, :bookmark_count, :reviewed_count, :reservation_count,
        :ave_total, :ave_accuracy, :ave_communication, :ave_cleanliness, :ave_location,
        :ave_check_in, :ave_cost_performance, :created_at, :updated_at
      ).merge(user_id: current_user.id)
    end
end
