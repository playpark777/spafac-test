class AddAdminUserIdToInquiries < ActiveRecord::Migration[4.2]
  def change
    add_column :inquiries, :admin_user_id, :integer
  end
end
