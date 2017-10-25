Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: '/graphiql', graphql_path: '/graphql'
  end

  post '/graphql', to: 'graphql#execute'
  get 'welcome/index'
  root 'welcome#index'
  resources :articles do
    resources :comments
  end
end
