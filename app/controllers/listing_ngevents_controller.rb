class ListingNgeventsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :search]
  before_action :set_my_event, only: [:edit, :update, :destroy]
  before_action :set_listing
  authorize_resource :user_ngevent

  # GET /listings/1/ngevents.json
  def index
    @ngevents = UserNgevent.mine(current_user).where(listing_id: params[:listing_id])
  end

  # GET /listings/1/ngevents/search.json
  def search
    ngs = UserNgevent.opened
    ngs = ngs.where(listing_id: params[:listing_id])
    ngs = ngs.around_month( DateTime.parse(params[:first_day]) )
    @ng_days = ngs.map( &:consecutive_days ).flatten
  end

  def manage
    authorize! :manage, @listing
  end

  # POST /listings/1/ngevents
  # POST /listings/1/ngevents.json
  def create
    listing_ngevent_params.each do |params|
      @ngevent = UserNgevent.new(params)
      if @ngevent.save
        flash[:notice]  = '予約不可日を追加しました。'
      else
        flash[:error] = @ngevent.errors.full_messages.join("")
      end
    end
    render json: {}, status: :created
  end

  # PATCH/PUT /ngevents/1
  # PATCH/PUT /ngevents/1.json
  def update
    @ngevent.assign_attributes( listing_ngevent_params )
    @ngevent.convert_end_of_day

    respond_to do |format|
      if @ngevent.save
        format.json { render json: {}, status: :ok }
      else
        format.json { render json: @ngevent.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ngevents/1
  # DELETE /ngevents/1.json
  def destroy
    respond_to do |format|
      if @ngevent.destroy
        format.json {
          flash[:notice]  = '削除に成功しました。'
          render json: {}, status: :ok
        }
      else
        flash[:alert] = @ngevent.errors.full_messages.join("")
        format.json { render json: @ngevent.errors, status: :unprocessable_entity }
      end
    end
  end

  def delete_all_day
    if listing_ngevent_params
      listing_ngevent_params.each do |event|
        if UserNgevent.exists?(user_id: event["user_id"], listing_id: event["listing_id"], start_at: event["start_at"].to_s, active: true)
          @ngevent = UserNgevent.find_by(user_id: event["user_id"], listing_id: event["listing_id"], start_at: event["start_at"].to_s, active: true)
          unless @ngevent.destroy
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
      @ngevent = UserNgevent.find(params[:id])
    end

    def set_my_event
      @ngevent = UserNgevent.where(id: params[:id], listing_id: params[:listing_id], user_id: current_user).first
    end

    def set_listing
      @listing = Listing.find(params[:listing_id])
    end

    def listing_ngevent_params
      if params[:event].present?
        params.require(:event).map do |u|
          ActionController::Parameters.new(u.to_hash).permit(:start_at, :end_at).merge(user_id: current_user.id, listing_id: params[:listing_id], reason: :holiday)
        end
      end
    end
end
