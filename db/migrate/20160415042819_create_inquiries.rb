class CreateInquiries < ActiveRecord::Migration[4.2]
  def change
    create_table :inquiries do |t|
      t.string :title, null: false
      t.string :name, null: false
      t.string :email
      t.text :body, null: false
      t.integer :status, default: 0, null: false
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :inquiries, :users
  end
end
