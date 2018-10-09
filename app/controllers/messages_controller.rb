class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_message, only: [:show, :edit, :update, :destroy]

=begin
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
=end

  def create
    if res = MessageThread.exists_thread?(message_params)
      mt_obj = MessageThread.find(res)
    else
      mt_obj = MessageThread.create_thread(message_params)
    end
    respond_to do |format|
      if Message.send_message(mt_obj, message_params)
        reservation_params = params['reservation']

        if reservation_params.present? && reservation_params['progress'].present?
          @reservation = Reservation.find(reservation_params['id'])
          @reservation.progress = reservation_params['progress']
          unless @reservation.save
            format.html { return redirect_to dashboard_path, notice: I18n.t('message.save.failure') }
            format.json { return render json: { success: false } } if request.xhr?
          end
          if @reservation.accepted? || @reservation.rejected? || @reservation.holded? || @reservation.canceled?
            #ReservationMailer.send_update_reservation_notification(@reservation, current_user.id).deliver_later!(wait: 1.minute) # if you want to use active job, use this line.
            ReservationMailer.send_update_reservation_notification(@reservation, current_user.id).deliver_now! # if you don't want to use active job, use this line.
          else
            #MessageMailer.send_new_message_notification(mt_obj, message_params).deliver_later!(wait: 1.minute) # if you want to use active job, use this line.
            MessageMailer.send_new_message_notification(mt_obj, message_params).deliver_now! # if you don't want to use active job, use this line.
          end
        else
          #MessageMailer.send_new_message_notification(mt_obj, message_params).deliver_later!(wait: 1.minute) # if you want to use active job, use this line.
          MessageMailer.send_new_message_notification(mt_obj, message_params).deliver_now! # if you don't want to use active job, use this line.
        end
        format.html { return redirect_to message_thread_path(mt_obj.id), notice: I18n.t('message.save.success') }
        format.json { return render json: { success: true } } if request.xhr?
      else
        format.html { return redirect_to message_thread_path(mt_obj.id), alert: I18n.t('message.save.failure') }
        format.json { return render json: { success: false } } if request.xhr?
      end
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(
        :message_thread_id,
        :from_user_id,
        :to_user_id,
        :checkin,
        :checkout,
        :num_of_people,
        :content,
        :progress,
        :read,
        :reservation_id,
        :listing_id
      )
    end
end
