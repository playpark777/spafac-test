image_path = File.join(Rails.root, "app/assets/images/sample/pic/pic001.jpg")
TopPageCoverImage.seed do |obj|
  obj.id = 1
  obj.image = File.new(image_path)
  obj.order_num = 1
end
image_path = File.join(Rails.root, "app/assets/images/sample/pic/pic002.jpg")
TopPageCoverImage.seed do |obj|
  obj.id = 2
  obj.image = File.new(image_path)
  obj.order_num = 2
end
image_path = File.join(Rails.root, "app/assets/images/sample/pic/pic003.jpg")
TopPageCoverImage.seed do |obj|
  obj.id = 3
  obj.image = File.new(image_path)
  obj.order_num = 3
end
image_path = File.join(Rails.root, "app/assets/images/sample/pic/pic004.jpg")
TopPageCoverImage.seed do |obj|
  obj.id = 4
  obj.image = File.new(image_path)
  obj.order_num = 4
end

TopPageCoverTagline.seed do |obj|
  obj.id = 1
  obj.tagline_ja = "扉の向こうは新しい世界"
  obj.sub_tagline_ja = "旅はもっと楽しくなる"
  obj.tagline_en = "Open the door to a whole new experience"
  obj.sub_tagline_en = "Find a unique room for your next trip to Japan"
#    obj.tagline_zh_cn = "住在当地的旅行"
#    obj.sub_tagline_zh_cn = "象当地人一样生活"
end

image_path = File.join(Rails.root, "app/assets/images/sample/pic/pic005.jpg")
TopPageDiscoveryImage.seed do |obj|
  obj.id = 1
  obj.order_num = 1
  obj.image = File.new(image_path)
  obj.tagline_ja = "東京"
  obj.tagline_en = "Tokyo"
#  obj.tagline_zh_cn = "东京"
  obj.link_url = "http://www.metro.tokyo.jp/index.htm"
  obj.size = 2
  obj.show_price = false
end
image_path = File.join(Rails.root, "app/assets/images/sample/pic/pic006.jpg")
TopPageDiscoveryImage.seed do |obj|
  obj.id = 2
  obj.order_num = 2
  obj.image = File.new(image_path)
  obj.tagline_ja = "大阪"
  obj.tagline_en = "Osaka"
#  obj.tagline_zh_cn = "大阪"
  obj.link_url = "http://www.google.com"
  obj.size = 1
  obj.show_price = false
end

image_path = File.join(Rails.root, "app/assets/images/sample/pic/pic008.jpg")
TopPageBeltImage.seed do |obj|
  obj.id = 1
  obj.image_flg = true
  obj.image = File.new(image_path)
  obj.tagline_ja = "帯画像タグライン"
  obj.sub_tagline_ja = "帯画像サブタグライン"
  obj.tagline_en = "Belt Image Tagline"
  obj.sub_tagline_en = "Belt Image Sub Tagline"
#    obj.tagline_zh_cn = "住在当地的旅行"
#    obj.sub_tagline_zh_cn = "象当地人一样生活"
  obj.link_url = "http://www.travel-labo.com"
end
