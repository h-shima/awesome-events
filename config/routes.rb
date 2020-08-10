Rails.application.routes.draw do
  root "welcome#index"
  get "/auth/:provider/callback" => "sessions#create"
  delete "/logout" => "sessions#destroy"

  resource :retirements

  resources :events do
    resources :tickets
  end

  # defaults: { format: 'json' } をつけることによって、/status へアクセスした時に、
  # /status.json へアクセスした時と同じようにJSONを返すようになる
  get "status" => "status#index", defaults: { format: 'json' }
end
