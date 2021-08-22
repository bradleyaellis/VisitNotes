Rails.application.routes.draw do
  root to: 'visit_notes#index'

  # resources :patients, only: [:index, :show] do 
  resources :progress_words
  resources :visit_notes
  # end
end
