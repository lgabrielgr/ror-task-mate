Rails.application.routes.draw do
  # devise customization
  devise_for :users, controllers: { registrations: "users/registrations" }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "team/:team_id/tickets" => "teams#tickets", as: :team_tickets
  get "ticket/:id" => "tickets#view", as: :ticket_view

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "pages#index"
end
