class AddUserAgentToInquiries < ActiveRecord::Migration[4.2]
  def change
    add_column :inquiries, :user_agent, :string, null: false, default: ""
  end
end
