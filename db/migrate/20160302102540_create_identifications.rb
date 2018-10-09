class CreateIdentifications < ActiveRecord::Migration[4.2]
  def change
    create_table :identifications do |t|
      t.references :profile, index: true
      t.string :image1, default: "", null: false
      t.string :image2, default: ""
      t.string :image3, default: ""
      t.string :note, default: ""

      t.integer :status, default: 0, null: false
      t.string :reason, default: ""
      t.datetime :processed_at
      t.references :processed_by, default: ""

      t.timestamps null: false
    end
    add_foreign_key :identifications, :profiles
  end
end
