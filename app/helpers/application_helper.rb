module ApplicationHelper

  def default_meta_tags(request, title, description, keywords)
    {
      charset: Settings.charset,
      og: {
        title: t('meta_tags.og.title'),
        type: Settings.meta_tags.og.type,
        url: request.original_url,
        image: Settings.meta_tags.og.image,
        site_name: t('meta_tags.og.site_name'),
        description: t('meta_tags.og.description')
      },
      fb: {
        admins: Settings.meta_tags.fb.admins
      },
      title: full_title(title),
      description: full_description(description),
      keywords: full_keywords(keywords),
      author: t('meta_tags.author'),
      viewport: Settings.meta_tags.viewport,
      format: {
        detection: Settings.meta_tags.format.detection
      }
    }
  end

  def i18n_url_for(options)
    if options[:locale] == I18n.default_locale
      options[:locale] = nil
    end
    url_for(options)
  end

  def full_title(page_title)
    base_title = t('meta_tags.title.base_title')
    if page_title.empty?
      base_title
    else
      "#{page_title} #{t('meta_tags.title.separator')} #{base_title}"
    end
  end

  def full_description(page_description)
    base_description = t('meta_tags.description.base_description')
    if page_description.empty?
      base_description
    else
      "#{page_description}"
    end
  end

  def full_keywords(page_words)
    base_words = t('meta_tags.keywords.base_keywords')
    if page_words.empty?
      base_words
    else
      "#{page_words}"
    end
  end

  def listing_cover_image_url(listing_id)
    ci = Listing.find(listing_id)
    if ci.blank?
      return ''
    else
      return ci.cover_image
    end
  end

  def listing_name(listing_id)
    ci = Listing.find(listing_id)
    if ci.blank?
      return ''
    else
      return ci.title
    end
  end

  # TODO: fix
  def number_to_yen(number)
    number_to_currency( number, :unit => '円' , :format => "%n%u")
  end

  def unread_messages
    Message.unread_messages(current_user.id).count
  end

  def user_id_to_user_obj(user_id)
    users = User.mine(user_id)
    if users.size.zero?
      return false # todo
    else
      users[0]
    end
  end

  def user_obj_to_name(user)
    "#{user.profile.last_name} #{user.profile.first_name}"
  end

  def user_id_to_name(user_id)
    results = User.mine(user_id)
    if results.size.zero?
      return Settings.user.noname
    else
      if results[0].profile.last_name.blank? && results[0].profile.first_name.blank?
        return Settings.user.noname
      else
        return "#{results[0].profile.last_name} #{results[0].profile.first_name}"
      end
    end
  end

  def review_count_of_host(host_id)
    results = Listing.mine(host_id).pluck('review_count')
    review_count = 0
    results.each do |result|
      review_count += result
    end
    review_count
  end

  def user_id_to_profile_image(user_id)
    result = ProfileImage.mine(user_id)
    result[0].try('image') || Settings.images.noimage2.url
  end

  def user_id_to_profile_image_thumb(user_id)
    result = ProfileImage.mine(user_id)
    result[0].try('image').thumb || Settings.images.noimage2.url
  end

  def host_image(host_image_obj)
    host_image_obj.try('image') || Settings.images.noimage2.url
  end

  def profile_image
    if profile_image = ProfileImage.where(user_id: current_user.id).first
      profile_image.try('image') || Settings.images.noimage2.url
    else
      return Settings.images.noimage2.url
    end
  end

  def profile_image_thumb(user_id=current_user.id)
    if profile_image = ProfileImage.where(user_id: user_id).first
      profile_image.try('image').thumb || Settings.images.noimage2.url
    else
      return Settings.images.noimage2.url
    end
  end

  def profile_image_exists?
    ProfileImage.exists?(user_id: current_user.id, profile_id: current_user.profile.id)
  end

  def new_or_edit_path(obj)
    obj ? edit_listing_path(obj) : new_listing_path(obj)
  end

  def left_step_count_and_elements(listing)
    listing.left_step_count_and_elements
  end

  def reservation_to_listing(reservation)
    Listing.find(reservation.listing_id)
  end

  def reservation_to_host(reservation)
    User.find(reservation.host_id)
  end

  def reservation_to_guest(reservation)
    User.find(reservation.guest_id)
  end

  def listing_id_to_weekly_pv(listing_id)
    ListingPv.weekly_pv(listing_id)
  end

  def new_reservations_came(user_id)
    Reservation.new_requests(user_id).count
  end

  def new_messages_came(user_id)
    MessageThread.unread(user_id).count
  end

  def counterpart_user_id(message_thread_id)
    MessageThreadUser.counterpart_user(message_thread_id, current_user.id)
  end

  def counterpart_user_obj(message_thread_id)
    user_id = MessageThreadUser.counterpart_user(message_thread_id, current_user.id)
    User.find(user_id)
  end

  def latest_message(message_thread_id)
    Message.message_thread(message_thread_id).last
  end

  def listing_id_to_listing_obj(listing_id)
    Listing.find(listing_id)
  end

  def reservation_id_to_reservation_obj(reservation_id)
    Reservation.find(reservation_id)
  end

  def reservation_id_to_messages(reservation_id)
    Message.reservation(reservation_id)
  end

  def profile_image_link
    profile_image = ProfileImage.where(user_id: current_user.id, profile_id: current_user.profile.id).first
    if profile_image.present?
      return edit_profile_profile_image_path(current_user.profile.id, profile_image.id)
    else
      new_profile_profile_image_path(current_user.profile.id)
    end
  end

  def each_manager_link(reservation)
    if current_user.id == reservation.host_id
      return dashboard_host_reservation_manager_path
    else current_user.id == reservation.guest_id
      dashboard_guest_reservation_manager_path
    end
  end

  def string_of_read(read, sender_flg)
    if read == true
      if sender_flg
        return t 'message.already_read.string'
      else
        return t 'message.read.string'
      end
    else
      if sender_flg
        return t 'message.waiting_for_read.string'
      else
        t 'message.unread.string'
      end
    end
  end

  def review_id_to_review_reply_msg(review_id)
    rr = ReviewReply.where(review_id: review_id).select('msg').first
    if rr.present?
      return rr.msg
    else
      return ''
    end
  end

  def sender?(user_id, from_user_id)
    pp user_id
    pp from_user_id
    return false unless user_id == from_user_id
    true
  end

  def controller_namespace
    controller.class.name.split('::')[-2]
  end

  def favorite_link(listing_id)
    if user_signed_in?
      if Favorite.exists?(user_id: current_user.id, listing_id: listing_id)
        favorite = Favorite.find_by(user_id: current_user.id, listing_id: listing_id)
        link_to favorite_path(id: favorite.id), class: "favorite listing-#{listing_id}", method: :delete, remote: true do
          "<span><i class='fa fa-heart'></i></span>".html_safe
        end
      else
        link_to add_favorites_path(listing_id: listing_id), class: "favorite listing-#{listing_id}", method: :post, remote: true do
          "<span><i class='fa fa-heart-o'></i></span>".html_safe
        end
      end
    else
      link_to user_session_path, class: "favorite" do
        "<span><i class='fa fa-heart-o'></i></span>".html_safe
      end
    end
  end
  def favorite_btn_link(listing_id)
    if user_signed_in?
      if Favorite.exists?(user_id: current_user.id, listing_id: listing_id)
        favorite = Favorite.find_by(user_id: current_user.id, listing_id: listing_id)
        link_to favorite_path(id: favorite.id, type: "btn"), class: "btn btn-outline btn-block btn-sm favorite listing-#{listing_id}", method: :delete, remote: true do
          "<i class='i fa fa-heart fa-pink'></i>お気に入り解除".html_safe
        end
      else
        link_to add_favorites_path(listing_id: listing_id, type: "btn"), class: "btn btn-outline btn-block btn-sm favorite listing-#{listing_id}", method: :post, remote: true do
          "<i class='i fa fa-heart-o fa-pink'></i>お気に入り登録".html_safe
        end
      end
    else
      link_to user_session_path, class: "btn btn-outline btn-block btn-sm" do
        "<span><i class='i fa fa-heart fa-pink'></i></span>お気に入り登録".html_safe
      end
    end
  end
end
