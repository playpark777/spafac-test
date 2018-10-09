ActiveAdmin.register IdentificationType do
  permit_params :name, :available

  config.sort_order = 'id_asc'
end
