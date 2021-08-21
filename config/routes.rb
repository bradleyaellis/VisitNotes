Rails.application.routes.draw do
  root to: 'patients#index'

  resources :patients, only: [:index, :show] do 
    resources :visit_notes
    resources :progress_words
  end
end
