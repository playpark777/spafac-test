class AddNoteToInquiries < ActiveRecord::Migration[4.2]
  def change
    add_column :inquiries, :note, :text, default: ""
  end
end
