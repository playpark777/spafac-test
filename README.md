[![wercker status](https://app.wercker.com/status/a5fdcf8611e905bf1ae8c8826d33c613/m "wercker status")](https://app.wercker.com/project/bykey/a5fdcf8611e905bf1ae8c8826d33c613)

# BASIC SPECIFICATION
- Rails version: 5.1.4
- Ruby version: 4.2.4
- RubyGems version: 2.4.5
- Rack version: 1.5
- JavaScript Runtime: JavaScriptCore
- Database adapter: postgresql(, mysql)

# Getting Started (Very Easy Way)

- unzip this project zip file

```ruby
$ cd airbnb-clone
$ bundle update
$ rake db:migrate (or bundle exec rake db:migrate)
$ rake default_data:set
$ rails s
```

and check localhost:3000 or the other specified IP and port from browser


## ATTENTION

By default, you can use Gemfile in which gems' version are specified.
IF YOU WANT TO USE LATEST VERSION OF GEMS, USE "GEMFILE.no_version"
*(rename this file like Gemfile.version_fixed, and rename Gemfile.no_version to Gemfile)*
(and bundle update again)


# Authentification, OAuth(SNS Login, etc)

- Devise

- config files: config/initializers/devise.rb

- read: https://github.com/plataformatec/devise

## Facebook Authentification

- https://github.com/plataformatec/devise/wiki/OmniAuth:-Overview

- config files: /config/initializers/devise.rb, /config/secrets.rb, ENV VARIABLES

# When using the function of Google Maps
"API key is required" when using Google Maps on the new site from 22nd June 2016.
Please refer here for the method of obtaining the API key of Google Maps.

- https://developers.google.com/maps/web/


# Admin Page

- Active Admin

- access: {root_url}/admin (e.g. http://localhost:3000/admin)

- config file: /config/initializers/active_admin.rb

- read: https://github.com/activeadmin/activeadmin/blob/master/docs/0-installation.md

- note: In default setting, you can only view data. If you want to create, update, delete them, set strong parameter in app/admin/{model_name}.rb

## If you want to use other Admin System

destroy files of active admin.

```ruby
$ rails destroy active_admin:install
```

If you delete avtive_admin files, db/schema.rb would have wrong infomartion.
To clean db/schema.rb, you can use rake db:migrate:reset command.
But this command would erase all data of project database and rebuild structure.
So you should take care about data and schema.

# Image File Upload

## development

Uploaded files are stored at /public/uploads/
The cache files are at /tmp/uploads/

## staging, production

- CarrierWave
- AWS S3

- config file: /config/initializers/carrierwave.rb

- read: https://github.com/carrierwaveuploader/carrierwave

# Video File Upload

not implemented
tba

# Pager

- Kaminari

- config file: /config/initializers/kaminari.rb

- read: https://github.com/amatsuda/kaminari

# Active Record Wrapper

- squeel

- config file: /config/initializers/squeel.rb

- read: https://github.com/activerecord-hackery/squeel

# Assets Precompile

- config file: /config/initializers/assets.rb, /config/environments/*.rb

# Services
## job queues
### Active Job

- resque
- Redis

- http://qiita.com/ryohashimoto/items/2f8fd685920a5318def4

## cache
### Memcached (staging, production)

### /tmp/cache (development)

- http://easyramble.com/rails-cache-fetch.htm

# How to run the test suite

- no test yet

## Mail

- config: config/environments/*.rb

### Devise Mailer

- used in only devise related program

### Action Mailer

- how to send mail with resque in dev

```ruby
$ redis-server
$ bundle exec rake resque:work
$ rake environment resque:scheduler
$ rails server
```
# I18n
Now ja and en are ready.

## i18n-js
i18n for js

- config:
  - config/i18n-js.yml
  - config/initializers/assets.rb
- source: config/locales/js.en.yml or js.ja.yml
- command to generate i18n file

```
$ rake i18n:js:export
```

- final file: app/assets/javascripts/i18n/*.js

* Deployment instructions

# for Heroku Deployment
## Addons
### Database
- Heroku Postgres

### Cache Storage
- MemCachier

### Cron
- Heroku Scheduler

### Mailer
- SendGrid (or Mandril)

### Log
- Papertrail

### Performance
- NewRelic

## ENV VARIABLES
### add env variables below as your project
- AWS_ACCESS_KEY_ID: "AWS access key id"
- AWS_REGION:        "S3 region"
- AWS_S3_BUCKET:     "S3 bucket name"
- AWS_SECRET_ACCESS_KEY: "aws secret access key "
- DATABASE_URL:           postgres://~~~~~
- FACEBOOK_APP_ID:          "FB app id for fb login"
- FACEBOOK_APP_SECRET:      "FB app secret for fb login"
- GOOGLE_MAP_API_KEY:          "api key for Google map use"
- HEROKU_POSTGRESQL_ONYX_URL: "~~~~"
- LANG:                       "~~~~"
- MEMCACHIER_PASSWORD:        "~~~~"
- MEMCACHIER_SERVERS:         "~~~~"
- MEMCACHIER_USERNAME:        "~~~~"
- PAPERTRAIL_API_TOKEN:       "~~~~"
- RACK_ENV:                   staging (or production)
- RAILS_ENV:                  staging (or profuction)
- RAILS_SERVE_STATIC_FILES:   enabled
- SECRET_KEY_BASE:            "~~~~"
- SENDGRID_PASSWORD:          "~~~~"
- SENDGRID_USERNAME:          "~~~~"
- TZ:                         Asia/Tokyo

# Seed Data
By default, sample data is prepared for early development using seed_fu gem.

```
$ rake db:seed_fu
```

## attention
If you want to use each seed file, use command like below.

```
$ rake db:seed_fu FILTER=profile_identification
```

If you want to use seed data by each environment, use command like below.

```
$ rake db:seef_fu FIXTURE_PATH=db/fixtures/development
```

# Change Log
## v2.1.0
- Added mail template function
- Support for fullcalendar update
- Changing the operation of the administration screen
- Other minor modifications

## v2.0.0
- Update to Rails 5 (5.1.4)
- Update to Ruby 4.2.4
- Implementation of multiple listing image registration function
- Implement listing favorite function
- Other minor modifications

## v1.5.2
- add Google api key secrets.yml For using Google map
- Update gem omniauth-facebook
- Fix listing search value
- Update README File

## v1.5.1
- Fix I18n in some controllers

## v1.5.0
- Switch Google Maps Language
- Remove Listing Options
- Fix listing#set_lon_lat spec
- Remove wafuku option
- Fix listing form
- Remove Price Slider Upper Limit
- Listing Charter Type
- Error message display
- Update README File

## v1.4.1
- Update README File

## v1.4.0
- Update Ruby Version 2.3.1
- Improve Listings and add specs
- Add Language Selector
- Fix Listing#geocode_with_google_map_api
- Change alerts background color
- Add a bank account
- Change Default disable_with for SimpleForm submit
- Add inquiry form

## v1.3.1
- Fix Update sample user's email

## v1.3.0
- Refactor all code
- Add Profile Identification
- Sample Seed Data(not recommend for production)
- Add Model test file
- Add Controller test file

## v1.2.0
- Brush up UI
- Refactor all code
- Adapt Facebook GraphAPI Modification
- Add Calendar to manage unavailable day for reservation
  - now having error
- listing bug fixed
- Use env variables in local
  - direnv is recommended
- change css structure
- Make JavaScript clean
- i18n
  - all text is in config/locale/*
  - url:
    - ja: http://---.com/
    - en: http://---.com/en
