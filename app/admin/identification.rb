ActiveAdmin.register Identification do
  permit_params :identification_type_id, :status, :reason

  index do
    selectable_column
    column :id
    column :profile
    column :note
    column :identification_type
    column :image1 do |identification|
      if identification.image1.present?
        image_tag(identification&.image1&.url(:thumb))
      end
    end
    column :image2 do |identification|
      if identification.image2.present?
        image_tag(identification&.image2&.url(:thumb))
      end
    end
    column :image3 do |identification|
      if identification.image3.present?
        image_tag(identification&.image3&.url(:thumb))
      end
    end
    column :status_i18n
    column :processed_at
    column :processed_by
    column :reason
    column :created_at
    column :updated_at
    actions
  end

  show do |identification|
    attributes_table do
      row :id
      row :profile
      row :note
      row :identification_type
      row :status_i18n
      row :processed_at
      row :processed_by
      row :reason
      row :image1 do
        if identification.image1.present?
          image_tag(identification.image1.url, width: '500px')
        end
      end
      row :image2 do
        if identification.image2.present?
          image_tag(identification.image2.url, width: '500px')
        end
      end
      row :image3 do
        if identification.image3.present?
          image_tag(identification&.image3&.url, width: '500px')
        end
      end
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  form do |f|
    image_tag(f.object.image1.url)
    f.inputs f.object.profile.full_name do
      f.input :status, as: :select, include_blank: false,
        collection: Identification.statuses.keys
      f.input :identification_type_id, as: :select, include_blank: false,
        collection: IdentificationType.availables.map { |type| [type.name, type.id] }
      f.input :reason, input_html: {
        placeholder: I18n.t('views.identifications.form.reason_placeholder')
      }
    end
    f.actions
  end

  before_update do |identification|
    if identification.status_changed? && !identification.not_yet?
      identification.processed_by = current_admin_user
      identification.processed_at = Time.now

      method_name = "send_identification_is_#{identification.status}_notification"
      IdentificationMailer.send(method_name, identification).deliver_now!
    end
  end

  controller do
    def scoped_collection
      case action_name
      when 'index'
        super.includes(:profile, :identification_type, :processed_by)
      else
        super
      end
    end
  end
end
