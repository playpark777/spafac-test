id_types = %w(運転免許証 国民健康保険証 パスポート 住基カード マイナンバーカード)
id_types.each { |type| IdentificationType.create(name: type, available: true) }
