class Reservation < ActiveRecord::Base
  belongs_to :host, class_name: 'User', foreign_key: 'host_id'
  belongs_to :guest, class_name: 'User', foreign_key: 'guest_id'
  belongs_to :listing
  has_one :review
  has_one :ngevent, class_name: "UserNgevent", dependent: :destroy

  enum progress: { requested: 0, canceled: 1, holded: 2, accepted: 3, rejected: 4, listing_closed: 5 }

  before_save :set_ngevent

  validates :host_id, presence: true
  validates :guest_id, presence: true
  validates :listing_id, presence: true
  validates :checkin, presence: true, date: {after: Time.zone.now.yesterday.end_of_day}
  validates :checkout, presence: true, date: {after: :checkin}
  validates :num_of_people, presence: true
  validates :progress, presence: true

  scope :as_guest, -> user_id { where(guest_id: user_id) }
  scope :as_host, -> user_id { where(host_id: user_id) }
  scope :order_by_created_at_desc, -> { order('created_at desc') }
  scope :new_requests, -> user_id { where(host_id: user_id, progress: 'requested') }
  scope :finished_before_yesterday, -> { where("checkout <= ?", Time.zone.yesterday) }
  scope :review_mail_never_be_sent, -> { where(review_mail_sent_at: nil) }
  scope :reviewed, -> { where.not(reviewed_at: nil) }
  scope :review_reply_mail_never_be_sent, -> { where(reply_mail_sent_at: nil) }
  scope :review_open?, -> { where(arel_table[:review_opened_at].not_eq(nil)) }

  def continued?
    if self.requested? || self.holded?
      return true
    else
      false
    end
  end

  def string_of_progress
    return I18n.t('string_of_progress.requested') if self.requested?
    return I18n.t('string_of_progress.canceled') if self.canceled?
    return I18n.t('string_of_progress.holded') if self.holded?
    return I18n.t('string_of_progress.accepted') if self.accepted?
    return I18n.t('string_of_progress.rejected') if self.rejected?
    return I18n.t('string_of_progress.unpublished') if self.listing_closed?
  end

  def subject_of_update_mail
    return I18n.t('reservation_mailer.send_update_reservation_notification.subject.canceled') if self.canceled?
    return I18n.t('reservation_mailer.send_update_reservation_notification.subject.holded') if self.holded?
    return I18n.t('reservation_mailer.send_update_reservation_notification.subject.accepted') if self.accepted?
    return I18n.t('reservation_mailer.send_update_reservation_notification.subject.rejected') if self.rejected?
  end

  def save_review_landed_at_now
    self.review_landed_at = Time.zone.now
    self.save
  end

  def save_reply_landed_at_now
    self.reply_landed_at = Time.zone.now
    self.save
  end

  def save_reviewed_at_now
    self.reviewed_at = Time.zone.now
    self.save
  end

  def save_replied_at_now
    self.replied_at = Time.zone.now
    self.save
  end

  def save_reply_mail_sent_at_now
    self.reply_mail_sent_at = Time.zone.now
    self.save
  end

  def save_review_opened_at_now
    self.review_opened_at = Time.zone.now
    self.save
  end

  def save_review_opened_mail_sent_at_now
    self.review_opened_mail_sent_at = Time.zone.now
    self.save
  end

  private

    def set_ngevent
      event = self.ngevent || UserNgevent.new
      event_params = {
        listing_id: self.listing_id,
        user_id: self.host_id,
        start_at: self.checkin,
        end_at:   self.checkout,
        reason: :reserved
      }
      event.assign_attributes( event_params )
      if self.progress_changed? && (self.canceled? || self.rejected? )
        event.active = false
        event.reason = :canceled
      end
      if Settings.reservations.include_checkout
        self.ngevent = event
      else
        self.ngevent = event.convert_end_of_day
      end
      self.ngevent.validate!
    end

end
