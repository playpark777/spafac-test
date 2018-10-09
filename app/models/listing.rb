class Listing < ActiveRecord::Base

  belongs_to :user
  has_many :listing_images, dependent: :destroy
  has_many :reservations
  has_many :reviews
  has_many :listing_ngevents, class_name: "UserNgevent"
  has_many :listing_okevents, class_name: "UserOkevent"
  has_many :favorites, dependent: :destroy

  enum charter_type: { designated: 0, shared: 1 }

  mount_uploader :cover_image, DefaultImageUploader

  validates :user_id, presence: true
  validates :charter_type, presence: true
  validates :location, presence: true
  validates :longitude, presence: true
  validates :latitude, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :title, presence: true
  validates :capacity, presence: true

  scope :mine, -> user_id { where(user_id: user_id) }
  scope :order_by_updated_at_desc, -> { order('updated_at desc') }
  scope :opened, -> { where(open: true) }
  scope :not_opened, -> { where(open: false) }
  scope :search_location, -> location_sel { where(location_sel) }
  scope :search_keywords, -> keywords_sel { where(keywords_sel) }
  scope :available_num_of_guest?, -> num_of_guest { where("capacity >= ?", num_of_guest) }
  scope :available_price_min?, -> price_min { where("price >= ?", price_min) }
  scope :available_price_max?, -> price_max { where("price <= ?", price_max) }

  def set_lon_lat
    geocode = self.geocode_with_google_map_api

    if geocode['status'] == 'OK'
      self.longitude = geocode['results'][0]['geometry']['location']['lng']
      self.latitude = geocode['results'][0]['geometry']['location']['lat']
    else
      self.longitude = 0.00
      self.latitude = 0.00
    end
    self.save
    geocode['status']
  end

  def geocode_with_google_map_api
    base_url = "https://maps.google.com/maps/api/geocode/json"
    params = "?key=#{Rails.application.secrets.google_map_api_key}&address=#{self.location}&sensor=false&language=ja"
    url = URI.encode(base_url + params)

    begin
      response = Net::HTTP.get_response(URI.parse(url))

      case response
      when Net::HTTPSuccess then
        JSON.parse(response.body)
      else
        {}
      end
    rescue Exception => e
      puts e
    end
  end

  def self.search(search_params)
    location = Listing.arel_table['location']
    location_sel = location.matches("\%#{search_params["location"]}\%")
    if search_params['where'] == 'top' || search_params['where'] == 'header'
      listing = Listing.search_location(location_sel).available_num_of_guest?(search_params['num_of_guest'])
      if search_params['schedule'].present?
        listing = listing.where( UserNgevent.enable_search_condition( DateTime.parse(search_params['schedule']) ).exists.not )
      end
      listing
    elsif search_params['where'] == 'listing_search'
      # tba: schedule
      price = search_params['price'].split(',')
      price_min = price[0].to_i
      price_max = price[1].to_i == 100000 ? nil : price[1].to_i
      keywords = Listing.arel_table['description']
      keywords_sel = keywords.matches("\%#{search_params["keywords"]}\%")

      if price_max
        Listing.search_location(location_sel)
          .available_num_of_guest?(search_params['num_of_guest'])
          .available_price_min?(price_min)
          .available_price_max?(price_max)
          .search_keywords(keywords_sel)
      else
        Listing.search_location(location_sel)
          .available_num_of_guest?(search_params['num_of_guest'])
          .available_price_min?(price_min)
          .search_keywords(keywords_sel)
      end
    end
  end

  def current_user_bookmarked?(user_id)
    Favorite.exists?(user_id: user_id, listing_id: self.id)
  end

  def left_steps
    result = {}
    result[:listing_image] = true unless ListingImage.exists?(listing_id: self.id)
    result
  end

  def left_step_count
    self.left_steps.length
  end

  def has_completed?
    self.left_step_count.zero?
  end

  def publish
    self.open = true
    self.save
  end

  def unpublish
    self.open = false
    self.save
  end

  def current_user_bookmarked?(user_id)
    Favorite.exists?(user_id: user_id, listing_id: self.id)
  end
end
