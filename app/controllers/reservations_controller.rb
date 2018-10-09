class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_identification!, only: [:create, :update]
  before_action :set_reservation, only: [:show, :update, :destroy]
  authorize_resource

  def create
    @reservation = Reservation.new(reservation_params)
    profile_id = User.user_id_to_profile_id(@reservation.guest_id)
    return redirect_to return_listing_profile_path(listing_id: @reservation.listing.id), notice: I18n.t('alerts.reservation.requirement.profile.not_yet', model: Profile.model_name.human) unless Profile.minimun_requirement?(@reservation.guest_id)
    return redirect_to return_listing_profile_profile_image_path(listing_id: @reservation.listing.id), notice: I18n.t('alerts.reservation.requirement.profile_image.not_yet', model: ProfileImage.model_name.human) unless Profile.minimun_requirement?(@reservation.guest_id)

    respond_to do |format|
      if @reservation.save
        # ReservationMailer.send_new_reservation_notification(@reservation).deliver_later!(wait: 1.minute) # if you want to use active job, use this line.
        ReservationMailer.send_new_reservation_notification(@reservation).deliver_now! # if you don't want to use active job, use this line.

        msg_params = Hash[
          'reservation_id' => @reservation.id,
          'listing_id' => @reservation.listing_id,
          'from_user_id' => @reservation.guest_id,
          'to_user_id' => @reservation.host_id,
          'progress' => @reservation.progress,
          'checkin' => @reservation.checkin,
          'checkout' => @reservation.checkout,
          'num_of_people' => @reservation.num_of_people,
          'content' => I18n.t('alerts.reservation.msg.request', model: Message.model_name.human)
        ]

        if res = MessageThread.exists_thread?(msg_params)
          mt_obj = MessageThread.find(res)
        else
          mt_obj = MessageThread.create_thread(msg_params)
        end

        if Message.send_message(mt_obj, msg_params)
          format.html { redirect_to dashboard_guest_reservation_manager_path, notice: I18n.t('alerts.reservation.save.success', model: Reservation.model_name.human, host: I18n.t('name.host'), msg: Message.model_name.human) }
          format.json { render :show, status: :created, location: @reservation }
        else
          format.html { redirect_to listing_path(@reservation.listing_id), notice: I18n.t('alerts.reservation.save.failure.no_date', model: Reservation.model_name.human) }
          format.json { render json: @reservation.errors, status: :unprocessable_entity }
        end
      else
        format.html { redirect_to listing_path(@reservation.listing_id), notice: I18n.t('alerts.reservation.save.failure.no_date', model: Reservation.model_name.human) }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @reservation.update(reservation_params)
        format.html { redirect_to dashboard_guest_reservation_manager_path(@listing, @reservation), notice: I18n.t('alerts.reservation.update.success') }
        format.json { render :show, status: :ok, location: @reservation }
      else
        format.html { render :edit }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    def reservation_params
      params.require(:reservation).permit(
        :listing_id,
        :host_id,
        :guest_id,
        :num_of_people,
        :content,
        :progress,
        :reason,
        :checkin,
        :checkout
      )
    end
end
