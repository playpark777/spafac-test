ActiveAdmin.register TopPageCoverTagline do

  form do |f|
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

  controller do
    def permitted_params
      params.permit :utf8, :_method, :authenticity_token, :locale, :commit, :id,
                    top_page_cover_tagline: [:tagline_ja, :sub_tagline_ja, :tagline_en, :sub_tagline_en, :tagline_zh_cn, :sub_tagline_zh_cn]
    end
  end

end
