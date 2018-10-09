class Users::RegistrationsController < Devise::RegistrationsController

  def create
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        create_profile resource
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      flash[:messages] = resource.errors.full_messages
      redirect_to new_user_registration_path, alert: I18n.t('.errors.messages.not_completed', count: resource.errors.size)
    end
  end

  def edit
    @mode = params.fetch(:mode, "email")
    super
  end

  def update
    @mode = params[:mode]
    super
  end

  protected
  def build_resource(hash=nil)
    hash[:uid] = User.create_unique_string
    super
  end
  def update_needs_confirmation?(resource, previous)
    resource.respond_to?(:pending_reconfirmation?) &&
    resource.pending_reconfirmation? &&
    resource.email != resource.unconfirmed_email
  end

  private
  def create_profile(resource)
    profile = Profile.create(user_id: resource.id)
    ProfileImage.create(user_id: resource.id, profile_id: profile.id, image: '', caption: '')
  end
end
