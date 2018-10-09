class MessageThread < ActiveRecord::Base
  has_many :messages, dependent: :destroy
  has_many :message_thread_users, dependent: :destroy
  has_many :users, through: :message_thread_users, dependent: :destroy

  scope :order_by_updated_at_desc, -> { order('updated_at') }

  def self.exists_thread?(msg_params)
    t_threads = MessageThreadUser.user_joins(msg_params['to_user_id']).select(:message_thread_id)
    f_threads = MessageThreadUser.user_joins(msg_params['from_user_id']).select(:message_thread_id)
    tt_array = []
    ft_array = []
    t_threads.each do |tt|
      tt_array << tt.message_thread_id
    end
    f_threads.each do |ft|
      ft_array << ft.message_thread_id
    end
    MessageThread.common_threads(tt_array, ft_array)
  end

  def self.common_threads(a_array, b_array)
    result = a_array & b_array
    false if result.size.zero?
    result.first
  end

  def self.create_thread(msg_params)
    mt = MessageThread.create()
    MessageThreadUser.create(
      message_thread_id: mt.id,
      user_id: msg_params['to_user_id'].to_i
    )
    MessageThreadUser.create(
      message_thread_id: mt.id,
      user_id: msg_params['from_user_id'].to_i
    )
    mt
  end

  def self.unread(user_id)
    mts = MessageThreadUser.where(user_id: user_id)
    result_array = []
    mts.each do |mt|
      result_array << mt.id if Message.exists?(message_thread_id: mt.message_thread_id, to_user_id: user_id, read: false)
    end
    result_array
  end

  def self.unread_messages(user_id)
    mts = MessageThreadUser.where(user_id: user_id)
    result_array = []
    mts.each do |mt|
      msgs = Message.where(message_thread_id: mt.message_thread_id, to_user_id: user_id, read: false)
      msgs.each do |msg|
        result_array << msg if msg.present?
      end
    end
    result_array
  end
end
