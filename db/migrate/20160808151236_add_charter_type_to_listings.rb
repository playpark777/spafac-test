class AddCharterTypeToListings < ActiveRecord::Migration[4.2]
  def change
    add_column :listings, :charter_type, :integer
  end
end
