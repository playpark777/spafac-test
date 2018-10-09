class AddRemoteIpToInquiries < ActiveRecord::Migration[4.2]
  def change
    add_column :inquiries, :remote_ip, :string, null: false, default: ""
  end
end
