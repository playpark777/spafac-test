ActiveAdmin.register Reservation do
  actions :all, except: [:create, :new, :update, :edit, :destroy]

  controller do
    def scoped_collection
      case action_name
      when 'index', 'show'
        super.includes(:host, :guest, :listing)
      else
        super
      end
    end
  end

end
