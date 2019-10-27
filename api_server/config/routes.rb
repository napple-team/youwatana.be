Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  mount ActionCable.server => '/cable'

  get '/generate_identifier', to: 'generate_identifier#index'
end
