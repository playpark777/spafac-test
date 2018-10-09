class Message < ActiveRecord::Base
  belongs_to :message_thread, touch: true
  belongs_to :to_user, class_name: 'User', foreign_key: 'to_user_id'
  belongs_to :from_user, class_name: 'User', foreign_key: 'from_user_id'

  validates :message_thread_id, presence: true
  validates :from_user_id, presence: true
  validates :to_user_id, presence: true
  validates :content, presence: true

  scope :unread_messages, -> user_id { where(to_user_id: user_id, read: false) }
  scope :message_thread, -> message_thread_id { where(message_thread_id: message_thread_id) }
  scope :order_by_created_at_desc, -> { order('created_at desc') }
  scope :reservation, -> reservation_id { where(reservation_id: reservation_id) }

  def self.send_message(mt_obj, message_params)
    content = message_params['content'].presence || ''
    listing_id = message_params['listing_id'].presence || 0
    reservation_id = message_params['reservation_id'].presence || 0
    obj = Message.new(
      message_thread_id: mt_obj.id,
      content: content,
      read: false,
      from_user_id: message_params['from_user_id'],
      to_user_id: message_params['to_user_id'],
      listing_id: listing_id,
      reservation_id: reservation_id
    )
    obj.save
  end

  def self.make_all_read(message_thread_id, to_user_id)
    Message.where(message_thread_id: message_thread_id, to_user_id: to_user_id, read: false).update_all(read: true, read_at: Time.zone.now)
  end
end
