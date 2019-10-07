Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :admin do
    resources :equipment, only: %i(index show new create edit update destroy)

    root to: "equipment#index" # <--- Root route
  end

  scope module: "api" do
    namespace :v1, path: "" do
      resources :assessments, only: :create
    end
  end
end
