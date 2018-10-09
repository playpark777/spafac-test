class CreateBankAccounts < ActiveRecord::Migration[4.2]
  def change
    create_table :bank_accounts do |t|
      t.references :profile, null: false, index: true
      t.references :bank, null: false, index: true
      t.string :branch_code, null: false
      t.string :branch_name, null: false
      t.references :type_of_bank_account, null: false, index: true
      t.string :number, null: false
      t.string :name, null: false

      t.timestamps null: false
    end
    add_foreign_key :bank_accounts, :profiles
    add_foreign_key :bank_accounts, :banks
  end
end
