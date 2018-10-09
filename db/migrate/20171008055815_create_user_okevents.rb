class CreateUserOkevents < ActiveRecord::Migration[4.2]
  def change
    create_table :user_okevents do |t|
      t.references :user, index: true
      t.references :listing, index: true, null: true
      t.references :reservation, index: true, null: true
      t.string :reason, null: false
      t.datetime :start, null: false
      t.datetime :end, null: false
      t.boolean :active, default: true
      t.timestamps null: false
    end
    add_foreign_key :user_okevents, :users
    add_foreign_key :user_okevents, :listings
    add_foreign_key :user_okevents, :reservations
  end
end
