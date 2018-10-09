class IdentificationType < ActiveRecord::Base
  has_many :identifications

  validates :name, presence: true
  validates :name, uniqueness: true

  scope :availables, -> { where available: true }
end
