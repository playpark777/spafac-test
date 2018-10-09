class ReviewReply < ActiveRecord::Base
  belongs_to :review

  validates :review_id, presence: true
  validates :msg, presence: true
end
