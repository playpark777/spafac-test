class IdentificationsController < ApplicationController
  before_action :authenticate_user!

  def show
    return redirect_to action: :new unless current_user.identification
    @identification = current_user.profile.identification
  end

  def new
    return redirect_to action: :show if current_user.identification
    @identification = current_user.profile.build_identification
  end

  def create
    @identification = current_user.profile.build_identification(
      identification_params
    )

    respond_to do |format|
      if @identification.save
        flash[:notice] = I18n.t("alerts.identification.save.success",
                                model: Identification.model_name.human)
        format.html { redirect_to action: :show }
        format.json { head :created, location: profile_identification_path  }
      else
        flash[:alert] = I18n.t("alerts.identification.save.failure",
                                model: Identification.model_name.human)
        format.html { render :new, notice: @identification.errors.full_messages.join("<br>") }
        format.json { render json: @identification.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @identification = current_user.profile.identification
    @identification.destroy
    flash[:notice] = I18n.t("alerts.identification.delete.success",
                            model: Identification.model_name.human)
    redirect_to action: :new
  end

  private
  def identification_params
    params.require(:identification).permit(
      :image1,
      :image2,
      :image3,
      :note,
    )
  end
end
