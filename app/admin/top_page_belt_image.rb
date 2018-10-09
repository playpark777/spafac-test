ActiveAdmin.register TopPageBeltImage do

  index do
    selectable_column
    column :id
    column :image_flg
    column :image do |img|
      image_tag(img.image.url(:thumb))
    end
    column :color
    column :tagline_ja
    column :sub_tagline_ja
    column :tagline_en
    column :sub_tagline_en
    # column :tagline_zh_cn
    # column :sub_tagline_zh_cn
    column :link_url
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    inputs '共通' do
      input :image_flg
      input :image
      input :color
      input :link_url
    end

    inputs '日本語' do
      input :tagline_ja
      input :sub_tagline_ja
    end

    inputs '英語' do
      input :tagline_en
      input :sub_tagline_en
    end

    # inputs '中国語' do
    #   input :tagline_zh_cn
    #   input :sub_tagline_zh_cn
    # end
    f.actions
  end

  show do |belt_image|
    attributes_table do
      row :id
      row :image_flg
      row :image do
        image_tag(belt_image.image.url, width: '500px')
      end
      row :color
      row :tagline_ja
      row :sub_tagline_ja
      row :tagline_en
      row :sub_tagline_en
      # row :tagline_zh_cn
      # row :sub_tagline_zh_cn
      row :link_url
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  controller do
    def permitted_params
      params.permit :utf8, :_method, :authenticity_token, :locale, :commit, :id,
                    top_page_belt_image: [
                      :image_flg,
                      :image,
                      :color,
                      :tagline_ja,
                      :sub_tagline_ja,
                      :tagline_en,
                      :sub_tagline_en,
                      :tagline_zh_cn,
                      :sub_tagline_zh_cn,
                      :link_url]
    end
  end

end
