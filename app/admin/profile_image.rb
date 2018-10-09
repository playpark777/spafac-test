ActiveAdmin.register ProfileImage do
  actions :all, except: [:create, :new, :destroy]

  controller do
    def scoped_collection
      case action_name
      when 'index', 'show'
        super.includes(:user, :profile)
      else
        super
      end
    end
  end
end
