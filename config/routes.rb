Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users,
  skip: [
    :session,
    :password,
    :registration,
    :confirmation
  ],
  controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  scope '(:locale)', locale: /en/ do

    # We define here a route inside the locale thats just saves the current locale in the session
    get 'omniauth/:provider' => 'users/omniauth#localized', as: :localized_omniauth
    devise_for :users,
    skip: :omniauth_callbacks,
    controllers: {
      sessions:            'users/sessions',
      registrations:       'users/registrations',
      passwords:           'users/passwords',
      confirmations:       'users/confirmations'
    }

    resources :profiles, only: [:show] do
      resources :profile_images, only: [:show]
    end

    resource :profile, except: [:index, :show] do
      collection do
        get 'return_listing' => 'profiles#return_listing'
      end
      resource :profile_image, except: [:index, :show] do
        collection do
          get 'return_listing' => 'profile_images#return_listing'
        end
      end
      resource :identification, except: [:edit, :update]
      resource :bank_account, except: [:edit, :update]
    end

  #  resources :auths

    get 'dashboard'                           => 'dashboard#index'
    get 'dashboard/host_reservation_manager'  => 'dashboard#host_reservation_manager'
    get 'dashboard/guest_reservation_manager' => 'dashboard#guest_reservation_manager'
    # get 'reviews'                             => 'profiles#review', as: 'user_review'
    # get 'introductions'                       => 'profiles#introduction', as: 'introduction'

    resources :message_threads, except: [:edit]

    resources :messages do
      collection do
        post 'send_message'
      end
    end

    resources :favorites, only: [:index, :destroy] do
      collection do
        post   '/:listing_id', action: 'create', as: "add"
      end
    end

    resources :listings do
      collection do
        get 'search',        action: 'search'
        get 'search_result', action: 'search_result'
        get 'page/:page',    action: 'index'
      end
      resources :listing_images, only: [:show, :create, :update, :destroy] do
        get 'manage', on: :collection
      end
      #resources :listing_videos do
      #  get 'manage', on: :collection
      #end
      resources :listing_ngevents do
        get 'manage', on: :collection
        get 'search', on: :collection
        post 'delete_all_day', on: :collection
      end
      resources :listing_okevents do
        get 'manage', on: :collection
        get 'search', on: :collection
        post 'delete_all_day', on: :collection
      end
      get 'publish',   action: 'publish',   as: 'publish'
      get 'unpublish', action: 'unpublish', as: 'unpublish'
    end

    resources :reservations, only: [:show, :create, :update] do
      resource :reviews do
        resource :review_replies
      end
    end

    #resources :wishlists

    resources :inquiries, only: [:new, :create] do
      collection do
        post :confirm
      end
    end

    if Rails.env.review_app?
      mount LetterOpenerWeb::Engine, at: '/letter_opener'
    end

    root 'welcome#index'

    get 'templates' => 'templates#invoice'
  end

end
