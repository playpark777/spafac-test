ActiveAdmin.register EmailTemplateSignature do
  index do
    column :id
    column :body

    actions
  end

  show do
    attributes_table do
      row :id
      row :body
    end
  end
end
