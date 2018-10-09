class RenameStartEndColumnToUserngevents < ActiveRecord::Migration[5.1]
  def change
    rename_column :user_ngevents, :start, :start_at
    rename_column :user_ngevents, :end,   :end_at
  end
end
