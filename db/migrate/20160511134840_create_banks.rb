class CreateBanks < ActiveRecord::Migration[4.2]
  def change
    create_table :banks do |t|
      t.string :name, null: false
      t.string :code, null: false
      t.boolean :available, default: true

      t.timestamps null: false
    end
    add_index :banks, [:name, :code], unique: true
  end
end
