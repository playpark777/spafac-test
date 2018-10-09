class RenameStartEndColumnToReservations < ActiveRecord::Migration[5.1]
  def change
    rename_column :reservations, :start, :checkin
    rename_column :reservations, :end,   :checkout
  end
end
