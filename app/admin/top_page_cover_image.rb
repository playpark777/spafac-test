ActiveAdmin.register TopPageCoverImage do

  index do
    selectable_column
    column :id
    column :image do |img|
      image_tag(img.image.url(:thumb))
    end
    column :order_num
    column :created_at
    column :updated_at
    actions
  end

  show do |cover_image|
    attributes_table do
      row :id
      row :image do
        image_tag(cover_image.image.url, width: '500px')
      end
      row :order_num
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  controller do
    def permitted_params
      params.permit :utf8, :_method, :authenticity_token, :locale, :commit, :id,
                    top_page_cover_image: [:image, :order_num]
    end
  end

end
