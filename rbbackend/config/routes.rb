Rails.application.routes.draw do
  # if Rails.env.development?
  #   mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  # end
  post "/graphql", to: "graphql#execute"
  #get "/graphql", to: "graphql#execute" #just to test
  resources :products, only: [:index, :show]
  get 'hello/:name', to: 'welcome#hello'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
