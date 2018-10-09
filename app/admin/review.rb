ActiveAdmin.register Review do

  controller do
    def scoped_collection
      case action_name
      when 'index', 'show'
        super.includes(:user, :reservation, :listing)
      else
        super
      end
    end
  end
end
