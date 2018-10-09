require "rails_helper"

RSpec.describe IdentificationMailer, type: :mailer do
  before do
    @locale = I18n.locale

    @admin = AdminUser.first ||
      AdminUser.create(email: "admin@example.com", password: "password")
    @user = FactoryBot.create(:user)
    @identification = @user.identification
    @approved_notification_template = FactoryBot.create(:approved_notification_template)
    @rejected_notification_template = FactoryBot.create(:rejected_notification_template)

    @signature = FactoryBot.create(:email_template_signature)
  end

  describe "send_identification_is_approved_notification" do
    before do
      @mail = IdentificationMailer.send_identification_is_approved_notification(@identification)
    end

    describe "when creating mail and before sending it" do
      specify { expect(ActionMailer::Base.deliveries).to be_empty }

      it "renders the headers" do
        expect(@mail.subject).to eq @approved_notification_template.subject
        expect(@mail.to.first).to eq @user.email
      end

      it "renders the body" do
        expect(@mail.html_part.body.to_s).to match(/#{@user.profile.full_name}/)
        expect(@mail.html_part.body.to_s).to match(/#{root_url}/)
        expect(@mail.html_part.body.to_s).to match(/#{I18n.t('basic_info.service_name')}/)
      end
    end

    describe "after sending the mail" do
      before do
        @mail.deliver_now
        @sent_mail = ActionMailer::Base.deliveries.last
      end

      specify { expect(ActionMailer::Base.deliveries.count).to eq 1 }

      it "renders the headers" do
        expect(@sent_mail.subject).to eq @approved_notification_template.subject
        expect(@sent_mail.to.first).to eq @user.email
      end

      it "renders the body" do
        expect(@mail.html_part.body.to_s).to match(/#{@user.profile.full_name}/)
        expect(@mail.html_part.body.to_s).to match(/#{root_url}/)
        expect(@mail.html_part.body.to_s).to match(/#{I18n.t('basic_info.service_name')}/)
      end
    end
  end

  describe "send_identification_is_rejected_notification" do
    before do
      @mail = IdentificationMailer.send_identification_is_rejected_notification(@identification)
    end

    describe "when creating mail and before sending it" do
      specify { expect(ActionMailer::Base.deliveries).to be_empty }

      it "renders the headers" do
        expect(@mail.subject).to eq @rejected_notification_template.subject
        expect(@mail.to.first).to eq @user.email
      end

      it "renders the body" do
        expect(@mail.html_part.body.to_s).to match(/#{@user.profile.full_name}/)
        expect(@mail.html_part.body.to_s).to match(/#{root_url}/)
        expect(@mail.html_part.body.to_s).to match(/#{I18n.t('basic_info.service_name')}/)
      end
    end

    describe "after sending the mail" do
      before do
        @mail.deliver_now

        @sent_mail = ActionMailer::Base.deliveries.last
      end

      specify { expect(ActionMailer::Base.deliveries.count).to eq 1 }

      it "renders the headers" do
        expect(@sent_mail.subject).to eq @rejected_notification_template.subject
        expect(@sent_mail.to.first).to eq @user.email
      end

      it "renders the body" do
        expect(@mail.html_part.body.to_s).to match(/#{@user.profile.full_name}/)
        expect(@mail.html_part.body.to_s).to match(/#{root_url}/)
        expect(@mail.html_part.body.to_s).to match(/#{I18n.t('basic_info.service_name')}/)
      end
    end
  end
end
