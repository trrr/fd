Fd::Application.routes.draw do
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
  mount Resque::Server.new, :at => "/resque"

  root to: redirect('/admin')

  get '/categories' => 'categories#index'
  get '/posts' => 'posts#index'
  get '/authors' => 'authors#index'

  # Legacy API support.
  namespace :backend do
    get '/mobile_api/posts' => 'categories#index'
    get '/mobile_api/tags' => 'posts#index'
  end

end
