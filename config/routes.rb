Rails.application.routes.draw do
  use_doorkeeper
  # devise customization
  devise_for :users, controllers: { registrations: "users/registrations" }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # TEAM ROUTES
  get "team/:team_id/tickets" => "teams#tickets", as: :team_tickets
  get "team/:team_id/tickets/new" => "tickets#new", as: :new_ticket
  post "team/:team_id/tickets" => "tickets#create", as: :create_ticket
  get "team/:team_id/edit" => "teams#edit", as: :team_edit
  patch "team/:team_id" => "teams#update", as: :team
  get "team/new" => "teams#new", as: :new_team
  post "team" => "teams#create", as: :create_team
  delete "team/:team_id/delete" => "teams#destroy", as: :team_destroy
  # TICKET ROUTES
  get "ticket/:id" => "tickets#view", as: :ticket_view
  get "ticket/:id/edit" => "tickets#edit", as: :ticket_edit
  patch "ticket/:id" => "tickets#update", as: :ticket
  delete "ticket/:id/delete" => "tickets#destroy", as: :ticket_destroy
  get "ticket/:id/comment/new" => "comments#new", as: :new_comment
  post "ticket/:id/comment" => "comments#create", as: :create_comment
  get "ticket/:id/comment/:comment_id/edit" => "comments#edit", as: :edit_comment
  patch "ticket/:id/comment/:comment_id" => "comments#update", as: :comment

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "pages#index"
end
