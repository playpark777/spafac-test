ActiveAdmin.register BankAccount do
  permit_params :bank_id, :type_of_bank_account_id, :branch_name, :branch_code,
    :number, :name

  index do
    selectable_column
    column :id
    column :profile
    column :bank
    column :branch_name
    column :branch_code
    column :type_of_bank_account
    column :number
    column :name
    column :created_at
    column :updated_at
    actions
  end

  show do |bank_account|
    attributes_table do
      row :id
      row :profile
      row :bank
      row :branch_name
      row :branch_code
      row :type_of_bank_account
      row :number
      row :name
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  form do |f|
    f.inputs "#{f.object.profile.full_name}'s #{BankAccount.model_name.human}" do
      f.input :bank_id, as: :select, include_blank: false,
        collection: Bank.availables
      f.input :branch_name
      f.input :branch_code
      f.input :type_of_bank_account, as: :select, include_blank: false,
        collection: BankAccountType.availables
      f.input :number
      f.input :name
    end
    f.actions
  end

  controller do
    def scoped_collection
      case action_name
      when 'index', 'show'
        super.includes(:profile, :bank, :type_of_bank_account)
      else
        super
      end
    end
  end
end
