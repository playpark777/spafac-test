require "rails_helper"

describe ReviewMailer do
  before(:all) do
    @reservation = FactoryBot.create(:reservation)
    @listing = @reservation.listing
    @guest = @reservation.guest
    @host = @reservation.host
    @review_opened_notification_template = FactoryBot.create(:review_opened_notification_template)
    @signature = FactoryBot.create(:email_template_signature)
  end

  describe "send_review_opened_notification" do
    before(:all) do
      @review = FactoryBot.create(:review)
      @review_reply = FactoryBot.create(:review_reply, review: @review)

      @mail = ReviewMailer.send_review_opened_notification(@reservation)
    end

    describe "when creating mail and before sending it" do
      specify { expect(ActionMailer::Base.deliveries).to be_empty }

      it "renders the headers" do

        expect(@mail.subject).to eq @review_opened_notification_template.subject
        expect(@mail.to.first).to eq @guest.email
      end

      it "renders the body" do
        expect(@mail.html_part.body.to_s).to match(/#{@host.profile.full_name}/)
        expect(@mail.html_part.body.to_s).to match(/#{@listing.title}/)
        expect(@mail.html_part.body.to_s).to match(/#{listing_url(nil, @reservation.listing_id)}/)
      end
    end

    describe "after sending the mail" do
      before do
        @mail.deliver_now
        @sent_mail = ActionMailer::Base.deliveries.last
      end

      specify { expect(ActionMailer::Base.deliveries.count).to eq 1 }

      it "renders the headers" do
        expect(@sent_mail.subject).to eq @review_opened_notification_template.subject
        expect(@sent_mail.to.first).to eq @guest.email
      end

      it "renders the body" do
        expect(@mail.html_part.body.to_s).to match(/#{@host.profile.full_name}/)
        expect(@mail.html_part.body.to_s).to match(/#{@listing.title}/)
        expect(@mail.html_part.body.to_s).to match(/#{listing_url(nil, @reservation.listing_id)}/)
      end
    end
  end
end
