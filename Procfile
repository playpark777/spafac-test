release: bundle exec rake db:migrate
web: bundle exec puma -C config/puma.rb
resque: env TERM_CHILD=1 RESQUE_TERM_TIMEOUT=9 bundle exec rake resque:work

