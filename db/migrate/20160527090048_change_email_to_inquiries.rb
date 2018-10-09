class ChangeEmailToInquiries < ActiveRecord::Migration[4.2]
  def up
    change_column :inquiries, :email, :string, null: false, default: ''
  end

  def down
    change_column :inquiries, :email, :string, null: true, default: ''
  end
end
