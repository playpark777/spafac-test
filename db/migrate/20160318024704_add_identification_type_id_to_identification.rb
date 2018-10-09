class AddIdentificationTypeIdToIdentification < ActiveRecord::Migration[4.2]
  def change
    add_column :identifications, :identification_type_id, :integer
  end
end
