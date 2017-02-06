Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :events do
  	resources :attendees, :controller => "event_attendees"

  	collection do
  		get :latest

  		post :bulk_update
  	end
  end

  get "welcome/say_hello" => "welcome#say"
  get "welcome" => "welcome#index"

  root 'welcome#index'

  # match ':controller(/:action(/:id(.:format)))', :via => :all
end
