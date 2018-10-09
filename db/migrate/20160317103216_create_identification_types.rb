class CreateIdentificationTypes < ActiveRecord::Migration[4.2]
  def change
    create_table :identification_types do |t|
      t.string :name, null: false
      t.boolean :available, default: true

      t.timestamps null: false
    end
    add_index :identification_types, :name, unique: true
  end
end
