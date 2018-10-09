ActiveAdmin.register TopPageDiscoveryImage do

  index do
    selectable_column
    column :id
    column :image do |img|
      image_tag(img.image.url(:thumb))
    end
    column :tagline_ja
    column :tagline_en
    # column :tagline_zh_cn
    column :order_num
    column :link_url
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    inputs '共通' do
      input :image
      input :order_num
      input :link_url
    end

    inputs '日本語' do
      input :tagline_ja
    end

    inputs '英語' do
      input :tagline_en
    end

    # inputs '中国語' do
    #   input :tagline_zh_cn
    # end
    f.actions
  end

  show do |discovery_image|
    attributes_table do
      row :id
      row :image do
        image_tag(discovery_image.image.url, width: '500px')
      end
      row :tagline_ja
      row :tagline_en
      # row :tagline_zh_cn
      row :order_num
      row :link_url
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  controller do
    def permitted_params
      params.permit :utf8, :_method, :authenticity_token, :locale, :commit, :id,
                    top_page_discovery_image: [
                      :image,
                      :tagline_ja,
                      :tagline_en,
                      :tagline_zh_cn,
                      :link_url,
                      :order_num]
    end
  end

end
