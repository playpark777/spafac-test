User.seed do |s|
  s.id = 1
  s.email = "test@example.com"
  s.password = "password"
  s.confirmed_at = Time.zone.now
  s.provider = "test"
end

User.seed do |s|
  s.id = 2
  s.email = "admin@example.com"
  s.password = "password"
  s.confirmed_at = Time.zone.now.ago(1.day)
  s.provider = "admin"
end
