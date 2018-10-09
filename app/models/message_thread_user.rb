class MessageThreadUser < ActiveRecord::Base
  belongs_to :message_thread
  belongs_to :user

  validates :message_thread_id, presence: true
  validates :user_id, presence: true

  scope :user_joins, -> user_id { where(user_id: user_id) }
  scope :mine, -> user_id { where(user_id: user_id) }
  scope :order_by_updated_at_desc, -> { order('updated_at desc') }
  scope :order_by_updated_at_asc, -> { order('updated_at asc') }
  scope :message_thread, -> message_thread_id { where( message_thread_id: message_thread_id ) }

  def self.counterpart_user(message_thread_id, my_user_id)
    user_ids = MessageThreadUser.message_thread(message_thread_id).pluck(:user_id)
    user_ids.each do |ui|
      return ui unless ui == my_user_id
    end
  end

  def self.is_a_member(message_thread_id, user_id)
    MessageThreadUser.exists?(message_thread_id: message_thread_id, user_id: user_id)
  end
end
