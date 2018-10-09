require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
  if Rails.env.production? || Rails.env.staging? || Rails.env.review_app?
    config.storage = :fog
    config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => 'AKIAIGK2V5WUFUIECFHA',
      :aws_secret_access_key  => "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",
      :region                 => 'us-east-1'
    }
    config.fog_directory = ENV['spafac-testbucket']
    config.fog_authenticated_url_expiration = 60
    #config.cache_storage = :fog # set cache dir s3
    config.cache_dir = "#{Rails.root}/tmp/uploads" # for Heroku
    #config.fog_public = true
  else
    config.storage = :file
  end

  CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/
end
