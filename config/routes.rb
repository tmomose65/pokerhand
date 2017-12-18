Rails.application.routes.draw do
  root to: 'home#top'
  post '/', to: 'home#top'
  mount API => "/"
end
