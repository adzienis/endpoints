Rails.application.routes.draw do

  post "user_events", to: "user_events#create", as: :create_user_event
  get "todays_stats", to: "user_events#todays_stats", as: :todays_stats

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
