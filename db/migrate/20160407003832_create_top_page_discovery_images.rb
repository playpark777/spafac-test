class CreateTopPageDiscoveryImages < ActiveRecord::Migration[4.2]
  def change
    create_table :top_page_discovery_images do |t|
      t.string :image, null: false
      t.string :tagline_ja, null: false
      t.string :tagline_en, null: false
#      t.string :tagline_zh_cn, null: false
      t.string :link_url, null: false
      t.integer :order_num, null: false
      t.integer :size, null: false, default: 1
      t.boolean :show_price, null: false, default: false
      t.integer :listing_id

      t.timestamps null: false
    end
    add_index :top_page_discovery_images, :order_num, unique: true
  end
end
