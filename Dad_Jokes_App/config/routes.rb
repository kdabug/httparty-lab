Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/responses", to: "responses#test"
  get "/random", to: "responses#random"
end
