Rails.application.routes.draw do

  resources :team_members, only: [:index, :show], path: 'team-members'

  %w( 403 404 422 500 ).each do |code|
    get code, to: 'errors#show', code: code
  end

  mount Optimadmin::Engine => "/admin"
  root to: 'application#index'

  # This has to be the last route in your list
  match "*path", to: "errors#show", via: :all, code: 404 unless Rails.application.config.consider_all_requests_local
end
Optimadmin::Engine.routes.draw do
  resources :articles, except: [:show] do
    collection do
      post 'order'
    end
    member do
      get 'toggle'
      get 'edit_images'
      post 'update_image_default'
      post 'update_image_fill'
      post 'update_image_fit'
    end
  end
  resources :articles, except: [:show] do
    collection do
      post 'order'
    end
    member do
      get 'toggle'
    end
  end
  get 'team_members/index'

  get 'team_members/show'

  resources :team_members, except: [:show] do
    collection do
      post 'order'
    end
    member do
      get 'toggle'
      get 'edit_images'
      post 'update_image_default'
      post 'update_image_fill'
      post 'update_image_fit'
    end
  end
  mount Flip::Engine => "/features"
end
