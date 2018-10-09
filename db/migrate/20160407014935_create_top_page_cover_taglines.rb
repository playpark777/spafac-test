class CreateTopPageCoverTaglines < ActiveRecord::Migration[4.2]
  def change
    create_table :top_page_cover_taglines do |t|
      t.string :tagline_ja, null: false
      t.string :sub_tagline_ja, null: false
      t.string :tagline_en, null: false
      t.string :sub_tagline_en, null: false
#      t.string :tagline_zh_cn, null: false
#      t.string :sub_tagline_zh_cn, null: false

      t.timestamps null: false
    end
  end
end
