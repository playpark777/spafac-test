class ListingOkeventsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :search]
  before_action :set_my_event, only: [:edit, :update, :destroy]
  before_action :set_listing
  authorize_resource :user_okevent

  # GET /listings/1/ngevents.json
  def index
    @okevents = UserOkevent.mine(current_user).where(listing_id: params[:listing_id])
  end

  # GET /listings/1/ngevents/search.json
  def search
    reference_date = DateTime.parse(params[:first_day])

    reservable_days = UserOkevent.get_reservable_days(params[:listing_id])
    # Twitter BootstrapによるOptionに選択可能というオプションが無いため選択不可の日付を抽出して送る
    from = (reference_date - 15.day)
    to = (reference_date + 1.month + 15.day)
    @calender_disabled_days = (from.to_date..to.to_date).to_a
    reservable_days.each do |date|
      @calender_disabled_days.delete(date)
    end
  end

  def manage
    authorize! :manage, @listing
  end

  # POST /listings/1/ngevents
  # POST /listings/1/ngevents.json
  def create
    listing_okevent_params.each do |params|
      @okevent = UserOkevent.new(params)
      if @okevent.save
        flash[:notice]  = '開催日を追加しました。'
      else
        flash[:error] = @okevent.errors.full_messages.join("")
      end
    end
    render json: {}, status: :created
  end

  # PATCH/PUT /ngevents/1
  # PATCH/PUT /ngevents/1.json
  def update
    @okevent.assign_attributes( listing_okevent_params )
    @okevent.convert_end_of_day

    respond_to do |format|
      if @okevent.save
        format.json {
          flash[:notice]  = '開催日を更新しました。'
          render json: {}, status: :ok
        }
      else
        format.json {
          flash[:error] = @okevent.errors.full_messages.join("")
          render json: @okevent.errors, status: :unprocessable_entity
        }
      end
    end
  end

  # DELETE /ngevents/1
  # DELETE /ngevents/1.json
  def destroy
    respond_to do |format|
      if @okevent.destroy
        format.json {
          flash[:notice]  = '削除に成功しました。'
          render json: {}, status: :ok
        }
      else
        flash[:alert] = @okevent.errors.full_messages.join("")
        format.json { render json: @okevent.errors, status: :unprocessable_entity }
      end
    end
  end

  def delete_all_day
    if listing_okevent_params.present?
      listing_okevent_params.each do |event|
        if UserOkevent.exists?(user_id: event["user_id"], listing_id: event["listing_id"], start: event["start"].to_s, active: true)
          @okevent = UserOkevent.find_by(user_id: event["user_id"], listing_id: event["listing_id"], start: event["start"].to_s, active: true)
          unless @okevent.destroy
            flash[:error] = '一部削除に失敗しました。'
          end
        end
      end
      if flash[:error].blank?
        flash[:notice]  = '削除に成功しました。'
      else
        flash[:notice]  = '削除に失敗しました。'
      end
    end
    render json: {}, status: :ok
  end

  private

    def set_event
      @okevent = UserOkevent.find(params[:id])
    end

    def set_my_event
      @okevent = UserOkevent.where(id: params[:id], listing_id: params[:listing_id], user_id: current_user).first
    end

    def set_listing
      @listing = Listing.find(params[:listing_id])
    end

    def listing_okevent_params
      if params[:event].present?
        params.require(:event).map do |u|
          ActionController::Parameters.new(u.to_hash).permit(:start, :end).merge(user_id: current_user.id, listing_id: params[:listing_id], reason: :holiday)
        end
      end
    end
end
