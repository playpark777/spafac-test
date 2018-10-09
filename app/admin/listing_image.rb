ActiveAdmin.register ListingImage do

  controller do
    def scoped_collection
      case action_name
      when 'index', 'show'
        super.includes(:listing)
      else
        super
      end
    end
  end
end
