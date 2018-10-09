ActiveAdmin.register Inquiry do
  permit_params :status, :admin_user_id, :note
  actions :all, except: [:destroy]

  index do
    selectable_column
    column :title
    column :name
    column :email
    column :user
    column :remote_ip
    column :user_agent
    column :assignee
    column :note
    column :status
    column :created_at
    column :updated_at
    actions
  end

  show do |inquiry|
    attributes_table do
      row :title
      row :name
      row :email
      row :user
      row :remote_ip
      row :user_agent
      row :body do |i|
        simple_format(i.body)
      end
      row :assignee
      row :status
      row :note
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  form do |f|
    f.inputs "title" do
      f.input :assignee, as: :select, include_blank: true,
        collection: AdminUser.all.map { |admin| [admin.email, admin.id] }
      f.input :status, as: :select, include_blank: false,
        collection: Inquiry.statuses.keys
      f.input :note, input_html: { rows: 5 }
    end
    f.actions
  end

  controller do
    def scoped_collection
      case action_name
      when 'index'
        super.includes(:user, :assignee)
      else
        super
      end
    end
  end
end
