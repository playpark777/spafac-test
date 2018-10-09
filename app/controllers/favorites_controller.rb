class FavoritesController < ApplicationController
  before_action :set_favorite, only: [:destroy]
  # respond_to :json, only: [:create, :destroy]

  # GET /favorites
  # GET /favorites.json
  def index
    @favorites = Favorite.mine(current_user.id).order_by_updated_at_desc.opened.page(params[:page])
  end

  # POST /favorites
  # POST /favorites.json
  def create
    @type = params[:type]
    @favorite = Favorite.new(user_id: current_user.id, listing_id: params[:listing_id])
    if @favorite.save
      flash[:notice]  = 'お気に入りに追加しました。'
    else
      flash[:error] = @favorite.errors.full_messages.join("")
    end
    render action: "response"
  end

  # DELETE /favorites/1
  # DELETE /favorites/1.json
  def destroy
    @type = params[:type]
    if @favorite.destroy
      flash[:notice]  = 'お気に入りを解除しました。'
    else
      flash[:error] = @favorite.errors.full_messages.join("")
    end
    render action: "response"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_favorite
      @favorite = Favorite.find(params[:id])
    end
end
