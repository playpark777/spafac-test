module TopPageModules
  extend ActiveSupport::Concern

  def set_tagline
    self.send("tagline_#{I18n.locale}")
  end

  def set_sub_tagline
    self.send("sub_tagline_#{I18n.locale}")
  end

  def link_url_matches_app_domain?
    if self.link_url.match(/^http\:\/\/www\.travel\-labo\.com/)
      self.link_url.match(/^http\:\/\/travel\-labo\-staging\.herokuapp\.com/)
      return true
    end
    false
  end


end
