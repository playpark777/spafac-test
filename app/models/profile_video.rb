class ProfileVideo < ActiveRecord::Base
  belongs_to :user
  belongs_to :profile

  validates :user_id, presence: true
  validates :profile_id, presence: true
  validates :video, presence: true
  #validates :order_num, numericality: {
  #  only_integer: true,
  #  equal_to: 0 # set has_one association
  #}
end
