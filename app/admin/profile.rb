ActiveAdmin.register Profile do
  actions :all, except: [:create, :new,:destroy]

  controller do
    def scoped_collection
      case action_name
      when 'index', 'show'
        super.includes(:user)
      else
        super
      end
    end
  end
end
