GmailAlerts::Application.routes.draw do
  root to: 'sessions#new'
  resources :sessions, only: :index
  get "/auth/:provider/callback" => 'sessions#create'
  delete "logout" => 'sessions#destroy'

  resources :uber do
    collection do
      get :form
      post :get_by_label
      post :get_total_amount
      post :get_amount_current_month
    end
  end

end
