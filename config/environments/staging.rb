Rails.application.configure do
  config.force_ssl = true
  config.cache_classes = true

  config.eager_load = true
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = true

  config.cache_store = :dalli_store,
   (ENV["MEMCACHIER_SERVERS"] || "").split(","),
   {:username => ENV["MEMCACHIER_USERNAME"],
    :password => ENV["MEMCACHIER_PASSWORD"],
    :failover => true,
    :socket_timeout => 1.5,
    :socket_failure_delay => 0.2
   }

  config.action_dispatch.rack_cache = true
  config.middleware.use Rack::Cache,
    :verbose => true,
    :metastore   => 'file:/var/cache/rack/meta',
    :entitystore => 'file:/var/cache/rack/body'

  client = Dalli::Client.new((ENV["MEMCACHIER_SERVERS"] || "").split(","),
                           :username => ENV["MEMCACHIER_USERNAME"],
                           :password => ENV["MEMCACHIER_PASSWORD"],
                           :failover => true,
                           :socket_timeout => 1.5,
                           :socket_failure_delay => 0.2,
                           :value_max_bytes => 10485760)
  config.action_dispatch.rack_cache = {
    :metastore    => client,
    :entitystore  => client
  }
  config.static_cache_control = "public, max-age=2592000"

  # Disable serving static files from the `/public` folder by default since
  # Apache or NGINX already handles this.
  config.serve_static_files = ENV['RAILS_SERVE_STATIC_FILES'].present?

  # Compress JavaScripts and CSS.
  config.assets.js_compressor = :uglifier
  config.assets.css_compressor = :sass

  config.assets.compile = false
  config.assets.digest = true
  config.assets.compress = true
  config.assets.debug = false

  # `config.assets.precompile` and `config.assets.version` have moved to config/initializers/assets.rb

  # Specifies the header that your server uses for sending files.
  config.action_dispatch.x_sendfile_header = "X-Sendfile" # for apache
  config.log_level = :debug

  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners.
  config.active_support.deprecation = :notify

  # Disable automatic flushing of the log to improve performance.
  config.autoflush_log = false

  # Use default logging formatter so that PID and timestamp are not suppressed.
  config.log_formatter = ::Logger::Formatter.new

  # Do not dump schema after migrations.
  config.active_record.dump_schema_after_migration = false

  # Mailer Setting
  # Ignore bad email addresses and do not raise email delivery errors.
  # Set this to true and configure the email server for immediate delivery to raise delivery errors.
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.perform_deliveries = true

  ## set your project mailer config below.
  ## config below is sample to use heroku addon 'SENDGRID'
  config.action_mailer.default_url_options = { host: "#{ENV['HEROKU_APP_NAME']}.herokuapp.com" }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    :user_name      => ENV['SENDGRID_USERNAME'],
    :password       => ENV['SENDGRID_PASSWORD'],
    :domain         => "heroku.com",
    :address        => "smtp.sendgrid.net",
    :port           => 25, # ssl:587, plain:25
    :authentication => :plain,
    :enable_starttls_auto => true
  }
end
