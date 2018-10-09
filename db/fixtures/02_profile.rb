Profile.seed do |s|
  s.user = User.find(1)
  s.first_name = "太郎"
  s.last_name = "山本"
end

Profile.seed do |s|
  s.user = User.find(2)
  s.first_name = "花子"
  s.last_name = "石川"
end
