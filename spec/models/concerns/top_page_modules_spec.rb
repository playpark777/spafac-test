require 'rails_helper'

describe TopPageModules do

  describe "TopPageCoverTagline" do
    obj = FactoryBot.create(:top_page_cover_tagline)

    describe "tagline" do
      it "locale - ja" do
        I18n.locale = :ja
        expect(obj.tagline).to eql obj.tagline_ja
      end
      it "locale - en" do
        I18n.locale = :en
        expect(obj.tagline).to eql obj.tagline_en
      end
    end

    describe "sub_tagline" do
      it "locale - ja" do
        I18n.locale = :ja
        expect(obj.sub_tagline).to eql obj.sub_tagline_ja
      end
      it "locale - en" do
        I18n.locale = :en
        expect(obj.sub_tagline).to eql obj.sub_tagline_en
      end
    end
  end

  describe "TopPageDiscoveryImage" do
    obj = FactoryBot.create(:top_page_discovery_image)
    obj_stg = FactoryBot.create(:top_page_discovery_image, :top_page_discovery_image_link_url_staging)
    obj_lh = FactoryBot.create(:top_page_discovery_image, :top_page_discovery_image_link_url_localhost)
    obj_g = FactoryBot.create(:top_page_discovery_image, :top_page_discovery_image_link_url_google)
    # obj_size_0 = FactoryBot.create(:top_page_discovery_image, :top_page_discovery_image_size_0)
    # pp obj_size_0

    describe "tagline" do
      it "locale - ja" do
        I18n.locale = :ja
        expect(obj.tagline).to eql obj.tagline_ja
      end
      it "locale - en" do
        I18n.locale = :en
        expect(obj.tagline).to eql obj.tagline_en
      end
    end

    describe "link_url_matches_app_domain?" do
      it "has_domain - production" do
        expect(obj.link_url_matches_app_domain?).eql? true
      end
      it "has_domain - staging" do
        expect(obj_stg.link_url_matches_app_domain?).eql? true
      end
      it "has_domain - localhost" do
        expect(obj_lh.link_url_matches_app_domain?).eql? true
      end
      it "has_not_domain" do
        expect(obj_g.link_url_matches_app_domain?).eql? false
      end
    end
  end

  describe "TopPageBeltImage" do
    obj = FactoryBot.create(:top_page_belt_image)
    obj_stg = FactoryBot.create(:top_page_belt_image, :top_page_belt_image_link_url_staging)
    obj_lh = FactoryBot.create(:top_page_belt_image, :top_page_belt_image_link_url_localhost)
    obj_g = FactoryBot.create(:top_page_belt_image, :top_page_belt_image_link_url_google)

    describe "tagline" do
      it "locale - ja" do
        I18n.locale = :ja
        expect(obj.tagline).to eql obj.tagline_ja
      end
      it "locale - en" do
        I18n.locale = :en
        expect(obj.tagline).to eql obj.tagline_en
      end
    end

    describe "sub_tagline" do
      it "locale - ja" do
        I18n.locale = :ja
        expect(obj.sub_tagline).to eql obj.sub_tagline_ja
      end
      it "locale - en" do
        I18n.locale = :en
        expect(obj.sub_tagline).to eql obj.sub_tagline_en
      end
    end

    describe "link_url_matches_app_domain?" do
      it "has_domain - production" do
        expect(obj.link_url_matches_app_domain?).eql? true
      end
      it "has_domain - staging" do
        expect(obj_stg.link_url_matches_app_domain?).eql? true
      end
      it "has_domain - localhost" do
        expect(obj_lh.link_url_matches_app_domain?).eql? true
      end
      it "has_not_domain" do
        expect(obj_g.link_url_matches_app_domain?).eql? false
      end
    end
  end

end
