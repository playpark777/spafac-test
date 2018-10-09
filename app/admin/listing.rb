ActiveAdmin.register Listing do
  actions :all, except: [:update, :edit]
  permit_params :open

  index do
    selectable_column
    column :title do |l|
      link_to(l.title, l)
    end
    column :user
    column :open
    column :zipcode
    column :location
    column :price
    column :capacity
    column :cover_image
    column :cover_image_caption
    column :delivery_flg
		column :review_count
		column :ave_total
		column :ave_accuracy
		column :ave_communication
	  column :ave_cleanliness
		column :ave_location
    column :ave_check_in
    column :ave_cost_performance
    column :longitude
    column :latitude
    column :created_at
    column :updated_at
    actions
  end

  show do |listing|
    attributes_table do
			row :title do
        link_to(listing.title, listing)
      end
			row :user do
        listing.user.profile
      end
			row :open
      row :description
			row :zipcode
			row :location
      row :direction
			row :price
			row :capacity
			row :cover_image do
        image_tag(listing.cover_image.url(:thumb))
      end
			row :cover_image_caption
			row :delivery_flg
			row :review_count
			row :ave_total
			row :ave_accuracy
			row :ave_communication
			row :ave_cleanliness
			row :ave_location
			row :ave_check_in
			row :ave_cost_performance
			row :longitude
			row :latitude
			row :created_at
			row :updated_at
    end
    active_admin_comments
  end

  form do |f|
    f.inputs f.object.title do
      f.input :open
    end
    f.actions
  end

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
