ReplaceIt::Application.routes.draw do
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
  mount Resque::Server.new, :at => "/resque"

  get '/tags' => 'application#tags'
  get '/posts' => 'posts#index'

  # Legacy API support.
  namespace :backend do
    get '/mobile_api/posts' => 'application#tags'
    get '/mobile_api/tags' => 'posts#index'
  end

end
