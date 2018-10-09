class AddColumnToReservation < ActiveRecord::Migration[5.1]
  def change
    add_column :reservations, :start, :date
    add_column :reservations, :end, :date
  end
end
