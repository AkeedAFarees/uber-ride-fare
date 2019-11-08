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
      get :get_amount_previous_month

      get :get_personal_amount
      get :get_personal_amount_current_month
      get :get_personal_amount_previous_month
    end
  end

end
