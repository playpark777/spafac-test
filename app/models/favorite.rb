class Favorite < ActiveRecord::Base
	belongs_to :user
	belongs_to :listing

	scope :mine, -> user_id { where('favorites.user_id = ?', user_id) }
	scope :order_by_updated_at_desc, -> { order('favorites.updated_at desc') }
	scope :opened, -> { includes(:listing).references(:listing).where(listings: {open: true}) }
end
