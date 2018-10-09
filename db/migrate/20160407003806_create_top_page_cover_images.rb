class CreateTopPageCoverImages < ActiveRecord::Migration[4.2]
  def change
    create_table :top_page_cover_images do |t|
      t.string :image, null: false
      t.integer :order_num, null: false

      t.timestamps null: false
    end
    add_index :top_page_cover_images, :order_num, unique: true
  end
end
