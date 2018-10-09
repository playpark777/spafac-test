class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :timeoutable
  devise :database_authenticatable, :registerable, :lockable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable

  attr_accessor :mode
  
  has_many :auths, dependent: :destroy
  has_one :profile, dependent: :destroy
  #has_many :wishlists, dependent: :destroy
  #has_many :emergency, through: :user_emergencies
  has_one :profile_image, dependent: :destroy
  has_one :profile_video, dependent: :destroy
  has_many :listings, dependent: :destroy
  has_many :message_thread_users, dependent: :destroy
  has_many :message_threads, through: :message_thread_users, dependent: :destroy
  has_many :inquiries
  has_many :favorites, dependent: :destroy

  validates :email, presence: true
  validates :email, uniqueness: true
  #VALID_EMAIL_REGREX = [a-zA-Z0-9_!#$%&*+=?^`{}~|'\-\/\.]+@[a-zA-Z0-9_!#$%&*+=?^`{}~|'\-\/]+(\.[a-zA-Z0-9_!#$%&*+=?^`{}~|'\-\/]+)+
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, format: { with: VALID_EMAIL_REGEX }

  with_options if: lambda {|o|
    (o.mode != 'email' && o.mode != 'confirm')
  } do |user|
    user.validates :password, presence: true
    user.validates :password, length: 8..128
  end

  # with_options if: 'password || new_record?' do |user|
  #   user.validates :password, presence: true
  #   user.validates :password, length: 8..128
  # end

  delegate :identification, to: :profile

  scope :mine, -> user_id { where(id: user_id) }

  def identification_approved?
    profile && identification && identification.approved?
  end

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    p '------------------------------------------------'
    pp auth
    p '------------------------------------------------'
    unless user = User.where(provider: auth.provider, uid: auth.uid).first
      user = User.new(
        provider: auth.provider,
        uid:      auth.uid,
        email:    auth.info.email,
        password: Devise.friendly_token[0,20]
      )
      user.skip_confirmation!
      user.save
    end
    unless Profile.exists?(user_id: user.id)
      profile = Profile.new(
        user_id: user.id,
        last_name: auth.info.last_name || '',
        first_name: auth.info.first_name || ''
      )
      profile.save

      unless ProfileImage.exists?(user_id: user.id, profile_id: profile.id)
        profile_image = ProfileImage.new(
          user_id: user.id,
          profile_id: profile.id,
          caption: ''
        )
        profile_image.remote_image_url = auth['info']['image'].gsub('http://','https://')
        profile_image.save
      end
    end

    auth_obj = Auth.find_by(user_id: user.id, provider: auth.provider)
    if auth_obj
      auth_obj.access_token = auth.credentials.token
    else
      auth_obj = Auth.new(
        user_id: user.id,
        provider: auth.provider,
        uid: auth.uid,
        access_token: auth.credentials.token
      )
    end
    auth_obj.save
    user
  end

  def self.create_unique_string
    SecureRandom.uuid
  end

  def self.user_id_to_profile_id(user_id)
    user = User.find(user_id)
    user.profile.id
  end
  
  ################
  # For Devise
  ################
  def self.confirm_by_token(confirmation_token)
    confirmable = find_first_by_auth_conditions(confirmation_token: confirmation_token)
    unless confirmable
      confirmation_digest = Devise.token_generator.digest(self, :confirmation_token, confirmation_token)
      confirmable = find_or_initialize_with_error_by(:confirmation_token, confirmation_digest)
    end
    confirmable.confirm if confirmable.persisted?
    confirmable
  end
  def confirm(args={})
    pending_any_confirmation do
      if confirmation_period_expired?
        self.errors.add(:email, :confirmation_period_expired,
          period: Devise::TimeInflector.time_ago_in_words(self.class.confirm_within.ago))
        return false
      end

      self.confirmed_at = Time.now.utc

      saved = if pending_reconfirmation?
        skip_reconfirmation!
        self.email = unconfirmed_email
        self.unconfirmed_email = nil
        self.mode = "confirm"
        save(validate: true)
      else
        save(validate: args[:ensure_valid] == true)
      end

      after_confirmation if saved
      saved
    end
  end
  def send_on_create_confirmation_instructions
    generate_confirmation_token!  unless @raw_confirmation_token
    send_devise_notification(:confirmation_on_create_instructions, @raw_confirmation_token, {})
  end
end
