Rails.application.routes.draw do
  root "welcome#index"
  get "/auth/:provider/callback" => "sessions#create"
  delete "/logout" => "sessions#destroy"

  resource :retirements, only: %i[new create]

  resources :events, only: %i[new create show edit update destroy] do
    resources :tickets, only: %i[new create destroy]
  end

  # defaults: { format: 'json' } をつけることによって、/status へアクセスした時に、
  # /status.json へアクセスした時と同じようにJSONを返すようになる
  get "status" => "status#index", defaults: { format: 'json' }

  match "*path" => "application#error404", via: :all
end
