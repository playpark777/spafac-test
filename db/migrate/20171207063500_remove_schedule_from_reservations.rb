class RemoveScheduleFromReservations < ActiveRecord::Migration[5.1]
  def change
    remove_column :reservations, :schedule, :date
  end
end
