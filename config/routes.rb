GmailAlerts::Application.routes.draw do
  root to: 'sessions#new'
  resources :sessions, only: :index
  get "/auth/:provider/callback" => 'sessions#create'
  delete "logout" => 'sessions#destroy'

  resources :ubers do
    collection do
      get :form
      get :get_by_label
      get :get_total_amount
      get :get_amount_current_month
    end
  end

end
