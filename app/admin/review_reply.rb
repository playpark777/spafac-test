ActiveAdmin.register ReviewReply do

  controller do
    def scoped_collection
      case action_name
      when 'index', 'show'
        super.includes(:review)
      else
        super
      end
    end
  end
end
